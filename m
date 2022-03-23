Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CD1C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Mar 2022 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiCWQZ1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiCWQZ0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2022 12:25:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D41C21B7
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2022 09:23:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h11so2591306ljb.2
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2022 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzP1vvNkzsaJ5TnI4bigf5Qe4Fxkkf/eLtVIshhrzmE=;
        b=J1OX1fAw34+yG5Nlpcl0P5cz3n/8EKiQEuWi5bf9CFoctRGAisxEhv6PZ3B8l67dv9
         I8FNidiQ3x33Ay8zbdnHNZ3F0ay3tx/t0vJXUhrSssxuTy8vZW6rV1OTvbQYs3lnKJxK
         GXvhkX1SRekSngGHpLWy1sJJvhBYTusrAKhlRNC3j2SqY6GNgLGeaksMhzRUOK6Y5bMV
         ES6ziPAqunvkdK+PAZhaqPl8cBqb0DuuFss4oSdX9zAuMpoGmegSH8HbygwJcffFK5Nw
         woCTUhm15Fk78mQs7Ot+yDSvvEN5pBCPjQJ5ge4mlWYKAShHRYbFi6o+krgL4thFshAl
         f8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzP1vvNkzsaJ5TnI4bigf5Qe4Fxkkf/eLtVIshhrzmE=;
        b=VP4chOq4pbFHg7mg+XXJIDoOMSdFGgz//+JACFbYh7dty3LUtDcSvQo4YdRm5I85UL
         zjB4Tj7iG3+TQxV9+828ck9Cp8y67se+IsNOLSo4wjUA+P9s6mgv0L19I7cKxp3dN3ES
         QlIogqX3s76HB/IEH518utKWf9dxj90DT5i5G3+jtyd+4w/9VBKW0grqizo8Xto06VuG
         WIR/Sp6qJ2O7zfyvqScqgW2RSjOjO7ayscXj6A6U/ftUT2V45jSEJjl4iT9Zp0jyRXaW
         sA6oMjHlsh8MqpadT8D5dSiqD3RV6BHiVbyC13qy2Bzg7cFJh7FA5pCGB3n1aRej7m1Z
         SNoQ==
X-Gm-Message-State: AOAM533TOExGcymPMgb+Ba7tTTL7gJGFQ2cj1JFyyQsGM3BAIQPglW/K
        bcMqpXZi3RPLUCgZGuVZCDEZAibwY4cA/c4ygaDwDQ==
X-Google-Smtp-Source: ABdhPJw145yP4OJgMMkbQwrMmz8sk4WrcEbgpT04TroKPcpJMt/drn6pez8KgN1ebxT+cYpKCnArxRMpTDHRAzjjrRM=
X-Received: by 2002:a2e:8255:0:b0:247:dff4:1f with SMTP id j21-20020a2e8255000000b00247dff4001fmr672641ljh.16.1648052634854;
 Wed, 23 Mar 2022 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com> <20220222033931.237638-8-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220222033931.237638-8-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Mar 2022 17:23:18 +0100
Message-ID: <CAPDyKFoOxZqf7YB5nFSuGCYs1+pjYC4eVZkYQ_um9j8PCm3YFg@mail.gmail.com>
Subject: Re: [PATCH V3 7/7] mmc: core: Support UHS-II card access
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     takahiro.akashi@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Jason.Lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> Embed UHS-II access functionality into the MMC request processing flow.
>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index fc3d8d61a97c..d2dcaa64bf27 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -31,6 +31,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/sd.h>
>  #include <linux/mmc/slot-gpio.h>
> +#include <linux/mmc/sd_uhs2.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/mmc.h>
> @@ -42,6 +43,7 @@
>  #include "host.h"
>  #include "sdio_bus.h"
>  #include "pwrseq.h"
> +#include "sd_uhs2.h"
>
>  #include "mmc_ops.h"
>  #include "sd_ops.h"
> @@ -335,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
>
>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       u32 payload[4]; /* for maximum size */
>         int err;
>
>         init_completion(&mrq->cmd_completion);
> @@ -352,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 return err;
>
> +       if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
> +           host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
> +               uhs2_cmd.payload = payload;
> +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> +               sd_uhs2_prepare_cmd(host, mrq);
> +       }
> +
>         led_trigger_event(host->led, LED_FULL);
>         __mmc_start_request(host, mrq);
>
> @@ -431,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
>   */
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       u32 payload[4]; /* for maximum size */
>         int err;
>
>         /*
> @@ -451,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 goto out_err;
>
> +       if (host->uhs2_caps.flags & MMC_UHS2_SUPPORT &&
> +           host->uhs2_caps.flags & MMC_UHS2_INITIALIZED) {
> +               uhs2_cmd.payload = payload;
> +               mrq->cmd->uhs2_cmd = &uhs2_cmd;
> +               sd_uhs2_prepare_cmd(host, mrq);
> +       }
> +
>         err = host->cqe_ops->cqe_request(host, mrq);
>         if (err)
>                 goto out_err;
> @@ -899,8 +919,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
>   */
>  void mmc_set_chip_select(struct mmc_host *host, int mode)
>  {
> -       host->ios.chip_select = mode;
> -       mmc_set_ios(host);
> +       if (!(host->uhs2_caps.flags & MMC_UHS2_INITIALIZED)) {
> +               host->ios.chip_select = mode;
> +               mmc_set_ios(host);
> +       }

As I stated for patch6, rather than having these hacks spread out into
the legacy code, we must not allow the ->set_ios() ops to be invoked
when UHS-II is being used/initialized.

>  }
>

Moreover, I think $subject patch should be squashed into patch6. There
is really no reason to have them split up like this. Or is there?

I have now walked through the series - and it seems like there are a
few more pieces that we need to sort out, but it's certainly getting
better and better.

Kind regards
Uffe
