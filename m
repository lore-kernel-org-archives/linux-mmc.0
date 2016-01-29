From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: make sure clock is enabled when executing ops->card_busy()
Date: Fri, 29 Jan 2016 11:23:39 +0100
Message-ID: <CAPDyKFrv2dVarscYz79svnhBGMy2TYbgePKYyKw_dMJiWmLrUA@mail.gmail.com>
References: <1454009514-6474-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36674 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcA2KXk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 05:23:40 -0500
Received: by mail-yk0-f182.google.com with SMTP id v14so63445910ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jan 2016 02:23:40 -0800 (PST)
In-Reply-To: <1454009514-6474-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>

On 28 January 2016 at 20:31, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> add pm_runtime_get_sync() before access MSDC_PS register

This isn't need as the mmc core does that when claiming the host, see
below commit.

>From that point there have been some additional fixup, as there were
actually some paths when to core invoked some of the host_ops
callbacks, without claiming the host. Although that should also have
been fixed now.

commit 9250aea76bfcbf4c2a7868e5566281bf2bb7af27
mmc: core: Enable runtime PM management of host devices

Kind regards
Uffe

>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 82a97ac..a56b16d 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1054,13 +1054,15 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
>  static int msdc_card_busy(struct mmc_host *mmc)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> -       u32 status = readl(host->base + MSDC_PS);
> +       u32 status;
>
> -       /* check if any pin between dat[0:3] is low */
> -       if (((status >> 16) & 0xf) != 0xf)
> -               return 1;
> +       pm_runtime_get_sync(host->dev);
> +       status = readl(host->base + MSDC_PS);
> +       pm_runtime_mark_last_busy(host->dev);
> +       pm_runtime_put_autosuspend(host->dev);
>
> -       return 0;
> +       /* check if any pin between dat[0:3] is low */
> +       return !!(((status >> 16) & 0xf) != 0xf);
>  }
>
>  static void msdc_request_timeout(struct work_struct *work)
> --
> 1.8.1.1.dirty
>
