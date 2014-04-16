From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 4/4] memstick: Add realtek USB memstick host driver
Date: Wed, 16 Apr 2014 09:13:52 +0100
Message-ID: <20140416081352.GA4754@lee--X1>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
 <1397199203-2235-5-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:45067 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaDPIN6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Apr 2014 04:13:58 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so10366890wes.21
        for <linux-mmc@vger.kernel.org>; Wed, 16 Apr 2014 01:13:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397199203-2235-5-git-send-email-rogerable@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, rogerable@realtek.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Oliver Neukum <oneukum@suse.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

Hi Andrew,

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

It seems Max and Alex are less than interested in this patch, so I'm
going to apply it anyway. In your last review you mentioned that it
looked good to your inexpert eye. Can I apply your Ack to that effect?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
