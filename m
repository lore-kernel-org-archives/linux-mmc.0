Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1DC48BDF
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Jun 2021 15:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787E8611CE
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Jun 2021 15:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFVPJM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:09:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:23972 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhFVPJL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Jun 2021 11:09:11 -0400
IronPort-SDR: MKWGQS8vImJYJSFISP2bdPnuy2wo/RcoL4CulfNSYUIFFO/gIE0Ih4NruG8DW65lKy1sVueYaP
 wG8uip37GBag==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="292701169"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292701169"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 08:06:54 -0700
IronPort-SDR: wVp8Hcnzl6gXPlnF/pdFhPGbrPPWOCGnmLM/kSP154Ak54Qb8AZ5QsPJLkZayKXnc/9CfVINZd
 GNscgsjpewOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="405991704"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2021 08:06:50 -0700
Subject: Re: [PATCH 0/7] sdhci-of-arasan driver updates for ZynqMP platform
To:     Manish Narani <manish.narani@xilinx.com>, michal.simek@xilinx.com,
        ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <eb8147db-cfb4-1f86-5464-0d069992708e@intel.com>
Date:   Tue, 22 Jun 2021 18:07:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/06/21 1:43 pm, Manish Narani wrote:
> This patch series has some bug fixes for sdhci-of-arasan driver with
> respect to ZynqMP platform. This series also has some code style changes
> in the driver.
> 
> Manish Narani (6):
>   mmc: sdhci-of-arasan: Modified SD default speed to 19MHz for ZynqMP
>   mmc: sdhci-of-arasan: Add "SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12" quirk.
>   mmc: sdhci-of-arasan: Skip Auto tuning for DDR50 mode in ZynqMP
>     platform
>   mmc: host: sdhci-of-arasan: Check return value of non-void funtions
>   mmc: host: sdhci-of-arasan: Use appropriate type of division macro
>   mmc: host: sdhci-of-arasan: Modify data type of the clk_phase array
> 
> Sai Krishna Potthuri (1):
>   mmc: arasan: Fix the issue in reading tap values from DT
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 51 ++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 

The subject prefixes look inconsistent, nevertheless, for all 7:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
