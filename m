From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Thu, 5 Sep 2013 09:12:14 +0000 (UTC)
Message-ID: <loom.20130905T110125-516@post.gmane.org>
References: <loom.20130830T140917-496@post.gmane.org> <52242F31.4030103@samsung.com> <loom.20130903T105514-341@post.gmane.org> <CAOprVPLx1NR37YJOYzXSkQ7w70o5kWp0dbKdn0OzCr_0B7TkUQ@mail.gmail.com> <52269C2A.2030105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55938 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763555Ab3IEJMe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Sep 2013 05:12:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VHVc8-0006By-Dg
	for linux-mmc@vger.kernel.org; Thu, 05 Sep 2013 11:12:33 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 11:12:32 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 11:12:32 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,
 
> http://permalink.gmane.org/gmane.linux.kernel.mmc/15430
This link mentions that BKOPS_EN 163bit in EXT_CSD is one-time programmable
flag but from JEDEC Standard No. 84-A441 spec, it is R/W bit. Please
re-confirm about the statement.


> > MMC-Utils open source utility for enabling and disabling features.
> > It use ioctl defined in block/card to send commands to host.
> > git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git

I am not able to find this git in my platform repo. 
Is this mmc-utils git mandatory to have? 
What if, somebody don't have it and need to enabled BKOPS for eMMMC4.41?
Is mmc-utils the only way to enable BKOPS?

Regards,
Prasanna NAVARATNA

