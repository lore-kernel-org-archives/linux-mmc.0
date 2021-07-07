Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666DC07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE60161C78
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 11:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhGGMAZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGMAZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 08:00:25 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A8C06175F
        for <linux-mmc@vger.kernel.org>; Wed,  7 Jul 2021 04:57:44 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o7so1429827vss.5
        for <linux-mmc@vger.kernel.org>; Wed, 07 Jul 2021 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O3GY2fEQnMWGEIJc61SHZMVxw1rzAtXQZu5zS1i7KN4=;
        b=zEkq6kuvDpttg+PECmsCahXUVcdX3MfVDpcfMsz1yDEslJX7uR+l24k6qX4F1pgJT2
         naXQ8WV0/jqWfgFQ2aExdJexyM0Rqf7Yas197mi5RZVziC1f8R36dlCK7b1EkzkajgjD
         Mb8NWN+62jc68bQy5wMZpIq76BaeLPPx7RTBFvf+NgFHDehLIoCuzw7XrWmrOlTNwjxz
         eLN4N5Rm0ayxq2VOcN5LSoOYk4HG5aVy4KpcrRF8w2F6KSsD8u42RjtW2Mw1FxsdNT2G
         owICGR7G5CfanycfPknlop6l1D2bvC+evqRNpCZn5Xq33BJARhQKXcW0iAlv7GllMOvH
         TU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O3GY2fEQnMWGEIJc61SHZMVxw1rzAtXQZu5zS1i7KN4=;
        b=o8jzJmo4DBO1s7HzrHLz/HIM6+POojEVkF+f3ngIa61PSGa2LubGNEecK8Xtnu+Gc/
         cLPxgJR+V0BnpyEzHWYz9oEE0Q023nbe9S0+U+G6T/gpn2B6dYRA1sgFROkUFYI+JaFj
         ilCAp986QVOogeaMbtH8H2y1MD++3CsF42bbwCOXsYHfSA6TJfjI7ELCYcF+6FTlWhMQ
         tX1o/Yp7ZiRofDrfZmj+kF1A0y/R9ra2UsCx9ovm89uIj2IiM4jFPDHiN9iYeev0FubI
         v7u2rInZnPY2jCCgbEN+3oOHnyagGtVWvC5O/TP/tGODzsQ2km5mDuWy/n8ERiStdOi/
         v3Ng==
X-Gm-Message-State: AOAM5316xbWh4CkvTheKzLD8nc80VTT6Oq1vxzK56wPmj/4QHitLwCKK
        oORJ5+kOYNn41ohk4iULsiqKT+CM10w9kRv/du+849fi3OpN9Xew
X-Google-Smtp-Source: ABdhPJxuS1nIy8es5nnvzwBpklq1CgC7HcO0aABRfqnbYWVWBpgtaLZhphDhqCH+Z5tU0MYozHNbz2X0lZVQXW8CMrY=
X-Received: by 2002:a67:bd0f:: with SMTP id y15mr20279260vsq.19.1625659063379;
 Wed, 07 Jul 2021 04:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680575489E508DC75D84857C41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680575489E508DC75D84857C41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Jul 2021 13:57:06 +0200
Message-ID: <CAPDyKFrCtRTHZYRjUecvrqr=YyhrTw+HXtdLRHeOTxoK94iSRg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: block: Differentiate busy and PROG state
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Jul 2021 at 10:27, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Prevent race condition with ioctl commands
>
> To fully prevent a race condition where the next
> issued command will be rejected as the card is no
> longer signalling busy but not yet back in TRAN state.
> The card may be in PROG state without signalling busy,
> for some of the commands that are only R1, but also
> for R1b commands, the card will signal non-busy as soon
> as receive buffers are free again, but the card has
> not finished handling the command and may therefore be
> in PROG.

Can you please point me to the corresponding information in the spec
that states that the above behavior is correct?

