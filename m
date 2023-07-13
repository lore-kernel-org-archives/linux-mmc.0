Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C22EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 08:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjGMIdY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjGMIcz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 04:32:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB06EA6
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 01:24:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668709767b1so273569b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689236654; x=1691828654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kKuPJ0jIVe9rxT8F83vWao/GSLcZQvkvWTM04IuCyY8=;
        b=nQ63IjH7Dxla397fTVbDwhr1FnHqS+asUrpDE9FJXZDc/fLh3oMUxE3eyjLHZEsPtH
         5CR9keJOKQzPGlbGaHE5/vKZ6GD5jwVmaJJSbafRJZyzYL9xngNuOWyu6maBOnlRMlP0
         WKQ8T/UWeOHZgLeUy/OUadpNeMEnG50IaUJ3v1cqa4PnIPl3IEM2l9oEdt7n152k/Qsl
         bwiOd+5XVn9EZyZF3UBqsHuN0OJfg7w0H4gMBHxOyTfVSRskXq3fErdWFO98duLqGQJ+
         YmLUR/s64PPChX6QlTA7Re7GvM5WDME2q33r2McXtsBAP0P4v58tyChop6k0iqW5hy5N
         BuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236654; x=1691828654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKuPJ0jIVe9rxT8F83vWao/GSLcZQvkvWTM04IuCyY8=;
        b=KQYTHsnTNYqrHicJZHJBRIxJcPymOXFzpLUdd5xG5MSvbcCc/bSlEnb1NmlOAXPjLu
         4BZn03dSusDDOh/AIOb6JWvZOgq+b6xGZClLw73Ikfixd3Pz36Uhq9wJfJtI3ydSgrPM
         Gzgq5OI3sdKOVWWP6QY0V7OtI0MPHG7lEz1aTFU7cLwNFLCamMtxFuaTSVCaTIgDkeUT
         ZgoeCuRI030wxFPyhXwQiqi5t3tgTwD2VH/5YMg6unLIwMLDEIxn47P1BzZQNi5hIkUX
         1F6bNwsjcYBmYcrrxKTnHfEoFySnw0kf+stwJrQ81hRg/mr7ARSscFxb25QuAvOHXI7m
         zaag==
X-Gm-Message-State: ABy/qLYZM3kwX+VI+mfrDpmt6yaIk0TZPmoRYrwGWaui9FY5c031C3HK
        nnpENySJY65ZOZg+t5pOXlLHEw==
X-Google-Smtp-Source: APBJJlF/JMk+PxvAAbvR3sfCNfLD7IimCJKgpKsJ/o22bsX9uppwZ6XLImDkWeMIqjs65woqwPtkRQ==
X-Received: by 2002:a05:6a00:1913:b0:668:852a:ffc4 with SMTP id y19-20020a056a00191300b00668852affc4mr615729pfi.4.1689236653671;
        Thu, 13 Jul 2023 01:24:13 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b0065da94fe921sm4909516pfn.50.2023.07.13.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:24:13 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:54:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 51/58] mmc: sdhci-spear: Convert to platform remove
 callback returning void
Message-ID: <20230713082410.tc3se6lr726hbeq6@vireshk-i7>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-51-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713080807.69999-51-frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13-07-23, 16:08, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mmc/host/sdhci-spear.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index c79035727b20..ec6c7d8e3736 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -117,7 +117,7 @@ static int sdhci_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int sdhci_remove(struct platform_device *pdev)
> +static void sdhci_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct spear_sdhci *sdhci = sdhci_priv(host);
> @@ -131,8 +131,6 @@ static int sdhci_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, dead);
>  	clk_disable_unprepare(sdhci->clk);
>  	sdhci_free_host(host);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -186,7 +184,7 @@ static struct platform_driver sdhci_driver = {
>  		.of_match_table = of_match_ptr(sdhci_spear_id_table),
>  	},
>  	.probe		= sdhci_probe,
> -	.remove		= sdhci_remove,
> +	.remove_new	= sdhci_remove,
>  };
>  
>  module_platform_driver(sdhci_driver);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
