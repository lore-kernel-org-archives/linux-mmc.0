From: Greg KH <greg@kroah.com>
Subject: Re: char interface to sdio, chdio.c
Date: Wed, 16 Jul 2014 16:11:46 -0700
Message-ID: <20140716231146.GA13500@kroah.com>
References: <20140716032655.GB30412@kroah.com>
 <53C6C2C5.1050804@codeaurora.org>
 <20140716184409.GB10633@kroah.com>
 <53C6D4B6.3030506@codeaurora.org>
 <53C705DB.3040700@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43735 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752261AbaGPXLx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jul 2014 19:11:53 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 59D8D21C0C
	for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2014 19:11:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53C705DB.3040700@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Alexander Kolesnikov <akolesni@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>

On Wed, Jul 16, 2014 at 04:08:11PM -0700, Stephen Boyd wrote:
> On 07/16/14 12:38, Stephen Boyd wrote:
> > On 07/16/14 11:44, Greg KH wrote:
> >> My specific question is why 2 different interfaces?
> > Ok. It definitely looks odd to support set/get of the VDD with sysfs and
> > ioctl interfaces. I'm just guessing, but I suspect it's a permissions
> > thing given that the patch that introduces the VDD stuff also updates
> > the permissions of the device node. Of course, the commit text only
> > mentions an ioctl, nothing about sysfs. The only other sysfs stuff seems
> > to be module parameters to change the vendor ids.
> >
> > I'll have to go repo diving to figure out if the sysfs interface was
> > ever used. Maybe Alex or Konstantin can respond before I have to do that.
> >
> >
> 
> I couldn't find any usage of the sysfs interface. The only thing I see
> used is the host_name field when the module is inserted, if that even
> happens at all (I'm not sure because it's behind some ifdef that may or
> may not be defined). Sorry this doesn't explain why there are two
> different interfaces for the VDD stuff. Hopefully Alex or Konstantin can
> help.

Thanks for looking.

Alex and/or Konstantin, any objection to me removing the sysfs interface
on this driver, and just using the char device ioctl hellhole^WAPI
instead?

thanks,

greg k-h
