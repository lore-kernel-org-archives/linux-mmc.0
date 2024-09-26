Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAF14F9E9;
	Thu, 26 Sep 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727395074; cv=none; b=chPbjhAipAyAfrQVoeAIljYXeOWfm0bsnVEEkZNBT61lUTLPyDAVDbea9nU43U9YfSd40wZZgtGUVJbBztXKYS25EihwRhKshREJ4xKtZpq/4t9Pcdu0q2GBfJLDW/u8IYD4Ev+lp1VFu1fBmHogIMrAHhbglRDobayKr8s7wck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727395074; c=relaxed/simple;
	bh=FVXTk+PNxmIc7tbjypwiWusNwsBd6vOgIY/+i7i7gu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kidr3Z9gdoVJf60qNtX7FykKAOmo6s2nGCUGHlIIx5dZE3JjQ4W863Y0BJsfx7z1YcxQIhHY1cS/B95NsmSTaU+QYnMHkFkPJGaNj7/amOrOD44pJ0HZgi99JZhTGOqJ1oUImAJkgZ+R7FGFYN3nYJhkD9Wtqxsj6bcvRBXBovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZBGWyWO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZBGWyWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727395072; x=1758931072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVXTk+PNxmIc7tbjypwiWusNwsBd6vOgIY/+i7i7gu0=;
  b=eZBGWyWOVCaXBI8lz5U4sEsSkcY0YWnbSKoPboPihr2Hbpba5QFoynU8
   MCtBeZAZV3J76BNyLHNyenFlU48cYjcxI8q5b+xfulPFYp22SDp3dUIQl
   ftwZrQRxpBYFq7LhSaAD5lpqIazmXeyTyn6fmNLGExUGJhH/6IhhrWWhJ
   DWisQnMb0tJdCQ98zihd/CEtgTulLOj7LUFuAtFDYASuWdBtpw09Bvz0m
   MEl1h9Idy5a74LRFVYmcT2MrfrrYIArR8sCxMd7ADn/1E1gUY2xq0J5sD
   BJsGZbQCJP03Fgez4uY0TbS9UFJhfv8rWWDS1QIdIh8oEYICorMozvyTw
   A==;
X-CSE-ConnectionGUID: CjHkej2HRxyM5I1eHwloDw==
X-CSE-MsgGUID: 7LTIKcqRSIyf7+pOsm6Uvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37092390"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="37092390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 16:57:51 -0700
X-CSE-ConnectionGUID: 2iM7RUfkTJSqozK86RpSyQ==
X-CSE-MsgGUID: dlxGB7OjSmyM18+yFzfp+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="77166783"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Sep 2024 16:57:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1styMk-000LJL-2X;
	Thu, 26 Sep 2024 23:57:46 +0000
Date: Fri, 27 Sep 2024 07:56:48 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chaotian.jing@mediatek.com
Cc: oe-kbuild-all@lists.linux.dev, ulf.hansson@linaro.org,
	matthias.bgg@gmail.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] mmc: mtk-sd: Implement Host Software Queue for eMMC and
 SD Card
Message-ID: <202409270757.fiwHeAaN-lkp@intel.com>
References: <20240925113949.149655-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925113949.149655-1-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11 next-20240926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/mmc-mtk-sd-Implement-Host-Software-Queue-for-eMMC-and-SD-Card/20240925-200025
base:   linus/master
patch link:    https://lore.kernel.org/r/20240925113949.149655-1-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH] mmc: mtk-sd: Implement Host Software Queue for eMMC and SD Card
config: arm-randconfig-002-20240927 (https://download.01.org/0day-ci/archive/20240927/202409270757.fiwHeAaN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409270757.fiwHeAaN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409270757.fiwHeAaN-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mmc_hsq_init" [drivers/mmc/host/mtk-sd.ko] undefined!
>> ERROR: modpost: "mmc_hsq_suspend" [drivers/mmc/host/mtk-sd.ko] undefined!
>> ERROR: modpost: "mmc_hsq_resume" [drivers/mmc/host/mtk-sd.ko] undefined!
>> ERROR: modpost: "mmc_hsq_finalize_request" [drivers/mmc/host/mtk-sd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
