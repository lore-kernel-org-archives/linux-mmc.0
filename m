From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 16:40:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104121622120.8483@peruna>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <alpine.DEB.2.00.1104111450340.32082@peruna> <201104130110.46815.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:34727 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757105Ab1DLXlA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 19:41:00 -0400
In-Reply-To: <201104130110.46815.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

Hi Arnd,

On Wed, 13 Apr 2011, Arnd Bergmann wrote:
> On Monday 11 April 2011, John Calixto wrote:
> > Sending ACMDs from userspace is useful for such things as:
> > 
> >     - The security application of an SD card (SD Specification, Part 3,
> >       Security)
> > 
> >     - SD passthrough for virtual machines
> > 
> > Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621
> > SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
> > 
> > Signed-off-by: John Calixto <john.calixto@modsystems.com>
> > Reviewed-by: Andrei Warkentin <andreiw@motorola.com>
> 
> Since the code is limited to ACMD and cannot do arbitrary commands, it's actually
> not possible to use this for the passthrough scenario, so you should not mention
> it in the changelog.
> 
> I would also still advocate something more high-level here because it's limited
> to a single use case. If you make the ioctl interface do the security commands
> directly, you would not need to rely on CAP_SYS_RAWIO.
> 

I'm happy to remove the text about passthrough from the changelog, but
it is a valid use for this ioctl.  I agree that ACMD by itself is not
sufficient for full passthrough, but this patch is a starting point for
anyone wanting to implement full CMD passthrough.

There are also several ACMD opcodes that are not related to security,
but to functionality like requesting to change the signalling voltage,
setting bus width, setting pre-erase block count, etc...  I think those
commands are what caused others to request some kind of capability
restriction.

> > +static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
> > +	struct mmc_ioc_cmd __user *user)
> > +{
> > +	struct mmc_blk_ioc_data *idata;
> > +	int err;
> > +
> > +	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
> > +	if (!idata) {
> > +		err = -ENOMEM;
> > +		goto copy_err;
> > +	}
> > +
> > +	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
> > +		err = -EFAULT;
> > +		goto copy_err;
> > +	}
> > +
> > +	idata->buf_bytes = idata->ic.blksz * idata->ic.blocks;
> > +
> > +	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
> 
> You should probably check the size and allow a fixed maximum here.
> 

OK, I'll read the specs to find a suitable maximum.

> > +static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> > +	unsigned int cmd, unsigned long arg)
> > +{
> > +	int ret = -EINVAL;
> > +	mutex_lock(&block_mutex);
> > +	if (cmd == MMC_IOC_ACMD)
> > +		ret = mmc_blk_ioctl_acmd(bdev, (struct mmc_ioc_cmd __user *)arg);
> > +	mutex_unlock(&block_mutex);
> > +	return ret;
> > +}
> 
> Why do you need the mutex here?
> 

This patch originated an a much earlier version of the kernel that did
not have unlocked ioctls.  To be honest, I based this on what I found in
other ioctl implementations.  Looking at who else grabs block_mutex, I
think it's safe to remove this.

> > +#ifdef CONFIG_COMPAT
> > +static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
> > +	unsigned int cmd, unsigned long arg)
> > +{
> > +	struct mmc_ioc_cmd __user *ic = (struct mmc_ioc_cmd __user *) arg;
> > +	ic->data_ptr = ic->data_ptr & 0xffffffff;
> 
> This conversion should use
> 
> 	ptr = (unsigned long)compat_ptr(ptr32);
> 
> You must never access __user pointers with a direct pointer dereference, but have
> to use copy_{from,to}_user or {get,put}_user. The code you have here allows a
> fairly simple root exploit.

Got it - thanks!

John
