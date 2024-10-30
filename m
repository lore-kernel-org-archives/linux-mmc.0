Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D01DDC10;
	Wed, 30 Oct 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281280; cv=none; b=ZCb0m1Ky2ugtW+AMk0F+TidAtd6fPIu0ihUjOsz36E1+8W3ZM1Y0LNnc4nbvMfnV6nXJasxW4qfiWDuOhXPuSvZx/p9hOEa61lfA6ypHGAAQh39MmRjc17+lPBiV1LIri1isauyOfj4+c1RnpijPZB8siutp+CeB5oCEUJl/xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281280; c=relaxed/simple;
	bh=NY0J1YfVmkX8Qs+Gth150sGt0ynOxPx1DD966vL8Wjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWkMbel9GaIY17tmBrTYOIehAeT87VI9c9sfYuRhI+LRJJeqLb5b5rivY+cU7mOQL+4C7XGaIY9d/frit3+gUxnlGG6XdF4/gE0/3W7NqId8M7NpQWkeHtaMS1ST4hxEEth+zf8llMJ+k+SdCFgFw9TCTn2K5LFuIXbwHP3vQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYUTxViz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYUTxViz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730281278; x=1761817278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NY0J1YfVmkX8Qs+Gth150sGt0ynOxPx1DD966vL8Wjw=;
  b=gYUTxVizesMfIYS7jCJ72yIplrU7gHv6SgoUatEEXE/wFfxd01a+hdNC
   y2U9Ye47JY2o6CzwcqiElHDbZKftI5Wuzu3OWC4oQ8APfx9s4buPSx0Hf
   jQbuMw2fyMDKP0ixrxifX8IQNv8Nw+62N3fDIJK+TTEYQprqNxheO53FW
   2fl1RSBZ236JvxzAbh4dTDK7fpF+BhoiDPWhMyXLth2N7clLoFZStyxEm
   gKDpOYXnofdC4ebiOrFdQ2AY+5FFflFs/gDNEw2QFMO6CxQP8cjqBDIiS
   JIg829NSvb8i2oMvOXHyvef86MIRCnMi+SJXermaiHOvUSzQb/BRtzinl
   g==;
X-CSE-ConnectionGUID: fJ2UM6JQS7qPlGknOa+EIA==
X-CSE-MsgGUID: 6D+xnIXGQROj0ViUTpmG7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29419521"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="29419521"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:41:17 -0700
X-CSE-ConnectionGUID: uW4Bhm4lS7utgiAuWMXJsA==
X-CSE-MsgGUID: g3gnIh6aRbOzFIrSUxFGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="105571180"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:41:13 -0700
Message-ID: <3a9d2d51-81c0-407d-ad0f-2c1202f15935@intel.com>
Date: Wed, 30 Oct 2024 11:41:08 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-uhs2: Remove unnecessary NULL check
To: Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
 dan.carpenter@linaro.org, takahiro.akashi@linaro.org
References: <20241030015326.2289070-1-benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241030015326.2289070-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/24 03:53, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> The "host->ops" pointer points to an offset into the "sdhci_ops" struct
> so it cannot be NULL. Remove "host->ops" check in "if" statement.

It is a pointer, so it could be NULL, but it never will be in this
function.

> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410271835.tqz9s9JV-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Apart from commit message:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c488c6d56015..b0e4ab852a94 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -413,7 +413,7 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
>  
>  	DBG("Begin do uhs2 detect init.\n");
>  
> -	if (host->ops && host->ops->uhs2_pre_detect_init)
> +	if (host->ops->uhs2_pre_detect_init)
>  		host->ops->uhs2_pre_detect_init(host);
>  
>  	if (sdhci_uhs2_interface_detect(host)) {

