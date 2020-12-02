Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2188C64E8A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6342222E
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 08:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgLBIat (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:30:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:65006 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbgLBIat (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 03:30:49 -0500
IronPort-SDR: rFvJ7REynL5pM4VfqUKQL9fiDtAoY5sXmAChoKlsxCKgdm/pOT9Qyjd1nn6aOfDAzTqr5u9SGF
 hAGL9/ZS/Ajw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152805390"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="152805390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:30:03 -0800
IronPort-SDR: KtHiIYhC2LdV0hKOyoeYg1Df6rlN7MSnVkMuMWV+mN/04ZIDYI3GeHnOL3loKs/AHXw6hV0dfF
 vlDXCx/DizMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="330350527"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2020 00:29:56 -0800
Subject: Re: [PATCH v2 0/4] sdhci-xenon ACPI support
To:     Marcin Wojtas <mw@semihalf.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com, kostap@marvell.com
References: <20201120032639.24386-1-mw@semihalf.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5b5a1367-2632-2754-bc8b-7d57d0205232@intel.com>
Date:   Wed, 2 Dec 2020 10:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120032639.24386-1-mw@semihalf.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/11/20 5:26 am, Marcin Wojtas wrote:
> Hi,
> 
> The second version of the sdhci-xenon ACPI support
> is now split into 4 patches instead of a single one.
> There are minor functional differencse - match_data
> introduction and using dedicated ACPI ID per
> controller variant.
> 
> The MacchiatoBin firmware for testing can be obtained from:
> https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
> 
> Changelog:
> v1->v2
>   * Split single commit to 4
>   * Use device_match_data and dedicated ACPI ID's per controller
>     variant
> 
> Marcin Wojtas (4):
>   mmc: sdhci-xenon: use match data for controllers variants
>   mmc: sdhci-xenon: switch to device_* API
>   mmc: sdhci-xenon: use clk only with DT
>   mmc: sdhci-xenon: introduce ACPI support
> 
>  drivers/mmc/host/sdhci-xenon.h     |  12 +-
>  drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++---
>  drivers/mmc/host/sdhci-xenon.c     | 120 +++++++++++++-------
>  3 files changed, 110 insertions(+), 62 deletions(-)
> 

Not withstanding Ulf's comments:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
