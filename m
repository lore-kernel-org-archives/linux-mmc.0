From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 16:21:38 +0200
Message-ID: <BANLkTimn3vB1JaBfboOL0ayG2FpXsUMe7w@mail.gmail.com>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <alpine.DEB.2.00.1104111450340.32082@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44571 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab1DLOV7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 10:21:59 -0400
Received: by qyg14 with SMTP id 14so4675203qyg.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 07:21:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104111450340.32082@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

2011/4/11 John Calixto <john.calixto@modsystems.com>:
[...]
> --- /dev/null
> +++ b/include/linux/mmc/ioctl.h
> @@ -0,0 +1,32 @@
> +#ifndef _MMC_IOCTL_H
> +#define _MMC_IOCTL_H
> +struct mmc_ioc_cmd {
> + =A0 =A0 =A0 /* implies direction of data. =A0true =3D write, false =
=3D read */
> + =A0 =A0 =A0 int write_flag;
> +
> + =A0 =A0 =A0 __u32 opcode;
> + =A0 =A0 =A0 __u32 arg;
> + =A0 =A0 =A0 __u32 response[4]; =A0/* CMD response */
> + =A0 =A0 =A0 unsigned int flags;
> + =A0 =A0 =A0 unsigned int blksz;
> + =A0 =A0 =A0 unsigned int blocks;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Sleep at least postsleep_min_us useconds, and at m=
ost
> + =A0 =A0 =A0 =A0* postsleep_max_us useconds *after* issuing command.=
 =A0Needed for some
> + =A0 =A0 =A0 =A0* read commands for which cards have no other way of=
 indicating
> + =A0 =A0 =A0 =A0* they're ready for the next command (i.e. there is =
no equivalent of a
> + =A0 =A0 =A0 =A0* "busy" indicator for read operations).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned int postsleep_min_us;
> + =A0 =A0 =A0 unsigned int postsleep_max_us;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Override driver-computed timeouts. =A0Note the dif=
ference in units!
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned int data_timeout_ns;
> + =A0 =A0 =A0 unsigned int cmd_timeout_ms;
> + =A0 =A0 =A0 __u64 data_ptr; =A0/* DAT buffer */

This will be more natural if you have an anonymous union here:
union {
  __u64 data_ptr_l;
  void *data_ptr;
};

> +};
> +#define MMC_IOC_ACMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
> +#endif =A0/* _MMC_IOCTL_H */

Best Regards,
Micha=B3 Miros=B3aw
