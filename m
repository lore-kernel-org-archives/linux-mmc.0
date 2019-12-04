Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA7BC2BC73
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294DF207DD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="AbKGkvlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLDJre (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:47:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38519 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfLDJre (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2019 04:47:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so7309496ljh.5
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2019 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G93r9hSvUWxgt3yBIvCkJ+xgQP9VrLAvhpX54ZmMAJo=;
        b=AbKGkvljSsanuuqNbL4Wo7QDV3/59IVsq0SZDobwuNMXiY6gvqJkMk2QLS268GsqTj
         ZmhK93i2lrdx0KkZnVlcN0W+fTSqmovil89zzZ7aNeQF6fDfEnSejNV84pAAvO25u4tc
         ZMaZbzVCll0j27lXFGIbt2uIR6Y7PC9OEP8InkomeajI94SXMs6GXSUuwF9E36Wut50o
         Lb7DqpXnPIfNxxVNofeb/Lu4IXybhWxPa5Z55kPa5sjSCAF4oOwX6TZoSX9fLeIycF9s
         /2d4L2iJpINYVon0xkzK7DtS1BQDXKbQ0Ej+2Pg7SPxtCLchkf3KbmjmEAfBTfSQ1iiu
         hzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G93r9hSvUWxgt3yBIvCkJ+xgQP9VrLAvhpX54ZmMAJo=;
        b=lb0e6salsuwCYxKz+B0aBpN8p3QlqJ8DzW+GOC2KXiIbNfnhXjC4AchF3qpfdveUEi
         nFaUMTVKJtIypjbBscBXhSfD1lTPjkvtyyqEWIdqGlCk/TkBNITZHkyiYEhLJT7LQMJ4
         qkpvcBf0Az1afKH5JSuYK9jNNC99sqjIe4m1ds34R8Lfs7/317DxLnoptFZAQxndPMiZ
         JWqZ8LBYV2GjU3C2QDFVtMWVtj3P/b3bvU6gNgRsBjbAQ3drFd2t8xDxyssx/cep8KrA
         JmqZLfH60yumIMjiAChee47MK0N0JWXKIz2KCat/779yZVH/4b916Rhn1giBS1MqgQ65
         K7pQ==
X-Gm-Message-State: APjAAAW/OF3D+ECHyoY2+9axOfgDFP34QWN/5lm4KHShd+42l43O1ExF
        NTUmHvxwkV1KyUFX4sxRuU9ozA==
X-Google-Smtp-Source: APXvYqzdx3vzXl4t5Le6eL6Hu4xLBaLoKktIe7I2Yps7eDUTjAAFSbmTVs4Xx81n+l3XSLCqwJ77hw==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr1306713ljl.65.1575452852013;
        Wed, 04 Dec 2019 01:47:32 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:6cb:3eec:c491:ac74:fd08:8d43? ([2a00:1fa0:6cb:3eec:c491:ac74:fd08:8d43])
        by smtp.gmail.com with ESMTPSA id g15sm2211562ljk.8.2019.12.04.01.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 01:47:31 -0800 (PST)
Subject: Re: [PATCH 4/5] mmc: renesas_sdhi: remove 4taps as a TMIO flag
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20191203200513.1758-1-wsa+renesas@sang-engineering.com>
 <20191203200513.1758-5-wsa+renesas@sang-engineering.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6789764c-0b90-0b0c-eba8-d545ec1b99ee@cogentembedded.com>
Date:   Wed, 4 Dec 2019 12:47:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191203200513.1758-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

On 03.12.2019 23:05, Wolfram Sang wrote:

> Now that the quirks structure is accesible, we can remove the TMIO flag

    Accessible?

> for HS400 using only 4 taps. This is Renesas specific anyhow.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/mmc/host/renesas_sdhi_core.c | 8 +++-----
>   include/linux/mfd/tmio.h             | 3 ---
>   2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 2c743429e1e3..8ee6298d5a51 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
[...]
> @@ -488,7 +488,8 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
>   static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
>   {
>   	struct renesas_sdhi *priv = host_to_priv(host);
> -	bool use_4tap = host->pdata->flags & TMIO_MMC_HAVE_4TAP_HS400;
> +	bool use_4tap = priv->quirks && priv->quirks->hs400_4taps;
> +

    Extra empty line?

>   
>   	/*
>   	 * Skip checking SCC errors when running on 4 taps in HS400 mode as
[...]

MBR, Sergei
