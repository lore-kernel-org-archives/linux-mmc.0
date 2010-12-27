From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v6 0/3]mmc: implement eMMC4.4 standard HW reset feature
Date: Mon, 27 Dec 2010 18:13:05 +0800
Message-ID: <20101227101305.GA20143@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33517 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0L0KRi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Dec 2010 05:17:38 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cjb@laptop.org, akpm@linux-foundation.org

Hi all,
   This is the version 6 of hardware reset feature implementation. When eMMC
   card cannot response any command, signal RST_n can help to reset eMMC
   card.

   patch1: enable HW reset capability if card supports.
   patch2: do hardware reset if card occurs read/write/erase timeout
   patch3: implement hwreset_emmc and reinit_emmc callbacks. In this patch,
   hwreset_emmc callback will pull up/down the corresponded GPIO line number
   to trigger RST_n signal.

   change log:
   1. Move hardware_reset callback to mmc_bus_ops so that all kinds of host
   controller can use hardware_reset callback to trigger RST_n signal.
   Different host controller only needs to provide a GPIO line number to
   this callback.
   2. Add GPIO pull up/down part in hardware_reset callback.
   3. Remove reset_emmc callback in sdhci_ops.

Thanks
Chuanxiao
