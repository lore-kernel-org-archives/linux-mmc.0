From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: Add realtek USB card reader driver
Date: Mon, 17 Feb 2014 10:02:11 +0000
Message-ID: <20140217100211.GE17875@lee--X1>
References: <1392199238-14500-1-git-send-email-rogerable@realtek.com>
 <1392199238-14500-2-git-send-email-rogerable@realtek.com>
 <20140214094427.GA7380@lee--X1>
 <5301A786.8040607@realtek.com>
 <20140217082222.GA17875@lee--X1>
 <5301D369.5010100@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50702 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbaBQKCS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 05:02:18 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so1960381wgh.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Feb 2014 02:02:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5301D369.5010100@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger <rogerable@realtek.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

> >>>>From: Roger Tseng <rogerable@realtek.com>
> >>>>
> >>>>Realtek USB card reader provides a channel to transfer command or=
 data to flash
> >>>>memory cards. This driver exports host instances for mmc and mems=
tick subsystems
> >>>>and handles basic works.
> >>>>
> >>>>Signed-off-by: Roger Tseng <rogerable@realtek.com>
> >>>>---
> >>>>  drivers/mfd/Kconfig          |  10 +
> >>>>  drivers/mfd/Makefile         |   1 +
> >>>>  drivers/mfd/rtsx_usb.c       | 760 ++++++++++++++++++++++++++++=
+++++++++++++++
> >>>>  include/linux/mfd/rtsx_usb.h | 628 ++++++++++++++++++++++++++++=
+++++++
> >>>>  4 files changed, 1399 insertions(+)
> >>>>  create mode 100644 drivers/mfd/rtsx_usb.c
> >>>>  create mode 100644 include/linux/mfd/rtsx_usb.h
> >>>
> >>>Applied again, thanks.
> >>>
> >>Would you also apply patch 2/3 and 3/3 that to make the device full=
y
> >>operational for users? Or should they be applied by maintainers of
> >>mmc/memstick subsystems?
> >>
> >>Chris, would you give some comment?
> >
> >I can apply them, but I need the other Maintainer Acks.
> >
> >If they are build orthogonal i.e. there are no build dependencies
> >between them, it's probably better that they go into their associate=
d
> >trees separately.
> >
> I think it would be better to apply them together since the later
> patches really depend on the 1st one,so now we are waiting for Acks
> from mmc/memstick subsystems.

When you say "depend on", do you mean as a build depenency, or won't
run without the first patch applied?

> But there is no one specified for "memstick/host/" in MAINTAINERS.
> Could anyone else Ack this?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
