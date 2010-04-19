From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: fix race condition between dma and omap_hsmmc
	callback
Date: Mon, 19 Apr 2010 15:06:24 +0530
Message-ID: <h2y618f0c911004190236wd64b071dkee00026da2077d05@mail.gmail.com>
References: <618f0c911003240600m1a38935av68f31a232ed8b8ad@mail.gmail.com>
	 <4BC43D99.6030809@nokia.com>
	 <x2s618f0c911004180637gde02aecn57c650cc19d142f0@mail.gmail.com>
	 <4BCC0F32.6020409@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4BCC0F32.6020409@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Adrian Hunter <adrian.hunter@nokia.com> wrote:
> Venkatraman S wrote:
>>
>> On Tue, Apr 13, 2010 at 3:17 PM, Adrian Hunter <adrian.hunter@nokia.=
com>
>> wrote:
>>>
>>> Venkatraman S wrote:
>>>>
>>>> This patch addresses the possible race condition between the dma
>>>> callback and hsmmc callback.
>>>
>>> Can you explain the problem in more detail? =A0If the final DMA int=
errupt
>>> comes before TC then all should be well.
>>
>> =A0 Actually it isn't, with descriptor loading. If the DMA callback =
arrives
>> "too early", the MMC TC is missed sometimes. The last transfer in th=
e log
>> below is actually stalled waiting for TC. This happens more often wh=
en the
>> transfer is large (> 300 blocks)
>
> You seem to be saying that, in the case of descriptor loading, the DM=
A
> callback
> does not indicate that the DMA is complete. =A0Isn't that a problem w=
ith
> descriptor
> loading?
>
  My understanding from the existing code
<snip>
        /*
         * If for some reason the DMA transfer is still active,
         * we wait for timeout period and free the dma
         */
        if (host->dma_ch !=3D -1) {
                set_current_state(TASK_UNINTERRUPTIBLE);
</snip>
 is that it's rare, but not impossible, for the DMA to be active even
when the TC has been received.
  At the same time, I found one issue in descriptor loading
after I sent the email yesterday, which could fix the problem I am seei=
ng.

>>
>>> If it comes after, then we need
>>> to be sure that the DMA has finished - particularly in the "read" c=
ase.
>>> Neither the existing code nor this patch seems to address that issu=
e.
>>>
>> =A0 With this patch the assumption is that MMC TC correctly signals =
the
>> end of read / write as requested. I don't know if there are any spec=
ific
>> reasons
>> to believe otherwise.
>
> It would be nice if there were a way to check that the DMA is complet=
e. i.e.
> if TC is received but DMA is not complete then set an error by callin=
g
> omap_hsmmc_dma_cleanup() instead of omap_hsmmc_xfer_done()
>
  Yes, I was testing such a mechanism as well.  Is it better to abort t=
he
transfer by setting an error, or do the omap_hsmmc_xfer_done() at the
callback of whichever
interrupt comes last ?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
