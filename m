Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C06DC433F5
	for <linux-mmc@archiver.kernel.org>; Sat, 30 Oct 2021 00:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A58E61154
	for <linux-mmc@archiver.kernel.org>; Sat, 30 Oct 2021 00:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJ3ADQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhJ3ADP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 20:03:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97CC061570;
        Fri, 29 Oct 2021 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9HvbWIqYXdpSwyUKGQ3CDM0n2/o7EJIBAgE5+a7ZpcU=; b=P2x8Ib59Wck6RXFObdalu9UNqs
        jFacWHmMgzXemdvIlsSxJUns9VjcJ6e7CMEVyB64CY2lfP+wwV70dm8yK1pOYJ0824SvUeUwPtes3
        qzJbKn3XQdp/vaA7Lr9I2sCYwZnZHSz0vTjf3rhDsREKEXslkGDnNv0FwDbg7hTrnF5iJGvCpWKQJ
        r1W8QuNAneetTmRooikRgMm0Z+Ep15gNQvTKDYgrZujtS4yTrCG4353M7ISpyQOMXq85Fyk6VGm/3
        UdjaRXZiWhvqy1DEZ1XvDDx+RD0yUyhpP+/rvxb3PpwJSo5xieO1wKtY3ahql4I24/r0OdKjbmEEH
        B2w/e7JA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgbnW-00CYpd-4I; Sat, 30 Oct 2021 00:00:34 +0000
Subject: Re: [PATCH 1/2] mmc: Add SD/SDIO driver for Sunplus SP7021
To:     "LH.Kuo" <lhjeff911@gmail.com>, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
References: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
 <1635487055-18494-2-git-send-email-lh.kuo@sunplus.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1cb5c303-5cba-cd3a-e73d-9e5535e3ab83@infradead.org>
Date:   Fri, 29 Oct 2021 17:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635487055-18494-2-git-send-email-lh.kuo@sunplus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/28/21 10:57 PM, LH.Kuo wrote:
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 95b3511..6f8bcd6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -14,6 +14,16 @@ config MMC_DEBUG
>   	  added host drivers please don't invent their private macro for
>   	  debugging.
>   
> +config SP_SDV2
> +	tristate "Sunplus SP7021 SD/SDIO Controller"
> +	depends on SOC_SP7021
> +	default m
> +	help
> +	  This selects the Sunplus SP7021 SD/SDIO controller.
> +	  If you have a controller with this interface, say Y or M here..
> +
> +	  If unsure, say N.

Hi,
Does SOC_SP7021 require this driver to be built in order
to boot?
If not, please remove the "default m" line.

Also, several of your patches seem to have lots of line
changes to the MAINTAINERS file, but it looks like they
should not be part of your patch submission.

thanks.
-- 
~Randy
