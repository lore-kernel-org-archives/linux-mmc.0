Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8784FC3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 06:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D362206F6
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 06:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDTGJf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:09:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:43382 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgDTGJe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Apr 2020 02:09:34 -0400
IronPort-SDR: Y14szW8yJPl79FSkXJsaNYGDij5VOG/lOrh9Zv9yFIapZqzcml8ARnpTaX6FxefIb7oudYUQcb
 pU8B7q1VFSkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 23:09:34 -0700
IronPort-SDR: SQHJ0sLBySw9ByQlKn3Z8vdXw2bZ5GeJdPCl37ICbWtL7AANdqyz4iwokbh8tzfH69f9t4qWmP
 tXIB/qV2bqrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="456275136"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2020 23:09:31 -0700
Subject: Re: [PATCH][next] sdhci: arasan: fix uninitialized value being
 returned as error code
To:     Colin King <colin.king@canonical.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200417154901.112236-1-colin.king@canonical.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <49e93e7a-1f9e-ce5b-ca68-a088069ca2b0@intel.com>
Date:   Mon, 20 Apr 2020 09:08:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200417154901.112236-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/04/20 6:49 pm, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the error return value in variable ret is not being initialized
> and so a successful return path is returning a garbage value. Since ret
> is not being used the simple fix is just return 0 on a successful return.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: f73e66a36772 ("sdhci: arasan: Add support for Versal Tap Delays")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

>  drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 16e26c217a77..45603ba515b2 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -735,7 +735,6 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  		container_of(clk_data, struct sdhci_arasan_data, clk_data);
>  	struct sdhci_host *host = sdhci_arasan->host;
>  	u8 tap_delay, tap_max = 0;
> -	int ret;
>  
>  	/*
>  	 * This is applicable for SDHCI_SPEC_300 and above
> @@ -781,7 +780,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct clk_ops versal_sdcardclk_ops = {
> @@ -807,7 +806,6 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  		container_of(clk_data, struct sdhci_arasan_data, clk_data);
>  	struct sdhci_host *host = sdhci_arasan->host;
>  	u8 tap_delay, tap_max = 0;
> -	int ret;
>  
>  	/*
>  	 * This is applicable for SDHCI_SPEC_300 and above
> @@ -857,7 +855,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct clk_ops versal_sampleclk_ops = {
> 

