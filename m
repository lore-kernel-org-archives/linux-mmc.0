From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: mmc: Relax checking for switch errors after
 HS200 switch
Date: Thu, 1 Dec 2016 11:18:06 +0100
Message-ID: <CAPDyKFpxHVYc2wYc-yV3YLa=NKg1k1aktKhzCKfaZ2oaA_QLSQ@mail.gmail.com>
References: <1479988969-1747-1-git-send-email-adrian.hunter@intel.com> <1479988969-1747-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:35232 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbcLAKSJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 05:18:09 -0500
Received: by mail-wj0-f180.google.com with SMTP id v7so199966468wjy.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 02:18:08 -0800 (PST)
In-Reply-To: <1479988969-1747-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 24 November 2016 at 13:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> The JEDEC specification indicates CMD13 can be used after a HS200 switch
> to check for errors. However in practice some boards experience CRC errors
> in the CMD13 response. Consequently, for HS200, CRC errors are not a
> reliable way to know the switch failed. If there really is a problem, we
> would expect tuning will fail and the result ends up the same. So change
> the error condition to ignore CRC errors in that case.

I agree, this seems like a good idea.

However...

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3268fcd3378d..34d30e2a09ff 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1223,7 +1223,12 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
>         err = mmc_switch_status(card);
> -       if (err)
> +       /*
> +        * For HS200, CRC errors are not a reliable way to know the switch
> +        * failed. If there really is a problem, we would expect tuning will
> +        * fail and the result ends up the same.
> +        */
> +       if (err && err != -EILSEQ)

I would rather change mmc_switch_status() to take a new parameter,
which tells it about ignoring CRC errors.

The reason is simply that I think these changes should probably apply
to HS400 as well, and then it just gets lots of duplicated code for
the same error check.

>                 goto out_err;
>
>         mmc_set_bus_speed(card);
> @@ -1387,6 +1392,14 @@ static int mmc_select_hs200(struct mmc_card *card)
>
>                 err = mmc_switch_status(card);
>                 /*
> +                * For HS200, CRC errors are not a reliable way to know the
> +                * switch failed. If there really is a problem, we would expect
> +                * tuning will fail and the result ends up the same.
> +                */
> +               if (err == -EILSEQ)
> +                       err = 0;
> +
> +               /*
>                  * mmc_select_timing() assumes timing has not changed if
>                  * it is a switch error.
>                  */
> --
> 1.9.1
>

Moreover, and somewhat related to this change:

Do we want to change mmc_switch_status() to be able to tell
mmc_send_status() about the number of command retries? Currently it
defaults to MMC_CMD_RETRIES, but I guess we only want to send *one*
CMD13?

Kind regards
Uffe
