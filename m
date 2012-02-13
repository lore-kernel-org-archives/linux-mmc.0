From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH] mmc: core: Substitute mmc_flush_cash for mmc_cache_ctrl
 in suspend
Date: Tue, 14 Feb 2012 02:04:04 +0530
Message-ID: <CAKLKtzd486AB8U7kxqo1_9FebD-MB-Nm2V4zBPHthQGDpPjKAQ@mail.gmail.com>
References: <000101cce7a7$fc0df6b0$f429e410$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38272 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab2BMUeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2012 15:34:05 -0500
Received: by wics10 with SMTP id s10so3727062wic.19
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2012 12:34:04 -0800 (PST)
In-Reply-To: <000101cce7a7$fc0df6b0$f429e410$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, ygardi@codeaurora.org

On 10 February 2012 09:26, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> After the cache is disabled in suspend, enabling cache can be done by
> mmc_init_card in resume. Currently this call path has been changed. I=
n
> case of sleep mode mmc_init_card isn't called. So mmc_cache_ctrl need=
 to
> be replaced with mmc_flush_cache in suspend.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 =A09 +++++++--
> =A01 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8a19143..70e25d8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2329,9 +2329,14 @@ EXPORT_SYMBOL(mmc_card_can_sleep);
> =A0*/
> =A0int mmc_flush_cache(struct mmc_card *card)
> =A0{
> - =A0 =A0 =A0 struct mmc_host *host =3D card->host;
> + =A0 =A0 =A0 struct mmc_host *host;
> =A0 =A0 =A0 =A0int err =3D 0;
>
> + =A0 =A0 =A0 if (!card)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 host =3D card->host;
> +
> =A0 =A0 =A0 =A0if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> @@ -2401,7 +2406,7 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0cancel_delayed_work(&host->detect);
> =A0 =A0 =A0 =A0mmc_flush_scheduled_work();
> =A0 =A0 =A0 =A0if (mmc_try_claim_host(host)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_cache_ctrl(host, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_flush_cache(host->card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_do_release_host(host);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EBUSY;
> --
> 1.7.0.4

Thanks for the changes.
Reviewed-by: Saugata Das <saugata.das@linaro.org>

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
