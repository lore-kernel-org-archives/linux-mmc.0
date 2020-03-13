Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE299C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7812074E
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 23:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm2F80U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCMXED (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:04:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42072 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgCMXEC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2020 19:04:02 -0400
Received: by mail-ua1-f65.google.com with SMTP id v16so3186202ual.9
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2020 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RS54kqU4ZoL/JYf9xb8FmVEyuposBptYBdg1XhxTjvU=;
        b=Wm2F80U/qMBMSKwzTlzGHa6o1sLnPfF3HvOrwUtm0NxjB+l1CPOtDjpjcN7UGsEaXs
         MJkWKdzoiWZBrVH/YKlVsWtLo/y0pmgZtOQtPI/fWesyUvta/tmr5Sc6A4cLNQPPJQHr
         ZbXhPrL1eHpHoounZ1UpwBb7q46D7oRaDqqU0WOgfzjI3QtPs2sMHHQUUL9d/8R8lGyU
         Wt8ILFTgOQC3fwRuTQj49ZyL3RmQya6KcGA9QgtXCW9LewqD8Qkj806K00ZciJmlIrKU
         mKsWXvvyBVmcT5eg2mGo4uXDKG3lgiQwR3e8W7+umbSZDImAW83qc49BeY760W2cbWMB
         /+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RS54kqU4ZoL/JYf9xb8FmVEyuposBptYBdg1XhxTjvU=;
        b=CJBIr7eW3V37+keDlXYJTefheZgsvyHuExhjE5FvioK+4GBE01gMmJuoxXv4od0Dze
         TApg5zrsAbuQPraPm4K4djzTYZRcxmOBHtQQ42gSKvHurJRrj0iZKhi7Y1JVthhs4n2d
         AoDTyAXNKrvSWDqwelRTgX8WYtOokyz7i9HveC6nJUb9iNWGSZj+IcWNiwpr8FQwN2W5
         0IX9+BLz4kLJrQpHQMhWS+vPNSOw15/Zggcgg0f3Mn5bUj+kc5oyBDsHcOGPYeCESjta
         3glJjUH7co9I3r7fTQUjiLG2csSLNq9IViv9ld8qbmAXsp5xFI8Kc6zuas2vaqqM94uj
         Rz9A==
X-Gm-Message-State: ANhLgQ29w/BMFdimJa0ehIRoDhs4yEG/Ipxu5vqyaE/YBGIapji3VbXA
        sLGsY0xyZM0UYk1pnRDVB+b4B80Wzw6gDE3dsr0MTw==
X-Google-Smtp-Source: ADFU+vslrgWZ+WwLQNF/SvQm9l+ZtDJHO/NTwCrNcP545NTgh6V4fcUru4452BxUtt7jtERTCU5sKZW85KUcjRGmknk=
X-Received: by 2002:ab0:7381:: with SMTP id l1mr10024983uap.104.1584140641580;
 Fri, 13 Mar 2020 16:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200312142904.232822-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200312142904.232822-1-tudor.ambarus@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 14 Mar 2020 00:03:25 +0100
Message-ID: <CAPDyKFpCnXri=Lj8kDUgWn-zHRudLeOvegDjQakzckR7OndbXA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: Display clock changes for debug
 purpose only
To:     Tudor.Ambarus@microchip.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Mar 2020 at 15:29, <Tudor.Ambarus@microchip.com> wrote:
>
> From: Cristian Birsan <cristian.birsan@microchip.com>
>
> The sdhci_at91_set_clks_presets() function is called multiple times
> at runtime and the messages are shown on the console. Display clk mul,
> gck rate and clk base for debug porpose only.
>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index ab2bd314a390..88f17abb69a7 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -204,8 +204,8 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>         /* Set capabilities in ro mode. */
>         writel(0, host->ioaddr + SDMMC_CACR);
>
> -       dev_info(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %u Hz\n",
> -                clk_mul, gck_rate, clk_base_rate);
> +       dev_dbg(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %u Hz\n",
> +               clk_mul, gck_rate, clk_base_rate);
>
>         /*
>          * We have to set preset values because it depends on the clk_mul
> --
> 2.23.0
