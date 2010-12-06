From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v4 0/4]implement eMMC4.4 standard HW reset feature
Date: Tue, 7 Dec 2010 00:03:02 +0800
Message-ID: <5D8008F58939784290FAB48F54975198320B3E4A2D@shsmsx502.ccr.corp.intel.com>
References: <20101201124842.GA5421@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33803 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab0LFQDk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 11:03:40 -0500
In-Reply-To: <20101201124842.GA5421@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Mai, Leonard" <leonard.mai@intel.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>

Hello all,
How about these patches? It implemented HW reset feature. When card occurred a timeout error during reading/writing/erasing, these patches will allow driver to reset eMMC card by trigger a HW reset signal.
Does anyone have any comments about the implementation of these patches? Wolfram and Arnd already pointed out the unsuitable patch headers. Thanks! :)


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> Sent: Wednesday, December 01, 2010 8:49 PM
> To: linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; cjb@laptop.org; arjan@linux.intel.com;
> alan@linux.intel.com; akpm@linux-foundation.org
> Subject: [PATCH v4 0/4]implement eMMC4.4 standard HW reset feature
> 
> Hi,
> 	These are the version 4 patches to implement eMMC4.4 HW reset
> 	feature. Host controller can use this feature by trigger RST_n signal.
> 	To enable this, byte 162 of EXT_CSD register should be set.
> 	HW reset is implemented in mmc core layer and sdhci host layer, and it
> 	will be used after each reading/writing/erasing timeout error occures.
> 
> 	change-log:
> 	This version change the way to detect timeout error conditions. Added a
> 	new routine mmc_handle_timeout_error to do this instead to do this in
> 	mmc_wait_for_req. Each timeout read/write/erase command can use this
> 	routine to do HW reset.
> 
> 	patch1: enable HW reset capability if card support.
> 
> 	patch2: add two new callback to implement HW reset in mmc core layer. In
> 	this patch, routine mmc_handle_timeout_error was added.
> 
> 	patch3: implement hardware_reset callback for sdhci host. A new callback
> 	reset_emmc was defined which will be each sdhci host controller to
> 	implement separately.
> 
> 	patch4: did a HW reset after each read/write/erase command.
> 
> Thanks
> Chuanxiao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
