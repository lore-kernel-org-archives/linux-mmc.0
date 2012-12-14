From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Signal voltage switch procedure for UHS mode (sdhci)
Date: Fri, 14 Dec 2012 14:16:07 +0100
Message-ID: <CAPDyKFqWjZQkEGh2-AmOx+9+sC2GJg-J8RybOEHY9DZqCCZjbQ@mail.gmail.com>
References: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63474 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab2LNNQI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 08:16:08 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so5794896ieb.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 05:16:08 -0800 (PST)
In-Reply-To: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com, per.forlin@stericsson.com, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com

Hi Kevin,

Thanks for looking into this for SDHCI.

On 14 December 2012 11:53, Kevin Liu <kliu5@marvell.com> wrote:
>
> This patchset is based on Johan's below patch series submitted recently:
>   mmc: core: Add mmc_power_cycle
>   mmc: core: Add card_busy to host_ops
>   mmc: core: Fixup signal voltage switch
>
> This patchset mainly update sdhci.c to co-work with Johan's above patches.
> The first two patches are some update for the core stack with Johan's patch.
> The third patch add the card_busy function and change the voltage_switch function in sdhci driver to work with the new code.
>
> Kevin Liu (3):
>  mmc: core: enhance the code for signal voltage setting
>  mmc: core: cycle power the card in voltage switch rather than mmc_sd_get_cid

Regarding you patches on the core layer. I think it would make sense
to instead of patching on top of Johan patchset, if needed, it is
better that you put review comment directly on Johans patches. Would
that be possible for you?

>  mmc: sdhci: update signal voltage switch code
>
>  drivers/mmc/core/core.c  |   71 +++++++++++-------
>  drivers/mmc/core/sd.c    |   16 +---
>  drivers/mmc/host/sdhci.c |  188 +++++++++++++++++++---------------------------
>  3 files changed, 125 insertions(+), 150 deletions(-)

Kind regards
Ulf Hansson
