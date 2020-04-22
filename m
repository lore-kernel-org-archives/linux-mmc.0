Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C1C5518B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9951C21569
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YToNmTSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgDVQdk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgDVQdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 12:33:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09CC03C1A9;
        Wed, 22 Apr 2020 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GhxXNkwIWL9QIK8tOJiZor+ArOGr/Ec9kz1wNtkTM0E=; b=YToNmTSoYuisnSyd35L7v7LRu0
        A5ulwNzUkiUyT5V//tSQCKg2khb7bPmuUMiqHb9bvvdLhK74se9wL6GGnHREUs6ZxdcacCc/Jt5cZ
        3TyV7N5ONiHlxAvsJAsIqc1u6QsqyNpK0Egy780p7nPsvnVUfYtVgG1j8QTN3EwIgoc98IDrjqgwU
        0ru98OLbqxg6ReXMLvBZSL88XcJXoPvSH/LhVCa8WQw3BPjOQcj+cLFfeHv7HvBjjJuuHf3NlDXKV
        5KXeivtJD1owtsgk0UiPbzAYMiL3vbmy+Nzq3hN3PaTeHRDWzU3OLI3KIKuVXNoooAki3uQon1big
        X6OVO1/g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRIJa-0000D2-4q; Wed, 22 Apr 2020 16:33:34 +0000
Subject: Re: [PATCH] mmc: sdhci-of-at91: make MMC_SDHCI_OF_AT91 depend on
 HAVE_CLK
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
References: <20200422153401.7913-1-yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <38b856aa-47a1-7957-ba96-32272aa404c0@infradead.org>
Date:   Wed, 22 Apr 2020 09:33:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422153401.7913-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/22/20 8:34 AM, Masahiro Yamada wrote:
> If sdhci-of-at91.c is compiled without CONFIG_HAVE_CLK, the line
> 
>   caps1 |= FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
> 
> ... emits "FIELD_PREP: value too large for the field" warning.
> 
> The compiler seems to decide clk_mul is constant (unsigned int)-1,
> because clk_get_rate() returns 0 when CONFIG_HAVE_CLK is disabled.
> 
> Add HAVE_CLK to the depenency since this driver does not work without
> the clock APIs anyway.
> 
> Link: https://lkml.org/lkml/2020/4/17/613
> Fixes: linux-next ("mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> 
> Ulf,
> 
> I do not know how to fill the Fixes tag.
> It is currently 8da1ff4f68a2 in linux-next, but I am not sure it is
> stable. I just added 'linux-next'.
> 
> If you have a preferred way, please modify it.
> 
> 
> 
> 
> 
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 462b5352fea7..2aee844722d6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -171,7 +171,7 @@ config MMC_SDHCI_OF_ASPEED
>  config MMC_SDHCI_OF_AT91
>  	tristate "SDHCI OF support for the Atmel SDMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> -	depends on OF
> +	depends on OF && HAVE_CLK
>  	help
>  	  This selects the Atmel SDMMC driver
>  
> 


-- 
~Randy
