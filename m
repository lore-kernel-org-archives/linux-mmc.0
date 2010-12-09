From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v5 0/4]implement eMMC4.4 standard HW reset feature
Date: Thu, 9 Dec 2010 20:24:03 +0800
Message-ID: <20101209122403.GA13236@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50211 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab0LIM1r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Dec 2010 07:27:47 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, cjb@laptop.org, kmpark@infradead.org, leonard.mai@intel.com

Hi,
	This is the version 5 of HW reset feature implementation. HW reset can
	reset eMMC card when card occurs a read/write/erase timeout error. It is
	useful when eMMC card cannot correspond any command after occurs a timeout
	error.

	change-log:
	patch1: use value 5 instead to judge whether eMMC card complies eMMC4.41
	standard.
	patch4: handle erase timeout error only when there was an error occurs
	after erase.

	patch1: enable HW reset capability if card support.

 	patch2: add two new callback to implement HW reset in mmc core layer. In
 	this patch, routine mmc_handle_timeout_error was added.

 	patch3: implement hardware_reset callback for sdhci host. A new callback
 	reset_emmc was defined which will be each sdhci host controller to
 	implement separately.

 	patch4: did a HW reset after each read/write/erase command if need.

Thanks
Chuanxiao
