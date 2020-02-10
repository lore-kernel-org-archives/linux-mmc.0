Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73DC3B186
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5420863
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 22:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="xewbsNn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJWvo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:51:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35400 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWvo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 17:51:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so9394267ljb.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2020 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IEk+jkgV6Aeja8O8GLIWrkuJbSf/8GPxErrvdOMfU+I=;
        b=xewbsNn73BP3o9FGaily5t8DL218WTXW9TYaPzDBW6uCMQ0DTF+2mNuYeOJCb2JjZO
         0l4tZflpYvkOO6CnjtBqY11zoKg60/gLQBKbywyVJbxcIii6qAlHgCibIdXcFE+LhURk
         trnZYiCCAuFDZeyLWNGvpnce1PJbjDwLtbBZAEdfaz0W9S+KXVW0aEfSxBMAIENR+eek
         GvckFMxKdRKhK68SOwIMuSymH8ICdMd/4MFx/j/775kOgDul7cb1D/OTGYNjqB9BJA+l
         6FdPv9JSHrhrlxTnQ4OXa57j0Mm9GQdmsD5ebwHldZ7Bn6eWagQxBU4kKUdPVYOM6ufU
         fG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IEk+jkgV6Aeja8O8GLIWrkuJbSf/8GPxErrvdOMfU+I=;
        b=PyIl9/8NbpIXbqB/3uX7C12hdIKLP3LbOb7WVjk23t4DJq06Bsi8C1v9r+1dz068Sy
         whF9QGA0Gpw8BzGnytX/GqAuJ2+xUePoSZaUcSeu3TSMADtYCFdS8/MEeja/Bym1rDFO
         F2l58KiTX2i56OCH3elqscy+vMO3FJwk/oUcCHcwhdjecqebXMT7QleJEuJnvdSS3KUX
         2ItsK6/6BbHqbtzeLNA7YlB/625wZRcg85UaT71rfFAUqVZDdl0Z0Fz2aO2t2Mfduq0J
         RzsSdiXnul4NZnt7yrdwQ6aRhuJqW+TiTi0ouowsh8u03LQyApOT6d2wnKJ/b5mhZeTn
         Nkjw==
X-Gm-Message-State: APjAAAWWYvdtQcpKYG2uAoMHfK8pzCb0BhKhvc7dQwrqyYwTxzyl03aa
        irc5dshX90Y7J1HurRKIZm2+0A==
X-Google-Smtp-Source: APXvYqw4vZvOYlWNEVElf8izn5d+S/VL6ofvNnJDXAgC9H8npjPUdoueIxYECZw5Kj9bFiRuMUiJ/A==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr2153180ljg.24.1581375102103;
        Mon, 10 Feb 2020 14:51:42 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id a10sm745458lfr.94.2020.02.10.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:51:41 -0800 (PST)
Date:   Mon, 10 Feb 2020 23:51:41 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH 3/6] mmc: tmio: give callback a generic name
Message-ID: <20200210225141.GC2443363@oden.dyn.berto.se>
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
 <20200129203709.30493-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129203709.30493-4-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-01-29 21:37:06 +0100, Wolfram Sang wrote:
> check_scc_error() is too Renesas specific. Let's just call it
> check_retune() to make it also easier understandable what it does.
> Only a rename, no functional change.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  drivers/mmc/host/tmio_mmc.h          | 2 +-
>  drivers/mmc/host/tmio_mmc_core.c     | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d63aeb35bd0b..24ee8ac1fe21 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -899,7 +899,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  
>  		host->execute_tuning = renesas_sdhi_execute_tuning;
>  		host->select_tuning = renesas_sdhi_select_tuning;
> -		host->check_scc_error = renesas_sdhi_check_scc_error;
> +		host->check_retune = renesas_sdhi_check_scc_error;
>  		host->prepare_hs400_tuning =
>  			renesas_sdhi_prepare_hs400_tuning;
>  		host->hs400_downgrade = renesas_sdhi_disable_scc;
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index bfebbe368f02..bdb9973981ff 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -176,7 +176,7 @@ struct tmio_mmc_host {
>  	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
>  	void (*reset)(struct tmio_mmc_host *host);
>  	void (*hw_reset)(struct tmio_mmc_host *host);
> -	bool (*check_scc_error)(struct tmio_mmc_host *host);
> +	bool (*check_retune)(struct tmio_mmc_host *host);
>  
>  	/*
>  	 * Mandatory callback for tuning to occur which is optional for SDR50
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 593f88cafb6e..3cacb516a66e 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -818,8 +818,8 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
>  	if (mrq->cmd->error || (mrq->data && mrq->data->error))
>  		tmio_mmc_abort_dma(host);
>  
> -	/* SCC error means retune, but executed command was still successful */
> -	if (host->check_scc_error && host->check_scc_error(host))
> +	/* Error means retune, but executed command was still successful */
> +	if (host->check_retune && host->check_retune(host))
>  		mmc_retune_needed(host->mmc);
>  
>  	/* If SET_BLOCK_COUNT, continue with main command */
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
