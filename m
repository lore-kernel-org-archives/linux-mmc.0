From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "mmc: block: don't use parameter prefix if built
 as module"
Date: Thu, 3 Mar 2016 07:58:33 -0800
Message-ID: <20160303155833.GA3613@kroah.com>
References: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
 <20160211171941.GA29378@kroah.com>
 <CAPDyKFp+2SQhAuDt26CpDQnd-KwhWM3GffgQip7aj-QtuUUjEA@mail.gmail.com>
 <20160212163216.GB5646@kroah.com>
 <CAPDyKFpRNQuTE9c6Ux_Bj0FXMnL4EiVFkswNf7F+c254W0xM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43185 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbcCCP6e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 10:58:34 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpRNQuTE9c6Ux_Bj0FXMnL4EiVFkswNf7F+c254W0xM1Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Thu, Mar 03, 2016 at 02:37:04PM +0100, Ulf Hansson wrote:
> On 12 February 2016 at 17:32, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Feb 12, 2016 at 11:06:03AM +0100, Ulf Hansson wrote:
> >> On 11 February 2016 at 18:19, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > On Thu, Feb 11, 2016 at 04:54:11PM +0100, Ulf Hansson wrote:
> >> >> This reverts commit 829b6962f7e3cfc06f7c5c26269fd47ad48cf503.
> >> >>
> >> >> Revert this change as it causes a sysfs path to change and therefore
> >> >> introduces and ABI regression. More precisely Android's vold is not being
> >> >> able to access /sys/module/mmcblk/parameters/perdev_minors any more, since
> >> >> the path becomes changed to: "/sys/module/mmc_block/..."
> >> >>
> >> >> Fixes: 829b6962f7e3 ("mmc: block: don't use parameter prefix if built as
> >> >> module")
> >> >> Reported-by: John Stultz <john.stultz@linaro.org>
> >> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> >
> >> > Please also add a "cc: stable..." tag to the patch so it gets picked up
> >> > in stable kernel releases.
> >>
> >> Doesn't the Fixes tag take care of that?
> >
> > Not at all, never rely on that, please read
> > Documentation/stable_kernel_rules.txt for how to properly tag a patch
> > for a stable release.
> >
> > Sometimes I get bored and look at patches with only a fixes: tag on them
> > to see how bad the maintainer is messing up and then do their work for
> > them, but that's rare these days...
> 
> That's sounds like you do this entirely manually, I doubt you have
> time for that? :-)

Right now, no, I don't, and because of that, I just ignored a few
hundred patches that had this tag on it but not a stable@ tag.  Most of
them probably were not relevant for a stable release, based on the usual
numbers, but possibly some were.  Oh well.

> So, isn't it quite simple to automate this thing, as all the
> information you need (ideally) is to know what commit is being fixed.
> Right?

Yes, and I have it semi-automated, but still you need to look at each
patch manually to ensure that they really do meet the stable kernel
rules.  That's not something that anyone has figured out how to automate
(if so, I would love it as my work here would be trivial!)

greg k-h
