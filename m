Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33508C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 12:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348206AbiCOMYv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348210AbiCOMYq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 08:24:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DA63D3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 25so26192772ljv.10
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPnb1ATRmSI8xZX+veYE4aEfgSHzzxZV5zRVXcuyhkU=;
        b=MyzIMcUTwXxiaAMPib2hzET3b2cxFOda5RQjUnVvckRXHSqJouuvENc6OiZeEO3ztp
         HA9qUIM8jD4siqP0DvJW4clgq3NdrqWdX2g3rNEP4SAfZwQNf3Ijx5z/DA8wXLdArYXx
         OZfmRzA3CBNjxBzdCxoI0U12ok4oTTMCAlyxjqFXCCsvPhtJCDO7rO0zPyuepsqppvZx
         UJVuHW1nXQLNX67ohVhl1lYk4pm6P9/9z3wU1MTHEN5tBPstKXAGSbqpPtxaLMLvjiV6
         FGq8rAwXOZixu40ziJoyXF23TFGmu/feAktE2VO+dQ14wkxPGuPl0LILRZkXBbYUdlEW
         OkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPnb1ATRmSI8xZX+veYE4aEfgSHzzxZV5zRVXcuyhkU=;
        b=HezEkTJ7Gqm7HsDqJIbUCIV8pi1H2zSYVCd53WjHkq6Wtf900TcY1z6gz+LVvJ4ukS
         ntWwdG6Zawx9xQDRPa8KBPgL5V5V/IjJN2IjVEOm1itVh1HEz9fJYAg4RESSys5Ma68s
         ++0KP/SAeqhcir6R2Ene5aI4sKUifNslrqE8uNPlhb+mgdIc/K12xRWCD/g4BPubdwAe
         6JN+UXEhyZM63SBC10Krmb5bRI1pwyh0zmOzSIvSa5QvQ0uJxSq1qjgnQHP7crv0KW3h
         T5ngpk7SsO2UXQCC0x5+unHaeZdqbkAD5S6SVPLynZgeIm66DK/p2JVEoJD4wzfJ/Lbx
         Mo3A==
X-Gm-Message-State: AOAM530Bqbkf/I2dtS7CKl5Gej30QtWlF+UWVyKopPvokaBeeAzUkHhI
        Qyc3t8d0fQJ4hbRjS9SXFVoE0FpkuEoHy42vhmpE3g==
X-Google-Smtp-Source: ABdhPJzvZgzztoUTLaSHmueiCTGTfSPqCknLmUmw+wNq7wRGhWufTTo6/FZarCRlzAyJi8R7+Rl557qFFdU5IwbOkAs=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr17459702lji.367.1647347009946; Tue, 15
 Mar 2022 05:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220308071415.1093393-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220308071415.1093393-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:53 +0100
Message-ID: <CAPDyKFoJXErrVyY3EJim3Yvn7ReeBzU5F+ic83KRBNJ1riROpg@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci_mmc: Handle error for clk_enable
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Mar 2022 at 08:14, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.
>
> Fixes: bbce5802afc5 ("davinci: mmc: updates to suspend/resume implementation")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/davinci_mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 2a757c88f9d2..80de660027d8 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1375,8 +1375,12 @@ static int davinci_mmcsd_suspend(struct device *dev)
>  static int davinci_mmcsd_resume(struct device *dev)
>  {
>         struct mmc_davinci_host *host = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_enable(host->clk);
> +       if (ret)
> +               return ret;
>
> -       clk_enable(host->clk);
>         mmc_davinci_reset_ctrl(host, 0);
>
>         return 0;
> --
> 2.25.1
>
