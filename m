Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2658AC2BA19
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC621569
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDWGlU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:41:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:42266 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWGlU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Apr 2020 02:41:20 -0400
IronPort-SDR: 6jRoIPJAbcIrMJVXbgDd7zTpESDY2g/F2AEzq9TjlhZnysEjfDX9EW8zJkOSPSGlgCGXYjeQcP
 T/ZDYFRCDplw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 23:41:19 -0700
IronPort-SDR: 8PpPekKEOHoT+2vPHBXDsmC5DN9uBSNC5Jr88gOiRf/DzsJsNkrEdnZJGgTx6ra3YMfe7DJSwj
 qWeHu4BovbVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="255888898"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2020 23:41:17 -0700
Subject: Re: [PATCH -next] mmc: sdhci-pci-o2micro: Make some symbols static
To:     Zou Wei <zou_wei@huawei.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1587624199-96926-1-git-send-email-zou_wei@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6f04980f-6f0b-8028-82b5-860321508e69@intel.com>
Date:   Thu, 23 Apr 2020 09:40:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587624199-96926-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/04/20 9:43 am, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/mmc/host/sdhci-pci-o2micro.c:497:6: warning: symbol
> 'sdhci_pci_o2_set_clock' was not declared. Should it be static?
> drivers/mmc/host/sdhci-pci-o2micro.c:512:5: warning: symbol
> 'sdhci_pci_o2_probe_slot' was not declared. Should it be static?
> drivers/mmc/host/sdhci-pci-o2micro.c:581:5: warning: symbol
> 'sdhci_pci_o2_probe' was not declared. Should it be static?
> drivers/mmc/host/sdhci-pci-o2micro.c:786:5: warning: symbol
> 'sdhci_pci_o2_resume' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index fa81050..e2a8468 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -494,7 +494,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  	}
>  }
>  
> -void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
> +static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	u16 clk;
>  
> @@ -509,7 +509,7 @@ void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_o2_enable_clk(host, clk);
>  }
>  
> -int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
> +static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> @@ -578,7 +578,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  	return 0;
>  }
>  
> -int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
> +static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  {
>  	int ret;
>  	u8 scratch;
> @@ -783,7 +783,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
> +static int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
>  {
>  	sdhci_pci_o2_probe(chip);
>  	return sdhci_pci_resume_host(chip);
> 

