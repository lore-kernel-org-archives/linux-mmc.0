Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB4C4321E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 10:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiLAKuc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 05:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiLAKtu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 05:49:50 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5803A321A
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 02:49:33 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l127so859173pfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ikf6w7foSy3H3xLafmriTTc4pYaFjs97m3cDRpTlgbs=;
        b=NpzO7SH20nK0Xl1hr4vkBBNfewxlf/H/nKRvpJmwMz7VCOzTlLuZp2Dsft637ordjb
         hFLsDJc8Ge8702lNVi8oxcstDVxfgkaJ/zdLF0NgGkwFutuhZje886LnmaUaeACx3FXi
         P4IBR/+8T7n4xL5ZeS4pcbH/mTbyRGa1Z4v9OLAtNJ2Q7t6R/kP+XZALWtLREEhfnYja
         ApTDd2S/5Lsj/weMY8atxG9X8aXEl8QVAbVtHybvEXAFMcJFe/34xzXI6zJ1RleICX1g
         aUhx+9oWepXO2DGckxyTKoRbO88PGnj/G8wvJ9vv/OYu1QPjGFpI0ecj9Yn9b+j41BV0
         pEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikf6w7foSy3H3xLafmriTTc4pYaFjs97m3cDRpTlgbs=;
        b=aNHeLOD6mHp8aIBfI44I9NIWjmKi9LZUAl1NQ1VNOCdeYL7w9voEg0hNZ9QYLm3sBt
         vCxSDxsrmOAQ9OjUhZ/JIcrdQS70cuf129J3zJdA9giJSx8a6BHlDcJTn9eMUqWMAe9W
         tkOmtIzj6s8I0vZ0MKbYETp7Ig1TQsjMv7vvFAgXSlh4qKHBxwNPgzAFB4DwS4dpui9q
         tcc5mD9qUou4tOcvWJaOqqH7o50or3P6383vKNyo+ZLNko+1YhGuncOaCimX1nK9mg3f
         TmfSYpDQcJ0O97golmxeFpOHbcHtFFRV8QBoy2yTxp7CDQGL4/p7hwOE+TMC+/A5gH07
         TTSQ==
X-Gm-Message-State: ANoB5pnM6WnvbgJX0MQaXEbro4J0/asOr5yh2ozKWJhiK5K5MMdj46YB
        GIdZkHEoPdprevX+jGTIS13FWhjRRMpWrQNE4OxuGA==
X-Google-Smtp-Source: AA0mqf6EoEhD1YKbOS/4D8QHZPSMQKRHKi/InS0m+IzdFa+S6e4B9bVxRFcQ0TFUtIfqdHlZnu1b7JI+RkqCS1vVlUY=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr39333378pgb.541.1669891773258; Thu, 01
 Dec 2022 02:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20221130121328.25553-1-wenchao.chen@unisoc.com>
In-Reply-To: <20221130121328.25553-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Dec 2022 11:48:57 +0100
Message-ID: <CAPDyKFqnCPiN_T8XWs-pz5UO+v+2Cy5YL9p5vJu929rN3SbXcg@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-sprd: Fix no reset data and command after
 voltage switch
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        gengcixi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 13:14, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> After switching the voltage, no reset data and command will cause
> CMD2 timeout.
>
> Fixes: 29ca763fc26f ("mmc: sdhci-sprd: Add pin control support for voltage switch")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changelog:
>
> v1 -> v2:
> There is no need to wait for the state of the pin to stabilize.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index b92a408f138d..bec3f9e3cd3f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -470,7 +470,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>         }
>
>         if (IS_ERR(sprd_host->pinctrl))
> -               return 0;
> +               goto reset;
>
>         switch (ios->signal_voltage) {
>         case MMC_SIGNAL_VOLTAGE_180:
> @@ -498,6 +498,8 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         /* Wait for 300 ~ 500 us for pin state stable */
>         usleep_range(300, 500);
> +
> +reset:
>         sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>
>         return 0;
> --
> 2.17.1
>
