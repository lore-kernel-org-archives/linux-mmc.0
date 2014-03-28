From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add realtek USB card reader driver
Date: Fri, 28 Mar 2014 07:59:42 +0000
Message-ID: <20140328075942.GD17779@lee--X1>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
 <1395744293-24398-2-git-send-email-rogerable@realtek.com>
 <201403280231.s2S2VP8X017745@rtits1.realtek.com>
 <5334ED70.6050309@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:55819 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaC1H7s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Mar 2014 03:59:48 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so3376125wgh.24
        for <linux-mmc@vger.kernel.org>; Fri, 28 Mar 2014 00:59:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5334ED70.6050309@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger <rogerable@realtek.com>
Cc: Oliver Neukum <oneukum@suse.de>, Samuel Ortiz <sameo@linux.intel.com>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

[...]

> >>+static int rtsx_usb_suspend(struct usb_interface *intf, pm_message=
_t message)
> >>+{
> >>+	struct rtsx_ucr *ucr =3D
> >>+		(struct rtsx_ucr *)usb_get_intfdata(intf);
> >>+
> >>+	dev_dbg(&intf->dev, "%s called with pm message 0x%04u\n",
> >>+			__func__, message.event);
> >>+
> >>+	mutex_lock(&ucr->dev_mutex);
> >>+	rtsx_usb_turn_off_led(ucr);
> >
> >When is this turned on again?
> >
>=20
> The LED is not in a permanent cut-off state after here. It is called
> to guarantee the LED is off during suspend to save more power. It
> could be lit up in the card host drivers(e.g. rtsx_usb_sdmmc.c)
> anytime whenever necessary.
>=20
> This has been asked may times. I'm considering putting some comment
> in next revision.

Yes, please do.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
