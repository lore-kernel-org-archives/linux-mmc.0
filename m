Return-Path: <SRS0=Gx1C=BO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F2C433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Aug 2020 05:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CF02064B
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Aug 2020 05:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHDF3a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:29:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:62694 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgHDF33 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Aug 2020 01:29:29 -0400
IronPort-SDR: wOoSP/RLVSVEWHG2BxbZcGETmWmpGlb/FXRmoZdH5ZHkH6KvUHtEuJ9ZyL3MoSLuFuOWO/oZuQ
 gN6MPyslrtJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="237113084"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="237113084"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 22:29:28 -0700
IronPort-SDR: Z8iqhYn++WufcKhSFIRurRKwOsdQH/yF+J5w7TlJp1oymsnYKRD5uGkMvu7j8j3vG0PTbUTF1e
 xeIsCzEzBVCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="330486541"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2020 22:29:27 -0700
Subject: Re: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: Bug fix for O2 host
 controller Seabird1
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200721011733.8416-1-shirley.her@bayhubtech.com>
 <BY5PR16MB33196E3E0FB7C2143BE7D73F8B4D0@BY5PR16MB3319.namprd16.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fc572647-9a51-ee38-c1a7-71f62c1edad0@intel.com>
Date:   Tue, 4 Aug 2020 08:29:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR16MB33196E3E0FB7C2143BE7D73F8B4D0@BY5PR16MB3319.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sorry, I have been away for a while, but I will look at it shortly.

On 3/08/20 10:23 pm, Shirley Her (SC) wrote:
> Hi, Adrian:
> 
> Do you have chance to review the patched code?
> 
> Thanks,
> Shirley
> 
> ----------------------------------------------------------------------------
> *From:* Shirley Her (SC) <shirley.her@bayhubtech.com>
> *Sent:* Monday, July 20, 2020 6:18 PM
> *To:* adrian.hunter@intel.com <adrian.hunter@intel.com>;
> ulf.hansson@linaro.org <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> <linux-mmc@vger.kernel.org>; linux-kernel@vger.kernel.org
> <linux-kernel@vger.kernel.org>
> *Cc:* Shaper Liu (WH) <shaper.liu@bayhubtech.com>; Chevron Li (WH)
> <chevron.li@bayhubtech.com>; Xiaoguang Yu (WH)
> <xiaoguang.yu@bayhubtech.com>; Max Huang (SC) <max.huang@bayhubtech.com>;
> Shirley Her (SC) <shirley.her@bayhubtech.com>
> *Subject:* [PATCH V1 1/2] mmc: sdhci-pci-o2micro: Bug fix for O2 host
> controller Seabird1
>  
> Add bug fix for O2 host controller Seabird1
> 
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
> ---
> change in V1:
> 1. Add quriks2 and mmc->caps2 for Seabird1
> 2. Add get_cd support for Seabird1
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c
> b/drivers/mmc/host/sdhci-pci-o2micro.c
> index e2a846885902..ed3c605fcf0c 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -561,6 +561,12 @@ static int sdhci_pci_o2_probe_slot(struct
> sdhci_pci_slot *slot)
>                          slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
>                  }
>  
> +               if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD1) {
> +                       slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
> +                       host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +                       host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +               }
> +
>                  host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
>  
>                  if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
> -- 
> 2.25.1
> 

