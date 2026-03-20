Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD33CFF64;
	Fri, 20 Mar 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023833; cv=none; b=P0txKU0s3hgvBNA4uhmSDCnWMukGTSxxs87k6pRZ55MSVjF7SYH2vUyljQEXeHRZlG1J2lP5HYk1ldUSZcIGTIk+Kfd9a8wpZ16Td8Ougw3EKlVL5fp5XFm7EAHBT4GWi0llafJ2edYIo1S/8CPG2qUfZKfBbBtPld0PstxVR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023833; c=relaxed/simple;
	bh=+Hct0wSWlEvIEqzBBlIjUJTEHlHgLpPL++WA8LriHAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTDNvjvSBGnbxI7V3lAHBoZ45EaGWDzTxVPengpd+ntXzhQBAZNL3eHUuI1RHFS6/F74EGUbpEbVqqNHcgsw4UE0sQI8qvcgM/+UwkBpI4OQNwj+zqGg7jkBXfGlZwwqUp0KgYnA0e3RCvg/WmHW8aEDCK9nqFnzd8ljErqo6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cz1QXChM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cz1QXChM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774023831; x=1805559831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Hct0wSWlEvIEqzBBlIjUJTEHlHgLpPL++WA8LriHAs=;
  b=Cz1QXChM5i7rwe73YNH+T9mxyDDMeNX1fDEODDCS1/XYnri22BHmDuHQ
   xkC0Q6l9/pChGRqBXRhQu/4FlIPj7dkqenHNpBFExW/uUincx1yAwkL+X
   OUtsboUb3bqJqV8aZKnC52EFwG2Zn8rBzWvDw2FzhdZqccnMZ8+ZGtblI
   QJb6l2bTEGbFJg/trBTUFiocTY+caBrAc3ouk5A8RmTEJSnPh50+EIx22
   2kHtHym072cSzIyNx1mu8Jsok4FqwEUlF8hlyXuM/PbXx/uQmuEKADQ9A
   JNVxR57R0Rxhw391pAYl0DnfgQoivAo8Yq07vHumxfrDiLgzleSGINjcw
   g==;
X-CSE-ConnectionGUID: gz8kqaqkRZO4DLDDMRrErw==
X-CSE-MsgGUID: +sala6otSAGpFEE3Q6I7ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74996885"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74996885"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 09:23:50 -0700
X-CSE-ConnectionGUID: fSoM1sc1Se6T+9nFulmVug==
X-CSE-MsgGUID: L+rjlPnzRK2GE6qe/qbFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223550846"
Received: from lkp-server01.sh.intel.com (HELO ba623fe84fe1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Mar 2026 09:23:46 -0700
Received: from kbuild by ba623fe84fe1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3cdS-0000000007x-44v7;
	Fri, 20 Mar 2026 16:23:42 +0000
Date: Sat, 21 Mar 2026 00:22:58 +0800
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
Message-ID: <202603202324.GqXKHqZB-lkp@intel.com>
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
[cannot apply to ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-core-Add-panic-context-host-operations-for-pstore-backends/20260320-064639
base:   linus/master
patch link:    https://lore.kernel.org/r/20260319185705.1516950-3-kamal.dasu%40broadcom.com
patch subject: [PATCH v3 2/4] mmc: sdhci: Implement panic-context write support
config: i386-randconfig-r134-20260320 (https://download.01.org/0day-ci/archive/20260320/202603202324.GqXKHqZB-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603202324.GqXKHqZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603202324.GqXKHqZB-lkp@intel.com/

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
