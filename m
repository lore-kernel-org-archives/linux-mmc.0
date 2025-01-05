Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A1184F;
	Sun,  5 Jan 2025 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736036927; cv=none; b=rQmIPMu10omZ8uEQOcpxvlZgUsI50mXILWoWMGu3rl67xKuVsWSOfStcF2A6C8Tv+cjwBIjijoLueOgJYqBaJJ4XNoW1RR/JNyYqx4ey+vTOw14ss11ePgZitvE7zqPt+L3++5F3nf8eCr2lCR35FQQPgYbkWHKYIrp0+Zo8L2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736036927; c=relaxed/simple;
	bh=ha0luu9hiAK5+1mfWX1KsAJ1kNx3anO7Gu4A8rsUsNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWaXHoPxIGOnrEWO68aizakCSFq8p5D5B1dNzLIbQjUuDMqrzuIFAurLmzlAu1EuDsqjwWRL1M4nOc+EBeAr0bJrtYS+C/iYck2n+Xa+5a5JpSue71DFgiCXFtSIO9o6VXhYPXD8HMZy3RjED0NAPAZPP0u7JfCvzjmHrKCUCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EedeoDGS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EedeoDGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736036926; x=1767572926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ha0luu9hiAK5+1mfWX1KsAJ1kNx3anO7Gu4A8rsUsNo=;
  b=EedeoDGSPj+2Ad/6ty057yE6SKFxRVK4MYl92ROYtfVWBURDVDEyNU7c
   AgWTriWatsJnBTchAUsWKQ7S6FOI4wG5t3fefOBgijQAq9/R+jjh65WZj
   l3HNqxgdTsUk0YbCqwv/ZhCB9n3et7VYHG0aPps7qNbXO460IUcJW9kF8
   pan3Va48PxJEA3QlAImAF9Fu4UdC+XCu8b5T0eCS3sAb9tP8Hiv5TaNwZ
   S8zeWhIhHdulO3Fo1K2w10w4Q5a4dlEKTFMvHIvj+251deAlf+YfEIJJW
   vAgvJKUylKVKoLT3Jh4LbxgTQNFtQoIKitWFyq/sWuUa58DboBPS1tzFr
   g==;
X-CSE-ConnectionGUID: ADid6mniSUW8aIqKY4MDsw==
X-CSE-MsgGUID: A/0MRvOASFekNO6pO42TXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11305"; a="35531000"
X-IronPort-AV: E=Sophos;i="6.12,289,1728975600"; 
   d="scan'208";a="35531000"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 16:28:45 -0800
X-CSE-ConnectionGUID: 5YZTBN2JRYGsUB+DQR1fwA==
X-CSE-MsgGUID: t5VFkvDQTMyR1CKV4A4zyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133019800"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jan 2025 16:28:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUEVS-000BKp-1D;
	Sun, 05 Jan 2025 00:28:38 +0000
Date: Sun, 5 Jan 2025 08:27:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: exynos: exynos8895-dreamlte: enable
 support for the touchscreen
Message-ID: <202501050840.JpoautB7-lkp@intel.com>
References: <20250104164321.333669-7-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104164321.333669-7-ivo.ivanov.ivanov1@gmail.com>

Hi Ivaylo,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on next-20241220]
[cannot apply to robh/for-next ulf-hansson-mmc-mirror/next linus/master v6.13-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivaylo-Ivanov/dt-bindings-mmc-samsung-exynos-dw-mshc-add-specific-compatible-for-exynos8895/20250105-004605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20250104164321.333669-7-ivo.ivanov.ivanov1%40gmail.com
patch subject: [PATCH v2 6/6] arm64: dts: exynos: exynos8895-dreamlte: enable support for the touchscreen
config: arm64-randconfig-003-20250105 (https://download.01.org/0day-ci/archive/20250105/202501050840.JpoautB7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250105/202501050840.JpoautB7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501050840.JpoautB7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts:196.18-19 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
