From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] unshare and simplify omap_hsmmc platform struct
Date: Wed, 24 Sep 2014 10:55:42 +0200
Message-ID: <CAPDyKFq2ZTGQ-cL7kEQatHg3WomNFJbxzDFx4TP8+PkyYc-v-w@mail.gmail.com>
References: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38675 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaIXIzn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Sep 2014 04:55:43 -0400
Received: by mail-qc0-f174.google.com with SMTP id i8so1809726qcq.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Sep 2014 01:55:42 -0700 (PDT)
In-Reply-To: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, pascal.huerst@gmail.com

On 22 September 2014 13:55, Andreas Fenkart <afenkart@gmail.com> wrote:
> mmci and omap_hsmmc share very little fields in the platform

mmci? Should be omap right?

I noticed the similar typo for one of the patches as well.

Kind regards
Uffe

> struct. unsharing significantly simplifies the omap_hsmmc driver
>
> Andreas Fenkart (6):
>   omap_hsmmc: unshare platform data struct with mmci driver
>   omap_hsmmc: remove unused callbacks from platform data struct
>   omap_hsmmc: remove unused fields in platform_data
>   omap_hsmmc: remove unused get_context_loss_count callback
>   omap_hsmmc: remove un-initialized callbacks from platform data
>   omap_hsmmc: remove un-initialized get_cover_state callback
>
>  arch/arm/mach-omap2/hsmmc.c                        |  61 ++--------
>  arch/arm/mach-omap2/hsmmc.h                        |  10 --
>  arch/arm/mach-omap2/mmc.h                          |   6 +-
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   6 +-
>  drivers/mmc/host/omap_hsmmc.c                      | 133 +++------------------
>  include/linux/platform_data/hsmmc-omap.h           | 103 ++++++++++++++++
>  7 files changed, 142 insertions(+), 183 deletions(-)
>  create mode 100644 include/linux/platform_data/hsmmc-omap.h
>
> --
> 2.1.0
>
