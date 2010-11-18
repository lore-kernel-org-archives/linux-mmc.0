From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v2 0/3]mmc: set a suitable max_discard_sectors value for HC
Date: Thu, 18 Nov 2010 16:59:51 +0800
Message-ID: <20101118085951.GA18161@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:64153 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593Ab0KRJCV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Nov 2010 04:02:21 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, alan@linux.intel.com, arjan@linux.intel.com

Hello Chris,
	  These are the version 2 patches of setting a suitable
	  max_discard_sectors value for sdhci host controller.

	  The max_discard_sectors determines how many sectors will be passed
	  down to host controller for erasing. The default value is UNIT_MAX
	  which means the block layer can pass down unlimited sectors one time
	  to host controller. But for some kinds of SDHCI host controller, like
	  MFLD SDHCI host controller cannot erase so many sectors one time. It
	  will generate a timeout interrupt since the erasing time is longer
	  than the host controller waiting timeout time. This should be a
	  hardware architecture issue.

	  So in these patches, add a new quirk to work around this. The new
	  quirk can help host controllers to set a safe max_discard_sectors value
	  for them.

	  patch1: Add a new quirk for SDHCI host controller and a new mmc
	  capability which will help mmc core layer to set a suitable
	  max_discard_sectors value for it.

	  patch2: Set the sdhci host controller timeout value to be the maximum
	  one for each erase command. This will be safe for this kind of SDHCI
	  host controller.

	  patch3: Add the new quirk to MFLD SDHCI host controller.

Thanks
Chuanxiao
