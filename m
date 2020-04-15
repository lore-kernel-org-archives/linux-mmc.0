Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B4C38A2B
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5580D20771
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 07:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441171AbgDOHUW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:20:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:60518 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441149AbgDOHUT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 03:20:19 -0400
IronPort-SDR: PaqZ+AhgjoUOcGbCRQoi83QTU4wBFrb6vn7ucmDOHh4+mEW/e2QutXMHLyEq3d0RtZxtoBDSVZ
 pstsBaGYkw5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:20:17 -0700
IronPort-SDR: filQrUmefFZnsuI2X6HjURYn2GJAKFaqJdDUHDl1jbs6NDIyk22jUx+7DXjhQrFwuoD9Str+50
 oTIdIdhXOLog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="244032687"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2020 00:20:14 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci: move SDHCI_CAPABILITIES_1 to a more
 suitable place
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        masahiroy@kernel.org
References: <20200408072105.422-1-yamada.masahiro@socionext.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <af02a837-c5a9-4d0a-34a4-534e155ac968@intel.com>
Date:   Wed, 15 Apr 2020 10:19:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408072105.422-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/04/20 10:21 am, Masahiro Yamada wrote:
> In the SDHCI specification, the Capabilities Register (Offset 0x40h)
> is the 64-bit width register, but in Linux, it is represented as two
> registers, SDHCI_CAPABILITIES and SDHCI_CAPABILITIES_1 so that drivers
> can use 32-bit register accessors.
> 
> The upper 32-bit field is associated with SDHCI_CAPABILITIES_1.
> 
> Move the definition of SDHCI_CAPABILITIES_1 to the correct place.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 79dffbb731d3..b786b68e0302 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -220,6 +220,7 @@
>  #define  SDHCI_CAN_64BIT_V4	0x08000000
>  #define  SDHCI_CAN_64BIT	0x10000000
>  
> +#define SDHCI_CAPABILITIES_1	0x44
>  #define  SDHCI_SUPPORT_SDR50	0x00000001
>  #define  SDHCI_SUPPORT_SDR104	0x00000002
>  #define  SDHCI_SUPPORT_DDR50	0x00000004
> @@ -236,8 +237,6 @@
>  #define  SDHCI_CAN_DO_ADMA3	0x08000000
>  #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
>  
> -#define SDHCI_CAPABILITIES_1	0x44
> -
>  #define SDHCI_MAX_CURRENT		0x48
>  #define  SDHCI_MAX_CURRENT_LIMIT	0xFF
>  #define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
> 

