Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B9C07545
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Oct 2023 01:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYBms (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Oct 2023 21:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYBmq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Oct 2023 21:42:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D170B1B3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Oct 2023 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698198164; x=1729734164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/yjOGSG/zxjaMJ7kW13P0KfSRDPFA8lg85Qo6TNJwqA=;
  b=cYyE32S31P+Vie6LteDlc/iWtzJ3pLjR9+4mTfbLfIva5SId0STFA0Jf
   9vMUDc2Q7JobNqBMC7Mo4gI+OohNaofECwEM16/aJkPLFTGuiEpGtnZpe
   mbLOqXJul0in1nsovcGLv0smItHlBhh8Q2CZF6mif0tqgPa/8LdDTp/pc
   UOuq4UOCp3pHdBNgI0diSYyCRbyA3JkK5fSeJQR1oRVTM+wLuxwuHzyPC
   zf4KVrn6F+SF5jAXMoEfIr1W/VNHXJTrnrc91US6UrqPyMQ9ddcLDRTIt
   JJne1hzyNAw7apf6ZCw9k2lseiDt/KqLLsHGLp04T1BGe+zpL0+Hi0a5S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451441123"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="451441123"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762295737"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="762295737"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2023 18:42:41 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvSut-0008VZ-15;
        Wed, 25 Oct 2023 01:42:39 +0000
Date:   Wed, 25 Oct 2023 09:42:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v2 2/2] mmc: host: msm: Disable auto-cmd12 during ffu
Message-ID: <202310250913.ri6qqodu-lkp@intel.com>
References: <20231023132128.1871269-3-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023132128.1871269-3-avri.altman@wdc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Avri,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.6-rc7 next-20231024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/mmc-core-Mark-close-ended-ffu-in-progress/20231023-212707
base:   linus/master
patch link:    https://lore.kernel.org/r/20231023132128.1871269-3-avri.altman%40wdc.com
patch subject: [PATCH v2 2/2] mmc: host: msm: Disable auto-cmd12 during ffu
config: csky-randconfig-001-20231025 (https://download.01.org/0day-ci/archive/20231025/202310250913.ri6qqodu-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310250913.ri6qqodu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310250913.ri6qqodu-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `sdhci_msm_request':
>> sdhci-msm.c:(.text+0x540): undefined reference to `mmc_is_ffu_cmd'
   csky-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `sdhci_and_cqhci_reset':
   sdhci-msm.c:(.text+0x5c0): undefined reference to `mmc_is_ffu_cmd'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
