import Head from 'next/head';
import styles from '../styles/Home.module.css';

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Cohere App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <img src="/cohere.png" alt="Cohere Logo" className={styles.logo} />
      </main>

      <style jsx>{`
        .main {
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh; /* 100% of the viewport height */
        }
      `}</style>

      <style jsx global>{`
        html,
        body {
          padding: 0;
          margin: 0;
        }
        * {
          box-sizing: border-box;
        }
      `}</style>
    </div>
  );
}
