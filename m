From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1]mmc: implemented eMMC4.4 enhanced area feature
Date: Thu, 20 Jan 2011 06:21:03 +0000
Message-ID: <20110120062103.GB5732@void.printf.net>
References: <20110113125727.GA20452@intel.com> <20110120032519.GA4827@void.printf.net> <5D8008F58939784290FAB48F54975198352A15BFC0@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60536 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab1ATGVG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Jan 2011 01:21:06 -0500
Content-Disposition: inline
In-Reply-To: <5D8008F58939784290FAB48F54975198352A15BFC0@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi Chuanxiao,

On Thu, Jan 20, 2011 at 02:08:04PM +0800, Dong, Chuanxiao wrote:
> > I think these should probably be printed in decimal instead of hex.

(Will assume you agree with this, let me know if not.)

> > Hm, this way the sysfs files will show up regardless of whether we have
> > an eMMC device or an SD card, which is very confusing.  Can you not check
> > whether enhanced_area_en == 1 before create these files?
> > 
> SD card will not use this code when initializing. So I think these files only are created for eMMC card. If the eMMC card doesn't support enhanced area, can we use the same way like below scenario, exporting some value like -EINVAL to user? What do you think?

Oh, makes sense -- I agree, let's just use -EINVAL, and update the sysfs
ABI doc to mention that.  Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
