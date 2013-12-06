From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] mmc: Do not call get_cd for non removable cards
Date: Fri, 6 Dec 2013 09:31:00 +0100
Message-ID: <CAPDyKFqn=tZPEz2SWrRRvDGkkZb_OUv7aA_F_NhzQfW_=J2x6Q@mail.gmail.com>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
	<1386250491-4708-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:62202 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3LFIbA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 03:31:00 -0500
Received: by mail-qe0-f51.google.com with SMTP id 1so261801qee.24
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2013 00:31:00 -0800 (PST)
In-Reply-To: <1386250491-4708-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5 December 2013 14:34, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Non removable cards are always present, so do not call get_cd for them.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 57a2b40..098374b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2460,7 +2460,8 @@ void mmc_rescan(struct work_struct *work)
>          */
>         mmc_bus_put(host);
>
> -       if (host->ops->get_cd && host->ops->get_cd(host) == 0) {
> +       if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
> +                       host->ops->get_cd(host) == 0) {
>                 mmc_claim_host(host);
>                 mmc_power_off(host);
>                 mmc_release_host(host);
> --
> 1.8.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
