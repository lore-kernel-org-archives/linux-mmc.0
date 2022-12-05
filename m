Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9AC47089
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Dec 2022 08:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLEIRF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Dec 2022 03:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiLEIQ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2022 03:16:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0CBF52;
        Mon,  5 Dec 2022 00:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670228218; x=1701764218;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sH9q+xEpJF7iv5b2TXJrMpoGv7B/IMq9/DUHAv34X4M=;
  b=eEfgmx5Ii9D6MlfCh7uNd4idQRO+uzKHwvidEf8whuR4Qzui06lUl5bC
   43xEAzAuJoJD+aPP13Vv/zKPwr6tKE2pgdaxEEQVAKa49w4OOHKv/4Y1N
   CIBoSmj61I3g5qM4jyG5kIXD/byGgGeXG46KLd7M7JR9UN5xxkTlryqky
   UrrjsbtxnpYUWf/7gtEHL+ZgMcUziAWlgTYGCmUKXbb8Z9th1D9L+KveQ
   BnckSuqn4oSldRdZR/CQZQ5zc+DWlTnV78vLl3YUb+olj98IgJtOWpBls
   k3/Q5V1mzQzJbpm/WXrIiYFF9u3d1IzGl5xqcYwQRF52h/IGSmwIm8Yeg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="343283513"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="343283513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:16:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="734507723"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="734507723"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.104])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:16:52 -0800
Message-ID: <973a9f5c-6798-3f92-cdeb-ce4571273cf1@intel.com>
Date:   Mon, 5 Dec 2022 10:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for SDHCI Broadcom BRCMSTB
 driver
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
References: <20221202212119.43214-1-kdasu.kdev@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221202212119.43214-1-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/22 23:21, Kamal Dasu wrote:
> Taking over as upstream maintainer for Broadcom SDHCI
> driver from Al Cooper.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1daadaa4d48b..90beddcf84b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18497,6 +18497,7 @@ K:	\bsecure_computing
>  K:	\bTIF_SECCOMP\b
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
> +M:	Kamal Dasu <kdasu.kdev@gmail.com>
>  M:	Al Cooper <alcooperx@gmail.com>
>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>  L:	linux-mmc@vger.kernel.org

