Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B931C9ED7
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617227; cv=none; b=SO5CRt11p2c/ErdLyBTEs+aWGO5F0iiPxoA0C2882vppYM3BTtiNfCFqPExm6D//pK4mpCHnafIYHbFgcWdR9HK4vG3Zyy50TubyLtqB/ErCAQaQ7lVIuBFyWbVwMnwTxxdrMsrP+ySTwikQ+7LAwuyITIuVF/RF3sN2gAkkKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617227; c=relaxed/simple;
	bh=7pYlqhZAV75VA9NPWEgHGw8MOQ/tvun3lnCZsbV3WVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRBQETO8qDlZhTdWdWt+NPT88b1bSQFH2UsdcqVXFmrkzByTgMdTozVV3NW6tQzg/xGNpwYxFatQtxd4iKgR+DevIky5AS84iaUSH9GV6tq4Lpi7VVqWC8vwn4CH06HbJkLsJN3/oMfsUXLndo67jeljCQaehMj0rvjUR7dlI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itXENuZH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itXENuZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725617225; x=1757153225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7pYlqhZAV75VA9NPWEgHGw8MOQ/tvun3lnCZsbV3WVE=;
  b=itXENuZHoi/N7gVJSZIw/eAEZ1scNnaoy9REnQSWvxlnmq4Z227i9Lkn
   UDuofvPvCgOXoKPpHXz9g2vpN9PuLJ8CM2MieOWI3p68rLvqP9mYYRGWH
   DgcEisiXg2MV/QFixbU9Ij6aseUk2Cab1/zx+0fYPCzRSLj9daUegsfGY
   HWOaufqqagVn165HsavuFUQNuK4RmC4h9DM8zhe+YIhNoHTPbHcPRmaDN
   sxKDZQ8M8CGOXa7P+z7lhB4/EBVQuWZhbR9H3Da3pVYFV36DeL7JkS4bF
   4MACDIqVBmU+MpL1w60k7kzgVP9hPYmFXwk4xsyB9CPNj6sb5FuBrl30p
   w==;
X-CSE-ConnectionGUID: NKk25rUsSImLEAlhBxIDZA==
X-CSE-MsgGUID: EQEt3CbqRX+JFURdyhOl1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="27297754"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="27297754"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:06:46 -0700
X-CSE-ConnectionGUID: 8CzufiW8TZW5L5IlaW+PEA==
X-CSE-MsgGUID: Hha2LLxqT7+OWdMIrL49HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96694086"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:06:44 -0700
Message-ID: <1eb222ee-38f6-4791-849c-7c0376ee96f3@intel.com>
Date: Fri, 6 Sep 2024 13:06:38 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] mmc: core: Add Ext memory addressing for erase
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-7-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240904145256.3670679-7-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 17:52, Avri Altman wrote:
> CMD22 shall precede CMD32 and CMD33 to configure 38-bit erase start
> address and 38 bit erase stop address.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06f63fbaadfb..8d9f2c44d2a2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1645,8 +1645,14 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
>  		cmd.opcode = SD_ERASE_WR_BLK_START;
>  	else
>  		cmd.opcode = MMC_ERASE_GROUP_START;
> -	cmd.arg = from;
> +	cmd.arg = from & 0xFFFFFFFF;

Not needed

>  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +
> +	if (mmc_card_ult_capacity(card)) {
> +		cmd.ext_addr = (from >> 32) & 0x3F;

'0x3F' not needed


> +		cmd.has_ext_addr = 1;

'true' if use bool

> +	}
> +
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err) {
>  		pr_err("mmc_erase: group start error %d, "
> @@ -1660,8 +1666,14 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
>  		cmd.opcode = SD_ERASE_WR_BLK_END;
>  	else
>  		cmd.opcode = MMC_ERASE_GROUP_END;
> -	cmd.arg = to;
> +	cmd.arg = to & 0xFFFFFFFF;

Not needed

>  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +
> +	if (mmc_card_ult_capacity(card)) {
> +		cmd.ext_addr = (to >> 32) & 0x3F;

'0x3F' not needed

> +		cmd.has_ext_addr = 1;

'true' if use bool

> +	}
> +
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err) {
>  		pr_err("mmc_erase: group end error %d, status %#x\n",

