Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC47C07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 08:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4671E6198D
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 08:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGFInt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhGFInt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 04:43:49 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09847C06175F
        for <linux-mmc@vger.kernel.org>; Tue,  6 Jul 2021 01:41:11 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id h16so1569989vkk.4
        for <linux-mmc@vger.kernel.org>; Tue, 06 Jul 2021 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xs0RpwlA6WTOw/ERwYypx9u87kguf+u5/j03m73M4fY=;
        b=AVHbPaqPIkfWQ0MNrI11bmb4iF+duXq2YIl+bBKksqUlw2O8NylYmSuVo8mB1KFVEu
         Ux3KEr7ecU2HPCsGfE7mGIQayqxERDuK3zy3Ki4l09LqdB7T/nEq7ccY+M/hwNhNfPE/
         IvqdDL/dt1kLE7Y4bTLGb9DtmG/sN8G0HI7mHIyNMbOKzM+WJxql3MaAWfOGOXjsYGP2
         uOeucYzyhYmBJL5v0ViY/i10gdtCAG6cm6/CnzaC6NlRcpb6blXPnZivhYUOEKV+TNRF
         kwY79RpD7LaeeuNiI63r2sjC2c4km1VKbGEG+m9iG6WOPNqRYWDSCizm3Xy1AXSuzlU3
         dNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xs0RpwlA6WTOw/ERwYypx9u87kguf+u5/j03m73M4fY=;
        b=QUEkLLdLexBw/ZPTustspe8OkGT1+bdkRnUbGzyh97nXMGqGyLlQO6LTAcy7XnmcZX
         Iy1tpCjJEzQSUUR2CmYYJg1AqVfeWJDqNcMQevsNenRcqEpcrfeTeQsobqyxtvl/pQh1
         fLrAEFXISRUrRDpV7NEBMnDPiutaCjxe7BRKTP/vPrvfC7IqkBI5HavPHbGCp/K2r4ca
         z14mLtyo4ehulhgWvSi1rZi1BYR56VMubMXkCR54+jTuGpDuZWLfzVBMxxjuns5cgggD
         jD9aixN1FFLfYbsNkjrB0mtFpXoYn1onKKVv+YRixpa1vkvCyVD3GQwXRqvG/AxZKEQG
         PlRg==
X-Gm-Message-State: AOAM532/YPGdklUlW5mUMt/XSqcc2NfGoh7TB0UjKtkeaWcuZ8qQnBJz
        kMFZftP+OqoINZTskd9sD0+X4u7kM4/NlrIhwLVtiA==
X-Google-Smtp-Source: ABdhPJx2NBe+23V1wjwA/oLVG448+9TGvolKnkDzjzwuacqtXPjo2IcohGMq7A1EkoyByjeQ3UdgEu2KTI4qwqUVlmM=
X-Received: by 2002:a1f:cf47:: with SMTP id f68mr12267032vkg.7.1625560870031;
 Tue, 06 Jul 2021 01:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Jul 2021 10:40:33 +0200
