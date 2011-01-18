From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Tue, 18 Jan 2011 15:27:14 +0800
Message-ID: <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
References: <20110114082310.GB27523@intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19276 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab1ARH1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 02:27:19 -0500
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "ohad@wizery.com" <ohad@wizery.com>

> -----Original Message-----
> From: Tardy, Pierre
> Sent: Monday, January 17, 2011 6:59 PM
> To: Dong, Chuanxiao; linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; cjb@laptop.org; ohad@wizery.com
> Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
> 
> 
> > MMC host has a sysfs interface to let user specify the auto suspended delay.
> > Each slot of the host controller can have a different delay for runtime
> > suspended.
> 
> 
> >   out:
> > +	/* power off host controller */
> > +	pm_runtime_put(&host->class_dev);
> If you want to use autosuspend feature, then you need to use the function
> pm_runtime_put_autosuspend().
> 
Eh, that is right. Will fix in the next submission

> 
> I'm also worried about this patch not taking in account the 8 clock cycles before
> shutting down the clock, contrary to the clock gating fw.
> If you power down hc, you will also gate the clock. So the sdio protocol might not be
> strictly followed.
As mmc spec said, 8 clock cycles is needed. That is right.
But I think if we have set the auto suspended delay for host, runtime pm core could make sure host to wait at least the auto suspended delay before shutting down the power of the device. So if the auto suspended delay is longer than 8 clock cycles, the mmc protocol can be followed, right?

Thanks
Chuanxiao
