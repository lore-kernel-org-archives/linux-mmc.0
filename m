Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AA1DF248;
	Tue,  9 Dec 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306687; cv=none; b=WXCkjTnxkrEjR80Gh9U6NJQ1JYYFGEn3I2jpg5kDRHKwkqHAKZqMoA7OqQCYUUziw2KYo32sVF8GdgecfXSjlDTOkECB9SQbpER4Hhr3uIeiHBS5P0onyqpIYkqgecngmeI7qznR/z+VqGJcrGAzivjPb74mkw4OEekvRbYXX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306687; c=relaxed/simple;
	bh=mFbT4lH79yDTHUyS7wtXasTGzShbkPr6lyhSnS1BMmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5MeMGBE20E5eNtMuBn8/26xK5k7hZ6qnY0EwOvG/TEddz5L5hXCJWCV+xOx59tc1o0ZKIHMkvkzCMjRho25QHhCCGO3R7AQWKEqdkEFhokfvEkdMv+P8QadS8vtqdwevFQHgGAK1fPUKzbiXEAZMktv9lz9OyJjtXDVzGuyjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnLe8j/K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnLe8j/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765306687; x=1796842687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFbT4lH79yDTHUyS7wtXasTGzShbkPr6lyhSnS1BMmQ=;
  b=WnLe8j/KKGFzFji6KBbsr+H9Zagq+ZPuTsurQKuAowQAlHITc8ME4oV3
   OCDHM6N07130MjAHY6SlohpB186AZA0k9nZfO/hfLhVUH3M8lpJidlZTs
   nSjsAyTGKY54nn1xX/EplAPXo9C2zaT8Qfi61Lq9T6Vx302LqgAysbWO5
   j4/+sDaVw/+mXJk4rwXvAOiTRHvk3VQhrMgRG/UKxxUkGOx/KJy+P3Hpz
   xxzD7H9Sc1EDQko4PNyMPNTqXv0w0tOQWV0TPoA1/far8eJdHzHlSK+fQ
   /6RXLewOM54nQVwPwPgNqrluskre/g3we+7MwTL1g51fUAEPAv86SOCR8
   w==;
X-CSE-ConnectionGUID: /HduyfwfSY67VxtDR5L79w==
X-CSE-MsgGUID: K6WXaXKYQVuQF4tY5H2f3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67157896"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67157896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:58:06 -0800
X-CSE-ConnectionGUID: YNsiv4mCTE6VKJ2rfASCMg==
X-CSE-MsgGUID: 79TPHIPMQIapKyEBbxu36Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="200727249"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Dec 2025 10:58:03 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT2uP-000000002B7-0M9u;
	Tue, 09 Dec 2025 18:58:01 +0000
Date: Wed, 10 Dec 2025 02:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: "ping.gao" <ping.gao@samsung.com>, jh80.chung@samsung.com,
	ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"ping.gao" <ping.gao@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
Message-ID: <202512100224.drEVwdNL-lkp@intel.com>
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
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20251210/202512100224.drEVwdNL-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6ec8c4351cfc1d0627d1633b02ea787bd29c77d8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100224.drEVwdNL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512100224.drEVwdNL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/dw_mmc.c:1902:49: error: no member named 'drv_dat' in 'struct dw_mci'
    1902 |         const struct dw_mci_drv_data *drv_data = host->drv_dat
         |                                                  ~~~~  ^
>> drivers/mmc/host/dw_mmc.c:1904:2: error: expected expression
    1904 |         WARN_ON(host->cmd || host->data);
         |         ^
   include/asm-generic/bug.h:109:29: note: expanded from macro 'WARN_ON'
     109 | #define WARN_ON(condition) ({                                           \
         |                             ^
   2 errors generated.


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
> 1904		WARN_ON(host->cmd || host->data);
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
