From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 08/19] mmc: sdhi: Enable the driver on all ARM platforms
Date: Tue, 29 Oct 2013 23:47:36 +0300
Message-ID: <52701EE8.4040302@cogentembedded.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <4906973.ikaOXXr4gP@avalon> <526FA641.9090300@cogentembedded.com> <172884142.S8DiPq9kQF@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62984 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab3J2Trg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2013 15:47:36 -0400
Received: by mail-lb0-f178.google.com with SMTP id o14so451351lbi.9
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2013 12:47:35 -0700 (PDT)
In-Reply-To: <172884142.S8DiPq9kQF@avalon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 10/29/2013 04:15 PM, Laurent Pinchart wrote:

>>>>> Renesas ARM platforms are transitioning from single-platform to
>>>>> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
>>>>> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
>>>>> and ARCH_SHMOBILE_MULTI and increase build testing coverage.

>>>>> Cc: Chris Ball <cjb@laptop.org>
>>>>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>>>> Cc: Ian Molton <ian@mnementh.co.uk>
>>>>> Cc: linux-mmc@vger.kernel.org
>>>>> Signed-off-by: Laurent Pinchart
>>>>> <laurent.pinchart+renesas@ideasonboard.com>

>> [...]

>>>>> diff --git a/drivers/mmc/host/tmio_mmc_dma.c
>>>>> b/drivers/mmc/host/tmio_mmc_dma.c index 65edb4a..535bc35 100644
>>>>> --- a/drivers/mmc/host/tmio_mmc_dma.c
>>>>> +++ b/drivers/mmc/host/tmio_mmc_dma.c
>>>>> @@ -28,7 +28,7 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host,
>>>>> bool enable)>
>>>>>
>>>>>    	if (!host->chan_tx || !host->chan_rx)
>>>>>    	
>>>>>    		return;

>>>>> -#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
>>>>> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARM)

>>>> I'm not sure about this one. In principle DMA so far is only used on SDHI
>>>> with TMIO. But this #if was for a theoretical case, when a TMIO MMC IP
>>>> inside an MFD is also used with DMA. Bus since I had no indormation about
>>>> whether the CTL_DMA_ENABLE register was SDHI specific or not, I put it
>>>> under an #if for the time being. In any case, I don't think making it
>>>> #ifdef CONFIG_ARM makes much sense. We can either remove the #if
>>>> completely, or keep it to limit the scope of this write to sh-mobile
>>>> arches.

>>> SUPERH || ARCH_SHMOBILE covers all the platforms this driver currently
>>> builds on. Now that we're adding ARCH_SHMOBILE_MULTI the #if needs to
>>> cover that case as well. I'm fine with limiting the CTL_DMA_ENABLE write
>>> to SUPERH only (which would modify the driver's behaviour)

>> I'm afraid that would break the driver's ability to work in DMA mode on SH-
>> Mobile SoCs.

> So can you confirm that writing the CTL_DMA_ENABLE register is required on all
> Renesas ARM SoCs (including SH-Mobile, R-Mobile and R-Car) ?

    I can't actually say anything about all SH-Mobile and R-Mobile SoCs, only 
about the R-Car SoCs: though the datasheets don't contain the SDHI register 
info, from my experience the register exists on R8A777x (I had to fix up the 
broken PIO fallback in the SDHI driver).

>>> or enabling it unconditionally, but I don't think adding a
>>> defined(CONFIG_ARCH_SHMOBILE_MULTI) to the above #if makes sense, unless
>>> there's a plan to add support for DMA for non-SH (including both SUPERH
>>> and ARCH_SHMOBILE) platforms.

>> Not only the plan -- I have already posted the patches to do it for R8A777x,
>> and Simon has queued them for 3.13.

> Could you please point me to those patches ?

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=next&id=1eb6b5a0e55bfcfb0852b7d0f9442841ff807345
https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=next&id=a43e5bd76a4a3df58167d85e8020a1c9e566ad75
https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=next&id=5d6aa3435275a5308684f90c17424b055ef7f572
https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/commit/?h=next&id=e6a8b11b82fdeaa78dad52552f945b772ee1a5c9

WBR, Sergei

