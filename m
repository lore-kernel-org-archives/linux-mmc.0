From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/2] mmc: core: Remove all code related to MMC_CLKGATE
Date: Mon, 30 Sep 2013 23:10:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1309302301400.24147@axis700.grange>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab3I3VK5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Sep 2013 17:10:57 -0400
In-Reply-To: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Ulf

On Mon, 30 Sep 2013, Ulf Hansson wrote:

> This patchset is remove all code related to MMC_CLKGATE. A significant
> portion of code can then be removed from the core layer which would
> simplify maintainance.
> 
> At the moment it seems like only some MIPS platforms were using
> MMC_CLKGATE, but at the same time the corresponding host drivers
> were not taking advantage of the mechanism. This made me feel confident
> in removing the feature entirely from the mmc subsystem could be done.
> 
> Also do note that for host drivers that would like to implement clock
> gating as a power save operation, using runtime PM is a far easier
> way to address this. Several host drivers is already fully supporting
> this as well.
> 
> Ulf Hansson (2):
>   MIPS: db1235: Don't use MMC_CLKGATE
>   mmc: core: Remove MMC_CLKGATE

Do I understand correctly, that you're proposing to remove the aggressive 
clock gating feature from MMC? If so, then please take into account my 
NAK. At least two SD / MMC drivers, that I'm aware of, actively used and 
developed on multiple platforms - sh_mmcif and tmio / sdhi implement MMC 
clock gating and rely on it to save power between IO.

Thanks
Guennadi

> 
>  Documentation/mmc/mmc-dev-attrs.txt |   10 --
>  arch/mips/configs/db1235_defconfig  |    1 -
>  drivers/mmc/core/Kconfig            |   10 --
>  drivers/mmc/core/core.c             |  116 +----------------
>  drivers/mmc/core/core.h             |    3 -
>  drivers/mmc/core/debugfs.c          |    5 -
>  drivers/mmc/core/host.c             |  245 -----------------------------------
>  drivers/mmc/core/mmc.c              |    6 +-
>  drivers/mmc/core/sd.c               |   12 +-
>  drivers/mmc/core/sdio.c             |    5 +-
>  drivers/mmc/core/sdio_irq.c         |   10 +-
>  include/linux/mmc/host.h            |   27 ----
>  12 files changed, 12 insertions(+), 438 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
