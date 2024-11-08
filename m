Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09125197A82;
	Fri,  8 Nov 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051853; cv=none; b=MG9vHv08fmbYlAxclocXdbI11s2QEpcjVg4sMfZQOX/lfmdQmLDZwt7ulNgcDDqimLLgL5Kh5pzRfB6/9hu60r2kkM3TekkxdZ1IcAfudLgTGhJXVIOl7NiuEhu4zrNOuY8lPNkO+d0y3Qc/vA0qHiavUmcM85cbZQrNmLFVknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051853; c=relaxed/simple;
	bh=vr5tVBaCA12jXhO6OiQrBT1zI3rt6AXgj5STH9W7qTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRzer5qkX9Srgbr2r8eqcODG5QB+UzxynImrUpod+AT5rTW+t9FB59eELpfYCZS9IhQTRNGZ/KQrV/82B+we8qA47Zu4jKrH0V5w0AUnHyeHTP5YN9MiPR4Ksm0bY3ql1gLVm5xvMlfbntD6T9hdkm5eQOTIEssg7ZNQzRqwyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+x7iyJl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+x7iyJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731051851; x=1762587851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vr5tVBaCA12jXhO6OiQrBT1zI3rt6AXgj5STH9W7qTY=;
  b=n+x7iyJlyPo5lUsd27jzTXWZ0T6/5M4EwkaDML1tXQN+GK5eyYodNuR3
   QHjGNjLJ8lVV5Bxx+SbfAKrRDP2mWnNuGYb4GSfgVtfu5IL/mJ8GhME0h
   li5ncuNj2Bg5aRPeCtOSRLjL0EJdZeM3Op84OvV+1LjM/4ELjrCCQi/js
   m/WjdImn0juk0jNh0EVnqwFHF/R3JukNj6/HZF/lNVUAricxsvxGzxdh3
   MYFKp8Xk6Moj68ioxcuhAQA9CdLrudZpvlseteIgaQ8h7o5uwUXRB2utr
   3Kir1xpS7sPRUf+cA8L59j7+G1wtHvEAS5qAioBlE59RqbTCFD1m+d9on
   w==;
X-CSE-ConnectionGUID: sqEQHBLPQ5C3wLfbYsOa3g==
X-CSE-MsgGUID: CnaPQQyzT0idZu5BDhsu6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31150508"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="31150508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 23:44:10 -0800
X-CSE-ConnectionGUID: HapB84t0RlK443jGPBI3Sw==
X-CSE-MsgGUID: 84yTqLuuQqiToKLP3qSiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85581533"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 23:44:07 -0800
Message-ID: <72b5788d-8b48-4794-8faf-9dab15e71e96@intel.com>
Date: Fri, 8 Nov 2024 09:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: core: Correction a warning caused by incorrect
 type in assignment for UHS-II
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, kernel test robot <lkp@intel.com>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20241105102901.351429-1-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241105102901.351429-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/24 12:29, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> There is a type issue in the assignment in the sd_uhs2_dev_init()
> that will generate a warning when building the kernel.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411051248.wvjHSFNj-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

It is OK for now, so:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

However it looks like in some other cases, the payload byte
order is wrong, but the value is zero which works anyway.
The UHS-II spec is a bit confusing because it says the DWORDs
are big endian, but the registers are 64-bits, so does that
mean the payload byte order is 3,2,1,0,7,6,5,4 ?

Perhaps someone could check.  I don't have time right now,
sorry.

> ---
>  drivers/mmc/core/sd_uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index c5847a2084d5..1c31d0dfa961 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -181,7 +181,7 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>  			    UHS2_DEV_INIT_COMPLETE_FLAG |
>  			    ((gd & 0xF) << 4) |
>  			    (gap & 0xF);
> -		uhs2_cmd.payload[0] = payload0;
> +		uhs2_cmd.payload[0] = (__force __be32)payload0;
>  
>  		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_INIT_PAYLOAD_LEN,
>  				     UHS2_DEV_INIT_RESP_LEN);