Message-ID: <CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Differentiate busy and non-TRAN state
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 6 Jul 2021 at 10:20, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Prevent race condition with ioctl commands
>
> Wait for both, a card no longer signalling busy
> and it being returned back to TRAN state.
> A card not signaling busy does not mean it is
> ready to accept new regular commands.
> Instead for a command to be done it should not only
> no longer signal busy but also return back to TRAN state,
> at least for commands that eventually transition back
> to TRAN. Otherwise the next ioctl command may be rejected
> as the card is still in PROG state after the previous command.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 84 +++++++++++++++++++++++++++++++++++-----
>  include/linux/mmc/mmc.h  |  9 +++--
>  2 files changed, 80 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 88f4c215caa6..dda10ccee37f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -411,7 +411,32 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc=
_cmd __user *ic_ptr,
>         return 0;
>  }
>
> -static int card_busy_detect(struct mmc_card *card, unsigned int timeout_=
ms,
> +static int is_return_to_tran_cmd(struct mmc_command *cmd)
> +{
> +       /*
> +        * Cards will never return to TRAN after completing
> +        * identification commands or MMC_SEND_STATUS if they are not sel=
ected.
> +        */
> +       switch (cmd->opcode) {
> +       case MMC_GO_IDLE_STATE:
> +       case MMC_SEND_OP_COND:
> +       case MMC_ALL_SEND_CID:
> +       case MMC_SET_RELATIVE_ADDR:
> +       case MMC_SET_DSR:
> +       case MMC_SLEEP_AWAKE:
> +       case MMC_SELECT_CARD:
> +       case MMC_SEND_CSD:
> +       case MMC_SEND_CID:
> +       case MMC_SEND_STATUS:
> +       case MMC_GO_INACTIVE_STATE:
> +       case MMC_APP_CMD:
> +               return false;
> +       default:
> +               return true;
> +       }
> +}

What exactly are you trying to do with the user space program through
the mmc ioctl with all these commands? The mmc ioctl interface is not
designed to be used like that.

In principle, it looks like we should support a complete
re-initialization of the card. I am sorry, but no thanks! This doesn't
work, but more importantly, this should be managed solely by the
kernel, in my opinion.

> +
> +static int card_poll_until_tran(struct mmc_card *card, unsigned int time=
out_ms,
>                             u32 *resp_errs)
>  {
>         unsigned long timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> @@ -433,8 +458,7 @@ static int card_busy_detect(struct mmc_card *card, un=
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
> @@ -442,6 +466,41 @@ static int card_busy_detect(struct mmc_card *card, u=
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
>
>         return err;
> @@ -596,12 +655,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *car=
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
> +       if (is_return_to_tran_cmd(&cmd)) {
> +               /*
> +                * Ensure card has returned back to TRAN state (e.g. from=
 PROG)
> +                * and is ready to accept a new command.
> +                */
> +               err =3D card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NU=
LL);
> +       }
> +
>         return err;
>  }
>
> @@ -1630,7 +1696,7 @@ static int mmc_blk_fix_state(struct mmc_card *card,=
 struct request *req)
>
>         mmc_blk_send_stop(card, timeout);
>
> -       err =3D card_busy_detect(card, timeout, NULL);
> +       err =3D card_poll_until_tran(card, timeout, NULL);
>
>         mmc_retune_release(card->host);
>
> @@ -1662,7 +1728,7 @@ static void mmc_blk_read_single(struct mmc_queue *m=
q, struct request *req)
>                         goto error_exit;
>
>                 if (!mmc_host_is_spi(host) &&
> -                   !mmc_ready_for_data(status)) {
> +                   !mmc_tran_and_ready_for_data(status)) {
>                         err =3D mmc_blk_fix_state(card, req);
>                         if (err)
>                                 goto error_exit;
> @@ -1784,7 +1850,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue=
 *mq, struct request *req)
>
>         /* Try to get back to "tran" state */
>         if (!mmc_host_is_spi(mq->card->host) &&
> -           (err || !mmc_ready_for_data(status)))
> +           (err || !mmc_tran_and_ready_for_data(status)))
>                 err =3D mmc_blk_fix_state(mq->card, req);
>
>         /*
> @@ -1854,7 +1920,7 @@ static int mmc_blk_card_busy(struct mmc_card *card,=
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
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d9a65c6a8816..9ae27504cbc9 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -163,10 +163,11 @@ static inline bool mmc_op_multi(u32 opcode)
>
>  static inline bool mmc_ready_for_data(u32 status)
>  {
> -       /*
> -        * Some cards mishandle the status bits, so make sure to check bo=
th the
> -        * busy indication and the card state.
> -        */
> +       return status & R1_READY_FOR_DATA;

mmc_ready_for_data() is also being called from mmc_busy_cb(). The
check for R1_STATE_TRAN is needed there.

> +}
> +
> +static inline bool mmc_tran_and_ready_for_data(u32 status)
> +{
>         return status & R1_READY_FOR_DATA &&
>                R1_CURRENT_STATE(status) =3D=3D R1_STATE_TRAN;
>  }
> --

Kind regards
Uffe
