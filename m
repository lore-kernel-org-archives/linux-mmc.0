From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] mmc: host: omap_hsmmc: Add custom card detect irq
 handler
Date: Wed, 22 Jul 2015 13:01:21 +0530
Message-ID: <55AF46C9.9050308@ti.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>	<1434451039-18195-4-git-send-email-vigneshr@ti.com>	<CALtMJEAy8p23dkqPYZT9wTfyvvjiwi6Swj9Fzpau9Y4K9dym5g@mail.gmail.com>	<55880B24.9010906@ti.com> <CALtMJEBnqzJsGgBoLDjkO+6iJ=67Cw1FXjQm0vfmcm1i3yZ5oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbbGVHbc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 03:31:32 -0400
In-Reply-To: <CALtMJEBnqzJsGgBoLDjkO+6iJ=67Cw1FXjQm0vfmcm1i3yZ5oA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org

Hi Andreas,

On 07/21/2015 01:46 PM, Andreas Fenkart wrote:
> Hi Vignesh,
> 
> Generally I don't like this patch, it will make it harder, not easier,
> to maintain the omap hsmmc driver. Also given that the bug occurs
> rarely, people will be reluctant to clean it up later or accept
> patches.
> 
> see also comments below
> 
[snip]
> 2015-06-22 15:18 GMT+02:00 Vignesh R <vigneshr@ti.com>:
>>
> 
>> But calls to omap_hsmmc_card_init or omap_hsmmc_get_cd are in the same
>> mmc_rescan thread. Hence, moving the recovery code to init_card does not
>> help.
> 
> what about clearing any pending transfer in
> - mmc_gpio_cd_irqt, or
> - mmc_detect_change
> 
> e.g. trigger the later mentioned .card_event callback from those
> functions, instead mmc_rescan? Then you can install your
> omap_hsmmc_request_clear as the card_event callback. This makes your
> custom isr handler redundant, actually your isr handler became
> standard.
> 

I looked  at the commit fa372a51cb5f93800f711473e5a36e0e0c9a8f00 which
moved .card_event out of mmc_gpio_cd_irqt. It points to two threads
where discussion to move .card_event to mmc_rescan happened[1][2]. The
concern there was this callback was being called from "atomic context"
but, I don't understand how threaded irq is "atomic context". (I am not
sure, if this is because those drivers have irqs disabled till threaded
irq is complete) But, I believe moving card_event callback back to
mmc_gpio_cd_irqt may break some drivers.
I will look into this further.
Do you have any insight on this commit? Thanks!

[1]https://lkml.org/lkml/2014/3/19/79
[2]https://lkml.org/lkml/2013/8/19/539

-- 
Regards
Vignesh
