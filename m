Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469812D73A6;
	Tue,  9 Dec 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303567; cv=none; b=blpObFL3oWI7BX0U1DPLkkLS2eRuvQ8A2BnKRUiu9abDAidWe39972n7De4T49brCU+tOkuV+wjGG+dS5C9j9/CxiS0HGJ9b1LGo99RWwWl+yZXKfFV5+EhaOMCt0BAHTLXU/3UsOmsMR6swbEQQuFvD//3NiUiKUg0jdlDUziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303567; c=relaxed/simple;
	bh=BIhbpujaBd/Ey0BGuUIoScMltJUr17Od4WaWo0SEAsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPF0zbV/0sq9+YjulYnuQ5rmMeVrtfaOsd6bOzVEkS44BRiWj1h4sSP/KhnAA/1HG3Y0tcLw4LOzUVy2afpKEmWK9xUaFboVKJpY3UqLR6KTaxD+myyKmNh3Yrl32HQpy1QA7IlhHsK75tHkPC0oHjX3C3kIdKj5d0fCd/y0Z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEccFJHr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEccFJHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765303562; x=1796839562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BIhbpujaBd/Ey0BGuUIoScMltJUr17Od4WaWo0SEAsg=;
  b=SEccFJHrsvIcmvyxLcBc2qRxu1/rT/Ikw55K1IIZqRLnk698JiaEJFqo
   7Uyh/PvewduWNRX4b4CUiVTr5X/ktX61Nwj31IATGgcMrprrJ1F16ahnM
   NxD0AJI+XZO6JNT1jgXndKNV65cz+VsX/fQxScef1V+KaWLedzc3ejVAs
   CFdssYUI1ANjvVchSIgTxtWxFFGR2inxQUft6tP8+LXwvTgqoThsLiZUd
   puXOS5DLYRI3IfriV/t9ISMqn7lR2ECApZzBiXX8s1dtL/dWAkfTxZZ83
   WkbPmV9d10hXga+OomJ0Qd6gSuPg3HAsGayyTnTyGuTw8b63VFcwAr/mn
   g==;
X-CSE-ConnectionGUID: dPn3ECe3TDaMpo3C3s32+g==
X-CSE-MsgGUID: U9ZbZnBRTomiKwQ0dU85kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="77884485"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="77884485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:06:02 -0800
X-CSE-ConnectionGUID: LRL7bE/YQkS1C+nZL/74rg==
X-CSE-MsgGUID: jsYyQLA4Q8ahdsYXczW1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="226955192"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Dec 2025 10:06:00 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT261-0000000028D-1diS;
	Tue, 09 Dec 2025 18:05:57 +0000
Date: Wed, 10 Dec 2025 02:05:06 +0800
From: kernel test robot <lkp@intel.com>
To: "ping.gao" <ping.gao@samsung.com>, jh80.chung@samsung.com,
	ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "ping.gao" <ping.gao@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
Message-ID: <202512100130.DkmKHepR-lkp@intel.com>
References: <20251209064910.3643039-1-ping.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209064910.3643039-1-ping.gao@samsung.com>

Hi ping.gao,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.18 next-20251209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ping-gao/mmc-dw_mmc-Use-pre_request-post_request_end-helper/20251209-144626
base:   linus/master
patch link:    https://lore.kernel.org/r/20251209064910.3643039-1-ping.gao%40samsung.com
patch subject: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
config: csky-randconfig-002-20251209 (https://download.01.org/0day-ci/archive/20251210/202512100130.DkmKHepR-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100130.DkmKHepR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512100130.DkmKHepR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/dw_mmc.c: In function 'dw_mci_request_end':
>> drivers/mmc/host/dw_mmc.c:1902:56: error: 'struct dw_mci' has no member named 'drv_dat'; did you mean 'drv_data'?
    1902 |         const struct dw_mci_drv_data *drv_data = host->drv_dat
         |                                                        ^~~~~~~
         |                                                        drv_data
   In file included from arch/csky/include/asm/bug.h:18,
                    from include/linux/bug.h:5,
                    from include/linux/random.h:6,
                    from include/linux/nodemask.h:94,
                    from include/linux/list_lru.h:12,
                    from include/linux/fs/super_types.h:7,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/mmc/host/dw_mmc.c:10:
>> include/asm-generic/bug.h:154:29: error: expected expression before '{' token
     154 | #define WARN_ON(condition) ({                                           \
         |                             ^
   drivers/mmc/host/dw_mmc.c:1904:9: note: in expansion of macro 'WARN_ON'
    1904 |         WARN_ON(host->cmd || host->data);
         |         ^~~~~~~


vim +1902 drivers/mmc/host/dw_mmc.c

  1895	
  1896	static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
  1897		__releases(&host->lock)
  1898		__acquires(&host->lock)
  1899	{
  1900		struct dw_mci_slot *slot;
  1901		struct mmc_host	*prev_mmc = host->slot->mmc;
> 1902		const struct dw_mci_drv_data *drv_data = host->drv_dat
  1903	
  1904		WARN_ON(host->cmd || host->data);
  1905	
  1906		host->slot->mrq = NULL;
  1907		host->mrq = NULL;
  1908		if (!list_empty(&host->queue)) {
  1909			slot = list_entry(host->queue.next,
  1910					  struct dw_mci_slot, queue_node);
  1911			list_del(&slot->queue_node);
  1912			dev_vdbg(host->dev, "list not empty: %s is next\n",
  1913				 mmc_hostname(slot->mmc));
  1914			host->state = STATE_SENDING_CMD;
  1915			dw_mci_start_request(host, slot);
  1916		} else {
  1917			dev_vdbg(host->dev, "list empty\n");
  1918	
  1919			if (host->state == STATE_SENDING_CMD11)
  1920				host->state = STATE_WAITING_CMD11_DONE;
  1921			else
  1922				host->state = STATE_IDLE;
  1923		}
  1924	
  1925		spin_unlock(&host->lock);
  1926		mmc_request_done(prev_mmc, mrq);
  1927		if (drv_data && drv_data->post_request_end)
  1928			drv_data->post_request_end(host);
  1929		spin_lock(&host->lock);
  1930	}
  1931	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
