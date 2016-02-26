From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 1/1 v2] mmc_utils: add ffu support
Date: Fri, 26 Feb 2016 14:50:59 +0000
Message-ID: <86vb5bcyp8.fsf@void.printf.net>
References: <SN1PR02MB13890B1700C4AE8F6FCD8C6C83A40@SN1PR02MB1389.namprd02.prod.outlook.com>
	<86ziuncyz2.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([192.34.86.38]:57060 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318AbcBZO6W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Feb 2016 09:58:22 -0500
In-Reply-To: <86ziuncyz2.fsf@void.printf.net> (Chris Ball's message of "Fri,
	26 Feb 2016 14:45:05 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Yaniv Agman <Yaniv.Agman@sandisk.com>

Hi,

On Fri, Feb 26 2016, Chris Ball wrote:
> Thanks for resending.  I'm getting some compile errors, any ideas?
>
> mmc_cmds.c: In function =E2=80=98do_ffu=E2=80=99:
> mmc_cmds.c:2076:31: error: invalid application of =E2=80=98sizeof=E2=80=
=99 to incomplete type =E2=80=98struct mmc_ioc_multi_cmd=E2=80=99
>   multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>                                ^
>
> mmc_cmds.c:2126:11: error: dereferencing pointer to incomplete type =E2=
=80=98struct mmc_ioc_multi_cmd=E2=80=99
>   multi_cmd->num_of_cmds =3D 3;
>            ^
>
> mmc_cmds.c:2162:23: error: =E2=80=98MMC_IOC_MULTI_CMD=E2=80=99 undecl=
ared (first use in this function)
>    ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>                        ^

Oh, I bet it's because we include <linux/mmc/ioctl.h>, and now that
needs to be coming from Linux 4.4+ to include the new ioctl.

Putting a compile-dependency on Linux 4.4+ seems very tough, though.
mmc-utils is built on many distributions (e.g. Debian repository build
machines, ChromeOS build machines) where it may not be possible to
upgrade the system kernel headers.

Please could we get some #ifdefs on MMC_IOC_MULTI_CMD around the
=46FU code?

Thanks!

- Chris.
--=20
Chris Ball   <http://printf.net/>
