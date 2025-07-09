Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7E28C5D8;
	Wed,  9 Jul 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056609; cv=none; b=Lcq59jBTUY9mKfh2FpD50FdkefA9AHf+1EtSjdwdiOfqQm8QJGWbeCtKQ4nWlpJkoJbmzT731E9f2RGB/sIMqdMHZWQx3CPkH3lYRD/cJw7bXmJrtGKRxd2RdzV2D4JH0LwAh09HWEG93NANEFvRLMwckE9c6NXWiYgJeoFHZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056609; c=relaxed/simple;
	bh=2+N4smsYfrl5HTf8MH0tIEMC4qA9EcZ/1I6Yj3gLik4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6uU6D6/EfQPPnpQ9qCD/H1TbkPU/hjcLROVnHLERWVCzJYHB0YmS0HNHulq4QDl2Xba94Ca/vtcSBvPdeOG/09f9FIJt7FQtsCUPTsJbO5DBczCQLQm/Ywk0b6d7zRAi11ozpf0gROzxqSNnkpMNBfh97YOu/LEMgvBoocNut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPmYOEA3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPmYOEA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752056608; x=1783592608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+N4smsYfrl5HTf8MH0tIEMC4qA9EcZ/1I6Yj3gLik4=;
  b=KPmYOEA3C2EUNRcAE6pvyo4RqCfqyqcfF6FO424jTCg9jjUQZe+qmg1D
   1O0QF/N24/IRPaJHe4z8RKVMUNOpll6x768dHe3F2CjQQIMUwoilhm/Vy
   p7WQ8/qkzq2Bw4DchNlhtP7DgNsgiigRYXTONf3QPengqPx1wEFyYLW+D
   k4VYE6prNIBAn28eCz54VGE6oriG3RIPUMn2JYdfDzExJpqv7brFCrGFU
   F8gnjxA+bnc3uYxC4RAZNfWNFq52TxBn9ag17rMBPSoPlLxQlG7x30zoi
   +AYWGcYpv5WZzDoEWhikG2Rl1qH49c+UpneRyIjUX2+8m3b4v9hxoS2oY
   g==;
X-CSE-ConnectionGUID: WPpMwy6rRuKVdkHsEjdq+Q==
X-CSE-MsgGUID: 0dE/07ZyQlGenSHCR7B4Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79750707"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79750707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 03:23:19 -0700
X-CSE-ConnectionGUID: nA7HpcjlRkSUBS07mOfahw==
X-CSE-MsgGUID: 2ZH4Zb0hTQCxpOErnia7Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160057178"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Jul 2025 03:23:13 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZRxG-0003OT-0W;
	Wed, 09 Jul 2025 10:23:10 +0000
Date: Wed, 9 Jul 2025 18:22:30 +0800
From: kernel test robot <lkp@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, David Wronek <david@mainlining.org>,
	Karel Balej <balejk@matfyz.cz>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, soc@lists.linux.dev,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v16 3/5] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Message-ID: <202507091803.RBsXE3aX-lkp@intel.com>
References: <20250708-pxa1908-lkml-v16-3-b4392c484180@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-pxa1908-lkml-v16-3-b4392c484180@dujemihanovic.xyz>

Hi Duje,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d7b8f8e20813f0179d8ef519541a3527e7661d3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Duje-Mihanovi/dt-bindings-mmc-sdhci-pxa-restrict-pinctrl-to-pxav1/20250709-011510
base:   d7b8f8e20813f0179d8ef519541a3527e7661d3a
patch link:    https://lore.kernel.org/r/20250708-pxa1908-lkml-v16-3-b4392c484180%40dujemihanovic.xyz
patch subject: [PATCH v16 3/5] arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
config: arm64-kismet-CONFIG_I2C_GPIO-CONFIG_VIDEO_MMP_CAMERA-0-0 (https://download.01.org/0day-ci/archive/20250709/202507091803.RBsXE3aX-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250709/202507091803.RBsXE3aX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091803.RBsXE3aX-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for I2C_GPIO when selected by VIDEO_MMP_CAMERA
   WARNING: unmet direct dependencies detected for I2C_GPIO
     Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (GPIOLIB [=n] || COMPILE_TEST [=n])
     Selected by [y]:
     - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=n]) && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
