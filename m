Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FEC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Feb 2022 15:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiBQPkY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:40:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbiBQPkX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 10:40:23 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E72B2E3A
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:40:07 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id o6so14282ljp.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QQBoXxNzNE8ywxlHFFfAWGomixHy2u6zilUaFbuhmE=;
        b=RrJjmHuXVzVPtammx2PWFkPzYxa0sp+CIs+a7p1reY0HA9oZgI6A2REIXw9b8X87aw
         7pc9oqYfh2pWUeDGPUC+sYPFiWy5TmNtt0N8Yk45gdx5bEQCumDai+PpoJesoGcTvHkK
         3DRBdvC49FrGQhrxOH/yH4nzcpoghoBj2cAkf/i7i2WMNp/JuYdHrXjA+/5A//mRpxy8
         kkUCQyA6YybDATTmZeDwQT8wppphoA7p08DHO0KUt+BMuEQXgDCFQhQosH1H2P+Ws4dH
         xyth298pl5lKvbRhwd5OOQ3S2/WTqa0/tqOiawymfYhfgUwa3YDahOFTXQbXp+jgr+f4
         kkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QQBoXxNzNE8ywxlHFFfAWGomixHy2u6zilUaFbuhmE=;
        b=p2T6/92M5FEQBchpOmBm3EhOk0hkTeyH3nzs4RIU5zPRqVZBUmPFEzSPZy6nXvXzya
         oF88akmV/1Shys5rLBZIloSh0EFws5LBL4HpuPCpKdztsPapJ+U6KJ9kRcXMWd0eMaFJ
         gnFzNaHdVWPWzM6Qk3JtgOfpe0zd+jQnkz9cfgP8mYXOMMTgqk0Z4idVWQp0MHBliOEW
         5HmIY6yRhJ3NMlfAGvJ4iNNkLqQJ1WZHcUdNacXcDmQoLvuBAByKbnaCsJdeq43Vjunv
         W4t+tDPM43Rxz0D+OGzSb3JUKECT8GSoErOhIyd0psOFbgbXD7R/oOXWxK6qH8Rg8HHe
         vUEg==
X-Gm-Message-State: AOAM533gQZ4KDgnGeEw2TR33Z7apLMyzfy+vmjYaKq/rH7qSk9C71vym
        M116zc0ZAQIyoxQYkJXg77zcRcY4UdTa3LFdUEQOrQ==
X-Google-Smtp-Source: ABdhPJz/2VHYH9XfV+9CZAADf8Qh3/CV94aravtyvXjpcx8p81PXfewRvi4Izfd3VQLRzuBPEmKSwtVVgXuWCGv7jDM=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr2624384lji.367.1645112406253; Thu, 17
 Feb 2022 07:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20220215081502.789067-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220215081502.789067-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:30 +0100
Message-ID: <CAPDyKFpkBGyxNxi3uYyYRrgh=itNf69-Xe9gwJktoE0p9yj74A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: imx-esdhc: Add imx93 compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, Kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Feb 2022 at 09:15, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX93 compatible string, it uses two compatible strings.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 17acbc665f5a..7dbbcae9485c 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -47,6 +47,7 @@ properties:
>            - const: fsl,imx7d-usdhc
>        - items:
>            - enum:
> +              - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
>            - const: fsl,imx8mm-usdhc
>
> --
> 2.25.1
>
