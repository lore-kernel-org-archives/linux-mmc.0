From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/9] mmc: core: Allow CMD13 polling when switch to HS200 mode
Date: Thu, 17 Nov 2016 16:02:43 +0100
Message-ID: <CAPDyKFrDP_K_muRArcNrMGBeTLB_XWawcMc9yb82k4cdd8z0eQ@mail.gmail.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org> <e003f72a-6084-eb1a-6b44-c6a11d93b3ae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36084 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934312AbcKQRqW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 12:46:22 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so325962564wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2016 09:46:21 -0800 (PST)
In-Reply-To: <e003f72a-6084-eb1a-6b44-c6a11d93b3ae@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 17 November 2016 at 11:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/11/16 12:51, Ulf Hansson wrote:
>> In cases when the mmc host doesn't support HW busy detection, polling for
>> busy by using CMD13 is beneficial. The reasons have already been explained
>> in earlier change logs.
>>
>> To allow polling with CMD13, let's provide MMC_TIMING_MMC_HS200 as the
>> timing parameter to __mmc_switch(), which makes sure the mmc host and the
>> mmc card operates at the same bus timing during the polling.
>
> I have reports of cases where CMD13 always gives CRC errors after switch
> to HS200.  Currently we are assuming the low frequency should mean that
> won't happen, but it does in some cases.  That is not entirely surprising
> since HS200 needs tuning at the final operating frequency.

>From a logical point of view and if tuning is needed also for the CMD
line, this somehow make sense.

However, this is *not* how the JEDEC spec describes the HS200 switch
sequence. It is clearly stated that the host should validate the CM6
status via sending a CMD13 command, *before* performing tuning.

Could it be that the observations about the CRC errors, is related to
a controller/driver issue and not a card issue?

>
> What I would like to do for hosts that support busy waiting or DAT0 polling
> (i.e. MMC_CAP_WAIT_WHILE_BUSY or host->ops->card_busy), is to ignore CRC
> errors from the CMD13 that checks the switch status.  The main reason for
> doing that is that we really expect the switch to succeed and, given HS200
> tuning requirement, the CRC error is not a reliable means of determining
> that it hasn't.

Hmm. So what you are saying is that CMD13 polling for HS200 doesn't
work, as tuning is needed.

So, to me that means we need to fall-back to use the generic CMD6
timeout instead (when HW busy detection isn't supported).

>
> With the existing code I would just change the err check:
>
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3268fcd3378d..c8862c58b60b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1387,6 +1387,13 @@ static int mmc_select_hs200(struct mmc_card *card)
>
>                 err = mmc_switch_status(card);
>                 /*
> +                * For HS200, CRC errors are not a reliable way to know the
> +                * switch failed. If there really is a problem, we would expect
> +                * tuning will fail and the result ends up the same.
> +                */
> +               if (err == -EILSEQ)
> +                       err = 0;
> +               /*

I don't think ignoring CRC errors is reliable when verifying the CMD6
status. My point is that we must not parse the status, in case of CRC
errors as it can't be trusted.

So, then we might as well just ignore validating the CMD6 status
altogether, but instead always move on to the tuning and hope that it
succeeds.

I think the CMD21 (tuning) should set the ILLEGAL COMMAND if HS200
mode isn't enabled, so we could check that. Anyway, we should fail
with the tuning if the earlier HS200 switch also failed. Don't you
think?

>                  * mmc_select_timing() assumes timing has not changed if
>                  * it is a switch error.
>                  */
>
>
> Then to support polling:
>
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c8862c58b60b..66d8d57ae2fb 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1352,6 +1352,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>         unsigned int old_timing, old_signal_voltage;
> +       bool send_status;
>         int err = -EINVAL;
>         u8 val;
>
> @@ -1373,18 +1374,20 @@ static int mmc_select_hs200(struct mmc_card *card)
>          * switch to HS200 mode if bus width is set successfully.
>          */
>         err = mmc_select_bus_width(card);
> -       if (err > 0) {
> -               val = EXT_CSD_TIMING_HS200 |
> -                     card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> -               err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                                  EXT_CSD_HS_TIMING, val,
> -                                  card->ext_csd.generic_cmd6_time, 0,
> -                                  true, false, true);
> -               if (err)
> -                       goto err;
> -               old_timing = host->ios.timing;
> -               mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> +       if (err <= 0)
> +               goto err;
> +
> +       send_status = !(host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
> +                     !host->ops->card_busy;
> +       old_timing = host->ios.timing;
> +
> +       val = EXT_CSD_TIMING_HS200 |
> +             card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> +       err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING, val,
> +                          card->ext_csd.generic_cmd6_time,
> +                          MMC_TIMING_MMC_HS200, true, send_status, true);
>
> +       if (!err && !send_status) {
>                 err = mmc_switch_status(card);
>                 /*
>                  * For HS200, CRC errors are not a reliable way to know the
>
>
>
> Thoughts?

Well, I think the main problem is that if we have cards that returns
CRC errors even after the HS200 switch, then we can't use polling, as
we can't trust to parse the CMD6 status.

Kind regards
Uffe
