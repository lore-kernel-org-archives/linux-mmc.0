Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604D19D09B
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711317; cv=none; b=U26qtPz7+SuJReDE6hanRzEUCXNZTi9l686GR5b2tVf0dm83akznwcMa5k1po/A9rjehkAOxlch6a4Ee11tafZINNHcxcYnCMP/OnWMqxqGaATr/VB1/jrY+X+JPT7eYfV8PYBtmN92t7/tJBCJyMfPn1rW9+Jn3sTs1kiqSD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711317; c=relaxed/simple;
	bh=s1hzt7glOz0ZAn9XcJ5h9svrxKmHqeYhfvvo9fsQxMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jsj5ciichvRY1VLapk6Jv2YZz2lkkmZA6yl0p3rVVNDHXPe87c+ejxYz4NGWvdBJwgJiDkE66pjZ/O52ALpLCX3k0banjZuGsHkz0oiybWElkKGFC8IGRm4IcmSn0Blq1b4aF9UF4+Sr6UC33UunNjAth/UQeRMTbdF0Gm4r5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ih3Y6nID; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ih3Y6nID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724711315; x=1756247315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s1hzt7glOz0ZAn9XcJ5h9svrxKmHqeYhfvvo9fsQxMU=;
  b=ih3Y6nIDawFhUABBr2OT8DMUSZ2q+JnM0niDNwEX1R2ytenbQrtStlYd
   bJldbauHMShAHupEZh9CPKsLu8Xhk7/FNg1QYg6jX+bqLa/hnvDLmRME7
   qfZp5+G+01kaoVO6grt2m9072ftoGPOYLYm3OTg7OAflmGJiT+eKFBxt/
   T58tlRA2SLhTSZMZj40tWkFFw8kkvMhJ4/MUzo6W1pD2Y4/YAek08sAYy
   oQgWFeRO1b6cVX1GJeaFKBtybNA0kJ4e3swC7EXcfOgKCglg9ayNENP8z
   Jdo4byZz7Nl9w+3iAu7wlOPho1DR1IVa01Ya47aV3XitTnybm2NJDei6h
   Q==;
X-CSE-ConnectionGUID: tlE4r6EkRdO/2qq3b8CXAw==
X-CSE-MsgGUID: 7wZDvgBTQauQqFznFeCP+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537791"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537791"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:28:34 -0700
X-CSE-ConnectionGUID: F8xtsXEHSZulrpyJwWgMzw==
X-CSE-MsgGUID: DlF0mGv4R7uOUTqqQvs7Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66994201"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2024 15:28:32 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siiCL-000Hes-2C;
	Mon, 26 Aug 2024 22:28:29 +0000
Date: Tue, 27 Aug 2024 06:28:06 +0800
From: kernel test robot <lkp@intel.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>, Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v4 6/9] mmc: host: Add close-ended Ext memory addressing
Message-ID: <202408270619.qJDzvXzO-lkp@intel.com>
References: <20240825074141.3171549-7-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825074141.3171549-7-avri.altman@wdc.com>

Hi Avri,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/mmc-sd-SDUC-Support-Recognition/20240826-161527
base:   linus/master
patch link:    https://lore.kernel.org/r/20240825074141.3171549-7-avri.altman%40wdc.com
patch subject: [PATCH v4 6/9] mmc: host: Add close-ended Ext memory addressing
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240827/202408270619.qJDzvXzO-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270619.qJDzvXzO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270619.qJDzvXzO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci.c:1797:17: error: implicit declaration of function 'mmc_card_ult_capacity' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           bool is_sduc = mmc_card_ult_capacity(host->mmc->card);
                          ^
   1 error generated.


vim +/mmc_card_ult_capacity +1797 drivers/mmc/host/sdhci.c

  1793	
  1794	static struct mmc_command *sdhci_get_sbc_ext(struct sdhci_host *host,
  1795						     struct mmc_command *cmd)
  1796	{
> 1797		bool is_sduc = mmc_card_ult_capacity(host->mmc->card);
  1798	
  1799		if (is_sduc) {
  1800			/*  Finished CMD22, now send actual command */
  1801			if (cmd == cmd->mrq->ext)
  1802				return cmd->mrq->cmd;
  1803		}
  1804	
  1805		/* Finished CMD23 */
  1806		if (cmd == cmd->mrq->sbc) {
  1807			if (is_sduc) {
  1808				/* send CMD22 after CMD23 */
  1809				if (WARN_ON(!cmd->mrq->ext))
  1810					return NULL;
  1811				else
  1812					return cmd->mrq->ext;
  1813			} else {
  1814				/* Finished CMD23, now send actual command */
  1815				return cmd->mrq->cmd;
  1816			}
  1817		}
  1818	
  1819		return NULL;
  1820	}
  1821	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
