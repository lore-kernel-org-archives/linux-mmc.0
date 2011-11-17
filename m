From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A question on IOCTL interface for MMC
Date: Thu, 17 Nov 2011 15:46:10 +0000
Message-ID: <201111171546.10214.arnd@arndb.de>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com> <CANYdXnoS31GLnbFcwj76SUoyVhcti8Q-4_5fmyRy3DUJGbSRjg@mail.gmail.com> <4EA5AE64.2030106@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59557 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab1KQPqS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 10:46:18 -0500
In-Reply-To: <4EA5AE64.2030106@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Chris Ball <cjb@laptop.org>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

On Monday 24 October 2011, J Freyensee wrote:
> On 10/24/2011 05:32 AM, Shashidhar Hiremath wrote:
> > Hi Arnd,
> >    As explained in previous mail, the IOCTL is actually an inteface to
> > block layer and it is only expecting read/write commands to be sent
> > through the interface.The prrof of it can be seen in write_flag
> > present in the IOCTL structure which indicates the either the command
> > can be read or a write command.
> >
> > So, can I submit a linux module to the kernel which uses the same
> > mmc_ioc_cmd structure and do all the required processing in my module.
> >
> > To be clear on my requirement:
> > it is  To test ALL SD/MMC Commands and NOT just the  Read/Write Commands.
> > or should I extend the mmc_test module present in kernel to support
> > testing of individual commands as well ?
> 
> I would think the mmc_test module would be a good vehicle to extend to 
> have it test individual commands.
> 
> Of course if there is no documentation or HOWTO use mmc_test module to 
> test an individual MMC command then the work is kind-of for naught.

I'm still catching up on my email after travelling. I'm sorry I did not
catch this earlier, because this seems to be the source of the confusion
that lead to the suboptimal implementation of test code in the kernel
driver.

I believe the correct answer to the original question would have been
that any command that does not take an argument should just pass
a length of zero on the ioctl interface. If I read the code correctly,
this needs at least a change to mmc_blk_ioctl_copy_from_user to 
handle zero-length arguments, and there are possibly some other
issues, but I think that should let you do everything you need.

	Arnd
