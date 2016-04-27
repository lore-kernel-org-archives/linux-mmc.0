From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: support for fixed 1.8V eMMC interface
Date: Wed, 27 Apr 2016 14:46:45 +0200
Message-ID: <CAPDyKFqzrH5DRJKJKy5k2+_CfDdg-mpjdsv7+PwRcuQE5dBfJA@mail.gmail.com>
References: <VI1PR05MB15338BD748ACE3938D3E4B339B640@VI1PR05MB1533.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36842 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbcD0Mqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 08:46:47 -0400
Received: by mail-wm0-f41.google.com with SMTP id n129so25723917wmn.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2016 05:46:47 -0700 (PDT)
In-Reply-To: <VI1PR05MB15338BD748ACE3938D3E4B339B640@VI1PR05MB1533.eurprd05.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Raul Benet <Raul.Benet@lightblueoptics.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 27 April 2016 at 13:44, Raul Benet <Raul.Benet@lightblueoptics.com> wrote:
> Hi,
>
> I am currently working on a design using i.MX6SL and Linux Kernel 3.14.52. Though I believe may question still applies to latest MMC code.
> Our design uses an eMMC as boot device and main storage (ie: it contains u-boot, kernel, dtb and rootfs).
>
> The eMMC I/O rail is fixed in hardware to 1.8Volts.
> The Processor SDIO I/O rail is controlled by the MMC driver.
>
> In 3.14.52, the MMC driver sets processor SDIO rail to 3v3 per default, and only when using HS DDR modes (which do not apply in our case) would it set it to 1.8V.
>
> I have seen that starting on 3.16, the function power_up() in drivers/mmc/core/core.c attempts at setting the regulator to 3v3, failing that it tries 1v8, failing that it tries 1v2.
>
> So I patched my kernel with that, and defined a fixed regulator with 1v8 in my dts, and set the vqmmc-supply to point to it.

That's great and exactly how you should do it!

> But that doesn't work, because power_up() ultimately tries to call set_voltage() on the vqmmc regulator, which doesn't seem to exist for "regulator-fixed" type of regulators, and hence it fails in setting all the rails, which ultimately means that it sets it to 3v3 ('cause that is the default/initial value of the field in the ios struct)

So mmc_power_up() invokes the mmc host ops
->start_signal_voltage_switch(). That doesn't use the vqmmc regulator
directly, as it is host dependent on how to deal with regulators.

>
> So my question is: how am I supposed to setup the MMC driver in my scenario (I/O at 1.8V always) ?
> (I know I can go and force the rail to 1.8V by hacking drivers/mmc/host/sdhci-esdhc-imx.c, but I would very much prefer to avoid that)

I think there are two options.

1. Make drivers/mmc/host/sdhci-esdhc-imx.c to check what voltages are
requested from the mmc core and deal with that depending on what the
regulator support.
2. Change the regulator API to accept that it can set a voltage on a
fixed regulator. Of course returning error if the voltage isn't
supported.

Kind regards
Uffe
