Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A6208A1;
	Fri, 24 May 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535393; cv=none; b=t9NbSVnsKJdX4QtX7zgVkjTf6k3HEOpxbxMGnhdk+VVPtbH45qXwGlNHqt3fGnv4ZYVY4BahARhfP7P/42jK2ooR4yY/QeBsdFGhLnKw3nrCOsOYvavkYxf2r+A5qXdBtnQEeBWG9m/Ua0NKwM/E36T9ZM/R0SKCwHBN5TiGYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535393; c=relaxed/simple;
	bh=wPTC8uCMIdwu51FSlfnw6NJaV8UQD91oFTZuzE6L3lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3ELUoEIJgdNYbpsMMeMRPSE8iqpetyk+AhOUcD2vOhn7ClWIeGSWF2pN9dgwdAjnibEkfPOWCl7iVSzD61EYSpdm21OSBj396wSbIit0fTRcBV7HNqwOZcYHvuGSKUsfgGOVhzYuwoQMYZyYBHQLp4bMkkt/TQte5GNXHKB4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4Yi3z3f; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4Yi3z3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716535392; x=1748071392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wPTC8uCMIdwu51FSlfnw6NJaV8UQD91oFTZuzE6L3lI=;
  b=n4Yi3z3fWTY3zi4dZFAJjs/EtX+R9PlOB7U9HMaRVGnAseGZLEkO4kFl
   1b01aVotcETUL3XinN+UfuUsgJoUtlNhERc+3/wQ7+Z9oTn1eZCzz4g+1
   aOmRfmXDQ3Q0VvC1x8AIi6H1ULR+tHm0NexX48necjJ07TytYfcN+ufPQ
   q81OxTnX7ijZsf3CUPDpc5DgTgWj02SX3MsxEnndaYqbm7dfUQmvxIgqy
   sQj3LBfWLIG970dNbDxDvNC/ubuc67iVQ8SptoBISwibg0yNdGZwv9Mzg
   V3vecKB3/AqA5LNGt7dEqPmSCdRoOM/8Tqox7k43Zo8vmcJZO/zyv7hBu
   Q==;
X-CSE-ConnectionGUID: l5ykJYS0RuWPKP53c+DAvA==
X-CSE-MsgGUID: d30gxJj+QJW7rL6Qpui7Ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35415830"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="35415830"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:23:11 -0700
X-CSE-ConnectionGUID: kV91wCo1RraN24KLUBbpEg==
X-CSE-MsgGUID: hVyiAtHAQ1S1w+i+RpfTLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="65147483"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 00:23:08 -0700
Message-ID: <42f2b1d4-e6c2-4860-956d-4f10c3b05529@intel.com>
Date: Fri, 24 May 2024 10:23:02 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 12/23] mmc: sdhci-uhs2: add reset function function
To: Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-13-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240522110909.10060-13-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/24 14:08, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V15:
>  - Refer the SD Host Controller Standard Specification Section 3.10
>    to add reset command data mechanism.
> 
> Updates in V14:
>  - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
>    sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode().
> 
> Updates in V13:
>  - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.
> 
> Updates in V8:
>  - Adjust the position of matching brackets.
> 
> Updates in V6:
>  - Remove unnecessary functions and simplify code.
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 57 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  drivers/mmc/host/sdhci.c      |  3 +-
>  drivers/mmc/host/sdhci.h      |  1 +
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 9cb0f1b2a37d..7652158ea151 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -10,7 +10,9 @@
>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -21,6 +23,8 @@
>  #define SDHCI_UHS2_DUMP(f, x...) \
>  	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
>  
> +#define UHS2_RESET_TIMEOUT_100MS		100000
> +
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  {
>  	if (!(mmc_card_uhs2(host->mmc)))
> @@ -49,6 +53,57 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Low level functions                                                       *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +/**
> + * sdhci_uhs2_reset - invoke SW reset
> + * @host: SDHCI host
> + * @mask: Control mask
> + *
> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> + */
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> +{
> +	u32 val;
> +
> +	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> +
> +	if (mask & SDHCI_UHS2_SW_RESET_FULL)
> +		host->clock = 0;
> +
> +	/* hw clears the bit when it's done */
> +	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> +				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
> +		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
> +			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
> +		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> +
> +static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {

Please use mmc_card_uhs2()

> +		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +
> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> +	}
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -57,6 +112,8 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
> +	host->mmc_host_ops.uhs2_reset_cmd_data = sdhci_uhs2_reset_cmd_data;

As noted for patch 8, any host controller resets needed
should be done before completing the request, so a call
back function should not be needed.

> +
>  	return 0;
>  }
>  
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 2bfe18d29bca..caaf9fba4975 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -177,5 +177,6 @@
>  struct sdhci_host;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8fc3e001db74..f212da6dc2aa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -236,7 +236,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset);
>  
> -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  {
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>  		struct mmc_host *mmc = host->mmc;
> @@ -249,6 +249,7 @@ static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_do_reset);
>  
>  static void sdhci_reset_for_all(struct sdhci_host *host)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 13703f1a3710..83d994c8d89e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -845,6 +845,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);

