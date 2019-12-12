Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F38C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 08:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAFC214AF
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 08:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfLLI6W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:58:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:5107 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfLLI6W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Dec 2019 03:58:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 00:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,305,1571727600"; 
   d="scan'208";a="211051659"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.169]) ([10.237.72.169])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2019 00:58:20 -0800
Subject: Re: [PATCH] mmc: sdhci-s3c: remove unused ext_cd_gpio field
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
References: <3f12c2deaae9e77a5e7ab8415db7751a27bc3b98.1575916477.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <dbb465fd-b3b1-422f-2a8a-e6f50bb7fede@intel.com>
Date:   Thu, 12 Dec 2019 10:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3f12c2deaae9e77a5e7ab8415db7751a27bc3b98.1575916477.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/12/19 8:37 pm, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 51e096f27388..8b15945dd499 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -117,7 +117,6 @@ struct sdhci_s3c {
>  	struct s3c_sdhci_platdata *pdata;
>  	int			cur_clk;
>  	int			ext_cd_irq;
> -	int			ext_cd_gpio;
>  
>  	struct clk		*clk_io;
>  	struct clk		*clk_bus[MAX_BUS_CLK];
> @@ -512,7 +511,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  			goto err_pdata_io_clk;
>  	} else {
>  		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> -		sc->ext_cd_gpio = -1; /* invalid gpio number */
>  	}
>  
>  	drv_data = sdhci_s3c_get_driver_data(pdev);
> 

