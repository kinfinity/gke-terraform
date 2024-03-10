import Image from "next/image"

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <Image
        className="relative dark:drop-shadow-[0_0_0.3rem_#ffffff70] dark:invert"
        src="/cohere.png"
        alt="Next.js Logo"
        width={500}
        height={400}
        priority
      />
    </main>
  )
}
