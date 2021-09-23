Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF3C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 11:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69FB610D1
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 11:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbhIWLvr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbhIWLvp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 07:51:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61802C061757
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 04:50:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b15so25010835lfe.7
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuhjfnIzHPL8k/0hEDGsJJcwbt02W2zMnf1vEQ+PDis=;
        b=VGU6L3poPyGvDF/aXFsDDNXQCN6mrAJdddBE1kYrMR5yGUwgqOq8Ka50kemkwIQBMd
         xcf75qW+cASxwx2aKMQJeW+smC0+uRSNVmsAp5ONF0enm/vmc7NeyiBnQ/KzflwyFJOI
         P1lieRAYSO25kGZ78vNXKGRkohrMSMU6HoCFq0ikLyBVeRJsvTC04BnNaxmWF3TxnDLc
         TI+CJee7tnr2wfApqfiQ39KWQcsebq37lX4j4bGXcaFOLoplJnRtT1iQeQZrVbkShI6n
         TDVIS6SzZsoeliR5AhmzrYGpxG8IpxMBT5bHfHKnhY+rF08K/as7N91N1ZV+JQLZMv0K
         V/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuhjfnIzHPL8k/0hEDGsJJcwbt02W2zMnf1vEQ+PDis=;
        b=jiyGxuE4NRhmplHHS5BcJlcYa4PhdN4rZRfxvRfRpiGJg56+9IQHw7R2Mkc+dIUAap
         XNrF2f36EB9gFHhSJCuYWOfHQB8zNt2YvaC3NyfQ3bLuSso/4DnrAffTtViQfzHKIPR8
         4MFebBoNKycDEewQ7ydIvtCZNPzFXJWGcKvPmMoITeFUdH6oyH8bIlA0cQ5Yx2h66alU
         3i00CgUoUTfA3VGAOQ5qAEoybeLdGeOCVAr1xpv++3RHkfQVc4YRWNjhmPjQjohtgKQ2
         1kkpE4Gq/3ONpQLM//7QuKtAmiOhmE1DO5jEKO1ZiCq0/WwlkhrYP8WF0oxgzlaeIR2V
         jJ2A==
X-Gm-Message-State: AOAM530jqcDhXaVp4TCNuVTKwJxaOk5iv5JMtaro75bA1sI/OX73XABt
        /bLDja3XOeB8lr21jgDKUEuWCWrEyX64xYo/8IbSow==
X-Google-Smtp-Source: ABdhPJxWkcEBeEeQpHl0z0PoIbho+KHQTVz5XNhEXvCE7yAmB2lRq3X91tXNby/WaVO/Vwb4Bp4hfOzgrqT8EjU/Zug=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr3739550lfb.71.1632397811612;
 Thu, 23 Sep 2021 04:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210914182023.8103-1-wsa+renesas@sang-engineering.com> <20210914182023.8103-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210914182023.8103-2-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 13:49:35 +0200
Message-ID: <CAPDyKFrqwo2+W4uSGwWYRmNHWAZC1cRozVs7GXXcBJ23FCU_bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: core: add helper to send STOP
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Sept 2021 at 20:20, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> There was a helper in the block layer already, but we need it in other
> parts soon as well. So, make it more generic by adding the 'retries'
> parameter and add the helper to mmc_ops.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/core/block.c   | 14 +-------------
>  drivers/mmc/core/mmc_ops.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 431af5e8be2f..58f1aa5ac33f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1642,18 +1642,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  #define MMC_DATA_RETRIES       2
>  #define MMC_NO_RETRIES         (MMC_MAX_RETRIES + 1)
>
> -static int mmc_blk_send_stop(struct mmc_card *card, unsigned int timeout)
> -{
> -       struct mmc_command cmd = {
> -               .opcode = MMC_STOP_TRANSMISSION,
> -               .flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
> -               /* Some hosts wait for busy anyway, so provide a busy timeout */
> -               .busy_timeout = timeout,
> -       };
> -
> -       return mmc_wait_for_cmd(card->host, &cmd, 5);
> -}
> -
>  static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
>  {
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> @@ -1663,7 +1651,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
>
>         mmc_retune_hold_now(card->host);
>
> -       mmc_blk_send_stop(card, timeout);
> +       mmc_send_stop(card->host, timeout, 5);
>
>         err = mmc_poll_for_busy(card, timeout, false, MMC_BUSY_IO);
>
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index ae25ffc2e870..6e9d1b6b9e55 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -9,6 +9,7 @@
>  #define _MMC_MMC_OPS_H
>
>  #include <linux/types.h>
> +#include <linux/mmc/mmc.h>
>
>  enum mmc_busy_cmd {
>         MMC_BUSY_CMD6,
> @@ -57,5 +58,18 @@ int mmc_cmdq_enable(struct mmc_card *card);
>  int mmc_cmdq_disable(struct mmc_card *card);
>  int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
>
> +static inline int mmc_send_stop(struct mmc_host *host, unsigned int timeout,

Nitpick: Would you mind renaming timeout to timeout_ms, as to clarify its unit.

> +                          unsigned int retries)
> +{
> +       struct mmc_command cmd = {
> +               .opcode = MMC_STOP_TRANSMISSION,
> +               .flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
> +               /* Some hosts wait for busy anyway, so provide a busy timeout */
> +               .busy_timeout = timeout,
> +       };
> +
> +       return mmc_wait_for_cmd(host, &cmd, retries);
> +}
> +
>  #endif
>
> --
> 2.30.2
>

Otherwise, this looks good to me!

Kind regards
Uffe
