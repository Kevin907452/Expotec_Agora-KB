import React,{useState} from 'react';
import {Link} from 'react-router-dom';
import modulosOriginales from '../data/materialOriginal.js';
import NavbarProfesor from './NavbarProfesor.jsx';
import {NavbarEstudiante} from './indexestudiante.jsx';
import './aulaOriginal.css';
function Cuestionario({preguntas,temaId}){
 const [respuestas,setRespuestas]=useState({});const [finalizado,setFinalizado]=useState(false);
 const [guardando,setGuardando]=useState(false),[error,setError]=useState(''),[resultado,setResultado]=useState(null);
 const entregar=async()=>{
  setGuardando(true);setError('');
  try{
   const token=localStorage.getItem('agora_token');
   const res=await fetch('http://localhost:3000/api/cuestionarios-educativos/entregar',{
    method:'POST',headers:{'Content-Type':'application/json',Authorization:`Bearer ${token||''}`},
    body:JSON.stringify({temaId,respuestas:preguntas.map((_,i)=>respuestas[i])})
   });
   const data=await res.json();if(!res.ok)throw new Error(data.mensaje||'No se pudo guardar la nota.');
   setResultado(data);setFinalizado(true);
  }catch(e){setError(e.message||'No se pudo guardar la nota.');}finally{setGuardando(false)}
 };
 if(!preguntas.length)return <p>Este cuestionario todavía no tiene preguntas en el material original.</p>;
 const correctas=preguntas.filter((p,i)=>respuestas[i]===p.correctAnswer).length;
 return <div className="ag-aula-quiz">{preguntas.map((p,i)=><fieldset key={i} disabled={finalizado}><legend>{i+1}. {p.question}</legend>{p.options.map((op,j)=><label key={j}><input type="radio" name={`pregunta-${i}`} checked={respuestas[i]===j} onChange={()=>setRespuestas(v=>({...v,[i]:j}))}/>{op}</label>)}</fieldset>)}{finalizado?<><h3>Resultado: {resultado?.aciertos ?? correctas} de {preguntas.length} ({resultado?.porcentaje ?? Math.round(correctas/preguntas.length*100)}%)</h3><p>Tu calificación se guardó en Notas.</p><button onClick={()=>{setFinalizado(false);setRespuestas({});setResultado(null);setError('')}}>Intentar otra vez</button></>:<><button disabled={guardando||Object.keys(respuestas).length!==preguntas.length} onClick={entregar}>{guardando?"Guardando nota…":"Comprobar respuestas y guardar nota"}</button>{error&&<p role="alert">{error}</p>}</>}</div>
}
export default function AulaOriginal(){
 const usuario=(()=>{try{return JSON.parse(localStorage.getItem('usuario')||'null')}catch{return null}})();
 const [indiceModulo,setIndiceModulo]=useState(0),[indiceTema,setIndiceTema]=useState(0),[girada,setGirada]=useState({});
 const modulo=modulosOriginales[indiceModulo],tema=modulo.topics[indiceTema];
 const cambiar=(mi,ti)=>{setIndiceModulo(mi);setIndiceTema(ti);setGirada({})};
 return <>{usuario?.rol==='profesor'?<NavbarProfesor/>:<NavbarEstudiante/>}<main className="ag-modules ag-aula"><Link className="ag-back" to="/modulos">← Volver a las tarjetas de módulos</Link><span className="ag-eyebrow">MATERIAL EDUCATIVO ORIGINAL</span><h1>Lecciones y cuestionarios</h1><p>Estos son los contenidos originales que compartiste. Sus cinco bloques aún deben distribuirse entre los seis módulos definitivos.</p><div className="ag-aula-layout"><aside>{modulosOriginales.map((m,i)=><div key={m.id}><button className={i===indiceModulo?'activo':''} onClick={()=>cambiar(i,0)}>{m.title}</button>{i===indiceModulo&&m.topics.map((t,j)=><button key={t.id} className={j===indiceTema?'activo tema':'tema'} onClick={()=>cambiar(i,j)}>{t.title}</button>)}</div>)}</aside><section className="ag-aula-content"><span className="ag-eyebrow">{modulo.title}</span><h2>{tema.title}</h2>{tema.type==='quiz'?<Cuestionario key={tema.id} temaId={tema.id} preguntas={tema.questions||[]}/>:<><p>{tema.content}</p>{Array.isArray(tema.cards)&&tema.cards.length>0&&<div className="ag-aula-cards">{tema.cards.map((c,j)=><button key={c.id||j} onClick={()=>setGirada(g=>({...g,[j]:!g[j]}))}><strong>{c.title}</strong><p>{girada[j]?c.backText:c.frontText}</p><small>Presiona para girar ↻</small></button>)}</div>}</>}<div className="ag-aula-next"><button disabled={indiceTema===0&&indiceModulo===0} onClick={()=>{if(indiceTema>0)cambiar(indiceModulo,indiceTema-1);else cambiar(indiceModulo-1,modulosOriginales[indiceModulo-1].topics.length-1)}}>← Anterior</button><button disabled={indiceModulo===modulosOriginales.length-1&&indiceTema===modulo.topics.length-1} onClick={()=>{if(indiceTema<modulo.topics.length-1)cambiar(indiceModulo,indiceTema+1);else cambiar(indiceModulo+1,0)}}>Siguiente →</button></div></section></div></main></>;
}