In principle what you are saying is that busy signalling on DAT0 is
*entirely* broken, at least for some cards and some commands.

> Since the next command is not known at the time of
> completion we must assume that it may be one that can
> only be accepted in TRAN state.
> Therefore we only consider a PROG command completed
> when we have polled for TRAN.

Right. See more comments about this further below.

>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c   | 86 ++++++++++++++++++++++++++++++++++----
>  drivers/mmc/core/mmc_ops.c |  2 +-
>  include/linux/mmc/mmc.h    | 10 +++--
>  include/linux/mmc/sd.h     |  3 ++
>  4 files changed, 87 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 88f4c215caa6..cb78690647bf 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -411,7 +411,34 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc=
_cmd __user *ic_ptr,
>         return 0;
>  }
>
> -static int card_busy_detect(struct mmc_card *card, unsigned int timeout_=
ms,
> +static int is_prog_cmd(struct mmc_command *cmd)
> +{
> +       /*
> +        * Cards will move to programming state (PROG) after these comman=
ds.
> +        * So we must not consider the command as completed until the car=
d
> +        * has actually returned back to TRAN state.
> +        */
> +       switch (cmd->opcode) {
> +       case MMC_STOP_TRANSMISSION:

This has an R1B response, hence we already do the proper polling that is ne=
eded.

In other words, we don't need to explicitly check for this command
here, as we are already checking the response type (R1B) in
__mmc_blk_ioctl_cmd().

> +       case MMC_WRITE_DAT_UNTIL_STOP:

What's this used for? It's obsolete, at least in the eMMC spec. Please drop=
 it.

> +       case MMC_WRITE_BLOCK:
> +       case MMC_WRITE_MULTIPLE_BLOCK:

These are already supported via the generic block interface, please
drop the checks.

> +       case MMC_PROGRAM_CID:
> +       case MMC_PROGRAM_CSD:

Let's discuss these, since they have R1 responses.

Although, according to the eMMC spec, the card moves to rcv state, not
the prg state as you refer to in the commit message. Normally, we
don't need to poll for busy/tran completion of these commands.

Have you observed through proper tests that this is actually needed?

> +       case MMC_SET_WRITE_PROT:
> +       case MMC_CLR_WRITE_PROT:
> +       case MMC_ERASE:

The three above have R1B, please drop them from here as they are
already supported correctly.

> +       case MMC_LOCK_UNLOCK:

Again, this has an R1 response and the card moves to rcv state.
Normally we shouldn't need to poll, but I have to admit that the eMMC
spec isn't really clear on what will happen when using the "forced
erase" argument. The spec mentions a 3 minute timeout....

> +       case MMC_SET_TIME: /* Also covers SD_WRITE_EXTR_SINGLE */
> +       case MMC_GEN_CMD:
> +       case SD_WRITE_EXTR_MULTI:

Are these actually being used? If not, please drop them from being
supported. I don't want to encourage crazy operations being issued
from userspace.

> +               return true;
> +       default:
> +               return false;
> +       }
> +}

Overall, it looks like we need to add a check for MMC_LOCK_UNLOCK to
poll for busy, but that's it, I think.

> +
> +static int card_poll_until_tran(struct mmc_card *card, unsigned int time=
out_ms,
>                             u32 *resp_errs)
>  {
>         unsigned long timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> @@ -433,8 +460,7 @@ static int card_busy_detect(struct mmc_card *card, un=
signed int timeout_ms,
>                         *resp_errs |=3D status;
>
>                 /*
> -                * Timeout if the device never becomes ready for data and=
 never
> -                * leaves the program state.
> +                * Timeout if the device never returns to TRAN state.
>                  */
>                 if (done) {
>                         dev_err(mmc_dev(card->host),
> @@ -442,6 +468,41 @@ static int card_busy_detect(struct mmc_card *card, u=
nsigned int timeout_ms,
>                                  __func__, status);
>                         return -ETIMEDOUT;
>                 }
> +       } while (R1_CURRENT_STATE(status) !=3D R1_STATE_TRAN);
> +
> +       return err;
> +}
> +
> +static int card_busy_detect(struct mmc_card *card, unsigned int timeout_=
ms,
> +                           u32 *resp_errs)
> +{
> +       unsigned long timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> +       int err =3D 0;
> +       u32 status;
> +
> +       do {
> +               bool done =3D time_after(jiffies, timeout);
> +
> +               err =3D __mmc_send_status(card, &status, 5);
> +               if (err) {
> +                       dev_err(mmc_dev(card->host),
> +                               "error %d requesting status\n", err);
> +                       return err;
> +               }
> +
> +               /* Accumulate any response error bits seen */
> +               if (resp_errs)
> +                       *resp_errs |=3D status;
> +
> +               /*
> +                * Timeout if the device never becomes ready for data.
> +                */
> +               if (done) {
> +                       dev_err(mmc_dev(card->host),
> +                               "Card remained busy! %s status: %#x\n",
> +                                __func__, status);
> +                       return -ETIMEDOUT;
> +               }
>         } while (!mmc_ready_for_data(status));

I don't quite understand what we accomplish with polling for TRAN
state in one case and in the other case, both TRAN and READY_FOR_DATA.
Why can't we always poll for TRAN and READY_FOR_DATA? It should work
for all cases, no?

>
>         return err;
> @@ -596,12 +657,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *car=
d, struct mmc_blk_data *md,
>
>         if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) =
{
>                 /*
> -                * Ensure RPMB/R1B command has completed by polling CMD13
> -                * "Send Status".
> +                * Ensure card is no longer signalling busy by polling CM=
D13.
>                  */
>                 err =3D card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
>         }
>
> +       if (is_prog_cmd(&cmd)) {
> +               /*
> +                * Ensure card has returned back to TRAN state
> +                * and is ready to accept a new command.
> +                */
> +               err =3D card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NU=
LL);
> +       }
> +
>         return err;
>  }
>
> @@ -1630,7 +1698,7 @@ static int mmc_blk_fix_state(struct mmc_card *card,=
 struct request *req)
