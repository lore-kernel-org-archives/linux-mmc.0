Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE1172BD0;
	Mon,  9 Sep 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869282; cv=none; b=X+OrBtIQrsr5glAg3Sk+f78DODJo8jSQ+1izjxRGJTyIK0gN4HBtyfCjcyNiki73bc1ZG1L2LRJctNnxn89bZbHmRtfJGDtCya5B7R+vJRlHlMcWibs+QKBa4vVY5SStWEByZztQihIDhY7UOCDPv0lEyxeaaiaIXaa3mRPWgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869282; c=relaxed/simple;
	bh=aF5/5BPPgM/TawCheDaRdSEei35GEIPJdxqVNj690HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6aQbdXXVvddFq8g+HAvMFVVK0SG6USSHTcrlCebh/9tiqZgzWDleq0hCtCxS9JI0sIrQ4whYp56doOcWZkAD2e/qzxGkUlX/1LIKpTbvYD4BDRKrABft6mhtlJRz+tt/DSmOpm1OUdcrPADqPelpKWfTqZROA+x9397r8IJJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aO6wWTq0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aO6wWTq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869281; x=1757405281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aF5/5BPPgM/TawCheDaRdSEei35GEIPJdxqVNj690HA=;
  b=aO6wWTq0yGGU/sbGLTOyAhbJI+BdkBIRc8UtUy3+CfVaFUwG/RtbAgh3
   QMlj/jkY9Ylx2ZR63fSXUXjeJXY9AjaCS0sn4nYXT1D8DjAyXFtFvVhYJ
   n0sG+vBomw5/lATsd0VG6gmFILAolO/3P5GqjTqaFUvaGAVPNRkmQo+dz
   G7hKOitzu86AHO2UZ4/RPxb3e3j/P1M4ESeXxFDQ/mSGQpYnoYyhPNstP
   iwIwBy6LtqvId7l0+yIDYltFegYvCZ4sWgl74Ob74OJH5vj2XwoSP2sFo
   IZ0UCv4UvJ/9/L+3+4BaNNzk1Zoj+N3yjuKVj8t3VGRIuM7gxAWnVQDVY
   A==;
X-CSE-ConnectionGUID: bpW1ZlLdTyiXek3azmDA8w==
X-CSE-MsgGUID: E/Ykfh9lRT6hDoTG1J3FyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24697708"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24697708"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:08:01 -0700
X-CSE-ConnectionGUID: icxGtOJVTKeViG9prbMkyQ==
X-CSE-MsgGUID: wGxXBdLqTgW7YcfP7CQUMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="97303042"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:57 -0700
Message-ID: <12073898-a98b-46dd-ad68-5d58340a7952@intel.com>
Date: Mon, 9 Sep 2024 11:07:51 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V21 14/22] mmc: sdhci-uhs2: add set_ios()
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
 <20240906102049.7059-15-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240906102049.7059-15-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/09/24 13:20, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a sdhci version of mmc's set_ios operation.
> THis is used to handle basic IO bus setting.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Doesn't seem to compile:

drivers/mmc/host/sdhci-uhs2.c:275:12: error: ‘sdhci_uhs2_set_ios’ defined but not used [-Werror=unused-function]
  275 | static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
      |            ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/mmc/host/sdhci-uhs2.o] Error 1
make[4]: *** [scripts/Makefile.build:485: drivers/mmc/host] Error 2
make[3]: *** [scripts/Makefile.build:485: drivers/mmc] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/home/ahunter/git/review/Makefile:1925: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2


Please check all patches compile.


