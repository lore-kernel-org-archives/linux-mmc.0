Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0714150997
	for <linux-mmc@vger.kernel.org>; Sat, 22 Nov 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763836877; cv=none; b=n7xDWD5GcEEbJY4oyBMKpzPQuzq8eSznQCsw0FSDnggVlBjq40u6+vO5d0XAdhtBmoC5mK/NyiBbt9aZkDz3eS9RF/PqxUG8LPavvfXISc+T5wLY6Yz+hAeiHcyi4tF29EDrhQLTfcHg5iOnX7qlfMdiv09uYlG9F7stfwpAah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763836877; c=relaxed/simple;
	bh=7OQussVEX3VL1i4dvTzo+b8cQPRywZM33MOZ8XhfypM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX8HRa45nKChmQTC+azPLpfIJkz6qgMCPLUoHwgYHSeqxiAVIvzC4UzGnpL87REl7Icgxddj4GJPsp7OayX2NkBJgNkUvNFycNAUSeiKbfnXyctoZXvTVRvAA58kWk5jwe66m2lCg98qoK/AUSOlk6vq4vk1sEMuBP4HgaiY9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxCVymHT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxCVymHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763836876; x=1795372876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7OQussVEX3VL1i4dvTzo+b8cQPRywZM33MOZ8XhfypM=;
  b=cxCVymHTKfpQBUGIMgMufkNgYkk0WQlv3Lx2v91Te0FM6d7pxTJCXJpz
   WmwR74yIqkCUWztqaPp5y6KTLzzh1JTBcWJIeSZAxMnL7YD/keHTRMMcg
   e2eanAQFsx7sZWJeVOnhtPiV5+nvRjMN7CaQl3cFmWF0W3VUhbnjz/oac
   3192fz6fcdle+HFZRqzEm7fJb2ZDjgjaj10Ia2DTTEkpbubJLkOGILPzO
   nHNALf12nmrTh+qPZbmmBhip1GJ/oY7aLbv2tR7j73sV2Tsh86g0tOI74
   DBDQIZZS7xZIPWVFHJ4PdnSZ0bog15caSwJg/Ysy0Uamc9ys19k5e7TkV
   A==;
X-CSE-ConnectionGUID: GVETHL+mQ2ym/4X0TcEu2g==
X-CSE-MsgGUID: oAkKPaxNSWmaWYoKVrHwBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="77371103"
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="77371103"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 10:41:15 -0800
X-CSE-ConnectionGUID: 9o8XzK+iSXOjTRhZQKI3kA==
X-CSE-MsgGUID: 4+QadW0tQmqxl/73NnbzYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,219,1758610800"; 
   d="scan'208";a="191151587"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 Nov 2025 10:41:14 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMsXn-0007l5-1M;
	Sat, 22 Nov 2025 18:41:11 +0000
