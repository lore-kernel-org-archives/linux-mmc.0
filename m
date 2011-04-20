From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 18:13:14 -0400
Message-ID: <m3ipu8d11h.fsf@pullcord.laptop.org>
References: <alpine.DEB.2.00.1104131713570.15392@peruna>
	<alpine.DEB.2.00.1104131737280.15392@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46302 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab1DTWJI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 18:09:08 -0400
In-Reply-To: <alpine.DEB.2.00.1104131737280.15392@peruna> (John Calixto's
	message of "Wed, 13 Apr 2011 17:38:40 -0700 (PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, Arnd Bergmann <arnd@arndb.de>

Hi John, some trivial changes,

On Wed, Apr 13 2011, John Calixto wrote:
> diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
> new file mode 100644
> index 0000000..ad6a871
> --- /dev/null
> +++ b/include/linux/mmc/ioctl.h
> @@ -0,0 +1,46 @@
> +#ifndef _MMC_IOCTL_H
> +#define _MMC_IOCTL_H

Nitpick: LINUX_MMC_IOCTL_H is a little more consistent with the other
headers in include/linux/mmc.

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
> +	/* DAT buffer */
> +	__u32 data_ptr_size;  /* size of the *pointer* */
> +	__u64 data_ptr;
> +};
> +#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)

I think we need to register the MMC_BLOCK_MAJOR (== 0xB3 00) prefix in
Documentation/ioctl/ioctl-number.txt.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
