From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Mon, 17 Jan 2011 10:59:25 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
References: <20110114082310.GB27523@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16164 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab1AQLAC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jan 2011 06:00:02 -0500
In-Reply-To: <20110114082310.GB27523@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "ohad@wizery.com" <ohad@wizery.com>


> MMC host has a sysfs interface to let user specify the auto suspended delay.
> Each slot of the host controller can have a different delay for runtime
> suspended.


>   out:
> +	/* power off host controller */
> +	pm_runtime_put(&host->class_dev);
If you want to use autosuspend feature, then you need to use the function pm_runtime_put_autosuspend().


I'm also worried about this patch not taking in account the 8 clock cycles before shutting down the clock, contrary to the clock gating fw.
If you power down hc, you will also gate the clock. So the sdio protocol might not be strictly followed.


Regards,
Pierre
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

