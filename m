From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Wed, 22 Feb 2012 16:11:30 +0200
Message-ID: <4F44F792.2000304@intel.com>
References: <4F190E26.4040909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:47188 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab2BVOL1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Feb 2012 09:11:27 -0500
In-Reply-To: <4F190E26.4040909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

On 20/01/12 08:48, Jaehoon Chung wrote:
> Enable eMMC background operations (BKOPS) feature.
> 
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.

You are leaving bkops running and releasing the host.  Won't
that cause problems for other entry points to mmc services
e.g. system suspend (cache control, sleep etc), ioctl, sysfs,
etc
