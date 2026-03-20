Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5D2D5C71;
	Fri, 20 Mar 2026 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773978092; cv=none; b=THAbpT8QHFy2ByYxgaxiwbvaVk/sGeBIIIamNzinhqOzyP6PfRQOes8n9CClKKfSsDuA3Ag5AHEM2r1QRdaLRs8UEHWMpGOSe34avHk3hdXclgqK/xfQMw3xurGZQpjfeMEB9jgVA2JQTa6vZAzaEJOkEMEWjOz5pGic83RdHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773978092; c=relaxed/simple;
	bh=B793okv8J9P9yN5aP1gb+mw5+fk7GK3Q0xVoa4v3W+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1K++M9vhU5kBoUk5Ijs4mSraZ7GHNiiNMTJ0CeShyJcbiYthDC4ZJyL+l/qhn0DufofnNpLHxR4iVscNR6Esp1yRqaYMSbym4ftNCg9GWqT91FBtXYQR3sDxDI2Z7/FiaKCPreMjeNEVD3sdj/zdnUCMt2GwTdsRWoWJO0O3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDGobM1w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDGobM1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773978090; x=1805514090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B793okv8J9P9yN5aP1gb+mw5+fk7GK3Q0xVoa4v3W+Q=;
  b=GDGobM1w8eEP5BXYaDX6ntF7BuvsyjxjDG/VG30EMqf3Y/cLwLOQ+9J0
   uOvAvrVtJdg+oXfJm53zGsgS6AZPHpEuajJwI9oPmuYkRrDY1KCu+OH6E
   WbPU7ZXQkFq6DV5E3QAg0rqBDk4HN77lmhxYrD4rkkqHyC4DTwibkA3J3
   Qv77qoR8aQ3WwEwWfyMY54oKrhdCtVeEkggHwhAcafApXtSLLKDoYe/g4
   cqra7A4/fNF4wjDz8sTL9vMlhgl0oHD07e+0r5CaIBT59OKKeJIFOqy1+
   T65CNafuFTB1CZcMhSdSuf1CzlGAf7R3ZkDPqVsl32cm6OaeFDMX84759
   Q==;
X-CSE-ConnectionGUID: 5RnG/32qTw+anZRTTXmLyw==
X-CSE-MsgGUID: gIZv/+xHRYu9gVvvPS92dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78666617"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78666617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 20:41:30 -0700
X-CSE-ConnectionGUID: 9aQVccFZTBiwnwy9+rM8nQ==
X-CSE-MsgGUID: FDinyjp+SGi9zNnm6y53Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228101729"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 20:41:27 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3Qjk-000000004xR-30a6;
	Fri, 20 Mar 2026 03:41:24 +0000
Date: Fri, 20 Mar 2026 04:40:56 +0100
From: kernel test robot <lkp@intel.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kamal Dasu <kamal.dasu@broadcom.com>
Subject: Re: [PATCH v3 2/4] mmc: sdhci: Implement panic-context write support
Message-ID: <202603200422.mPPKA7F3-lkp@intel.com>
References: <20260319185705.1516950-3-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319185705.1516950-3-kamal.dasu@broadcom.com>

Hi Kamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc4 next-20260319]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-core-Add-panic-context-host-operations-for-pstore-backends/20260320-064639
base:   linus/master
patch link:    https://lore.kernel.org/r/20260319185705.1516950-3-kamal.dasu%40broadcom.com
patch subject: [PATCH v3 2/4] mmc: sdhci: Implement panic-context write support
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260320/202603200422.mPPKA7F3-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200422.mPPKA7F3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200422.mPPKA7F3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/mmc/host/sdhci.c:3104 function parameter 'mmc' not described in 'sdhci_panic_prepare'
>> Warning: drivers/mmc/host/sdhci.c:3154 function parameter 'mmc' not described in 'sdhci_panic_poll_completion'
>> Warning: drivers/mmc/host/sdhci.c:3154 function parameter 'mrq' not described in 'sdhci_panic_poll_completion'
>> Warning: drivers/mmc/host/sdhci.c:3211 function parameter 'mmc' not described in 'sdhci_panic_complete'
>> Warning: drivers/mmc/host/sdhci.c:3211 function parameter 'mrq' not described in 'sdhci_panic_complete'
>> Warning: drivers/mmc/host/sdhci.c:3104 function parameter 'mmc' not described in 'sdhci_panic_prepare'
>> Warning: drivers/mmc/host/sdhci.c:3154 function parameter 'mmc' not described in 'sdhci_panic_poll_completion'
>> Warning: drivers/mmc/host/sdhci.c:3154 function parameter 'mrq' not described in 'sdhci_panic_poll_completion'
>> Warning: drivers/mmc/host/sdhci.c:3211 function parameter 'mmc' not described in 'sdhci_panic_complete'
>> Warning: drivers/mmc/host/sdhci.c:3211 function parameter 'mrq' not described in 'sdhci_panic_complete'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
