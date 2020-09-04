Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC7C43461
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1E42087C
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 10:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lf0HxtXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgIDKmu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgIDKmW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2020 06:42:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E9EC061245
        for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2020 03:42:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c15so975597plq.4
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2020 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIRGdkogEbr2UU4S8C5/CFso+vuQ+g2531Q9ZkBMLUI=;
        b=lf0HxtXKMSyYzKLuSZFXF6q+/8QS2LhO8X4eKUQrQw27IOgZw9be6+E5iTpwCaRJ+Y
         lyKPPcsNegehi3VOvhhhAzzIusL4QB6dXCsO35c7v0Fp5veXhVfZosJaSZi/G4qTNGSU
         cNkdqloEiwKlqfMOBW/bWyzozp0NFaRbDqojxFe8k760+XTlP8ByHp+rwx8EnyDjtvtZ
         vErWrDcP9K+WXouHmumZN4kVZWTPSbKMIf1ZJvFO55ui1QQ6Bw9Bw4DJBimDzQUAWIhs
         TqJ+H/xKlfnggpy6RpbkxmV00XLVpT78HaH84BeTUwDcT9jJqwlqlYmtlKnFV3ce1ISp
         xQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIRGdkogEbr2UU4S8C5/CFso+vuQ+g2531Q9ZkBMLUI=;
        b=V5DETcRY/f4k0Ck24fVaoUOkY34aqwjpHwVQSmrIDafPDv1MQWgguWLJLRX5mAK+dD
         kwaY6hyUgN0PK55iSEiIPs7tWKtghYohiv5bN5TIMdH5KCqdyglTw/v5D6jBsiWvBcCq
         R2nwHFDw3umX3XqNBSE0GLjcsWO4njWW5i9B5GbWh5bn6TgTlElvzFPkdu0qjmGM21E8
         1YDAK1MV9I3BbVNYnu+szS+rOfxh3BQXM6ZswSLCoQplCfhtVPgEwoonlIcM0HioSYuo
         wt7C/YRr4YEETfQ8QoMwKMqPX5CnIsl9sTYMk4T9RjieJTd4QIfEcKgaJOuez7lh2SQR
         AXQQ==
X-Gm-Message-State: AOAM531dETz7hk3FCTNZdcGEVDdo/1XhvlVMPNPdwHmjMt0H8qf392ye
        LcImOuQZSx3LwqLIottn9tXw
X-Google-Smtp-Source: ABdhPJx5DfeJqeWBG7RepL9K/iqki0O/TK0I5SNGWwxqxq5OmeX0PIlrHDrBhn1zJA8hoV9b6IRjYg==
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr7675652pjn.109.1599216141746;
        Fri, 04 Sep 2020 03:42:21 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id s9sm4985194pgm.40.2020.09.04.03.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 03:42:20 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:12:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, swboyd@chromium.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 6/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that
 are newer than 5.4
Message-ID: <20200904104211.GA4056@mani>
References: <20200903232441.2694866-1-dianders@chromium.org>
 <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 0903, Douglas Anderson wrote:
> This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> probe") but applied to a whole pile of drivers.  This batch converts
> the drivers that appeared to have been added after kernel 5.4.
> 

Backporting made easy ;)

> Signed-off-by: Douglas Anderson <dianders@chromium.org>

For owl-mmc,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 1 +
>  drivers/mmc/host/owl-mmc.c           | 1 +
>  drivers/mmc/host/sdhci-esdhc-mcf.c   | 1 +
>  drivers/mmc/host/sdhci-milbeaut.c    | 1 +
>  drivers/mmc/host/sdhci-of-sparx5.c   | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index 53e3f6a4245a..7cd9c0ec2fcf 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -903,6 +903,7 @@ static struct platform_driver meson_mx_sdhc_driver = {
>  	.remove  = meson_mx_sdhc_remove,
>  	.driver  = {
>  		.name = "meson-mx-sdhc",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  		.of_match_table = of_match_ptr(meson_mx_sdhc_of_match),
>  	},
>  };
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index df43f42855e2..ccf214a89eda 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -689,6 +689,7 @@ MODULE_DEVICE_TABLE(of, owl_mmc_of_match);
>  static struct platform_driver owl_mmc_driver = {
>  	.driver = {
>  		.name	= "owl_mmc",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  		.of_match_table = owl_mmc_of_match,
>  	},
>  	.probe		= owl_mmc_probe,
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 71bf086a9812..ca7a1690b2a8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -509,6 +509,7 @@ static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
>  static struct platform_driver sdhci_esdhc_mcf_driver = {
>  	.driver	= {
>  		.name = "sdhci-esdhc-mcf",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe = sdhci_esdhc_mcf_probe,
>  	.remove = sdhci_esdhc_mcf_remove,
> diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
> index 4e7cc0680f94..148b37ac6564 100644
> --- a/drivers/mmc/host/sdhci-milbeaut.c
> +++ b/drivers/mmc/host/sdhci-milbeaut.c
> @@ -333,6 +333,7 @@ static int sdhci_milbeaut_remove(struct platform_device *pdev)
>  static struct platform_driver sdhci_milbeaut_driver = {
>  	.driver = {
>  		.name = "sdhci-milbeaut",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  		.of_match_table = of_match_ptr(mlb_dt_ids),
>  	},
>  	.probe	= sdhci_milbeaut_probe,
> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
> index 747f108a0ace..28e4ee69e100 100644
> --- a/drivers/mmc/host/sdhci-of-sparx5.c
> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> @@ -255,6 +255,7 @@ MODULE_DEVICE_TABLE(of, sdhci_sparx5_of_match);
>  static struct platform_driver sdhci_sparx5_driver = {
>  	.driver = {
>  		.name = "sdhci-sparx5",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  		.of_match_table = sdhci_sparx5_of_match,
>  		.pm = &sdhci_pltfm_pmops,
>  	},
> -- 
> 2.28.0.526.ge36021eeef-goog
> 
