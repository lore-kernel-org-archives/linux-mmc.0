From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v1 0/3]mmc: set a suitable max discard sectors value for
	host controller
Date: Thu, 11 Nov 2010 17:05:02 +0800
Message-ID: <20101111090502.GA18170@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32325 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab0KKJGw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 04:06:52 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

Hi Chris,
   These 3 patches set a suitable max_discard_sectors value for mmc
   queue which will be used for ERASE/TRIM. Add Adrian in Cc loop since
   he implemented the ERASE/TRIM feature for MMC driver.

   patch1: calculated a suitable timeout time for SDHCI host controller.
   Each erase cmd should be finished within the timeout time.

   patch2: calculated a suitable max_discard_sectors value for mmc
   queue. Since some SDHCI host controller cannot process the whole
   sectors at one time. In this patch, a new callback get_tmclk in
   mmc_host_ops was added to help core layer to calculate the max value.
   If this callback was implemented, core layer will calculted a suitable
   value. If not, the max_discard_sectors value will be the same as
   before.

   patch3: implemented get_tmclk callback for SDHCI host controller.

   Adrian, hope I can get your comment about these patches as well.
   Thanks for your time to review these patches.

Regards
Chuanxiao
