Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0E1C2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AAD20732
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 10:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504459AbgDPKER (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:04:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:64634 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504310AbgDPKEO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Apr 2020 06:04:14 -0400
IronPort-SDR: e98BOlgd6z8WbbqXwGaIvhNNg1bE0+KgDNQXzPpnzAQTJR3VJgehgOKiMpr/4ovDDKLIf8NyuB
 ui8M7hAFJCBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 03:04:13 -0700
IronPort-SDR: NR7amtrUlN9jrXFVu8HC7eEEbqlG8TxMwdkX1r/2jalt3zKSb9fFp0umHixebn6dog/F1oQICK
 jtU9416CJvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363940812"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 03:04:10 -0700
Subject: Re: [PATCH V1 3/4] mmc: sdhci-msm: Set
 SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        ulf.hansson@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
 <1586706808-27337-4-git-send-email-vbadigan@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <34a9cd31-0457-7fa7-9399-65e5151f15f5@intel.com>
Date:   Thu, 16 Apr 2020 13:03:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1586706808-27337-4-git-send-email-vbadigan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/04/20 6:53 pm, Veerabhadrarao Badiganti wrote:
> sdhci-msm can support auto cmd12.
> So enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index d826e9b..482045b 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1882,7 +1882,9 @@ static void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> -		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	.ops = &sdhci_msm_ops,
>  };
> 

