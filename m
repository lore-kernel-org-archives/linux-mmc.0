Return-Path: <SRS0=BsGh=52=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A31C2BA2B
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Apr 2020 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E5020757
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Apr 2020 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="kiErzZW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDJKZ7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:25:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33064 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDJKZ7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Apr 2020 06:25:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so1069670lfc.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2020 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5Ka1EBeOIBN7Xip1m/jcK1PNBiGzFSitTQ9/Dn9oVlk=;
        b=kiErzZW99ioUHOduilY5qDSzF6tnYhHFdkApTlIKgYV8GROump89AA8sK+PSW/Y9hj
         3PfXpfHuajUBIymxswOEwFfA/QKqQe6zJz9E/3do437YllZFMTTPNvTvcAplnqkonv8t
         KDV8qV1pZ09qppfRPbVBLGytyZkXIHeX57cw8DFR2SJhMAb9nUaeGzTyGRLV3XSF4vaH
         upUqtDUdpZEyRu58hBIzM9ZakH3hCaK92ACv6fl5xqSqKM8jbifG7Dggpr8KEfA9Hjmv
         gQZhmWLLPd84e1PIDhhPBvf9AgIA5H3KIZN4yAzX+STqhs0uoN9gC+ul/aVt6BOEOqgD
         TRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5Ka1EBeOIBN7Xip1m/jcK1PNBiGzFSitTQ9/Dn9oVlk=;
        b=WceFKhp1095ayZVmiHptaMQrMol7E8EP+9mmoj8L7Y2zgVCCrzrgh7Qv3fKAuAfZCU
         yq44gGVcaejudr3PbF1bFvWN8zH0bzCSkRVUwtLR742AsDISvRbNXh6lGeowfPggeQsb
         1w1Lj23skvKxl5euIk6e5kv7cxBqfFGHfF0PMYxUylPzmOVQYZG2By3LDNWIFhLI6JX+
         ONl4KIMUtIvs4AVSqMd+kWtJTygZPcmCtBhxLu09GUTMexEGx32mHgSDGcEM3jAw24Lz
         5Wjy58QRxgm4xKO1g97MPnFAFoSRDQCQNWWtXJQjYF7MugRU9SmGDdbm+IFk09o0sUue
         c+CA==
X-Gm-Message-State: AGi0PuYRFRlIjb1qNw1OIGoIZj6VkhBNyHPju39FLF4GDF3Nbn4hQs9w
        EBlse479i6IB7rXXDLZJJ4zxlg==
X-Google-Smtp-Source: APiQypKOmEFYNGqJVIOi+A9sRZ1j6b/GL0bDuviFgNVIBdX7C2KnnFsZb6/2Om+IKofSECqsG1FS8g==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr2309630lfe.163.1586514357429;
        Fri, 10 Apr 2020 03:25:57 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id q4sm1023321lfk.67.2020.04.10.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 03:25:56 -0700 (PDT)
Date:   Fri, 10 Apr 2020 12:25:56 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: simplify summary output
Message-ID: <20200410102556.GC2798828@oden.dyn.berto.se>
References: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-04-08 16:22:52 +0200, Wolfram Sang wrote:
> No need to call platform_get_resource twice when we still have the
> pointer from before. Also, use '%pa' for a resource_size_t pointer.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index c002e9fb67fb..de7f4fc9bc21 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -933,10 +933,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  			goto eirq;
>  	}
>  
> -	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
> -		 mmc_hostname(host->mmc), (unsigned long)
> -		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
> -		 host->mmc->f_max / 1000000);
> +	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
> +		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
>  
>  	return ret;
>  
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