>
>         mmc_blk_send_stop(card, timeout);
>
> -       err =3D card_busy_detect(card, timeout, NULL);
> +       err =3D card_poll_until_tran(card, timeout, NULL);
>
>         mmc_retune_release(card->host);
>
> @@ -1662,7 +1730,7 @@ static void mmc_blk_read_single(struct mmc_queue *m=
q, struct request *req)
>                         goto error_exit;
>
>                 if (!mmc_host_is_spi(host) &&
> -                   !mmc_ready_for_data(status)) {
> +                   !mmc_tran_and_ready_for_data(status)) {
>                         err =3D mmc_blk_fix_state(card, req);
>                         if (err)
>                                 goto error_exit;
> @@ -1784,7 +1852,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue=
 *mq, struct request *req)
>
>         /* Try to get back to "tran" state */
>         if (!mmc_host_is_spi(mq->card->host) &&
> -           (err || !mmc_ready_for_data(status)))
> +           (err || !mmc_tran_and_ready_for_data(status)))
>                 err =3D mmc_blk_fix_state(mq->card, req);
>
>         /*
> @@ -1854,7 +1922,7 @@ static int mmc_blk_card_busy(struct mmc_card *card,=
 struct request *req)
>         if (mmc_host_is_spi(card->host) || rq_data_dir(req) =3D=3D READ)
>                 return 0;
>
> -       err =3D card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
> +       err =3D card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, &status);
>
>         /*
>          * Do not assume data transferred correctly if there are any erro=
r bits
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 973756ed4016..a0be45118a93 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -465,7 +465,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>         if (err)
>                 return err;
>
> -       *busy =3D !mmc_ready_for_data(status);
> +       *busy =3D !mmc_tran_and_ready_for_data(status);
>         return 0;
>  }

Kind regards
Uffe
