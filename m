Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB1C4167B
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Dec 2022 07:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLIHcU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Dec 2022 02:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLIHbm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2022 02:31:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484C42985;
        Thu,  8 Dec 2022 23:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670571021; x=1702107021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CsY99elT+rE23AZSG7dcf1pSjxakIjRmVdHMlDG14XI=;
  b=bUdmkhgQKc8qUAWg/CYK+PvqyfYMWW2YYQGsxAWuXmtFhM2Ql7lDxS/5
   ZU4/+glz/A7rCWPrXZNPAjZMoVmHcx60ugLk05PzY2G0pvxeH+64h0EGM
   KMHllDmbaCbXltNRLpCHIDXjZqg3JoWBBqvr364ZOtYaVUHJbK4d9qCka
   S1TX/ZW3LdtEel76TPqaWAuYdeu2L0TIItGRY5XJHjcWsnW6La9kJCqti
   S6NbYRjak8EyrWzpglr0tHvr6kmHwMO6e69zSNPKqECvAGVt3pPf7ufED
   qMn3cO/Mq4lI9/NkdTqUgQ4jlOOY2vplOBwA7esf4yNSgBZXww2XrvsDt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="379615994"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="379615994"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 23:30:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="678066639"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="678066639"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.86])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 23:30:15 -0800
Message-ID: <42914812-dd00-3c62-95bd-018e328043b4@intel.com>
Date:   Fri, 9 Dec 2022 09:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Modify mismatched function name
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/12/22 05:41, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/mmc/host/sdhci-of-esdhc.c:243: warning: expecting prototype for _fixup(). Prototype was for esdhc_writel_fixup() instead.
> drivers/mmc/host/sdhci-of-esdhc.c:117: warning: expecting prototype for _fixup(). Prototype was for esdhc_readl_fixup() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3397
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 9d875bb531a8..4712adac7f7c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -98,7 +98,7 @@ struct sdhci_esdhc {
>  };
>  
>  /**
> - * esdhc_read*_fixup - Fixup the value read from incompatible eSDHC register
> + * esdhc_readl_fixup - Fixup the value read from incompatible eSDHC register
>   *		       to make it compatible with SD spec.
>   *
>   * @host: pointer to sdhci_host
> @@ -223,7 +223,7 @@ static u8 esdhc_readb_fixup(struct sdhci_host *host,
>  }
>  
>  /**
> - * esdhc_write*_fixup - Fixup the SD spec register value so that it could be
> + * esdhc_writel_fixup - Fixup the SD spec register value so that it could be
>   *			written into eSDHC register.
>   *
>   * @host: pointer to sdhci_host

