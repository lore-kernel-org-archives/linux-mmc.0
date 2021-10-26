Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B8C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916586109D
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhJZPnB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhJZPm7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Oct 2021 11:42:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C0C061243
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 08:40:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d13so15829949ljg.0
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dI3e2yWb/uU+1tnC1/zWVYk4uFqXhgsB4McGikM5lUw=;
        b=dgqlsNw0H5kyGA5TWB1RzuH7MVg+T2iViWLbbis+jByI8r2y+xQU9cOFSvOLU6ZKwi
         3KaZDMBvsBp9nlr86Zou84ys64kzpuoVHsSfDA+rfEa1mWlAKvlOGensxU02agst4UAp
         R2Bj+LwW6QR9ZH1Ddy4MdqlbOvhXCoAc0tNFsCvO6wmlRaw0Qy9E5Cd73l1U9ES991qN
         /guby18kM499xkdc0KXbPb+WKOaWUd/ZOpVfhP3tyk2Fjt59n4oeM15mwPnvzIVraLp/
         /wecRv/8zpr5bLyYtG6dvKo/f9h/K4ASKz9BDARltki9+DmNrBIzyxORfk7DPWFZCKng
         UIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dI3e2yWb/uU+1tnC1/zWVYk4uFqXhgsB4McGikM5lUw=;
        b=BcwGINeHD/C4s06FTzalM5jpK2tWtJyj2tAtI6+EGpcvajPZoH3s7HFj+v0ZYBVYnb
         lMYUULbGu9VBHK+KWD+rwej08mxcSDpIPox9SSs+jwmGOc9XnHnMwBCNxeFRI4l4Zab2
         tGkhZqB9D2hA1F09JiOd5De/ynHIZse/VzdNFLwqlVnpOmIcb/Dnf3gvOJcL+KLZkbLV
         i0y0TfTsqXngn6meIpzQXVsoJxthos8QA2d83W94O3FYd5xI09Ppb36lYIxJRmt9Ta5N
         9X8MeuvZ+VzvpJPnn0qv9dJJslIrxtvV6IH2lcDi4cBFMLXRd0MF/zRsJpgu0uUrUDGH
         4fng==
X-Gm-Message-State: AOAM533w6z8NCIWh+LUZ2vpbXG3pxLS7eAIjTbJyM2yJ3NVZHFeFlndc
        ujGfcV06Tfl3MTIu5iIpYNBX1lp5U4JBY8tbja26fQ==
X-Google-Smtp-Source: ABdhPJxjK+2RgtinaImTk9WZkEHEmETy0+4aTjX4JMJv4txyCEICQCRa7hvJGpINMvqMR/q9t/VdpFVs6tZRpTs+f24=
X-Received: by 2002:a2e:b550:: with SMTP id a16mr27647108ljn.229.1635262832943;
 Tue, 26 Oct 2021 08:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211021071333.32485-1-clin@suse.com>
In-Reply-To: <20211021071333.32485-1-clin@suse.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 17:39:55 +0200
Message-ID: <CAPDyKFrfUmisEO=OXZAi7U9N5gsfZHLWX7gPTHwt_AAsv78NpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add SDHCI driver support for NXP S32G2
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        s32@nxp.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Oct 2021 at 09:13, Chester Lin <clin@suse.com> wrote:
>
> Hello,
>
> This is a patch series for initial sdhci support on NXP S32G2 platforms.
> In the previous work[1], only basic DTs and serial ports are supported for
> minimum hardware booting. Here we want to add a mmc-host node and add
> support in the sdhci-esdhc-imx driver so that S32G2 can also mount file
> system from SDCard but not just ramdisk. As the first step, we choose fixed
> clocks to fulfill the requirements the mmc host driver needs, and they will
> be replaced by ARM SCMI clock protocol (0x14) once the SCMI feature are
> added into S32G2 DT later.
>
> This patchset has been verified with NXP downstream firmware blobs [ver:
> bsp27/28/29/30], such as TF-A[2] and U-Boot[3] (BL33) on CodeAurora.
>
> Thanks,
> Chester
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/freescale/s32g2.dtsi
> [2]: https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/
> [3]: https://source.codeaurora.org/external/autobsps32/u-boot/
>
> Chester Lin (3):
>   dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G2 support
>   mmc: sdhci-esdhc-imx: add NXP S32G2 support
>   arm64: dts: s32g2: add USDHC support
>
>  .../bindings/mmc/fsl-imx-esdhc.yaml           |  1 +
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 32 +++++++++++++++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |  4 +++
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |  4 +++
>  drivers/mmc/host/sdhci-esdhc-imx.c            | 17 ++++++++--
>  5 files changed, 56 insertions(+), 2 deletions(-)
>

Patch 1 and 2, applied for next, thanks!

Kind regards
Uffe
