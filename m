Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AF4F215
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654779; cv=none; b=Xc8NOLlzkdDehZ0IroNX1i7H6F/bxJpI4SZO9sGgbo73rVKU8ct3Zv+ouImnsMpfkoeFYq+DgPHvfow2EpMRMFqwavi8sRMb8Z43gRKJN6Ti3e7zi2m/9WqvhNLAFF/BAK57yPe+ahLU0rPrUq2P3IIbMPd7CX8Iv6uHMvT3X3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654779; c=relaxed/simple;
	bh=+rJrtqFKSmmtiUEmO5AeCB+IHx1Za/pa+l0WmcMT2AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S62d3pNaCtMKMUX8hL7TM/1unK82VZv+IapEvTkmxmIRYAdAUhJ9Tstl0dyFzfANQUff3REfiA9kY2oMT9fHGrBq3OAtd4mrHuD/pEGx+am5s+ZBip2ui9CM2VCGostCcHmTrQZmkT15gGrCFCTTbB0csubQTpzx236Ej71eePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IL5N6C/z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IL5N6C/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724654778; x=1756190778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+rJrtqFKSmmtiUEmO5AeCB+IHx1Za/pa+l0WmcMT2AE=;
  b=IL5N6C/zjIz+NHTZ7ix28tmOnZDzgA6FHkxuPcZtquHb7LXqBSLolRBF
   +PksSVQnK8r/4+507OBnuQNGDEkFdIy6FszYh3UbEy7wYfUJ5/bCYlf1Z
   Ha+M8P+RqfI2ynwl8pecmImYzwJKleVAtmDA+4UeTTuHXEALG9aGGb2au
   2DOKkwyeA4gw5pK3SNQCIsEhZdAVrvJK5EryJ3uj6UxKpm2/5LuzIpfus
   /ewIi28BHyI+OpE1TRtrjpw2elO2rxx33/LDE0DF1wlmbYusneXDbGocJ
   xlJzAQ8Yxokv3LiUreaYuvDQ8z8WH+dhuW4+GZDSh2SJ/oLoJsjQ3r3eK
   g==;
X-CSE-ConnectionGUID: xH8UxosGSk+JIuq1LhL8Rg==
X-CSE-MsgGUID: sICD6XyjSrOuW9KpHK155Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="40526949"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="40526949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:46:17 -0700
X-CSE-ConnectionGUID: I4S1G80CTxubhUzI1DNbxg==
X-CSE-MsgGUID: s0tjeLQQR7Wb/LdXdwZBzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="99909308"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:46:11 -0700
Message-ID: <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
Date: Mon, 26 Aug 2024 09:46:06 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Add SDUC Support
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/24 10:41, Avri Altman wrote:
> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
> cards support capacity larger than 2TB and up to including 128TB. Thus,
> the address range of the card expands beyond the 32-bit command
> argument. To that end, a new command - CMD22 is defined, to carry the
> extra 6-bit upper part of the 38-bit block address that enable access to
> 128TB memory space.
> 
> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II – Same
> as SDXC.
> 
> The spec defines several extensions/modifications to the current SDXC
> cards, which we address in patches 1 - 10.  Otherwise requirements are
> out-of-scope of this change.  Specifically, CMDQ (CMD44+CMD45), and
> Extension for Video Speed Class (CMD20).
> 
> First publication of SDUC was in [1].  This series was developed and
> tested separately from [1] and does not borrow from it.
> 
> [1] https://lwn.net/Articles/982566/

Perhaps add support for mmc_test, and it would be better
if enabling SDUC was the last patch, so bisecting doesn't
leave a kernel that half-supports SDUC.

> 
> ---
> Changes in v4:
>  - Squash patches 1 & 2 (Ulf)
>  - Amend SD_OCR_2T to SD_OCR_CCS in mmc_sd_get_cid (Ulf)
>  - Use card state instead of caps2 (Ricky & Ulf)
>  - Switch patches 5 & 6 (Ulf)
> 
> Changes in v3:
>  - Some more kernel test robot fixes
>  - Fix a typo in a commit log (Ricky WU)
>  - Fix ACMD22 returned value
>  - Add 'Tested-by' tag for the whole series (Ricky WU)
> 
> Changes in v2:
>  - Attend kernel test robot warnings
> 
> ---
> 
> Avri Altman (9):
>   mmc: sd: SDUC Support Recognition
>   mmc: sd: Add Extension memory addressing
>   mmc: core: Add open-ended Ext memory addressing
>   mmc: core: Add close-ended Ext memory addressing
>   mmc: host: Always use manual-cmd23 in SDUC
>   mmc: host: Add close-ended Ext memory addressing
>   mmc: core: Allow mmc erase to carry large addresses
>   mmc: core: Add Ext memory addressing for erase
>   mmc: core: Adjust ACMD22 to SDUC
> 
>  drivers/mmc/core/block.c  | 56 ++++++++++++++++++++++++++++------
>  drivers/mmc/core/bus.c    |  4 ++-
>  drivers/mmc/core/card.h   |  3 ++
>  drivers/mmc/core/core.c   | 63 ++++++++++++++++++++++++++++-----------
>  drivers/mmc/core/core.h   | 14 +++++++--
>  drivers/mmc/core/queue.h  |  1 +
>  drivers/mmc/core/sd.c     | 36 ++++++++++++++--------
>  drivers/mmc/core/sd.h     |  2 +-
>  drivers/mmc/core/sd_ops.c | 16 ++++++++++
>  drivers/mmc/core/sd_ops.h |  1 +
>  drivers/mmc/core/sdio.c   |  2 +-
>  drivers/mmc/host/sdhci.c  | 40 +++++++++++++++++++++----
>  include/linux/mmc/card.h  |  2 +-
>  include/linux/mmc/core.h  |  1 +
>  include/linux/mmc/sd.h    |  4 +++
>  15 files changed, 195 insertions(+), 50 deletions(-)
> 

