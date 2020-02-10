Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6974AC3F68F
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 23:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4474120848
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 23:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="UvFBSN+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJXx6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:53:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgBJXx6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 18:53:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so9534496ljg.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2020 15:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7lxN1U/G4mY9j838MWfGKlJd4LAT0jOtRiqfH4sfZyo=;
        b=UvFBSN+iNM68jNQTJvv7IujRuJgqBwFOJrHb87fl5u4i/MiqZ7TYcKEa4SqYrdP0EE
         Q0SKJEQfvnnOKSCNxnXJoR2LP5XLm2NxBeZxS4c2UrMzVmS6fk3iRO9Ll4BDR5sktllC
         tAbrRXTffPt7jZmWNSdx8UmZ62FWLKWmh5kXxoG/D6/TqpeC1QbpKrsfRAbK7QziuCzc
         nBKSTkR7bRcM3/4FzubmZaHgvodW2OnoTqC6eIgVFWCVoGEgzqPG/KN8ylXNcbuMnlyp
         ZqEc8omylPQdpkOzr3N9Nqd/S3ARXr/TJ0VYrbvPmY6dNoyABJ8+NfHqlMfNUPBO4fES
         Cojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7lxN1U/G4mY9j838MWfGKlJd4LAT0jOtRiqfH4sfZyo=;
        b=SvTqAJPA5uGqT302wiUoeePTePGr2Ji9aElA/x3nayUgS+x4/gXElIbnEAVN0eOVbx
         IB05MqIkwT82XSTB34M/h6U666AVsTZ5Adl01G1zUmc+NBBqaVXfsImnIYoJuucLXBZE
         pQA6ZEy+Qgj1Zn27eQ1mu7pBmmYZAITpv3gkPlAbxWjUuW7Sqjshk8YPh0u53BofGoON
         7sDKsh0gReEg4KUmWOKppV6dzHqxn2S6FreQkeBN9sKuFaUON3reZSqIH5Qvc/F6rf0q
         y9TEO8rK0TJ8qHOcCEbQt4xe6bOd0Xaeag/Bey/wNmYm9LwHuU9Q0HpVfLVvoQICGGir
         +aGQ==
X-Gm-Message-State: APjAAAVpnO4/4Qrlsk3Cp8nQovA7gbCBYaU1KuLsLvzqz5IRmetFme3U
        J4u1UC1bbXJdRFXWffgy2QLOxg==
X-Google-Smtp-Source: APXvYqzNXqvBnrVeHFcY3iJytyCydZj17IvC3eL8KLc0fx4OLf+4V2dfnyIEzP48qjj5Su33UaJ10w==
X-Received: by 2002:a2e:b61a:: with SMTP id r26mr2434226ljn.72.1581378836046;
        Mon, 10 Feb 2020 15:53:56 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id o6sm802932lfg.11.2020.02.10.15.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 15:53:55 -0800 (PST)
Date:   Tue, 11 Feb 2020 00:53:54 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH 4/6] mmc: tmio: enforce retune after runtime suspend
Message-ID: <20200210235354.GD2443363@oden.dyn.berto.se>
References: <20200129203709.30493-1-wsa+renesas@sang-engineering.com>
 <20200129203709.30493-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129203709.30493-5-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2020-01-29 21:37:07 +0100, Wolfram Sang wrote:
> Currently, select_tuning() is called after RPM resume. But
> select_tuning() needs some additional function calls to work correctly.
> Instead of reimplementing the whole postprocessing, just enforce
> retuning.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> I couldn't trigger RPM suspend even with debug code. Shimoda-san said
> it should only occur with removed cards which is not so easy with
> soldered eMMC. For those cases, I think the aproach taken here is fine.
> Needs more discussion, though, to make sure...

I really like the change so I really wanted to provoke a suspend to be 
able to provide a tested by tag, but I have so far been unable to do so 
:-(

> 
>  drivers/mmc/host/renesas_sdhi_core.c | 1 -
>  drivers/mmc/host/tmio_mmc.h          | 1 -
>  drivers/mmc/host/tmio_mmc_core.c     | 8 +-------
>  3 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 24ee8ac1fe21..0c9e5e010bda 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -898,7 +898,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  			dev_warn(&host->pdev->dev, "Unknown clock rate for tuning\n");
>  
>  		host->execute_tuning = renesas_sdhi_execute_tuning;
> -		host->select_tuning = renesas_sdhi_select_tuning;
>  		host->check_retune = renesas_sdhi_check_scc_error;
>  		host->prepare_hs400_tuning =
>  			renesas_sdhi_prepare_hs400_tuning;
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index bdb9973981ff..b6fffd3d2650 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -183,7 +183,6 @@ struct tmio_mmc_host {
>  	 * and mandatory for SDR104.
>  	 */
>  	int (*execute_tuning)(struct tmio_mmc_host *host, u32 opcode);
> -	int (*select_tuning)(struct tmio_mmc_host *host);
>  
>  	/* Tuning values: 1 for success, 0 for failure */
>  	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 3cacb516a66e..aeafa1c68ce2 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1302,11 +1302,6 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_suspend);
>  
> -static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
> -{
> -	return host->tap_num && mmc_can_retune(host->mmc);
> -}
> -
>  int tmio_mmc_host_runtime_resume(struct device *dev)
>  {
>  	struct tmio_mmc_host *host = dev_get_drvdata(dev);
> @@ -1323,8 +1318,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>  
>  	tmio_mmc_enable_dma(host, true);
>  
> -	if (tmio_mmc_can_retune(host) && host->select_tuning(host))
> -		dev_warn(&host->pdev->dev, "Tuning selection failed\n");
> +	mmc_retune_needed(host->mmc);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
