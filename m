From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Wed, 8 Dec 2010 22:17:29 +0200
Message-ID: <AANLkTinSLx6Zk-5orwxb_=f_pinLzc83-i8NmJ7u8KiR@mail.gmail.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
 <AANLkTi=2gcr_5uSQtu+5_35xG4ZhsLRCwWCW+Me-QSLb@mail.gmail.com>
 <AANLkTim3mt=Xcqw1d15bFJ78FM1kRHYAmvNp-=CoYLAW@mail.gmail.com> <AANLkTikht-+K5GkAGeuO0xWB=k9hTX=FUvzA5apsDA6h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:47341 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab0LHURv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 15:17:51 -0500
Received: by iwn40 with SMTP id 40so2151407iwn.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Dec 2010 12:17:50 -0800 (PST)
In-Reply-To: <AANLkTikht-+K5GkAGeuO0xWB=k9hTX=FUvzA5apsDA6h@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, njun@marvell.com, binw@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@marvell.com>

On Wed, Dec 8, 2010 at 1:13 PM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> Thanks for suggestion, do you mean
> Not use rfkill totally

If you want rfkill functionality, you can still provide it of course,
but don't give it direct access to the hardware.

You should provide rfkill functionality from within your wlan driver,
and then when ->set_block() is called, you probably want to take down
the wlan interface. Essentially pm_runtime_put_sync should be called,
which will tell SDIO core to power down the chip.

>, which already integrated into bluetooth,
> /net/bluetooth/hci_core.c

Yes, and take a look what it does there - it closes the device - and
doesn't fiddle with gpios directly.

> Instead, SDIO core introduce new regulator domain "gpio" for example
> corresponding to gpio handling, =A0like "vmcc" corresponding to real
> voltage control.
> SDIO core call regulator_get/regulator_enable/regulator_disalbe("gpio=
"),
> to pull up and pull down gpio?

You should make sure that mmc_power_off/mmc_power_up will do whatever
needed to power off/on your card.

These functions will call into your host controller (via mmc_set_ios)
and eventually that should trigger your regulator appropriately.

>
> For how to open/close wifi, we used to use rfkill block/unblock wifi,
> which in fact to pull up/down the reset and power pin.
> Then how to open/close wifi in this method, using suspend & resume?

To power on/off your card, your driver will just need to call the
pm_runtime_get/put_* API (see wl1271_sdio_set_power() for reference).

>
> Thanks
>
