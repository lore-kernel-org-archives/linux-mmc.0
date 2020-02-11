Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D8C3B186
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F332082F
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="Ws25qt8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBKACo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:02:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36170 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBKACn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 19:02:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so5656578lfh.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2020 16:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cKEW2oUgOjCypiZhYcZ2lOx7hLN52eOywH4Wltad51U=;
        b=Ws25qt8Mkv/A4U/S8rkX84BJboHUsgtO0s2IOm1b3Ouqgbg+mbn3uRYX0zxHrVG1vh
         Q6FYQ4xRq6ffz4dSEqi7lKYM2ZHMBVyU53Gf1DbO+ZewK/XFl6tECFDJUlu3hcDWgKVy
         gf07fC2nMxZumeF1bQePim6cSy+sVsNSlqn6uviMdTb0ypLz8K9dczUkk26zVn46+8Qw
         QDJZeN0J4BfQfD4FFE2pjCQwzwJljSsqXYJQfCPASD1nSRd2/9oHCLTqq05IpZjcwizm
         rkBlAosOE5d6j5xdsixkJ/6Vn/5jcsDx006OYjZOUSdY12Xzjh9AGFHVO14t+AjDNDY4
         zGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cKEW2oUgOjCypiZhYcZ2lOx7hLN52eOywH4Wltad51U=;
        b=BDep1sMh5QJ9LjjqAGMC/1zpDe5TNfEl4LvufsQFmozsp5nvtGdnmK92IEAEm9sVl1
         x6V1uReDFZpoYKTRrBJtIjFSMQBTFSEDnrT37tq8g+b3JCeqORx9n5wItdkNgdfGoBpL
         NgxQfveoTtRPjuqk769wZ9nyTcXQvrI31vIEPUBjfVufD8sWqH78kFjwlZyTApen+iXL
         1MHoaCP8al8iZV7Cc8bnNDorDPKkmF8j0j3ScmmWl5CE1Q8pZg+sNUTCU/jO3oH6gLj4
         I0+effR8L2brdoXXxlmev3kbHDlgVIuOUJVT5tZh/4vTfF/nyFguTeby/rM0ddZNMnVT
         OChw==
X-Gm-Message-State: APjAAAWIuAeNmGY330g3ipgYDbrcf3UTw1khAY2076Tde2xfPjaYrTIx
        fthK0HJjW4a0wdr5qECImmAR7Q==
X-Google-Smtp-Source: APXvYqzANtjoaf7m4/dM3WgJzxTj1WApGl+OuWY9CAL83omkOWXL+2gatuo6NJYz74gLZNHkXiggiA==
X-Received: by 2002:a19:f610:: with SMTP id x16mr1990681lfe.80.1581379360779;
        Mon, 10 Feb 2020 16:02:40 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id g15sm1082413ljk.8.2020.02.10.16.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 16:02:40 -0800 (PST)
Date:   Tue, 11 Feb 2020 01:02:39 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH 6/6] mmc: tmio: remove superfluous callback wrappers
Message-ID: <20200211000239.GF2443363@oden.dyn.berto.se>
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
 <20200129203709.30493-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129203709.30493-7-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2020-01-29 21:37:09 +0100, Wolfram Sang wrote:
> After various refactoring, we can populate the mmc_ops callbacks
> directly and don't need to have wrappers for them anymore.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 18 ++++++++++------
>  drivers/mmc/host/tmio_mmc_core.c     | 32 +---------------------------
>  2 files changed, 12 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 22eaabe513d0..0f07cc1aee34 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -321,8 +321,9 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
>  		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
>  }
>  
> -static void renesas_sdhi_hs400_complete(struct tmio_mmc_host *host)
> +static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
>  {
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
>  	struct renesas_sdhi *priv = host_to_priv(host);
>  
>  	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> @@ -376,8 +377,9 @@ static void renesas_sdhi_reset_scc(struct tmio_mmc_host *host,
>  				     SH_MOBILE_SDHI_SCC_CKSEL));
>  }
>  
> -static void renesas_sdhi_disable_scc(struct tmio_mmc_host *host)
> +static void renesas_sdhi_disable_scc(struct mmc_host *mmc)
>  {
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
>  	struct renesas_sdhi *priv = host_to_priv(host);
>  
>  	renesas_sdhi_reset_scc(host, priv);
> @@ -412,9 +414,12 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
>  			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>  }
>  
> -static void renesas_sdhi_prepare_hs400_tuning(struct tmio_mmc_host *host)
> +static int renesas_sdhi_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +
>  	renesas_sdhi_reset_hs400_mode(host, host_to_priv(host));
> +	return 0;
>  }
>  
>  #define SH_MOBILE_SDHI_MAX_TAP 3
> @@ -899,10 +904,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  
>  		host->execute_tuning = renesas_sdhi_execute_tuning;
>  		host->check_retune = renesas_sdhi_check_scc_error;
> -		host->prepare_hs400_tuning =
> -			renesas_sdhi_prepare_hs400_tuning;
> -		host->hs400_downgrade = renesas_sdhi_disable_scc;
> -		host->hs400_complete = renesas_sdhi_hs400_complete;
> +		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
> +		host->ops.hs400_downgrade = renesas_sdhi_disable_scc;

Would it make sens to rename renesas_sdhi_disable_scc() to 
renesas_sdhi_hs400_downgrade() to fit the pattern that it's called from 
the mmc_ops?

With or without this nit,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> +		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
>  	}
>  
>  	num_irqs = platform_irq_count(pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index aeafa1c68ce2..a2415fb5dde0 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -997,34 +997,7 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
>  	return blk_size;
>  }
>  
> -static int tmio_mmc_prepare_hs400_tuning(struct mmc_host *mmc,
> -					 struct mmc_ios *ios)
> -{
> -	struct tmio_mmc_host *host = mmc_priv(mmc);
> -
> -	if (host->prepare_hs400_tuning)
> -		host->prepare_hs400_tuning(host);
> -
> -	return 0;
> -}
> -
> -static void tmio_mmc_hs400_downgrade(struct mmc_host *mmc)
> -{
> -	struct tmio_mmc_host *host = mmc_priv(mmc);
> -
> -	if (host->hs400_downgrade)
> -		host->hs400_downgrade(host);
> -}
> -
> -static void tmio_mmc_hs400_complete(struct mmc_host *mmc)
> -{
> -	struct tmio_mmc_host *host = mmc_priv(mmc);
> -
> -	if (host->hs400_complete)
> -		host->hs400_complete(host);
> -}
> -
> -static const struct mmc_host_ops tmio_mmc_ops = {
> +static struct mmc_host_ops tmio_mmc_ops = {
>  	.request	= tmio_mmc_request,
>  	.set_ios	= tmio_mmc_set_ios,
>  	.get_ro         = tmio_mmc_get_ro,
> @@ -1033,9 +1006,6 @@ static const struct mmc_host_ops tmio_mmc_ops = {
>  	.multi_io_quirk	= tmio_multi_io_quirk,
>  	.hw_reset	= tmio_mmc_hw_reset,
>  	.execute_tuning = tmio_mmc_execute_tuning,
> -	.prepare_hs400_tuning = tmio_mmc_prepare_hs400_tuning,
> -	.hs400_downgrade = tmio_mmc_hs400_downgrade,
> -	.hs400_complete	= tmio_mmc_hs400_complete,
>  };
>  
>  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
