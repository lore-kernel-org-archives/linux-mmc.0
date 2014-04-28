From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 4/4] memstick: Add realtek USB memstick host driver
Date: Mon, 28 Apr 2014 11:10:10 +0100
Message-ID: <20140428101010.GR6264@lee--X1>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
 <1397199203-2235-5-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:61977 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbaD1KKS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 06:10:18 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so5375639wiv.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2014 03:10:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397199203-2235-5-git-send-email-rogerable@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: rogerable@realtek.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Oliver Neukum <oneukum@suse.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

> From: Roger Tseng <rogerable@realtek.com>
>=20
> Realtek USB memstick host driver provides memstick host support based=
 on the
> Realtek USB card reader MFD driver.
>=20
> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> ---
>  drivers/memstick/host/Kconfig       |  10 +
>  drivers/memstick/host/Makefile      |   1 +
>  drivers/memstick/host/rtsx_usb_ms.c | 839 ++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 850 insertions(+)
>  create mode 100644 drivers/memstick/host/rtsx_usb_ms.c

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
