Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75D22315;
	Wed, 30 Oct 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292372; cv=none; b=ICCEeMjrSKwp8QDDLQTz8Ul6scufLRkXApCFqUtbhOQlqR23/oJW432khKQzRhKJU44w+xzJGOx/7CwqLFtYPAUzbpc0Z+yRf0ZA+MR0GL9mLtFOqGR3qd4dgwWv8y4aye3adVV5uw2v4aVNL3nFrNtv2xEYriQrRyvDdc151Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292372; c=relaxed/simple;
	bh=bXjN3jxZTpXTs9jd7bP8iqE6qhrpgO3mfDc+0GYcu10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kig8w5r0/jMGNfzpGPbXse7LIYdLyUV5z8xutHL5nyk22bibUCovOKbXfoxm+WWn/ti9+b8sc1yaGB8paXoFSAA5qBdXrexvl0evx1uZsVNw8O8NCpLOWgeMk90fSBLjVUab9EiWfWjjVPLACkjTOWd043FcV7xhaW1oMiCuFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mlfo7gDM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mlfo7gDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730292370; x=1761828370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bXjN3jxZTpXTs9jd7bP8iqE6qhrpgO3mfDc+0GYcu10=;
  b=Mlfo7gDMnJSvzZmR9gf+LHdqvr1DhUXJuh+XSiuqeRCx67l6CcdpiYVF
   3J6NQvFbJaop4tm0GWMvyzIMcrZTi+Wc9aL803lLlRVMIvD4Laya7bp/Y
   TPfwnQ2FGUt4ZDTm0V27q6gYZ3amfR1bwJ2tKy8SmHTxF/cLtCVOrP1un
   tXxh8okc72IwX0EJOdht4z2YCpM2kDOjGtA3IKCfXhlc76NVAyo8nS1oP
   59JUswkbEg/QBgCkkp4sh5YG9glY8VyhkSaDEDprT5FaowKCa1Cp+bat8
   Zr6x6s4voT+wexO2srwjG58C8eI8Q00tR7MMo0yxlLz5OlgVF27u9e+iU
   A==;
X-CSE-ConnectionGUID: uw5d4xQQQ5qSN40rm8ouIg==
X-CSE-MsgGUID: ad4FWkWwS/KUfngwUWj8CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30138492"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30138492"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:46:07 -0700
X-CSE-ConnectionGUID: htBDIDUOS1uoNltIdnDP+Q==
X-CSE-MsgGUID: b4snr80zRT6qcx7IskSAbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83115085"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:46:03 -0700
Message-ID: <9507bd21-e0ad-4bb0-b3f1-747201e28280@intel.com>
Date: Wed, 30 Oct 2024 14:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: remove unnecessary variables
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, kernel test robot <lkp@intel.com>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20241030112216.4057-1-victorshihgli@gmail.com>
 <20241030112216.4057-2-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241030112216.4057-2-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/24 13:22, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> There are unnecessary variables in the sdhci_uhs2_send_command()
> that will generate a warning when building the kernel.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410252107.y9EgrTbA-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-uhs2.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c488c6d56015..43820eb5a7ea 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -684,7 +684,6 @@ static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_comman
>  
>  static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> -	int flags;
>  	u32 mask;
>  	unsigned long timeout;
>  
> @@ -714,30 +713,6 @@ static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command
>  
>  	sdhci_uhs2_set_transfer_mode(host, cmd);
>  
> -	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> -		WARN_ONCE(1, "Unsupported response type!\n");
> -		/*
> -		 * This does not happen in practice because 136-bit response
> -		 * commands never have busy waiting, so rather than complicate
> -		 * the error path, just remove busy waiting and continue.
> -		 */
> -		cmd->flags &= ~MMC_RSP_BUSY;
> -	}
> -
> -	if (!(cmd->flags & MMC_RSP_PRESENT))
> -		flags = SDHCI_CMD_RESP_NONE;
> -	else if (cmd->flags & MMC_RSP_136)
> -		flags = SDHCI_CMD_RESP_LONG;
> -	else if (cmd->flags & MMC_RSP_BUSY)
> -		flags = SDHCI_CMD_RESP_SHORT_BUSY;
> -	else
> -		flags = SDHCI_CMD_RESP_SHORT;
> -
> -	if (cmd->flags & MMC_RSP_CRC)
> -		flags |= SDHCI_CMD_CRC;
> -	if (cmd->flags & MMC_RSP_OPCODE)
> -		flags |= SDHCI_CMD_INDEX;
> -
>  	timeout = jiffies;
>  	if (host->data_timeout)
>  		timeout += nsecs_to_jiffies(host->data_timeout);

