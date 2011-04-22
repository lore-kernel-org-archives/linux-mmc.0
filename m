From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v7] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 18:28:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104211754520.3919@peruna>
References: <alpine.DEB.2.00.1104211735290.3919@peruna> <alpine.DEB.2.00.1104211743210.3919@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:40871 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755797Ab1DVB2z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 21:28:55 -0400
In-Reply-To: <alpine.DEB.2.00.1104211743210.3919@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Thu, 21 Apr 2011, John Calixto wrote:

<snip>

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
> +	idata->buf_bytes = (u64) idata->ic.blksz * idata->ic.blocks;
> +	if (idata->buf_bytes > MMC_IOC_MAX_BYTES) {
> +		err = -EOVERFLOW;
> +		goto copy_err;
> +	}
> +
> +	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
> +	if (!idata->buf) {
> +		err = -ENOMEM;
> +		goto copy_err;
> +	}
> +

Per Arnd's recommendation, I just cast the ``data_ptr`` to
``(void *)(unsigned long)`` to solve the compatibility issue with the
buffer pointer in struct mmc_ioc_cmd.

> +	if (copy_from_user(idata->buf, (void __user *)(unsigned long)
> +					idata->ic.data_ptr, idata->buf_bytes)) {
> +		err = -EFAULT;
> +		goto copy_err;
> +	}
> +
> +	return idata;
> +
> +copy_err:
> +	kfree(idata->buf);
> +	kfree(idata);
> +	return ERR_PTR(err);
> +
> +}
> +

<snip>

I also left mmc_blk_ioctl() and mmc_blk_compat_ioctl() as they were in
v6.  IMHO, a __mmc_blk_ioctl() function that accepts a compat32 boolean
arg does not do much to enhance readability or functionality in this
case.  With the implementation in the 2 functions below, I intended to
make it clear that:

    - mmc_blk_ioctl() is responsible for delegating to the appropriate
      handler based on the incoming ioctl cmd.  The ``if`` would be
      replaced with a ``switch`` when adding other values for cmd.

    - mmc_blk_compat_ioctl() is responsible for converting the ioctl arg
      to something suitable for consumtption by mmc_blk_ioctl().

    - when CONFIG_COMPAT is undefined, you get no code related to
      compatibility.

> +
> +static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> +	unsigned int cmd, unsigned long arg)
> +{
> +	int ret = -EINVAL;
> +	if (cmd == MMC_IOC_CMD)
> +		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
> +	unsigned int cmd, unsigned long arg)
> +{
> +	return mmc_blk_ioctl(bdev, mode, cmd, (unsigned long) compat_ptr(arg));
> +}
> +#endif
> +
>  static const struct block_device_operations mmc_bdops = {
>  	.open			= mmc_blk_open,
>  	.release		= mmc_blk_release,
>  	.getgeo			= mmc_blk_getgeo,
>  	.owner			= THIS_MODULE,
> +	.ioctl			= mmc_blk_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl		= mmc_blk_compat_ioctl,
> +#endif
>  };
>  

<snip>

It makes a lot of sense to me to make sure that struct mmc_ioc_cmd is
the same size on 32-bit and 64-bit machines, since it is used by _IOWR()
to derive the value for MMC_IOC_CMD.  Any change in its size requires
having other compatibility logic to deal with a MMC_IOC_CMD32.

Note that as this struct has evolved, I also needed to add a ``__pad``
member to the struct to achieve the goal of keeping it the same size on
32-bit and 64-bit.  I could have used packing or alignment compiler
directives, but this seemed simplest to me (I can add up the bytes in my
head!):

> diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
> new file mode 100644
> index 0000000..225e1e1
> --- /dev/null
> +++ b/include/linux/mmc/ioctl.h
> @@ -0,0 +1,54 @@
> +#ifndef LINUX_MMC_IOCTL_H
> +#define LINUX_MMC_IOCTL_H
> +struct mmc_ioc_cmd {
> +	/* Implies direction of data.  true = write, false = read */
> +	int write_flag;
> +
> +	/* Application-specific command.  true = precede with CMD55 */
> +	int is_acmd;
> +
> +	__u32 opcode;
> +	__u32 arg;
> +	__u32 response[4];  /* CMD response */
> +	unsigned int flags;
> +	unsigned int blksz;
> +	unsigned int blocks;
> +
> +	/*
> +	 * Sleep at least postsleep_min_us useconds, and at most
> +	 * postsleep_max_us useconds *after* issuing command.  Needed for some
> +	 * read commands for which cards have no other way of indicating
> +	 * they're ready for the next command (i.e. there is no equivalent of a
> +	 * "busy" indicator for read operations).
> +	 */
> +	unsigned int postsleep_min_us;
> +	unsigned int postsleep_max_us;
> +
> +	/*
> +	 * Override driver-computed timeouts.  Note the difference in units!
> +	 */
> +	unsigned int data_timeout_ns;
> +	unsigned int cmd_timeout_ms;
> +
> +	/*
> +	 * For 64-bit machines, the next member, ``__u64 data_ptr``, wants to
> +	 * be 8-byte aligned.  Make sure this struct is the same size when
> +	 * built for 32-bit.
> +	 */
> +	__u32 __pad;
> +
> +	/* DAT buffer */
> +	__u64 data_ptr;
> +};

To help with the casting in 32-bit userspace, I also provided
``mmc_ioc_cmd_set_data(ic, ptr)`` as a helper macro:

> +#define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
> +
> +#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
> +
> +/*
> + * Since this ioctl is only meant to enhance (and not replace) normal access to
> + * the mmc bus device, an upper data transfer limit of MMC_IOC_MAX_BYTES is
> + * enforced per ioctl call.  For larger data transfers, use the normal block
> + * device operations.
> + */
> +#define MMC_IOC_MAX_BYTES  (512L * 256)
> +#endif  /* LINUX_MMC_IOCTL_H */
> -- 
> 1.7.4.1
> 

John
