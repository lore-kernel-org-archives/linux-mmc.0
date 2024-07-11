Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234F1C3D;
	Thu, 11 Jul 2024 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675076; cv=none; b=AVrZnBKUPAnUFMn1rcuxHyA8trklHeIbB/DBttE/HnmiPR4NK6mStNkqbqgMCejYT98J38YoT6pUNqlZF8NW3335rJc7Hz6H07pkiePsOtyiu1F7tn+rsWh6qwvZ9j9AtseOyvGkEQj3LA+lCPVOGvgOKTy8TXXG/KS9tn0GWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675076; c=relaxed/simple;
	bh=lhqwGvm/e63bmGWhqkZtBaI8UAe3M4qdk+9Ap2o1tdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHKUdLQgyQ5w29gc569DGxYZp4QcwsOph7P5xkRaa+CO5RUJwINsrl9LxwIJxHfa04qYOJ8q+50R2Tol9PjoeYZNzyBuFFPoNw3Hd1CioQ62dfFx2VfKm42Sy3AhORUY/QrUdPChHUnaa0VrHykh3v6FrUDo+OyT2zPOYix2cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkx2BZ1Y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkx2BZ1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720675075; x=1752211075;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lhqwGvm/e63bmGWhqkZtBaI8UAe3M4qdk+9Ap2o1tdI=;
  b=jkx2BZ1Y3GwQte2yHCY48imTOLLCl2rKukUkeZHUBKK63VbxOm4ktmvI
   yTJ6WYxoa4Oz6u9AYGhpQWrCFKMchZMqMSpew5ZeAcDwQ6JaAH8ATvRGL
   4xg8yuIXi+S88px2WZ6WAce9owRtFhm9ZcbfznCef+cWZ4IG5VQra1Jf0
   3zru7g17Xn38WE4ntYyXmnGPoGkU9AGJkyA2W0r2G5lr43OaZJLxM7SQU
   IKZEzk++IfXLr/JK2LzPA3jJTDkxp9piAeQN9t+ik1WWQ1gYcX0jHj2GZ
   nz4U6rReNHaahJ94B++OAt4zJBWw0spLR24sIfn3QZq7woI9+sKrQcy88
   Q==;
X-CSE-ConnectionGUID: 3OsAl6pVSl+fdb3y6cEmUg==
X-CSE-MsgGUID: zVKNs/FWTiCAJu4CKgHk4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28627773"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="28627773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 22:17:54 -0700
X-CSE-ConnectionGUID: Hnryk8TFRliYHD2HuRcphg==
X-CSE-MsgGUID: VD6yqZEkQ1miWjdB4sckjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="71660991"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 22:17:52 -0700
Message-ID: <44a4c774-c312-48d7-a627-19a7b86a3bf5@intel.com>
Date: Thu, 11 Jul 2024 08:17:47 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20240710180737.142504-1-adrian.hunter@intel.com>
 <20240711040133.GB2556@lst.de>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240711040133.GB2556@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/24 07:01, Christoph Hellwig wrote:
> On Wed, Jul 10, 2024 at 09:07:37PM +0300, Adrian Hunter wrote:
>> blk_queue_max_segment_size() ensured:
>>
>> 	if (max_size < PAGE_SIZE)
>> 		max_size = PAGE_SIZE;
> 
> This is a bit misleading, as it also warned about it and papered over it
> with the above as it had no way to return errors.  Any everyone seeing
> these problems now ignored the warnings before, probably for years..

Was there a warning, since the message in blk_queue_max_segment_size()
was:

		pr_info("%s: set to minimum %u\n", __func__, max_size);

> 
> Except for that:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

