From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
Date: Tue, 24 Nov 2015 12:01:53 +0100
Message-ID: <CAPDyKFp4U5vG_UswnLe1L2Vq1VwdkptThSdzhPYoP+hhGFTaQA@mail.gmail.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
	<1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
	<20151109132305.GC15706@odux.rfo.atmel.com>
	<CAPDyKFrTTEnSFNvmx3e__Ap9gOGpA2-bz+yrq7ibz0wXGSWCXA@mail.gmail.com>
	<20151109144030.GD15706@odux.rfo.atmel.com>
	<CAPDyKFquZ+_Rf07gX+i-=_bzSa7KJ5+xQ8N21kK2mvfMGdVQMw@mail.gmail.com>
	<20151109163026.GE15706@odux.rfo.atmel.com>
	<20151124092341.GA2228@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35279 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbbKXLBy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2015 06:01:54 -0500
Received: by ykba77 with SMTP id a77so13995156ykb.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2015 03:01:54 -0800 (PST)
In-Reply-To: <20151124092341.GA2228@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 24 November 2015 at 10:23, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Hi Ulf,
>
> On Mon, Nov 09, 2015 at 05:30:26PM +0100, Ludovic Desroches wrote:
>> On Mon, Nov 09, 2015 at 05:00:46PM +0100, Ulf Hansson wrote:
>
> [...]
>
>> > Now, this discussion was interesting, but I forgot what problem you
>> > actually where trying to solve? :-)
>>
>> There is this discussion because of two things:
>> - Fixing something I consider as a bug: when I have a VMMC, only
>>   setting/clearing bit 0. Our controller strictly obeys to the spec and
>>   check the 'SD Bus Voltage Select' field. Since we put a reserved value
>>   (000), the Power On is not performed.
>> - I was trying to get help to understand what is this 'SD Bus Voltage'.
>>   For our controller and sdhci_set_power(), it seems to stand for VMMC.
>>   For me, everything concerning bus voltage is related to VQMMC, so I was
>>   disappointed.
>
> Do you plan to take the patch for VMMC? If yes, I will send a new patch
> for the device tree (I'll only add vmmc, not vqmmc as discussed); if
> not, forget these two patches.
>

Which patch do you refer to for "VMMC"?

Kind regards
Uffe
