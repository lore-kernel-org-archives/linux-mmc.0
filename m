From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/3] mfd: Add realtek USB card reader driver
Date: Mon, 10 Feb 2014 11:30:54 +0000
Message-ID: <20140210113054.GE21522@lee--X1>
References: <1391697307-23457-1-git-send-email-rogerable@realtek.com>
 <1391697307-23457-2-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44546 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbaBJLbB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2014 06:31:01 -0500
Received: by mail-wi0-f179.google.com with SMTP id hn9so2682173wib.6
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2014 03:30:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391697307-23457-2-git-send-email-rogerable@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: rogerable@realtek.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

> From: Roger Tseng <rogerable@realtek.com>
>=20
> Realtek USB card reader provides a channel to transfer command or dat=
a to flash
> memory cards. This driver exports host instances for mmc and memstick=
 subsystems
> and handles basic works.
>=20
> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> ---
>  drivers/mfd/Kconfig          |  10 +
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/rtsx_usb.c       | 760 +++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/rtsx_usb.h | 628 +++++++++++++++++++++++++++++++++=
++
>  4 files changed, 1399 insertions(+)
>  create mode 100644 drivers/mfd/rtsx_usb.c
>  create mode 100644 include/linux/mfd/rtsx_usb.h

Applied with Greg's Ack.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
