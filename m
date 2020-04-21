Return-Path: <SRS0=Yb6F=6F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6AFC54FC9
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 11:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6DC206F4
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 11:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="M3e+03IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgDULs1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDULs0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2020 07:48:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8872C061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2020 04:48:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so7620938lja.13
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2020 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WthWl0ofkQVZ0izGYsGCgjoGn+5tpeaX1xtYlSrM77E=;
        b=M3e+03IQQHh19vu3+IqCDJ5CnRk6OeROGlnw2Zkq7mV6IalUnUKeoGrqRcjgQywzQS
         FgbixJWGUage8cAMSMzNDew7fwXWh9ZbbcIhVWGN87RTh3wm3UOHnTXym3VAdHL/LoNG
         bnXmIWT0Le1Wqkz42PF1c+ZMs6MQv49RzN90pcDv2EThvx9vwyaS3QaRhV0tWXlAQbs4
         PmIKgV35BxwfY+V1M9xTPNrRbSzcv5plfYS7jIjgg7DtTGX7zdnm+23xYwn7LcHApfSc
         neHSck8pNHdKa+66NHV4fike/U3LYFaQcl3D3VNd60nSmmmhAG/tPJtzpRKYTywAl+M2
         vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WthWl0ofkQVZ0izGYsGCgjoGn+5tpeaX1xtYlSrM77E=;
        b=LHR+g1Blg+0XLwL1hjRDr4aX9MO57tdpLypBFayNfPdpkoCmFLkgopbFVNRjmiVNQl
         CQiGI2pPonrBeTxuSZpoiWjs8B6PNxozFeZhmqeo5RZ+AMewhQZ+nOHxOC4eb6xzmMaX
         kSCTECFAvvLfR7P1xkPPZL55d1zWA5z9RaWyummSIs44JBIMnWDEQxQzXv/a8qwfOjnY
         BCcbTPyFfJ8ooR2+E8ZZSRLfc5/4s6lYijhyKqkpDl9006HbWhpbPkApMH+4Ul7W5sKt
         sIZC7BhgO1qtJyOj70h3iIs6UutLsg1NEHfxQ+KxX56cWZyi6GgnV48aJ5yFqA2OASdu
         A0tQ==
X-Gm-Message-State: AGi0PubOIh26FKaTL7jD6xIV7JGb8MZaNbzKmBatF7Pje9kla0zSLNt+
        mcie13LqC9FJL3wxR5rafZpvUg==
X-Google-Smtp-Source: APiQypJto+OJO85STpa7GBrtCU5Pmo1PrVliKXZ+6uAxNpDecvO79fXnI+G4ut+oJKLb1TctABJxmA==
X-Received: by 2002:a2e:b00a:: with SMTP id y10mr12203805ljk.158.1587469704455;
        Tue, 21 Apr 2020 04:48:24 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id z7sm1765798ljc.17.2020.04.21.04.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 04:48:23 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:48:23 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: shorten types after refactorization
Message-ID: <20200421114823.GC2600980@oden.dyn.berto.se>
References: <20200420170230.9091-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420170230.9091-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2020-04-20 19:02:30 +0200, Wolfram Sang wrote:
> After TAP refactorization, we can use 'unsigned int' for two more
> variables because all the calculations work on this type now.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi.h      | 2 +-
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 12d8016672b0..86efa9d5cd6d 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -64,7 +64,7 @@ struct renesas_sdhi {
>  	/* Sampling data comparison: 1 for match, 0 for mismatch */
>  	DECLARE_BITMAP(smpcmp, BITS_PER_LONG);
>  	unsigned int tap_num;
> -	unsigned long tap_set;
> +	unsigned int tap_set;
>  };
>  
>  #define host_to_priv(host) \
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 1dfe6c32280b..28b0830c4251 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -527,7 +527,7 @@ static int renesas_sdhi_execute_tuning(struct tmio_mmc_host *host, u32 opcode)
>  static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, bool use_4tap)
>  {
>  	struct renesas_sdhi *priv = host_to_priv(host);
> -	unsigned long new_tap = priv->tap_set;
> +	unsigned int new_tap = priv->tap_set;
>  	u32 val;
>  
>  	val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ);
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
