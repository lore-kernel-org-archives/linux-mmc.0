From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: kernel BUG at drivers/mmc/core/sdio_io.c:28!
Date: Wed, 27 Oct 2010 16:05:06 +0200
Message-ID: <AANLkTimvER2Qjpphj+io-qh9mRfDQJ1=goARH3zDLpeJ@mail.gmail.com>
References: <652BFE86-3BFE-4E21-88BA-004CA7140D18@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41287 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab0J0OF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 10:05:28 -0400
In-Reply-To: <652BFE86-3BFE-4E21-88BA-004CA7140D18@mac.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benzy Gabay <benzyg@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, Vishal Mahaveer <vishalm@ti.com>, linux-mmc@vger.kernel.org

Hi Elvis,

On Wed, Oct 27, 2010 at 3:24 PM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
> root@beagleboard:/wlan# insmod sdio.ko
=2E..
> root@beagleboard:/wlan# insmod tiwlan_drv.ko
=2E..
> root@beagleboard:/wlan# ifconfig tiwlan0 up
> [ =A0200.916687] TIWLAN: 2227.094325: pInitParams->RoamingScanning_2_=
4G_enable 0
> [ =A0200.924530] dashboard20_wifi_power: 1
> [ =A0200.943267] dashboard20_wifi_power: 0
> [ =A0200.947937] dashboard20_wifi_power: 1
> [ =A0201.020507] dashboard20_wifi_reset: 0
> [ =A0201.024200] dashboard20_wifi_set_carddetect: 1
> [ =A0201.029113] dashboard20_wifi_set_carddetect: Nobody to notify
> [ =A0202.027465] tiwlan_sdio_probe not yet called
> [ =A0202.031768] tiwlan_sdio_probe not yet called    <---------------=
------------------------------
> [ =A0202.036590] kernel BUG at drivers/mmc/core/sdio_io.c:28!
> [ =A0202.041961] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000


The BUG is most probably in the driver you are using, and not in the SD=
IO layer.

The driver is calling sdio_claim_host() without having a valid SDIO fun=
ction.

Check out the 2 lines above the BUG message - you have a log there
complaining that your SDIO driver's probe function wasn't called.

You actually seem to have two problems here:
1. Your SDIO driver's probe function isn't called
2. Your WLAN driver is using the SDIO API without having a valid SDIO f=
unction

Ignoring the 2nd issue for now, you most probably have an integration
problem.  Is the chip powered up correctly ? is it mmc rescanned after
it is powered up ? are you using the correct mmc controller ? have you
configured your mmc lines correctly (board muxing) ? etc..

Maybe you want to checkout the mainline wl1271 driver using Luca's
Beagle board patches :)

Regards,
Ohad.
