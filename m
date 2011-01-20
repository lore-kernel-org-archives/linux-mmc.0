From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: SDHC Read Performance
Date: Thu, 20 Jan 2011 13:01:04 +0900
Message-ID: <AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com>
References: <20110119000909.GA9412@verge.net.au>
	<AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
	<20110119080542.GE1960@verge.net.au>
	<20110120033020.GA32120@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110120033020.GA32120@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 20, 2011 at 12:30 PM, Simon Horman <horms@verge.net.au> wro=
te:
> I ran my tests again with CONFIG_SH_DMAE (and CONFIG_DMA_ENGINE)
> enabled and the results are substantially better. Although
> the results are still below the theoretical speeds of the cards.
>
> Read Speed - SHDI
> SD1.1: =A0 =A0 =A0 =A0 =A0 9.9 MB/s
> SD2.0: =A0 =A0 =A0 =A0 =A017.2 MB/s
> SDHC Class 2: =A0 17.0 MB/s
> SDHC Class 10: =A017.2 MB/s
> MMC4.0: =A0 =A0 =A0 =A0 =A08.6 MB/s =A0 <-- Clocked down to 12Mhz due=
 to driver limitations
>
> I also tested the Write Speed
> SD1.1: =A0 =A0 =A0 =A0 =A0 2.4 MB/s =A0 <-- Faster than expected
> SD2.0: =A0 =A0 =A0 =A0 =A0 2.8 MB/s =A0 <-- Faster than expected
> SDHC Class 2: =A0 =A02.5 MB/s =A0 <-- Faster than expected
> SDHC Class 10: =A0 3.8 MB/s =A0 <-- Slower than expected
> MMC4.0: =A0 =A0 =A0 =A0 =A02.1 MB/s =A0 <-- Clocked down to 12Mhz due=
 to driver limitations
>
> For reference I obtained the following results on my laptop,
> which according to dmesg has a SAMSUNG MMCRE28G VBM1 PQ.
>
> Read
> SD1.1: =A0 =A0 =A0 =A0 =A010.0 MB/s
> SD2.0: =A0 =A0 =A0 =A0 =A019.2 MB/s
> SDHC Class 2: =A0 19.4 MB/s
> SDHC Class10: =A0 17.9 MB/s =A0<---- What!!!?
> MMC4.0: =A0 =A0 =A0 =A0 =A08.2 MB/s
>
> Write
> SD1.1: =A0 =A0 =A0 =A0 =A0 2.7 MB/s
> SD2.0: =A0 =A0 =A0 =A0 =A0 3.4 MB/s
> SDHC Class 2: =A0 =A03.1 MB/s
> SDHC Class10: =A0 =A03.8 MB/s =A0<---- What!!!?
> MMC4.0: =A0 =A0 =A0 =A0 =A02.0 MB/s

Interesting, thanks for running these tests. Two things cross my mind:

1) Can you try a different SDHC Class 10 card? I'd just simply buy a
top-of-the-line SanDisk card myself and try that, but anything
different from what you're having is probably useful as a contrast.

2) How about the MMC4.0 down-clocking. Is there anything we can do
about that software-wise?

Cheers,

/ magnus