Date: Sun, 23 Nov 2025 02:40:36 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 13/13] mmc: dw_mmc: Remove struct dw_mci_slot
Message-ID: <202511230231.JzqFjaBp-lkp@intel.com>
References: <1763634565-183891-14-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763634565-183891-14-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251120]
[cannot apply to krzk/for-next rockchip/for-next linus/master ulf-hansson-mmc-mirror/next v6.18-rc6 v6.18-rc5 v6.18-rc4 v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-Remove-unused-struct-dma_pdata/20251120-205522
base:   next-20251120
patch link:    https://lore.kernel.org/r/1763634565-183891-14-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH 13/13] mmc: dw_mmc: Remove struct dw_mci_slot
config: arc-randconfig-002-20251123 (https://download.01.org/0day-ci/archive/20251123/202511230231.JzqFjaBp-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251123/202511230231.JzqFjaBp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511230231.JzqFjaBp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/debugfs.h:16,
                    from drivers/mmc/host/dw_mmc.c:12:
>> drivers/mmc/host/dw_mmc.c:140:23: warning: 'dw_mci_req_fops' defined but not used [-Wunused-const-variable=]
     140 | DEFINE_SHOW_ATTRIBUTE(dw_mci_req);
         |                       ^~~~~~~~~~
   include/linux/seq_file.h:213:37: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     213 | static const struct file_operations __name ## _fops = {                 \
         |                                     ^~~~~~


vim +/dw_mci_req_fops +140 drivers/mmc/host/dw_mmc.c

f95f3850f7a9e1 Will Newton 2011-01-02   99  
f95f3850f7a9e1 Will Newton 2011-01-02  100  #if defined(CONFIG_DEBUG_FS)
f95f3850f7a9e1 Will Newton 2011-01-02  101  static int dw_mci_req_show(struct seq_file *s, void *v)
f95f3850f7a9e1 Will Newton 2011-01-02  102  {
93ac9a7f4a2ac9 Shawn Lin   2025-11-20  103  	struct dw_mci *host = s->private;
f95f3850f7a9e1 Will Newton 2011-01-02  104  	struct mmc_request *mrq;
f95f3850f7a9e1 Will Newton 2011-01-02  105  	struct mmc_command *cmd;
f95f3850f7a9e1 Will Newton 2011-01-02  106  	struct mmc_command *stop;
f95f3850f7a9e1 Will Newton 2011-01-02  107  	struct mmc_data	*data;
f95f3850f7a9e1 Will Newton 2011-01-02  108  
f95f3850f7a9e1 Will Newton 2011-01-02  109  	/* Make sure we get a consistent snapshot */
93ac9a7f4a2ac9 Shawn Lin   2025-11-20  110  	spin_lock_bh(&host->lock);
93ac9a7f4a2ac9 Shawn Lin   2025-11-20  111  	mrq = host->mrq;
f95f3850f7a9e1 Will Newton 2011-01-02  112  
f95f3850f7a9e1 Will Newton 2011-01-02  113  	if (mrq) {
f95f3850f7a9e1 Will Newton 2011-01-02  114  		cmd = mrq->cmd;
f95f3850f7a9e1 Will Newton 2011-01-02  115  		data = mrq->data;
f95f3850f7a9e1 Will Newton 2011-01-02  116  		stop = mrq->stop;
f95f3850f7a9e1 Will Newton 2011-01-02  117  
f95f3850f7a9e1 Will Newton 2011-01-02  118  		if (cmd)
f95f3850f7a9e1 Will Newton 2011-01-02  119  			seq_printf(s,
f95f3850f7a9e1 Will Newton 2011-01-02  120  				   "CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
f95f3850f7a9e1 Will Newton 2011-01-02  121  				   cmd->opcode, cmd->arg, cmd->flags,
f95f3850f7a9e1 Will Newton 2011-01-02  122  				   cmd->resp[0], cmd->resp[1], cmd->resp[2],
f95f3850f7a9e1 Will Newton 2011-01-02  123  				   cmd->resp[2], cmd->error);
f95f3850f7a9e1 Will Newton 2011-01-02  124  		if (data)
f95f3850f7a9e1 Will Newton 2011-01-02  125  			seq_printf(s, "DATA %u / %u * %u flg %x err %d\n",
f95f3850f7a9e1 Will Newton 2011-01-02  126  				   data->bytes_xfered, data->blocks,
f95f3850f7a9e1 Will Newton 2011-01-02  127  				   data->blksz, data->flags, data->error);
f95f3850f7a9e1 Will Newton 2011-01-02  128  		if (stop)
f95f3850f7a9e1 Will Newton 2011-01-02  129  			seq_printf(s,
f95f3850f7a9e1 Will Newton 2011-01-02  130  				   "CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
f95f3850f7a9e1 Will Newton 2011-01-02  131  				   stop->opcode, stop->arg, stop->flags,
f95f3850f7a9e1 Will Newton 2011-01-02  132  				   stop->resp[0], stop->resp[1], stop->resp[2],
f95f3850f7a9e1 Will Newton 2011-01-02  133  				   stop->resp[2], stop->error);
f95f3850f7a9e1 Will Newton 2011-01-02  134  	}
f95f3850f7a9e1 Will Newton 2011-01-02  135  
93ac9a7f4a2ac9 Shawn Lin   2025-11-20  136  	spin_unlock_bh(&host->lock);
f95f3850f7a9e1 Will Newton 2011-01-02  137  
f95f3850f7a9e1 Will Newton 2011-01-02  138  	return 0;
f95f3850f7a9e1 Will Newton 2011-01-02  139  }
64c1412b77d08d Shawn Lin   2018-02-23 @140  DEFINE_SHOW_ATTRIBUTE(dw_mci_req);
f95f3850f7a9e1 Will Newton 2011-01-02  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
