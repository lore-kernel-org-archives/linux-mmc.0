From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: remove the check of mmc_card_blockaddr for
 SD cards
Date: Tue, 8 Aug 2017 12:38:13 +0200
Message-ID: <CAPDyKFry8mp6G1dEcGZ9C8dWK5HFH2tOnY-8V6p1jspx2TSiXA@mail.gmail.com>
References: <1502071634-94106-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33576 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdHHKiO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 06:38:14 -0400
Received: by mail-qk0-f177.google.com with SMTP id a77so17228928qkb.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 03:38:14 -0700 (PDT)
In-Reply-To: <1502071634-94106-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 7 August 2017 at 04:07, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Per the SD physical layer simplified specification V4.10,
> section 4.6.2, CSD version 1.0 SD card should use taac, nsac
> and r2w_factor for calculating the data access time. But the
> taac and nsac for SDHC(CSD version 2.0) are always fixed and
> the software should use the recommended value for timeout. When
> parsing the CSD, we sanely set them to zero for SDHC(CSD version
> 2.0), all the calculation for timeout_ns and timeout_clk is zero
> as well. So what we actually want to limit here is either SDHC
> case or unreasonable timeout reported by the cards. In principle
> we should at least be able to remove the bogus check for the
> mmc_card_blockaddr.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
> Changes in v3:
> - still keep data->timeout_clks = 0 for hosts
>
> Changes in v2:
> - rephrase the changelog and only remove mmc_card_blockaddr.
>
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6177eb0..5dd1c00 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -763,7 +763,7 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>                 /*
>                  * SDHC cards always use these fixed values.
>                  */
> -               if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
> +               if (timeout_us > limit_us) {
>                         data->timeout_ns = limit_us * 1000;
>                         data->timeout_clks = 0;
>                 }
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
