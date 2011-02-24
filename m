From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1]mmc: set timeout for SDHCI host before sending busy
	cmd
Date: Thu, 24 Feb 2011 20:15:04 +0000
Message-ID: <20110224201504.GA12913@void.printf.net>
References: <20110224111935.GB7169@intel.com> <AANLkTinJEXc_x36Rht=XfYEtjShAYKWRDcsjGFtd=5Tj@mail.gmail.com> <5D8008F58939784290FAB48F5497519835CE59FE81@shsmsx502.ccr.corp.intel.com> <79DD18D4-C79A-4B08-B9E6-050D7EF2FC3D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45580 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab1BXUPM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 15:15:12 -0500
Content-Disposition: inline
In-Reply-To: <79DD18D4-C79A-4B08-B9E6-050D7EF2FC3D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Jae hoon Chung <jh80.chung@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Feb 24, 2011 at 10:32:30AM -0800, Philip Rakity wrote:
> proposed this a while ago and strongly support just removing the quirk for broken timeout and setting the timeout value to maximum of 0xE.
> 
> This also handles the case of the sd device having a timeout value too low.  In my testing I have come across SD cards that do not provide the correct value.
> We force our pxa168, pxa910, and mmp2 controllers to have 0xE.  

Yeah, OLPC's CaFe controller -- which might be the same hardware as yours,
actually -- has the same problem.

Does anyone know of a reason (beyond strict spec-compliance, I suppose)
for honoring the timeout value rather than using 0xE everywhere?  If not,
I'm willing to try out Philip's suggestion.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
