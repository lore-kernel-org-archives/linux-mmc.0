From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v1 0/4]mmc: enable eMMC4.41 new feature background
	operations and HPI
Date: Tue, 23 Nov 2010 16:43:09 +0800
Message-ID: <20101123084309.GA17754@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab0KWIpp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 03:45:45 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, alan@linux.intel.com, arjan@linux.intel.com, hang.yuan@intel.com

Hi,
	These patches were enabled eMMC4.41 standard new feature: background
	operations and HPI.

	Since these two features are opertional, driver only enable for those
	eMMC card which supports them.

	HPI can interrupt both background operations and low priority foreground
	operations. In these patches, only implemented using HPI to interrupt
	background operations.

	patch1: enable background operations feature for supported eMMC card.
	patch2: let eMMC card do background operations when user reqeust queue
	is idle. In this patch, also considered when driver added runtime power
	management.
	patch3: enable HPI feature for supported eMMC card.
	patch4: use HPI to interrupt background operations if there is user
	request(foreground operations).

Thanks
Chuanxiao
