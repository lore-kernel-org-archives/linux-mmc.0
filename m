Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA5C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C202075B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckWYYhKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPPiA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:38:00 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42735 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgAPPiA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 10:38:00 -0500
Received: by mail-ua1-f65.google.com with SMTP id u17so7792997uap.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzUD1zwU0rAYKh4GeaUEkzHO0hgVckdO3UlIrWCkJwk=;
        b=ckWYYhKcKb2dT7sxw5ofXkMuaW2T6G0oFm+4I1V6e8zX5MefXp/STLeCkdZBNxk9MI
         neLrSF/Zm+xkeIuUx/p6cIwda217LAvMkqRheBadA9nNimTzyZTSrfmaqOR/CMoqkegg
         CsFoks/mMk2fK8FTgIa5gL7BHICvFOGcuj+LkBtrD96/RZcjo1sqeEpKX/vgbz5R7ufx
         y09r1/bp77UukJ7tvo0ZDo19yuZ7IP4uvq8igqiZatyxQjyY5x9Vc5WRgOn1D7EqO6EU
         xIPvGJt7CgkVt3kAyfGVCrGwBQ1+yzgUzkdriZQppQLw8BZT/wupfBCRLzxV1Kd0utFa
         0qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzUD1zwU0rAYKh4GeaUEkzHO0hgVckdO3UlIrWCkJwk=;
        b=G0B/O0tHAUuYTwhCyuzC6r2mN+78VDSWwi4cJcsdgRpTez79c2Y/gaJGxKoCw89SgA
         n+sgQ7hz1/6eFBOHTgGd3jwuqdyZgGutgkRdqyfAEC0ez1pQ5K7xfjC//epvhxwnwP6X
         iTyDnfACR6P57RKQMWqARCdb2/qMTONXINFpx6Cy9+7pj3Vg3OQV8d7QKzT9KaLRhsSo
         OOeYlnxim30XP4A7cL8vMSSFi0/wnka8OI+EEhfdx5QU9BpYCSnlm1scLpnUe7XCgmes
         af4+Qxh6tRNcSFr26VZkCEkwsiNI29DMSn9+p8s+pyqGZIXmo2nVJUugdfVCkSF0mcAb
         x4Ng==
X-Gm-Message-State: APjAAAUjBakqXmwVNmlphsupYrcqQfEPY6DTdqzqiOUcPRH7pfTPr+xQ
        I9FF7wQj6R1Fy0xV+M26o4jQv4m9BlRaf82hJyVbnQ==
X-Google-Smtp-Source: APXvYqxIHUm57SaE/1DYL+57dh4bMqtXOA4yP6vvoIGdM8To9YtT6rURJfc0cAe4IX6fBKyQ0iXse1GSG+37snCem2w=
X-Received: by 2002:ab0:5510:: with SMTP id t16mr19495257uaa.15.1579189079583;
 Thu, 16 Jan 2020 07:37:59 -0800 (PST)
MIME-Version: 1.0
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com> <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 16:37:23 +0100
Message-ID: <CAPDyKFqbWrj5XruJW3ooQSzw51YAg2ukrjdBdkBx1szTU=5DJA@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        rjones@gateworks.com,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        sebastien.szymanski@armadeus.com,
        Aisheng Dong <aisheng.dong@nxp.com>, richard.hu@technexion.com,
        angus@akkea.ca, cosmin.stoica@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, jun.li@nxp.com,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org, dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jan 2020 at 06:37, Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add compatible string for imx8mp
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 2fb466c..c93643f 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -21,6 +21,7 @@ Required properties:
>                "fsl,imx8mq-usdhc"
>                "fsl,imx8mm-usdhc"
>                "fsl,imx8mn-usdhc"
> +              "fsl,imx8mp-usdhc"
>                "fsl,imx8qxp-usdhc"
>
>  Optional properties:
> --
> 2.7.4
>
