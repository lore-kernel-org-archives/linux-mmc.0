Return-Path: <SRS0=oXoI=6N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069FC83003
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Apr 2020 11:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451812073E
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Apr 2020 11:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2LNk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:13:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:33550 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2LNk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Apr 2020 07:13:40 -0400
IronPort-SDR: uxImJFwZWLTyIWYU9a+fyyYugF9e6F2nbvgTw8vqsS2lNVPG0XqPG429UtABm0XpljAFKTyjUg
 2NjX+zRAJOSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 04:13:39 -0700
IronPort-SDR: zjzfMHT5BB66Hs/gj0e1aXCxb8N2PmdNTpWdpUtqlCAAO0Ev2ceZJ4DlchCLJYnpCRtql61WdR
 u2dSl3ajmUrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,331,1583222400"; 
   d="scan'208";a="282471636"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 04:13:37 -0700
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix no irq handler from suspend
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, Renius.Chen@genesyslogic.com.tw,
        vineethrp@gmail.com, dflogeras2@gmail.com
References: <20200427103048.20785-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <887453a2-b77d-c4f6-7a83-d742e5c9fe13@intel.com>
Date:   Wed, 29 Apr 2020 14:14:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427103048.20785-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/04/20 1:30 pm, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> The kernel prints a message similar to
> "[   28.881959] do_IRQ: 5.36 No irq handler for vector"
> when GL975x resumes from suspend. Implement a resume callback to fix this.
> 
> Fixes: 31e43f31890c ("mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x")
> Co-developed-by: Renius Chen <renius.chen@genesyslogic.com.tw>
> Signed-off-by: Renius Chen <renius.chen@genesyslogic.com.tw>
> Tested-by: Dave Flogeras <dflogeras2@gmail.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ce15a05f23d4..7195dd33ac3d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -334,6 +334,18 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>  	return value;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> +{
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +
> +	pci_free_irq_vectors(slot->chip->pdev);
> +	gli_pcie_enable_msi(slot);
> +
> +	return sdhci_pci_resume_host(chip);
> +}
> +#endif
> +
>  static const struct sdhci_ops sdhci_gl9755_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.enable_dma		= sdhci_pci_enable_dma,
> @@ -348,6 +360,9 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
>  	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
>  	.probe_slot	= gli_probe_slot_gl9755,
>  	.ops            = &sdhci_gl9755_ops,
> +#ifdef CONFIG_PM_SLEEP
> +	.resume         = sdhci_pci_gli_resume,
> +#endif
>  };
>  
>  static const struct sdhci_ops sdhci_gl9750_ops = {
> @@ -366,4 +381,7 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
>  	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
>  	.probe_slot	= gli_probe_slot_gl9750,
>  	.ops            = &sdhci_gl9750_ops,
> +#ifdef CONFIG_PM_SLEEP
> +	.resume         = sdhci_pci_gli_resume,
> +#endif
>  };
> 

