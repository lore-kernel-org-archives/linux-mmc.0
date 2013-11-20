From: spalav <spalav@leapfrog.com>
Subject: Re: [PATCH] =?utf-8?b?bW1jX3Rlc3Q6?= move files from sysfs to debugfs
Date: Wed, 20 Nov 2013 01:56:11 +0000 (UTC)
Message-ID: <loom.20131120T025226-139@post.gmane.org>
References: <1284102650-15044-1-git-send-email-ext-andriy.shevchenko@nokia.com> <4C89DC01.6000601@nokia.com> <20100910202943.GB9862@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47374 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab3KTCFF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Nov 2013 21:05:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VixA8-0006Us-CR
	for linux-mmc@vger.kernel.org; Wed, 20 Nov 2013 03:05:04 +0100
Received: from 209.119.85.5 ([209.119.85.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2013 03:05:04 +0100
Received: from spalav by 209.119.85.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2013 03:05:04 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Greg KH <greg <at> kroah.com> writes:

> 
> On Fri, Sep 10, 2010 at 10:19:29AM +0300, Adrian Hunter wrote:
> > Andy Shevchenko wrote:
> > >As proposed by Greg the more logically is to keep files for mmc_test driver
> > >under debugfs.
> > 
> > What happens if debugfs is not enabled in config?  Should there be
> > some kind of dependency there?  At least an error message would be
> > good - see below.
> 
> That would be good, but note that all major distros now enable it, so
> it's less and less of an issue these days.
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hi,
I am using 3.4 kernel and trying to use CONFIG_MMC_TEST option. 
I am booting from an SD card, want to test eMMC on board. 
I have CONFIG_DEBUF_FS option turned on and I am building mmc_test as a
module. But when I follow the steps written here, I do not see driver
probing. So "test" file never gets created under
/sys/kernel/debug/mmc2/mmc2\:001/. 

Can you please help me out here by pointing out what I am doing wrong? I
know this is a very old thread but it's worth a shot! 

Thanks,
SP



