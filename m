Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1F2B9C5
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700750; cv=none; b=QfGR5AfpHh6SiCZPufILH3bFUaJTJRnZkh7xJtJJ8Vy/YLQnK1l3ajItU27iFtmPzRSmZtmCDYChbwW08ZrPjh6lrEuGd/H81BW/ddoosHDVhFF5QdvYBcm7DsvWwPq0nA+wcen6NuvfM3pzjwJysBMMw0DMtXVshFY9KdVRaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700750; c=relaxed/simple;
	bh=0d3e3xnQARHBnzJ3/KT8Z3pjx81V4NfO7llFRCrEoDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUmRzfEE8/Q7bUgDqanfSzgTFLQDFjSnnGroDeOJfzVDMVlHuetFiBZJrWiIifl3RNdjz6oYtpN406I3HtN3jaOVrezHx/BC1FJiNzWsyP9MAb495padJUDwAMVt8pQlo1T7da/29P1l992QQFsPxK8RJCYr4jnsU8rLzmt3Dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iagpFL7/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iagpFL7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724700747; x=1756236747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0d3e3xnQARHBnzJ3/KT8Z3pjx81V4NfO7llFRCrEoDE=;
  b=iagpFL7/RHEUNe+xMxHz1VM6eGi8Cpatngh/0my2ayOREucpPikgvklh
   FkV7SstbOFqMJVWuoGJfYssdHE1d8WNwln1+XaOxd+L+gUdqXh+gbOuwf
   96uVS4QxUqDGCnSzj5Fq5yDSV3M1xv3ubLgU2PyTvXjEsXiO/f20W5EDL
   dUvfaNFP8wO44OTuljbdAy5OxmexR5SYoy8uhxIDpGxNPrFn3rO2l8VEN
   Nbm6QM4xB/EMlnjYgg5Z9q9fd2d2UbXFu9LmmY0+SjS3cjKSZ5PNOHCDR
   /Wl9XHnK43tjFb0uRZJiwQ2iHyhUu1dc0nI6NFc22bojzscEiteyNk/9l
   Q==;
X-CSE-ConnectionGUID: jUWGYhTYSyy0LWwvNbrkEg==
X-CSE-MsgGUID: 7dWcjKW3QwqDjUE6JN95ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40649627"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="40649627"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 12:32:26 -0700
X-CSE-ConnectionGUID: 4JvIRGm7T5ux+8XFPNxewA==
X-CSE-MsgGUID: QONRKAcHScKhmvGz6J6xLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62668840"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2024 12:32:25 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sifRv-000HXM-0j;
	Mon, 26 Aug 2024 19:32:23 +0000
Date: Tue, 27 Aug 2024 03:31:33 +0800
From: kernel test robot <lkp@intel.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>, Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v4 6/9] mmc: host: Add close-ended Ext memory addressing
Message-ID: <202408270315.TTjSYp25-lkp@intel.com>
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
config: arc-randconfig-002-20240827 (https://download.01.org/0day-ci/archive/20240827/202408270315.TTjSYp25-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270315.TTjSYp25-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270315.TTjSYp25-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci.c: In function 'sdhci_get_sbc_ext':
>> drivers/mmc/host/sdhci.c:1797:24: error: implicit declaration of function 'mmc_card_ult_capacity' [-Werror=implicit-function-declaration]
    1797 |         bool is_sduc = mmc_card_ult_capacity(host->mmc->card);
         |                        ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
