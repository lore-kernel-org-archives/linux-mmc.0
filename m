Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79AFC0A;
	Tue, 29 Oct 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214002; cv=none; b=HQzeLmwd7LP9t/L3NSj/iDSZOIW4t6IMBToUA3v1GvfUB9ym8AQ8t3ouubpnBIQ0EsczeAP+fF5ttYj8lAoTMLMCa0a3M9WdkTlHS9MMJR8/2vl0ozfHrOve1AYe0u4yQJMFQsfJloydbPSmlOn0Q0imFb1nmSZBYbddbSQiSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214002; c=relaxed/simple;
	bh=SiEFjk6TmcgSl4Jn7HhISzuv6QAVmzOotSoDU8dmeEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwAyZgDW472pHiS8QinL06N8YajZR4O3xNUUVOotLZp6bCWPzSaqwRs7ZvGYdTJ1HtJJhWrAmxUIxgu0FZOueB9hFlidZ7xnZ+YrbHnQBwPDQYu0BIj6FguL1x14gTggC+81F2VpkYlBs0Iak8tO2AII/CPrrrPgQNIId6J0rkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+zzB3nv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+zzB3nv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214000; x=1761750000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SiEFjk6TmcgSl4Jn7HhISzuv6QAVmzOotSoDU8dmeEw=;
  b=P+zzB3nvHiQ746656/pWwVcWESLQqvhJdvbsi8P7eH/6TAkQ8xzNW/r4
   g0vOyvPbLl+KxcC8o4a/UJ8f3JIKpcdrCFhc5ECe71v7BhilznnMCL7K2
   MBoxHIafBJ2qewePjObF0Rc+5wUw1dHbOBjuKTPcACsWZvKcSCS+2HODM
   iPpsUOXre6AEI94mkSeZPj3vURGFvqC8956mmYLFF+GqYs38QbisqczgI
   2y9rBG+xl7x1PsRv/poN3Por+//MtFrpTHisv2tdOspU3pZVfKoi2QQVO
   YsVhr4o9kMGLv+bcaQWwE6fbenmXK1YYnCQC/bbr2vjGm/r/EE3Ljgklx
   A==;
X-CSE-ConnectionGUID: ysYmMqfhTPmJyd9rmCBPkg==
X-CSE-MsgGUID: cqeukXbLTy2nQ3XWyRjLvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47322642"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47322642"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:59:59 -0700
X-CSE-ConnectionGUID: t62fhBRmSRONYCfyGV2ujA==
X-CSE-MsgGUID: 8NCGtjc+Q+enW08+sMFsJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82127490"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:59:56 -0700
Message-ID: <b46e153f-f329-44b9-a72e-bcc65763f789@intel.com>
Date: Tue, 29 Oct 2024 16:59:50 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: core: A couple of fixes for UHS-II card
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
 Victor Shih <victorshihgli@gmail.com>, linux-kernel@vger.kernel.org
References: <20241029131752.226764-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241029131752.226764-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/24 15:17, Ulf Hansson wrote:
> The recently introduced UHS-II support to the mmc core has a few problems,
> during the card initialization and re-initialization. This series intends to
> addresses some these problems.
> 
> Ulf Hansson (3):
>   mmc: core: Simplify sd_uhs2_power_up()
>   mmc: core: Add error handling of sd_uhs2_power_up()
>   mmc: core: Fix error paths for UHS-II card init and re-init
> 
>  drivers/mmc/core/sd_uhs2.c | 65 +++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


