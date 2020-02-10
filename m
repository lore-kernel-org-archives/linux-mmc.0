Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E50CC3B186
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 22:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466092051A
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 22:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="lyVhN+A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJWrr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:47:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42944 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWrr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 17:47:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so5528107lfl.9
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2020 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ziXSid8CCKAm4F7rWBURLQZwd/Cb31uMBwVbldO9hQ0=;
        b=lyVhN+A0H8K2Il96ZSbNCoCY9tlPJ/5/bCOTZSNRJrKRvH/c/6RbwDwSME7gdOobie
         DGYwIu/qTPestP7UgpeOTzC3cBAMT5CdGTcsKTGAmIJF4hKnFsxo85Qd8SCMUNPPw3Lu
         WmS//vQsVgLoakmbDe34y2Cw28YY61BxFVMdHU0v819X5d6npSy19HnrxhkcDxHLgq5c
         CIDEggRsE7Zj+bYa2grjZ7bU3msBH1k08UgtjUCobSgwyz+KqjRXDhqBeFoHw44FjNtX
         rryOI52h5NObfEd+ANXmXp3RoaT36BbJjA4j5vg6sLgqAspFKVbL9/L+oy8ps5b+R8ZE
         1CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ziXSid8CCKAm4F7rWBURLQZwd/Cb31uMBwVbldO9hQ0=;
        b=EIyQv4izt6yR/vmRjnV//HLGoO2lM6zlwq0qdZsRlshTqCEvbl/dpcUmS8sSUO78gn
         ad6umgQnuNhyPNTcigV8OtGOJJMcsYupAABl0UvXLUcde6cfeQgWolyxOQANMsspRjbS
         JWL/wBY1/ZtGTOPebHBISd93sIGh9GvlMXVe9qvxX8gJks+ndvb2zU26CRkyzBw5cvDT
         h3dhsQzJohY9yuHuXUNxUkNjLw1XOkLNUxSntc79ULKY9GdZCtY7bLYVlsBatU3WMIWG
         CpsnmnEHLloKlzZ1pqJUZOQ9Djda6LZtYu4PqLLnqZPboqo99Sv5suB3qD1htYGS5YZb
         sDww==
X-Gm-Message-State: APjAAAUwyZ5dKrja5qbZKWQCxIa3ADhZ4tRayFBfXO+u7YkU5WOjKlGw
        /82eZfuWnsc8kT+UohdcgCriLg==
X-Google-Smtp-Source: APXvYqwQMZDtOnQpUeoAmKdigmzNMAxinmVuU3FEIwq+xYwzSVZOtkqfNRXlXTyJsFdpv0vYqhqJow==
X-Received: by 2002:a19:94d:: with SMTP id 74mr1797274lfj.144.1581374865494;
        Mon, 10 Feb 2020 14:47:45 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id z19sm751630lfg.26.2020.02.10.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:47:44 -0800 (PST)
Date:   Mon, 10 Feb 2020 23:47:44 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH 2/6] mmc: renesas_sdhi: complain loudly if driver
 needs update
Message-ID: <20200210224744.GB2443363@oden.dyn.berto.se>
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
 <20200129203709.30493-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129203709.30493-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2020-01-29 21:37:05 +0100, Wolfram Sang wrote:
> When the tap array in the driver is too low, this is not a warning but
> an error. Also _once is not helpful, we should make sure it is
> prominently in the logs. It is safe to do this because this will only
> show up during SoC enablement when we a new SoCs needs more taps (if
> that ever will happen).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Note: 'unsigned long' seems big enough for a while. But, famous last
> words(tm). We could handle this at runtime by reallocating a bigger
> buffer. Very unsure if it is worth it, though.

I can not tell if it's worth doing this now or not. But if it's a error 
instead of a warning it will be easier to spot if we should have done so 
;-)

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
>  drivers/mmc/host/renesas_sdhi_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index b3ab66f963f8..d63aeb35bd0b 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -499,9 +499,9 @@ static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
>  		return 0; /* Tuning is not supported */
>  
>  	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
> -		dev_warn_once(&host->pdev->dev,
> -			"Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
> -		return 0;
> +		dev_err(&host->pdev->dev,
> +			"Too many taps, please update 'taps' in tmio_mmc_host!\n");
> +		return -EINVAL;
>  	}
>  
>  	priv->doing_tune = true;
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
