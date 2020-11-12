Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94265C2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3832722240
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="04lsBmi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKLNYH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgKLNYH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 08:24:07 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1486C0613D6
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 05:24:06 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id i6so8431251lfd.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 05:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rRW5MIB7V0h30WOhgIWrIt9ko1KI9/KHM6tTURJFyqU=;
        b=04lsBmi9FdzaU1n2PwuNOvyFERuwrmhZrKyBISHwDW1GEwJsTjoFR5BwnzJg4P2/3d
         JkATLAWUZrupEEeY1uisYNIgSM3mBJDA/hhqnG2OEnlYQ1aReMQZ+ujnwQI9HaD4Fcdd
         87+ri8EuwaNWi1U88iO09u0MYl7noImZzwU3ry2gFIpYtF0mP14kjeppHm6RHVAuwL61
         6eUTtXSVjkjfVqgLmfu7bN+zyFaGuhXLhH2BTqHQxMlHbdMboff3ehjkdryaIghWReRq
         on0wdf9Jbh5+n8uyQVGp0php2tIBa9VvH9sGMGAn/aZZv77Uwy9646rsdyCfm5ajf0sR
         2DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rRW5MIB7V0h30WOhgIWrIt9ko1KI9/KHM6tTURJFyqU=;
        b=o3BCS8KLCibQhyZI1DWTmOaYeCLTFk7FfrD8iinG0IMO6E14zsDujeGhiHUinompAw
         Gsgrn5nR44u3Sfz2GOSQJxSGWkRBnUjlRJBh2tjcsV9VWrtn2Pz5SiZuilp3kftvZuht
         RneOlt10mMtwkhKtjVKsDqFjGbfItrI7wq9lVTafQyPqcSP34BIPZKD1yKZ5InkRoW+1
         va1ZcIrRZoLVsygGO5Bof2vcdWxivKNq5c6DyYCLC65bPzEnkakEP3LFiyjdUdKriN5G
         52a+2+XbDLC4D64dmrID+QROhOtPApqRm8vDucnDu2t43gY6q/R+ejId8NjhtoXjApp/
         p6dw==
X-Gm-Message-State: AOAM530Me93I8wKC1UKlgqqwwniCYL0oD9Lc+GsR/9PNYkxo9q2FDZBz
        6runO27KSpVmUIXZd2dFm0YocA==
X-Google-Smtp-Source: ABdhPJyL+BfAfl3HY/Gl49SAQV/bFzWdpxw1y7CaU2YO4TLlqe2egdqB73mmglA5TJDj9qY3ir507g==
X-Received: by 2002:a19:ad04:: with SMTP id t4mr11147668lfc.577.1605187445137;
        Thu, 12 Nov 2020 05:24:05 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id z4sm555636lfd.123.2020.11.12.05.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:24:04 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:24:03 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: don't hardcode SDIF values
Message-ID: <20201112132403.GC1491229@oden.dyn.berto.se>
References: <20201111100244.15823-1-wsa+renesas@sang-engineering.com>
 <20201111100244.15823-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111100244.15823-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-11-11 11:02:43 +0100, Wolfram Sang wrote:
> Use a macro to name the hardcoded values. Also, move the SDIF register
> definition into the SDHI driver because this is an SDHI extension.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 7 +++++--
>  drivers/mmc/host/tmio_mmc.h          | 1 -
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index b3eb0182c4af..55633826d38c 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -49,6 +49,9 @@
>  #define HOST_MODE_GEN3_32BIT	(HOST_MODE_GEN3_WMODE | HOST_MODE_GEN3_BUSWIDTH)
>  #define HOST_MODE_GEN3_64BIT	0
>  
> +#define CTL_SDIF_MODE	0xe6
> +#define SDIF_MODE_HS400		BIT(0)
> +
>  #define SDHI_VER_GEN2_SDR50	0x490c
>  #define SDHI_VER_RZ_A1		0x820b
>  /* very old datasheets said 0x490c for SDR104, too. They are wrong! */
> @@ -381,7 +384,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
>  		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>  
>  	/* Set HS400 mode */
> -	sd_ctrl_write16(host, CTL_SDIF_MODE, 0x0001 |
> +	sd_ctrl_write16(host, CTL_SDIF_MODE, SDIF_MODE_HS400 |
>  			sd_ctrl_read16(host, CTL_SDIF_MODE));
>  
>  	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF,
> @@ -529,7 +532,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
>  			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>  
>  	/* Reset HS400 mode */
> -	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
> +	sd_ctrl_write16(host, CTL_SDIF_MODE, ~SDIF_MODE_HS400 &
>  			sd_ctrl_read16(host, CTL_SDIF_MODE));
>  
>  	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 9546e542619c..7ff41185896a 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -42,7 +42,6 @@
>  #define CTL_DMA_ENABLE 0xd8
>  #define CTL_RESET_SD 0xe0
>  #define CTL_VERSION 0xe2
> -#define CTL_SDIF_MODE 0xe6
>  
>  /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
>  #define TMIO_STOP_STP		BIT(0)
> -- 
> 2.28.0
> 

-- 
Regards,
Niklas Söderlund
