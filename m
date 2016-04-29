From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Potential issue with SDHCI DMA
Date: Fri, 29 Apr 2016 11:59:39 +0300
Message-ID: <5723227B.9070006@intel.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <6297512.2KmasKu6UN@wuerfel> <5714857C.9070002@intel.com>
 <7893683.FFM02uuNdT@wuerfel> <57232233.1030702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30421 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbcD2JDb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Apr 2016 05:03:31 -0400
In-Reply-To: <57232233.1030702@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jisheng Zhang <jszhang@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Eric Miao <eric.y.miao@gmail.com>, Alexander Kurz <akurz@blala.de>, Jaehoon Chung <jh80.chung@samsung.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Al Cooper <alcooperx@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, Dong Aisheng <dongas86@gmail.com>

+ linux-mmc

On 29/04/16 11:58, Adrian Hunter wrote:
> On 18/04/16 17:33, Arnd Bergmann wrote:
>> On Monday 18 April 2016 09:58:04 Adrian Hunter wrote:
>>>
>>> Thanks for looking.
>>>
>>> It looked to me like sdhci-pxav3 devices created by mmp2_add_sdhost() might
>>> also be candidates.
>>>
>>
>> Oh, you are right, I missed that.
>>
>> I remember looking at sdhci-pxav2 and not finding any machine defining one,
>> but I must have skipped over sdhci-pxav3 failing to realize that this is
>> a different one.
>>
>> 	Arnd
>>
> 
> OK, so my plan to email sdhci driver maintainers ran into a snag.  It turned
> out to be too hard to dig up email addresses.  I have grabbed a few names
> and cc'ed them to this email anyway.
> 
> For those people, the issue is this:
> 
> An unexpected side-effect of commit 7b91369b4655 ("mmc: sdhci: Set DMA mask
> when adding host") is that SDHCI devices that do not define a DMA mask may
> find that DMA no longer works.  That was the case for a sdhci-esdhc-imx
> device, but that has been fixed - refer commit fc26fe9c3869 ("ARM: mach-imx:
> sdhci-esdhc-imx: initialize DMA mask").
> 
> DeviceTree, ACPI and PCI always set up a DMA mask for devices that they
> enumerate, so only hard-coded platform devices are expected to be affected.
> 
> We found only one other candidate: sdhci-pxav3 devices created by
> mmp2_add_sdhost().  Not sure if anyone has looked at that though.
> 
> Obviously, if you are unsure if your devices are affected, you can test and
> if there is a problem you will see the warning messages "mmcX: Failed to set
> 32-bit DMA mask" and "mmcX: No suitable DMA available - falling back to PIO".
> 
> Regards
> Adrian
> 
> 

