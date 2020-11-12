Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF50C2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBAC22248
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="IAPe+SxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKLNZB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLNZB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 08:25:01 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB6C0613D1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 05:24:59 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so6089655ljg.13
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 05:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nKUou+uG+uNSWzIJKtZPppeQ0wVvm4JaNlwgSgYxeLQ=;
        b=IAPe+SxZsTdCfHIwxUrBBAvhFj/okyjg+fxB9yzmYiXjm6FfkywzQVvLw8sh1GrMlP
         CcNCC+H71b2BQxwtcpVzRkjgDx/PkL/GUI+Bd4dAXxiSeyL5IxAKEEd26nj09ZuqsXJw
         2Z0SuMRu3dxtV3gFQ7e2LQ4xF8VRjdLVR1cYh3MxErlC/3xXBs7WEMGZuxY15dON/yBF
         1vKK4HaA3ZSJMawXH8OpR2d/2QtCchc01HI2kSQK26SPNs/Fjv138GvWppwHE6+7jcHn
         jyRpDNRVp2csdnB5M0lX+G4Qo8SwjAfSSaCiKFMDLNNlBOX04SrHTqzcjBmXe9cg0V51
         BKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nKUou+uG+uNSWzIJKtZPppeQ0wVvm4JaNlwgSgYxeLQ=;
        b=dQO/UfGUa3ZQiMl3cJiysoVthMBab/JYnMla0npD0U4o5qN7uqw7J4u2hYd9emkeCc
         T5d+JhvgMs5oAnxeK6a+bD5SAFMlFmVidq08/Pxr5DHlG4NZ10K3hqRtxfIfKYgz3Dtf
         3pOGXXdZebEDiIVbBS29AVs8lTW6mc017zSgPRwON8RxpE1v3X4lBN2eDs3qVXTDYhdv
         KRinrfAyGeUimNouCvrgcfsH4iexVzb0p0KY8E7B4NY2IgCbNPCdmcbMCFaiDQEE2b6F
         CubhbtrUFCdpJTu8oCK96fTsrkhXn4uHzY/2W2Yp9c8GYK5557CzeU4aQTA/9WHhLMZy
         ZPQQ==
X-Gm-Message-State: AOAM533OFB0fNbUVfy2CQf6xAD+aIIfEVagU2n8+XnrBNu6E8F7txOcD
        49IWY6PWuK3BjXAjsY+owoAZFiCbbcvg9A==
X-Google-Smtp-Source: ABdhPJy/GVGOabsGsorsQRu/TrNeqs7g/8D1tlLuufxqkQw8wrt2sUVPE8+A6RJbMhMwTymbCwxAVA==
X-Received: by 2002:a2e:9109:: with SMTP id m9mr4582490ljg.123.1605187498412;
        Thu, 12 Nov 2020 05:24:58 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id l26sm562335lfp.26.2020.11.12.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:24:57 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:24:56 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 3/3] mmc: renesas_sdhi: sort includes
Message-ID: <20201112132456.GD1491229@oden.dyn.berto.se>
References: <20201111100244.15823-1-wsa+renesas@sang-engineering.com>
 <20201111100244.15823-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111100244.15823-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2020-11-11 11:02:44 +0100, Wolfram Sang wrote:
> Better prevent double includes.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 55633826d38c..bb937411c2ec 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -18,22 +18,22 @@
>   *
>   */
>  
> -#include <linux/kernel.h>
>  #include <linux/clk.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/platform_device.h>
> -#include <linux/pm_domain.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
> -#include <linux/mfd/tmio.h>
> -#include <linux/sh_dma.h>
> -#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl-state.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/sh_dma.h>
> +#include <linux/slab.h>
>  #include <linux/sys_soc.h>
>  
>  #include "renesas_sdhi.h"
> -- 
> 2.28.0
> 

-- 
Regards,
Niklas Söderlund
