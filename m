From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v3 0/2]MMC:implement eMMC4.4 standard HW reset feature
Date: Thu, 18 Nov 2010 11:04:11 +0800
Message-ID: <20101118030411.GA10621@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, arjan@linux.intel.com, alan@linux.intel.com
List-Id: linux-mmc@vger.kernel.org

Hello Chris,
	  These are the version 3 of HW reset feature implementation. Since I
	  didnot get any response from the version 2 and version1 patches, I am
	  not sure whether I need to change. So just did a little change in
	  form.

	  The 2 patches implemented eMMC4.4 hardware reset feature in core layer
	  and sdhci host layer, but need each sdhci host controller to implement
	  the real reset part specially.

	  patch 0001: implemented eMMC4.4 hardware reset feature in mmc core
	  layer. Added reinit callback in mmc_bus_ops and hardware_reset
	  callback in mmc_host_ops.
	  patch 0002: implemented hardware reset callback in sdhci host layer.
	  Added reset_emmc callback in sdhci_ops.

	  changelog:
	  patch 0001: add a error check when switch to enable HW reset bit
	  failed. Also add some comment to explain the added 2 new callbacks.
	  patch 0002: add some comment to explain the reset_emmc callback.

Thanks
Chuanxiao
