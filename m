From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
Date: Mon, 23 May 2016 11:52:01 +0530
Message-ID: <5742A189.4060803@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
 <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
 <20160518193028.GT5995@atomide.com>
 <0d463add-9fa5-a768-2ba6-34c4126c7817@ti.com>
 <20160519145745.GU5995@atomide.com> <87shxdlws6.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87shxdlws6.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, rogerq@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Felipe,

On Friday 20 May 2016 12:06 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Tony Lindgren <tony@atomide.com> writes:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160519 01:10]:
>>> On 05/18/2016 10:30 PM, Tony Lindgren wrote:
>>>> Ideally the adma support would be a separate loadable module,
>>>> similar how the cppi41dma is a child of the OTG controller.
>>>
>>> The Master DMA is part of the hsmmc IP block. If the same ADMA module is
>>> present on other IPs it might be beneficial to have a helper library to handle
>>> it (allocating the descriptor pool, wrinting, updating descriptors, etc).
>>
>> OK. Yeah if it's part of the MMC controller it makes no sense to
>> separate it. So then the conecrns are using alternate DMA
>> implementations and keeping PM runtime working :)
>>
>> BTW, Felipe mentioned that the best thing to do in the long run would
>> be to set up sdhci-omap.c operating in ADMA mode.
>>
>> Felipe, care to summarize what you had in mind?
> 
> yeah, just write a new sdhci-omap.c to start moving away from
> omap-hsmmc.c, just like it was done for 8250-omap.
> 
> At the beginning, it could be just the bare minimum to get it working
> and slowly move over stuff like pm runtime, dmaengine, PIO. Move more
> platforms over to that driver and, eventually, get rid of omap-hsmmc.c
> altogether.
> 
> That way, development can be focussed on generic layers (SDHCI) to which
> OMAP MMC controller is compliant (apart from the VERSION register
> quirk).

About an year back, when I tried using SDHCI for OMAP I ran into issues and was
not able to get it working. IIRC SDHCI_PRESENT_STATE (or OMAP_HSMMC_PSTATE) was
not showing the correct state for card present and is unable to raise an
interrupt when a card is inserted. I didn't debug this further.

It also kept me wondering why gpio interrupt was always used for card detect
instead of using mmci_sdcd line of the controller.

Thanks
Kishon
