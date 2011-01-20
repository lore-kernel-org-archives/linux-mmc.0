From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 1/1]mmc: implemented eMMC4.4 enhanced area feature
Date: Thu, 20 Jan 2011 14:55:27 +0800
Message-ID: <5D8008F58939784290FAB48F54975198352A15C006@shsmsx502.ccr.corp.intel.com>
References: <20110113125727.GA20452@intel.com>
 <20110120032519.GA4827@void.printf.net>
 <5D8008F58939784290FAB48F54975198352A15BFC0@shsmsx502.ccr.corp.intel.com>
 <20110120062103.GB5732@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110120062103.GB5732@void.printf.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,
> 
> On Thu, Jan 20, 2011 at 02:08:04PM +0800, Dong, Chuanxiao wrote:
> > > I think these should probably be printed in decimal instead of hex.
> 
> (Will assume you agree with this, let me know if not.)
Agree with this. Sorry for missing it.

> 
> > > Hm, this way the sysfs files will show up regardless of whether we have
> > > an eMMC device or an SD card, which is very confusing.  Can you not check
> > > whether enhanced_area_en == 1 before create these files?
> > >
> > SD card will not use this code when initializing. So I think these files only are
> created for eMMC card. If the eMMC card doesn't support enhanced area, can we
> use the same way like below scenario, exporting some value like -EINVAL to user?
> What do you think?
> 
> Oh, makes sense -- I agree, let's just use -EINVAL, and update the sysfs
> ABI doc to mention that.  Thanks!
Cool! I will fix these and then resubmit the new patch. :)

Thanks
Chuanxiao
