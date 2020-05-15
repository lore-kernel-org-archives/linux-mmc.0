Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52FC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC852078C
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 14:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOOb5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 10:31:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:25542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEOOb5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 May 2020 10:31:57 -0400
IronPort-SDR: M82nLLN/wHKfHsJh8kvqS1RTA+UAQAIcsVp58Xbbp6Jl7/AIFaHMG+Mpau1CQubkp4S1oc03Hc
 HLV2u6i30ioA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:31:56 -0700
IronPort-SDR: Ah/P2qSEeZWYqOZ8Oa57VMtZD4fisQtDi5J8j7bWCHUAHadvD18yALGaIslp3dIoY3v+fajODR
 g8yIAfEKUdow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="266619515"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2020 07:31:53 -0700
Subject: Re: [PATCH V1 0/7] Target specific DLL configuration for qcom SDHC
To:     Sarthak Garg <sartgarg@codeaurora.org>, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a4bfb88c-b429-5733-8dd1-558ddc6bc71a@intel.com>
Date:   Fri, 15 May 2020 17:32:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/05/20 11:02 am, Sarthak Garg wrote:
> Sarthak Garg (6):
>   dt-bindings: mmc: Add information for DLL register properties
>   mmc: sdhci-msm: Update dll_config_3 as per HSR
>   mmc: sdhci-msm: Update DDR_CONFIG as per device tree file
>   mmc: sdhci-msm: Read and use DLL Config property from device tree file
>   mmc: sdhci-msm: Introduce new ops to dump vendor specific registers
>   mmc: sdhci-msm: dump vendor specific registers during error
> 
> Veerabhadrarao Badiganti (1):
>   mmc: host: sdhci-msm: Configure dll-user-control in dll init sequence

For patches 2 to 7

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  14 +++
>  drivers/mmc/host/sdhci-msm.c                       | 103 ++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c                           |   3 +
>  drivers/mmc/host/sdhci.h                           |   1 +
>  4 files changed, 118 insertions(+), 3 deletions(-)
> 

