Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D19EC001E0
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 11:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjJWLvK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjJWLvI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 07:51:08 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7575E8
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 04:51:05 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7c08b7744so31552167b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698061865; x=1698666665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj2+Gc/tcBXDbia3+UIXbheoVCOn899YQdDlUVcmlIo=;
        b=vnke0QLxQBqb/ILqVk4aUwfBWa1x617MtUiWsRMfY48iZiAdWz7mAeT+QLpQuiDYl3
         dHYIu07AcAQBJ8kLwnyKYHNjoM2EnwubG7TlSAu7ub5d3U4jeyH5U322sfoSe4zguQZP
         /tWeFw+MDTdqtFTJ4Qf4Pe+UbfYxbFaxP9uYZEu+rYTljscECGtJJ0OUI+UAJ6WorMzP
         KI+WAy3PrLpoWK1z3LckOxVtQpGBpYKx+bi9EbBMZ2Cg8McPHvfBRDN08dMkiaLP7hoI
         oP+JsMPnhONNQSWT6SyWrDDqz63WxfUXcyG8vueWKVYr/wmLia4dxI2JrtlU1mjMscKd
         mzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061865; x=1698666665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj2+Gc/tcBXDbia3+UIXbheoVCOn899YQdDlUVcmlIo=;
        b=tQ2bXDvl1KEUcGGcQj0HD8U6sBulu0pftrGxlG0CScoH5a9FunymQ63X4R4lKLpADm
         qjbIpamWk4JbeoHMskDps52qaiIrXrOQ462FHQjFEg5B9AImabdkFoL3bchjWGsNTn6P
         KMcpUII5pGvqpJm7emoQCeRsUzx1y5kHZ/xcRibmdMNVz/ITZFPy8kp3deL9DHdIozt+
         JdF5siQ3+DTMR9TB9HX0nPyv8a+lDiQtYGpkmEj+5KNzOoCn4M0f7xhHvypZgOz3sJsL
         Mh5uXpKDNNC/2Sl7K50lZ9T93noIJg6ho99thpPnkZb8Ps7ha4oP8ERUb7dkNaAzfSci
         GH0Q==
X-Gm-Message-State: AOJu0Yyvkxpp+tS7QRloRDnJp5I78IHPHIFmFZxE4a4TFrusgJiIzSTS
        FiKq8i1N8tLJo3C3m9bYvtVzvB4QTpw5y3ps5ilX6A==
X-Google-Smtp-Source: AGHT+IEwvU+/pk0AxYWqEzRPVjjkPdAkURGQidrpdHtxY/1Fddbs6AX51+cZAUDGouaOttT5eQe5wFBBC/i2td/pjBQ=
X-Received: by 2002:a05:690c:f11:b0:5a7:d937:6f27 with SMTP id
 dc17-20020a05690c0f1100b005a7d9376f27mr11004991ywb.19.1698061864957; Mon, 23
 Oct 2023 04:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230911153246.137148-1-aubin.constans@microchip.com>
In-Reply-To: <20230911153246.137148-1-aubin.constans@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Oct 2023 13:50:29 +0200
Message-ID: <CAPDyKFoFjZOOzTM_vMxoNTph2nx=0WR0pyBqco44v8YacjOixw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
To:     Aubin Constans <aubin.constans@microchip.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Sept 2023 at 17:33, Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> On the one hand Eugen has taken responsibilities outside Microchip,
> on the other hand I have some experience with the Microchip SDMMC
> SDHCI controller.
> Change Eugen as reviewer and take over maintainership of the SDHCI
> MICROCHIP DRIVER.
> Also, take over maintainership of its predecessor, that is the MCI
> MICROCHIP DRIVER.
>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>

Thanks for volunteering to help out with the maintenance!

Applied for next.

Kind regards
Uffe



> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2833e2da63e0..52beaf4f7fbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14022,7 +14022,7 @@ F:      Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>  F:     drivers/iio/adc/mcp3911.c
>
>  MICROCHIP MMC/SD/SDIO MCI DRIVER
> -M:     Ludovic Desroches <ludovic.desroches@microchip.com>
> +M:     Aubin Constans <aubin.constans@microchip.com>
>  S:     Maintained
>  F:     drivers/mmc/host/atmel-mci.c
>
> @@ -19235,7 +19235,8 @@ F:      Documentation/devicetree/bindings/mmc/sdhci-common.yaml
>  F:     drivers/mmc/host/sdhci*
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
> -M:     Eugen Hristev <eugen.hristev@microchip.com>
> +M:     Aubin Constans <aubin.constans@microchip.com>
> +R:     Eugen Hristev <eugen.hristev@collabora.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Supported
>  F:     drivers/mmc/host/sdhci-of-at91.c
> --
> 2.39.2
>
