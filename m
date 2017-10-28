From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: renesas sdhi driver and DMA
Date: Sat, 28 Oct 2017 10:02:34 +0200
Message-ID: <20171028080234.GB28431@bigcity.dyn.berto.se>
References: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
 <SG2PR06MB11658C446725E77967BF22598A5A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11658C446725E77967BF22598A5A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On 2017-10-27 21:11:39 +0000, Chris Brandt wrote:
> Hi Wolfram,
> 
> Sorry, back on this subject...
> 
> > > > [<bf9921e7>] (tmio_mmc_dma_callback) from [<bf908e1b>]
> > > (rzadma_tasklet+0x23/0x98)
> > >
> > > For SYS-DMAC, this is a callback called by the dmaengine core once the
> > > DMA is completed. My guess is you call it directly from an interrupt
> > > handler? It would be easier to talk over code here, I guess.
> > >
> > > > Is it now a requirement that I have to register my DMA channel
> > > > interrupts as devm_request_threaded_irq?
> > > >
> > > > Will that fix my issue?
> > >
> > > I can't say yet if this alone will do. Likely not. Can you share the
> > > code already?
> > 
> > The interrupt handler is starting a tasklet, and then the tasklet calls
> > the callback. I thought tasklets didn't run in an interrupt context?????
> 
> 
> So here's what I found.
> 
> According to:
> 
> https://www.kernel.org/doc/Documentation/dmaengine/client.txt
> 
> It says:
> "Note that callbacks will always be invoked from the DMA engines 
> tasklet, never from interrupt context."
> 
> 
> My DMA driver was calling the SDHI callback from within a tasklet (ie, 
> softirq). Almost all the other DMA drivers doing the same thing.
> 
> All was fine until that patch you submitted (52ad9a8e854c) that now adds
> a wait_for_completion() in the SDHI callback.

This is a interesting finding, I did some bisecting a while back to try 
and understand why a known problematic SD card started to have more 
issues then last time I tested it. That investigation also ended up 
pointing to 52ad9a8e854c.

> 
> Now I get the "BUG: scheduling while atomic".
> 
> The R-Car driver uses a threaded irq to call the callbacks, not a 
> tasklet.
> 
> So I hacked my code to also call the callbacks from a threaded irq like 
> rcar-dma.c.
> And....that works (no more scheduling while atomic).

Can you post that hack or just send it to me privately if it's to 
hackish for a mailinglist :-) I'm still interested in my problematic SD 
card and would just like to see what happens with your hack applied.

> 
> So, the question is, which of these statements are correct?
> 
>   1. wait_for_completion should not be called in a DMA callback
> 
>   2. DMA engine drivers should use threaded IRQs instead of tasklets
> 
> 
> The issue with #2 is that mic_x100_dma.c, sh/rcar-dmac.c and 
> sh/shdma-base.c are the only ones calling request_threaded_irq,
> so you would think that tasklets are the correct method.
> 
> 
> Thanks,
> Chris
> 

-- 
Regards,
Niklas Söderlund
