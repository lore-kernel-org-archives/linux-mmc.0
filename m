Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AC283FD9;
	Tue, 25 Aug 2026 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688819; cv=none; b=oZUt+KpNUBPK4kv7v1ZFj3jvfQonUNzN0bX92O8SxDG/Gw+MXMbKi0GqYegxObRUivBS5m7C3Z4PD7OyBkDl8H3Cd2jtCkUC/y9d2nQ62FH+NnHqOxniO41+0iVsCbp49a4j50XrAqy8kaaF1vuakmxGSexO7edUOqbragdlZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688819; c=relaxed/simple;
	bh=p5PIuMzBWQbg+MB0Z71V+GUXdgSOjlIjIDP8IWR5RwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNXsgtm1LMvyOHVb9ozatOhMSb9GZQCUP/3ub5AIHdoLqlXwkiSsURIpvqQfQgIUQNgIFpr2R2nGW05BS7qBSwmCKNNFP6pKvQqDRQ6kapaHJm03TURMY8RKM9vJLffxhSWXz9ltdW67OTxanBoHb5VkPDXADPsi1QTTU/fiOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0i3lvmp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0i3lvmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787688816; x=1819224816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5PIuMzBWQbg+MB0Z71V+GUXdgSOjlIjIDP8IWR5RwE=;
  b=G0i3lvmpgdeyksVybTkRvBvH9xZuQxpFiAg7DhE0zYvo9t0Gu1pmg4b8
   YHZTeHc584nsa1j88eFnCqDol+68a/ya4xRyFl2QHbO11cnZD/8Bio8be
   C4owu6aAJKNbBi4Y7vHVEn44aLJG88eMsz+kQKN9tMIJKCvHn8xrzO9RT
   vHXdhYpLVnIJTm2ib05Rs4QTq0YnLEokhND7myj9HjpvsQ1O9kHPXJ6BW
   20Gdqf/OJyZrQMabyzjQZLEMBm3yDffp+1RVKFyXZ2MpuuJe5fn7GDz2N
   nxZmDaRz+xUyDZrAOCIzND2oehOgaMWtmN2D/2IFOJScswVvkZEZqUHP/
   A==;
X-CSE-ConnectionGUID: i4dbIRUzQ9CFFKngJ+FbHg==
X-CSE-MsgGUID: s9BcG29vSMyycdykS5mHDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="91983166"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="91983166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:13:35 -0700
X-CSE-ConnectionGUID: SPKpC5QpQa2e5m1L7y41rg==
X-CSE-MsgGUID: I5oUfwkmTJK1oO4Ru7tN9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264757810"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 13:13:34 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyxWV-000000006Kh-2ImB;
	Tue, 25 Aug 2026 20:13:31 +0000
Date: Wed, 26 Aug 2026 04:13:05 +0800
From: kernel test robot <lkp@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: Re: [PATCH] memstick: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <202608260448.DBZikir0-lkp@intel.com>
References: <20260825082718.244949-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825082718.244949-1-triet.hoang.dev@gmail.com>

Hi Triet,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.2 next-20260824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Triet-Hoang/memstick-Convert-to-DEFINE_SIMPLE_DEV_PM_OPS/20260825-152717
base:   linus/master
patch link:    https://lore.kernel.org/r/20260825082718.244949-1-triet.hoang.dev%40gmail.com
patch subject: [PATCH] memstick: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260826/202608260448.DBZikir0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260826/202608260448.DBZikir0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608260448.DBZikir0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/memstick/host/r592.c: In function 'r592_suspend':
>> drivers/memstick/host/r592.c:854:9: error: implicit declaration of function 'r592_clear_interrupts' [-Wimplicit-function-declaration]
     854 |         r592_clear_interrupts(dev);
         |         ^~~~~~~~~~~~~~~~~~~~~


vim +/r592_clear_interrupts +854 drivers/memstick/host/r592.c

9263412501022fe Maxim Levitsky  2011-03-25  849  
9263412501022fe Maxim Levitsky  2011-03-25  850  static int r592_suspend(struct device *core_dev)
9263412501022fe Maxim Levitsky  2011-03-25  851  {
deaa53989537c62 Chuhong Yuan    2019-07-23  852  	struct r592_device *dev = dev_get_drvdata(core_dev);
9263412501022fe Maxim Levitsky  2011-03-25  853  
9263412501022fe Maxim Levitsky  2011-03-25 @854  	r592_clear_interrupts(dev);
9263412501022fe Maxim Levitsky  2011-03-25  855  	memstick_suspend_host(dev->host);
8fa7292fee5c524 Thomas Gleixner 2025-04-05  856  	timer_delete_sync(&dev->detect_timer);
9263412501022fe Maxim Levitsky  2011-03-25  857  	return 0;
9263412501022fe Maxim Levitsky  2011-03-25  858  }
9263412501022fe Maxim Levitsky  2011-03-25  859  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
