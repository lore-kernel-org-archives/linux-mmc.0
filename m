From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Sat, 1 May 2010 16:28:59 -0700
Message-ID: <z2ye9c3a7c21005011628r7c0c2b5bq36126db83d3ea5e3@mail.gmail.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	 <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	 <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	 <t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	 <q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	 <20100422110025.GC20008@n2100.arm.linux.org.uk>
	 <g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
	 <20100501224429.GA17693@n2100.arm.linux.org.uk>
	 <x2u63386a3d1005011604kaee33364l880e90a4e2453e0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <x2u63386a3d1005011604kaee33364l880e90a4e2453e0f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus WALLEIJ <linus.walleij@stericsson.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, May 1, 2010 at 4:04 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/5/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>
>> Versatile has some MUXing on three of the DMA signals, so (eg) we
>> really don't want UARTs claiming DMAs just because they're in existe=
nce
>> and not in use - that would prevent DMAs from being used for (eg) AA=
CI
>> or MMC.
>
> As long as Versatile doesn't specify any filter function or
> data for the channel allocation function (it currently doesn't and de=
faults
> to NULL) it won't even try to call the DMA engine to allocate a chann=
el
> for say the UART.
>
> There is nothing blocking some other peripheral from grabbing a
> muxed channel in that case.
>
> But the implementation of the DMA engine would be better of
> handling the muxing dynamically I believe, so when the PL011
> driver (say) requests a DMA channel, it doesn't mean it requests the
> *physical* channel and holds it (unless the driver is very na=C4=8Fve=
ly
> implemented) it nominally means it reserves a placeholder in the
> DMA engine.
>
> When the driver issues a request to perform a DMA transfer, it will p=
ull
> out a physical channel and use that, then return it. If there is too
> much combat about the physical channels, you configure out DMA
> for the least wanted PrimeCells.
>

Could you simulate this by publishing more struct dma_chans than are
physically present, and then handle the muxing internal to the driver?
 Or am I misunderstanding the usage model?
