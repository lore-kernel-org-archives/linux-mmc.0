Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF225C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D91220707
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUVHiSIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgE1KP2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbgE1KPV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:15:21 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A79C08C5D1
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:19 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id m18so6608226vkk.9
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k9E+YiCz7eYDmM11BkqW6Mr85TeDyC8/4dldyhTF8E8=;
        b=YUVHiSIXPjOMZXRJSWOJ6cycwQMjyqcnxpdlF7flS/6dx25hW5vtgM8PMR4lN5I0h5
         44cSX1wqIloWusdYYBHbP9wH7TisJ0f/gclugCoXjP9nByCIlB/jZj0RsMdeSzd8u0az
         hq3SxrrjMy2z24sDYf9xlvwdqJy/vGO9DW6gSMYJLVbj4MJCUK78rRIVvuWMC5iM3flH
         ECOjtf3BTFhfpCmzXQiYFDqQQLJKM1/xNsbfejruRPHC560F6zKIqVkJZZhkR2wfMsf9
         ixYRG3mAdTZI2/Qc/c+/uGWeJ4gFVFIrAJGRsrEsqJPGzSRrq3rIat/QjLmlFinR4g8l
         g4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k9E+YiCz7eYDmM11BkqW6Mr85TeDyC8/4dldyhTF8E8=;
        b=Z26ZuHrmkyDUlausG9m3FdhB7lGdPAMMScuIKD70D93Bj3FAM1V1ZrjNgv0TYEd2Gb
         AgDqbSS5UvlwZbfmySN3LJAl1B7E4oWc1T1cDMswxu5lZcOli05IIGyHMTBriImWSJUG
         q+OS5GU7nyAmunQeLGhRBYTiEF3YIwNvABU1wEdAwZDeuwVN4mvXejR8+QU1ungcPFPf
         ejjBQWIz3VjMiXcOGzIRIbz9DWB3kQBjjMjcIGOjBHC0th40KRr1Lecyf8Meu93qGaxq
         MKtJod1N1yseixdRXMSLEzZ6Q9nFNq8pJTFWCBjEr9BZEZDbY99xhoEzF18LWH/yHfhu
         BiTA==
X-Gm-Message-State: AOAM532MqtooC+vEifxpbYBOBtplWwIuABqeu4yNglmbnh+S08sHLwKS
        993Fv8SL34Uc91X8yxiQtx5upATkq7phGtGKeDAanytPt1k=
X-Google-Smtp-Source: ABdhPJzq+Kx3OYL+6G1qhd2lkHQpjppzj1oPaVyPbutDkNuy2xuAXrFoC2t79djeyVLRUTgP3zWyrrJaCDTr4yv034k=
X-Received: by 2002:a1f:fc06:: with SMTP id a6mr1443177vki.101.1590660918913;
 Thu, 28 May 2020 03:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com> <1590488522-9292-2-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1590488522-9292-2-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:40 +0200
Message-ID: <CAPDyKFoSSS0rh06Kso44J+ZFQC16K+Xttw6gQfUiganHKG5BXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: disable the CMD CRC check for
 standard tuning
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 12:32, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> In current code, we add 1ms dealy after each tuning command for standard
> tuning method. Adding this 1ms dealy is because USDHC default check the
> CMD CRC and DATA line. If detect the CMD CRC, USDHC standard tuning
> IC logic do not wait for the tuning data sending out by the card, trigger
> the buffer read ready interrupt immediately, and step to next cycle. So
> when next time the new tuning command send out by USDHC, card may still
> not send out the tuning data of the upper command=EF=BC=8Cthen some eMMC =
cards
> may stuck, can't response to any command, block the whole tuning procedur=
e.
>
> If do not check the CMD CRC for tuning, then do not has this issue. USDHC
> will wait for the tuning data of each tuning command and check them. If t=
he
> tuning data pass the check, it also means the CMD line also okay for tuni=
ng.
>
> So this patch disable the CMD CRC check for tuning, save some time for th=
e
> whole tuning procedure.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 2cf7fa59270e..b0ddf3db440f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -91,6 +91,7 @@
>  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
>  #define ESDHC_TUNING_START_TAP_DEFAULT 0x1
>  #define ESDHC_TUNING_START_TAP_MASK    0x7f
> +#define ESDHC_TUNING_CMD_CRC_CHECK_DISABLE     (1 << 7)
>  #define ESDHC_TUNING_STEP_MASK         0x00070000
>  #define ESDHC_TUNING_STEP_SHIFT                16
>
> @@ -1316,6 +1317,18 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_ho=
st *host)
>                                 tmp |=3D imx_data->boarddata.tuning_step
>                                         << ESDHC_TUNING_STEP_SHIFT;
>                         }
> +
> +                       /* Disable the CMD CRC check for tuning, if not, =
need to
> +                        * add some delay after every tuning command, bec=
ause
> +                        * hardware standard tuning logic will directly g=
o to next
> +                        * step once it detect the CMD CRC error, will no=
t wait for
> +                        * the card side to finally send out the tuning d=
ata, trigger
> +                        * the buffer read ready interrupt immediately. I=
f usdhc send
> +                        * the next tuning command some eMMC card will st=
uck, can't
> +                        * response, block the tuning procedure or the fi=
rst command
> +                        * after the whole tuning procedure always can't =
get any response.
> +                        */
> +                        tmp |=3D ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
>                         writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
>                 } else if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNI=
NG) {
>                         /*
> @@ -1661,8 +1674,6 @@ static int sdhci_esdhc_imx_probe(struct platform_de=
vice *pdev)
>         if (err)
>                 goto disable_ahb_clk;
>
> -       host->tuning_delay =3D 1;
> -
>         sdhci_esdhc_imx_hwinit(host);
>
>         err =3D sdhci_add_host(host);
> --
> 2.17.1
>
