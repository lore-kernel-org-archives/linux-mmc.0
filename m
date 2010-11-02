From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v2 0/2]mmc: implemented eMMC4.4 hardware reset feature
Date: Tue, 2 Nov 2010 20:35:50 +0800
Message-ID: <20101102123550.GA1313@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30749 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822Ab0KBMhG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Nov 2010 08:37:06 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Hello Chris,
	  Several days ago, I send a patch which is used to implement the
	  eMMC4.4 hardware reset feature. But did not get any response till
	  now. I have splitted that patch into 2 for easy understanding, and
	  posting here for you to review it. Thanks.

	  The 2 patches implemented eMMC4.4 hardware reset feature in core
	  layer and sdhci host layer, but need each sdhci host controller to
	  implement the real reset part specially.

	  patch 0001: implemented eMMC4.4 hardware reset feature in mmc core
	  layer.
	  patch 0002: implemented hardware reset callback in sdhci host
	  layer.

	  I also have a concern about the enabling hardware reset part. As
	  eMMC 4.4 standar says, to enable hardware reset need to set the bit
	  0 of byte 162 in ext_csd register. However this register is onetime
	  programmable, once setted, cannot be changed any more. And the
	  standar also says this feature is disabled by default. If driver
	  does not set it, the feature can not be enabled. So is it suitable
	  for driver to set this bit?

Thanks
Chuanxiao
