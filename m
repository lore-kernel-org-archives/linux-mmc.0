From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Wed, 13 Apr 2011 01:10:46 +0200
Message-ID: <201104130110.46815.arnd@arndb.de>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <alpine.DEB.2.00.1104111450340.32082@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61819 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab1DLXKy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 19:10:54 -0400
In-Reply-To: <alpine.DEB.2.00.1104111450340.32082@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

On Monday 11 April 2011, John Calixto wrote:
> Sending ACMDs from userspace is useful for such things as:
> 
>     - The security application of an SD card (SD Specification, Part 3,
>       Security)
> 
>     - SD passthrough for virtual machines
> 
> Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621
> SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
> 
> Signed-off-by: John Calixto <john.calixto@modsystems.com>
> Reviewed-by: Andrei Warkentin <andreiw@motorola.com>

Since the code is limited to ACMD and cannot do arbitrary commands, it's actually
not possible to use this for the passthrough scenario, so you should not mention
it in the changelog.

I would also still advocate something more high-level here because it's limited
to a single use case. If you make the ioctl interface do the security commands
directly, you would not need to rely on CAP_SYS_RAWIO.

> +static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
> +	struct mmc_ioc_cmd __user *user)
> +{
> +	struct mmc_blk_ioc_data *idata;
> +	int err;
> +
> +	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
> +	if (!idata) {
> +		err = -ENOMEM;
> +		goto copy_err;
> +	}
> +
> +	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
> +		err = -EFAULT;
> +		goto copy_err;
> +	}
> +
> +	idata->buf_bytes = idata->ic.blksz * idata->ic.blocks;
> +
> +	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);

You should probably check the size and allow a fixed maximum here.

> +static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> +	unsigned int cmd, unsigned long arg)
> +{
> +	int ret = -EINVAL;
> +	mutex_lock(&block_mutex);
> +	if (cmd == MMC_IOC_ACMD)
> +		ret = mmc_blk_ioctl_acmd(bdev, (struct mmc_ioc_cmd __user *)arg);
> +	mutex_unlock(&block_mutex);
> +	return ret;
> +}

Why do you need the mutex here?

> +#ifdef CONFIG_COMPAT
> +static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
> +	unsigned int cmd, unsigned long arg)
> +{
> +	struct mmc_ioc_cmd __user *ic = (struct mmc_ioc_cmd __user *) arg;
> +	ic->data_ptr = ic->data_ptr & 0xffffffff;

This conversion should use

	ptr = (unsigned long)compat_ptr(ptr32);

You must never access __user pointers with a direct pointer dereference, but have
to use copy_{from,to}_user or {get,put}_user. The code you have here allows a
fairly simple root exploit.

	Arnd
