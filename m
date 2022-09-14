Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A5ECAAD3
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Sep 2022 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiINODH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Sep 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiINOCa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2022 10:02:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24879EED
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2022 07:01:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h3so9976206lja.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2022 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FZgMr2uzHswuhD90JcA7j6LsjWrwsLINoMF2i9AWFAI=;
        b=TwFugg/x9Y9KEkWOKgfpfOMHXawb6srXFkN9JOCbdXdgiPSH/AKsujToFEWKceyVEc
         3wh/psBAa7L6uSt24bMEQTLoC9mRjKF4VS/VKGnM/FayZtETN4jDwYnPuY+etAiFB4kA
         94OuivN8XE0EiUYstNCUXs/T4g1cc8EyJpz1sWMhk0RCBcAsvFAEna/UsrlgKpQ31gqh
         V1fbAQLEe9hb0q1UhN2nn83rE/+e2pt1xWOPWfsWvsR3mFGN/J0XWKt5l4QZD9d8d2HO
         aG4dkpkUzpvoHoSTFS86Ik43LUZi7ySt9lXutBVEvpAxnwNt02BxHAkpAvelIHfZk5ZK
         461w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FZgMr2uzHswuhD90JcA7j6LsjWrwsLINoMF2i9AWFAI=;
        b=2T/UtCZuY9v6cy82YpmsIKATWoOsU8WMPZ6bd2bln05iDMHz5VAWRfE6VsjUyJLBdz
         Se/KYk6SW+BctDeI0T4MDqfQXTFxtfTkzKPgqObiOtumje/Tr7LrPNNuX24pglViXckf
         mmZAQjINxvrDZcFlkuT5eOX9aS6eTQL72UJijsbd614IxMWkfWSWjRXgRFWW2zyixUM7
         fXcBvaQgfWmsGKp4JWFGag/uestzhe7ehYa6ywEJkJjF4WTbtHVSN/jdGCDKcZ16INqg
         63Q/Xne4Z8kHICHlUY2+mJK9Abi54SKTDhDfjwfF2ueu6ZDhIs2EzOEZIebFKY7HyX9u
         NGlQ==
X-Gm-Message-State: ACgBeo2UXtsjx9hrlohzAt87nRSRlRfVEzoFIwqdwjrbMVohgVZL51mI
        D3lZ6KwJ0zRMJ3z7Ot2Re1cKP7tjBpP3fEbB0Z8aRrF8njUi6w==
X-Google-Smtp-Source: AA6agR72DHzRxrpk/pmx6gNR+tjez0f6IOWZ7mAjiJYnMyi8AVoBOw3RcuPfX5lTmG4JUxDPv2IabRUwdGYeJ4mXReI=
X-Received: by 2002:a05:651c:214:b0:26a:b03b:9e0c with SMTP id
 y20-20020a05651c021400b0026ab03b9e0cmr10198794ljn.463.1663164099573; Wed, 14
 Sep 2022 07:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220907205753.1577434-1-saproj@gmail.com>
In-Reply-To: <20220907205753.1577434-1-saproj@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Sep 2022 16:01:02 +0200
Message-ID: <CAPDyKFrdsGm4mN+e3OVMEePwk63bt1T0AVQdh0YRxg=AJECA2Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix 4-bit bus width, remove 8-bit bus width
To:     Sergei Antonov <saproj@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Jonas Jensen <jonas.jensen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Sept 2022 at 22:58, Sergei Antonov <saproj@gmail.com> wrote:
>
> According to the datasheet:
> https://bitbucket.org/Kasreyn/mkrom-uc7112lx/src/master/documents/FIC8120_DS_v1.2.pdf
> , page 377
> 4-bit bus width is turned on by bit 2 of the Bus Width Register, so
> the current bitmask is wrong:
>  define BUS_WIDTH_4            BIT(1)
> BIT(1) does not work and BIT(2) works. It was verified on real MOXA
> hardware with FTSDC010 controller revision 1_6_0.
>
> The corrected value of BUS_WIDTH_4 mask collides with:
>  define BUS_WIDTH_8            BIT(2)
> No evidence of 8-bit bus width mode is found in the datasheet. Remove
> code dealing with 8-bit bus width.
>
> Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index b6eb75f4bbfc..dfc3ffd5b1f8 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -111,8 +111,8 @@
>  #define CLK_DIV_MASK           0x7f
>
>  /* REG_BUS_WIDTH */
> -#define BUS_WIDTH_8            BIT(2)
> -#define BUS_WIDTH_4            BIT(1)
> +#define BUS_WIDTH_4_SUPPORT    BIT(3)
> +#define BUS_WIDTH_4            BIT(2)
>  #define BUS_WIDTH_1            BIT(0)
>
>  #define MMC_VDD_360            23
> @@ -524,9 +524,6 @@ static void moxart_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_BUS_WIDTH_4:
>                 writel(BUS_WIDTH_4, host->base + REG_BUS_WIDTH);
>                 break;
> -       case MMC_BUS_WIDTH_8:
> -               writel(BUS_WIDTH_8, host->base + REG_BUS_WIDTH);
> -               break;
>         default:
>                 writel(BUS_WIDTH_1, host->base + REG_BUS_WIDTH);
>                 break;
> @@ -651,16 +648,8 @@ static int moxart_probe(struct platform_device *pdev)
>                 dmaengine_slave_config(host->dma_chan_rx, &cfg);
>         }
>
> -       switch ((readl(host->base + REG_BUS_WIDTH) >> 3) & 3) {
> -       case 1:
> +       if (readl(host->base + REG_BUS_WIDTH) & BUS_WIDTH_4_SUPPORT)
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
> -               break;
> -       case 2:
> -               mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -               break;
> -       default:
> -               break;
> -       }
>
>         writel(0, host->base + REG_INTERRUPT_MASK);
>
> --
> 2.34.1
>
