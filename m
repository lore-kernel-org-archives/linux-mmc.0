From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 1/1 v2] mmc_utils: add ffu support
Date: Fri, 26 Feb 2016 14:45:05 +0000
Message-ID: <86ziuncyz2.fsf@void.printf.net>
References: <SN1PR02MB13890B1700C4AE8F6FCD8C6C83A40@SN1PR02MB1389.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([192.34.86.38]:56915 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932066AbcBZOw3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Feb 2016 09:52:29 -0500
In-Reply-To: <SN1PR02MB13890B1700C4AE8F6FCD8C6C83A40@SN1PR02MB1389.namprd02.prod.outlook.com>
	(Avi Shchislowski's message of "Tue, 23 Feb 2016 11:27:44 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Yaniv Agman <Yaniv.Agman@sandisk.com>

Hi Avi,

On Tue, Feb 23 2016, Avi Shchislowski wrote:
> Adding support for field firmware update over multiple command ioctl.
> As multiple command ioctl is supported only from kernel 4.4, this pat=
ch should be used against kernel 4.4 and above.
>
> Known issues:
> - There is no support for Multiple Block write commands (CMD25) in ex=
isting=20
>    IOCTL implementation
> - In case MODE_OPERATION_CODES field is not supported by the device
>    manual reset of the device/platform is required.
>    The reset issue discussed in another email thread - " [RFC 0/6] mm=
c: Field Firmware Update"
>
> Change since v1:
> - modified copyright header
>
> Signed-off-by: Yaniv Agman <yaniv.agman@sandisk.com>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>

Thanks for resending.  I'm getting some compile errors, any ideas?

mmc_cmds.c: In function =E2=80=98do_ffu=E2=80=99:
mmc_cmds.c:2076:31: error: invalid application of =E2=80=98sizeof=E2=80=
=99 to incomplete type =E2=80=98struct mmc_ioc_multi_cmd=E2=80=99
  multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
                               ^

mmc_cmds.c:2126:11: error: dereferencing pointer to incomplete type =E2=
=80=98struct mmc_ioc_multi_cmd=E2=80=99
  multi_cmd->num_of_cmds =3D 3;
           ^

mmc_cmds.c:2162:23: error: =E2=80=98MMC_IOC_MULTI_CMD=E2=80=99 undeclar=
ed (first use in this function)
   ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
                       ^

- Chris.
--=20
Chris Ball   <http://printf.net/>
