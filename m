From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 16:42:32 +0200
Message-ID: <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42544 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab0JaOmx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 10:42:53 -0400
Received: by iwn10 with SMTP id 10so5937761iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 07:42:53 -0700 (PDT)
In-Reply-To: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Daniel,

On Sun, Oct 31, 2010 at 4:29 PM, Daniel Drake <dsd@laptop.org> wrote:
> I'm running linus master and can't load the libertas module for the
> sd8686 wifi hardware in the OLPC XO-1.5 laptop.
> Probe fails with -16.

That's why I asked you if this scenario works in the other thread.
It's probably the same issue (both scenarios try to power up the chip
by calling mmc_sdio_power_restore).

I guess the error comes from mmc_sdio_init_card() - can you please
check out what exactly triggers it inside that function (just put some
printk's there..) ?

Thanks!
Ohad.

>
> dmesg and config:
> http://dev.laptop.org/~dsd/20101031/dmesg-sdio-probe-fail.txt
> http://dev.laptop.org/~dsd/20101031/config-sdio-probe-fail.txt
>
> I've done some initial investigation; in sdio_bus_probe() we do this:
> =A0 =A0 =A0 =A0ret =3D pm_runtime_get_sync(dev);
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> and pm_runtime_get_sync() returns -16
>
> Daniel
>