> ---
> 
> Updates in V14:
>  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
>    sdhci_uhs2_set_ios().
> 
> Updates in V13:
>  - Add judgment condition for power mode in the __sdhci_uhs2_set_ios().
>  - Modify comment message.
> 
> Updates in V9:
>  - Simplity the turning_on_clk in sdhci_set_ios().
> 
> Updates in V8:
>  - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
>    and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
>  - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
>    and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
>  - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
>    in sdhci_uhs2_set_ios().
> 
> Updates in V7:
>  - Remove unnecessary functions.
> 
> Updates in V6:
>  - Modify return value in some functions.
>  - Remove unnecessary functions.
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 95 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
>  drivers/mmc/host/sdhci.h      |  2 +
>  4 files changed, 132 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 8bd2baa79d76..abb56ab8f916 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -207,6 +207,101 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
>  
> +/**
> + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
> + * @host:	SDHCI host
> + * @clear:	bit-wise clear mask
> + * @set:	bit-wise set mask
> + *
> + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> + */
> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> +{
> +	u32 ier;
> +
> +	ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
> +	ier &= ~clear;
> +	ier |= set;
> +	sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
> +	sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> +
> +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u8 cmd_res, dead_lock;
> +	u16 ctrl_2;
> +
> +	/* UHS2 Timeout Control */
> +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> +
> +	/* change to use calculate value */
> +	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
> +
> +	sdhci_uhs2_clear_set_irqs(host,
> +				  SDHCI_UHS2_INT_CMD_TIMEOUT |
> +				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
> +				  0);
> +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> +	sdhci_uhs2_clear_set_irqs(host, 0,
> +				  SDHCI_UHS2_INT_CMD_TIMEOUT |
> +				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
> +
> +	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	if (ios->power_mode != MMC_POWER_OFF &&
> +	    (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> +	     ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	     ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> +	     ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
> +		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> +	else
> +		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +	host->timing = ios->timing;
> +
> +	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> +		sdhci_enable_preset_value(host, true);
> +
> +	if (host->ops->set_power)
> +		host->ops->set_power(host, ios->power_mode, ios->vdd);
> +	else
> +		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> +
> +	sdhci_set_clock(host, host->clock);
> +}
> +
> +static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> +		 mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd, ios->timing);
> +
> +	if (!mmc_card_uhs2(mmc)) {
> +		sdhci_set_ios(mmc, ios);
> +		return 0;
> +	}
> +
> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> +		return 0;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD) {
> +		if (ios->power_mode == MMC_POWER_OFF) {
> +			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +			mmc_regulator_set_vqmmc2(mmc, ios);
> +		}
> +		return -1;
> +	}
> +
> +	sdhci_set_ios_common(mmc, ios);
> +
> +	__sdhci_uhs2_set_ios(mmc, ios);
> +
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 9bd3f610cf8c..f6649a518842 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 366c3d30dba6..63fa1714930a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -47,8 +47,6 @@
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> -
>  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
>  
>  void sdhci_dumpregs(struct sdhci_host *host)
> @@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  	case MMC_TIMING_MMC_HS400:
>  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
>  		break;
> +	case MMC_TIMING_UHS2_SPEED_A:
> +	case MMC_TIMING_UHS2_SPEED_A_HD:
> +	case MMC_TIMING_UHS2_SPEED_B:
> +	case MMC_TIMING_UHS2_SPEED_B_HD:
> +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> +		break;
>  	default:
>  		pr_warn("%s: Invalid UHS-I mode selected\n",
>  			mmc_hostname(host->mmc));
> @@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
>  	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
>  }
>  
> -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	bool reinit_uhs = host->reinit_uhs;
> -	bool turning_on_clk = false;
> -	u8 ctrl;
> -
> -	host->reinit_uhs = false;
> -
> -	if (ios->power_mode == MMC_POWER_UNDEFINED)
> -		return;
> -
> -	if (host->flags & SDHCI_DEVICE_DEAD) {
> -		if (!IS_ERR(mmc->supply.vmmc) &&
> -		    ios->power_mode == MMC_POWER_OFF)
> -			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> -		return;
> -	}
>  
>  	/*
>  	 * Reset the chip on each power off.
> @@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		sdhci_enable_preset_value(host, false);
>  
>  	if (!ios->clock || ios->clock != host->clock) {
> -		turning_on_clk = ios->clock && !host->clock;
> -
>  		host->ops->set_clock(host, ios->clock);
>  		host->clock = ios->clock;
>  
> @@ -2374,6 +2361,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			mmc->max_busy_timeout /= host->timeout_clk;
>  		}
>  	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> +
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	bool reinit_uhs = host->reinit_uhs;
> +	bool turning_on_clk;
> +	u8 ctrl;
> +
> +	host->reinit_uhs = false;
> +
> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> +		return;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD) {
> +		if (!IS_ERR(mmc->supply.vmmc) &&
> +		    ios->power_mode == MMC_POWER_OFF)
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		return;
> +	}
> +
> +	turning_on_clk = ios->clock != host->clock && ios->clock && !host->clock;
> +
> +	sdhci_set_ios_common(mmc, ios);
>  
>  	if (host->ops->set_power)
>  		host->ops->set_power(host, ios->power_mode, ios->vdd);
> @@ -2942,7 +2954,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>  
> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  {
>  	/* Host Controller v3.00 defines preset value registers */
>  	if (host->version < SDHCI_SPEC_300)
> @@ -2970,6 +2982,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  		host->preset_enabled = enable;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
>  
>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>  				int err)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0f78708d0c70..5c66927210bd 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -848,6 +848,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);

