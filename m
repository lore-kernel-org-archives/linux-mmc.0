From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: core: support hs speed mode if hs200 mode fails
Date: Tue, 10 May 2016 11:46:53 +0200
Message-ID: <CAPDyKFqNqLGXDPaCtPehSCM2tUS1r1yuYdg1_XJoUxfw-bB0jA@mail.gmail.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
	<1461171092-30631-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35753 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcEJJqy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 05:46:54 -0400
Received: by mail-wm0-f49.google.com with SMTP id e201so170044799wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 02:46:54 -0700 (PDT)
In-Reply-To: <1461171092-30631-3-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <dongas86@gmail.com>

On 20 April 2016 at 18:51, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> Currently if mmc_select_hs200 mode switch fails, MMC core
> can only use legacy mode to run the card.
> Let's retry HS speed mode if HS200 fails.
>
> Before the fix:
> mmc0: mmc_select_hs200 failed, error -74
> : switch to mmc0 failed
> mmc0: new MMC card at address 0001
> mmcblk0: mmc0:0001 Q2J55L 7.12 GiB
> mmcblk0boot0: mmc0:0001 Q2J55L partition 1 2.00 MiB
> mmcblk0boot1: mmc0:0001 Q2J55L partition 2 2.00 MiB
> mmcblk0rpmb: mmc0:0001 Q2J55L partition 3 4.00 MiB
>  mmcblk0: p1 p2
>
> After the fix:
> mmc0: mmc_select_hs200 failed, error -74
> mmc0: new DDR MMC card at address 0001
> mmcblk0: mmc0:0001 Q2J55L 7.12 GiB
> mmcblk0boot0: mmc0:0001 Q2J55L partition 1 2.00 MiB
> mmcblk0boot1: mmc0:0001 Q2J55L partition 2 2.00 MiB
> mmcblk0rpmb: mmc0:0001 Q2J55L partition 3 4.00 MiB
>  mmcblk0: p1 p2
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 55c8201..b573dc7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1315,7 +1315,8 @@ static int mmc_select_timing(struct mmc_card *card)
>
>         if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>                 err = mmc_select_hs200(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
> +
> +       if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS))
>                 err = mmc_select_hs(card);
>
>         if (err && err != -EBADMSG)
> --
> 1.9.1
>
