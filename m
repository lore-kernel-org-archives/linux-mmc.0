Return-Path: <SRS0=85Gt=6S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA80C3A5A9
	for <linux-mmc@archiver.kernel.org>; Mon,  4 May 2020 07:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF6C20746
	for <linux-mmc@archiver.kernel.org>; Mon,  4 May 2020 07:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEDH0r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 May 2020 03:26:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:51226 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgEDH0q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 May 2020 03:26:46 -0400
IronPort-SDR: bKzXpkmAhjhSAStYYEZY+2aV/hwtWtgdOmwiQPYMJAwm6OtrRlp6UWJvLy7CToHZvb9+Fr53qO
 zE8tsYa+LLGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 00:26:46 -0700
IronPort-SDR: dNqaLO+Hhv22m8nqff4QTwAcXvRubXWgF6SDi0/GRsT3KhPlXKfqgOjeTiF7z9wU92GxRa73n0
 /uVi6kIg3WeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="259248998"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 04 May 2020 00:26:43 -0700
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix can not access GL9750 after
 reboot from Windows 10
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, renius.chen@genesyslogic.com.tw,
        custos.mentis@gmail.com
References: <20200504063957.6638-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <21b55731-388f-91ef-3f38-5896f7da9121@intel.com>
Date:   Mon, 4 May 2020 10:27:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504063957.6638-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/05/20 9:39 am, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Need to clear some bits in a vendor-defined register after reboot from
> Windows 10.
> 
> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> Reported-by: Grzegorz Kowal <custos.mentis@gmail.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ce15a05f23d4..8170b659f2af 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -26,6 +26,9 @@
>  #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
>  #define   GLI_9750_DRIVING_1_VALUE    0xFFF
>  #define   GLI_9750_DRIVING_2_VALUE    0x3
> +#define   SDHCI_GLI_9750_SEL_1        BIT(29)
> +#define   SDHCI_GLI_9750_SEL_2        BIT(31)
> +#define   SDHCI_GLI_9750_ALL_RST      (BIT(24)|BIT(25)|BIT(28)|BIT(30))
>  
>  #define SDHCI_GLI_9750_PLL	      0x864
>  #define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
> @@ -122,6 +125,8 @@ static void gli_set_9750(struct sdhci_host *host)
>  				    GLI_9750_DRIVING_1_VALUE);
>  	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
>  				    GLI_9750_DRIVING_2_VALUE);
> +	driving_value &= ~(SDHCI_GLI_9750_SEL_1|SDHCI_GLI_9750_SEL_2|SDHCI_GLI_9750_ALL_RST);
> +	driving_value |= SDHCI_GLI_9750_SEL_2;
>  	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
>  
>  	sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
> 

