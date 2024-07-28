Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445643AD2
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171489; cv=none; b=O9wyDTtI7RumuWC4C4b0suY8dl5PRU2Xj77JqY8CY3PKl+x9nWqpwAexGfH0tI5tVJy9Vp/Y0N0oQhYmIVOx4GXVN4OOEPeKJQK7IlEcOaAd+cuMXksRvqbSNvyFv48b+b6kCKdwK2e/DCf46mVAHNZyarVyypJZcFsIZD1t4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171489; c=relaxed/simple;
	bh=2Ih5dkL1PzWSbRDfBt0lOFyfRs1wcE88ubJ84fcm2Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWdEGrvwVB/08pFFAB11qpWn1Tluz6nEbFzggSoUaSYRud2A8MkUmWKS6W7U3bjy25AzaOTSxmynDuntjJNQ/8ic/X1ThN93eY9/Fr6Sg8QAIy76IYYSzCjN0knTO6vdug4EPGIAr9jAcRkT67eC2B32ZQO6Rtpr9DbUxlpWmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMkR98ye; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMkR98ye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722171487; x=1753707487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Ih5dkL1PzWSbRDfBt0lOFyfRs1wcE88ubJ84fcm2Tk=;
  b=TMkR98yeRTMZYLs8YXd558FhKnTf4AoSK0BZuK5PChXyI2bKoQ48LzLR
   f0Q+jM7cqJUNH5VeM3XaZMNNrXWy3LjBuBNr+MVC3eKrBWC3y2qTNUeHy
   SYxoJqFT5P7ycKSFwosnjZvfWVpcfEeNeFdPAZDuk6pONyf5rMW0EfuYc
   Lds03iM5tOlPcOvgaS1aNBoQ16S9KZYVE5vI2FW6q3U6tJQuZNvIFNfcY
   4YkSEnnT8NYgsH75qSbIsUKh+6Ps6gWFuVfQ0CfDNdEfswR/Bq+pHRqVL
   2e9hrwWo6w9V3KKy3Ofwn2Q9Nm7tv5Wz4FjhJ+YjcqIEgnYM+ugQ+uAtR
   A==;
X-CSE-ConnectionGUID: xYlX7QuuRhC4znoC+USXLw==
X-CSE-MsgGUID: NZygjK4/Rcy+vDRTo/rT2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="37421033"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="37421033"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 05:58:06 -0700
X-CSE-ConnectionGUID: 22X2QdalQv+3/wrbBkGMrw==
X-CSE-MsgGUID: EpME6cwJSUqKd0NUBE1p3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="53687396"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jul 2024 05:58:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY3TN-000qny-2a;
	Sun, 28 Jul 2024 12:58:01 +0000
Date: Sun, 28 Jul 2024 20:57:41 +0800
From: kernel test robot <lkp@intel.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ricky WU <ricky_wu@realtek.com>, Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH 04/10] mmc: core: Add open-ended Ext memory addressing
Message-ID: <202407282028.yNWpiXqJ-lkp@intel.com>
References: <20240728081154.1782120-5-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728081154.1782120-5-avri.altman@wdc.com>

Hi Avri,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10 next-20240726]
[cannot apply to ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/mmc-sd-SDUC-Support-Recognition/20240728-161645
base:   linus/master
patch link:    https://lore.kernel.org/r/20240728081154.1782120-5-avri.altman%40wdc.com
patch subject: [PATCH 04/10] mmc: core: Add open-ended Ext memory addressing
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240728/202407282028.yNWpiXqJ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407282028.yNWpiXqJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407282028.yNWpiXqJ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
>> ERROR: modpost: "mmc_send_ext_addr" [drivers/mmc/core/mmc_block.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
