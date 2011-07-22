From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: mmc: sdio add regulator vsdio
Date: Fri, 22 Jul 2011 11:14:23 +0800
Message-ID: <CAMj5BkiYyQ5aEEn+T5d0zVrNZheFSaBaxwqu_MraKchdEG+ORw@mail.gmail.com>
References: <546AA1AA-99EE-45E4-A322-6E34C7EBF63F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38992 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab1GVDOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2011 23:14:24 -0400
Received: by qyk29 with SMTP id 29so3609578qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2011 20:14:23 -0700 (PDT)
In-Reply-To: <546AA1AA-99EE-45E4-A322-6E34C7EBF63F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, Bing Zhao <bzhao@marvell.com>, Frank Huang <frankh@marvell.com>

>>diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>index 790f959..61fff10 100644
>>--- a/drivers/mmc/host/sdhci.c
>>+++ b/drivers/mmc/host/sdhci.c
>>@@ -1295,6 +1295,18 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
>>
>> =A0 =A0 =A0 sdhci_set_clock(host, ios->clock);
>>
>>+ =A0 =A0 =A0if (host->vsdio) {
>
> Why does this code need to be specific to sdio ? =A0Should be general=
ized.

sdio device, like bt/wlan have the requirement to dynamically control p=
ower.
Also the runtime_pm introduced to mmc core by Ohad, is specifically for=
 sdio.
=46or mmc/sd, still not consider to dynamically control power, there
already regulator vmmc to control power.
The requirement for sdio device is more complicated, for example
during suspend, sdio device may require continue power on.

>
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ios->power_mode !=3D host->power_mod=
e_old) {
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ios->power_mode =3D=3D=
 MMC_POWER_OFF)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulato=
r_disable(host->vsdio);
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ios->power_mode =3D=3D=
 MMC_POWER_UP)
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulato=
r_enable(host->vsdio);
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>+
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0host->power_mode_old =3D ios->power_mode=
;
>
> move up inside if since if not change no need to set.
>
> if the regulator is shared between different devices will this work ?

What do you mean different devices.
It is considered for different sdio client devices, not consider mmc/sd=
=2E

>
>>+ =A0 =A0 =A0}
>>+
>> =A0 =A0 =A0 if (ios->power_mode =3D=3D MMC_POWER_OFF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_power(host, -1);
>> =A0 =A0 =A0 else
>>@@ -2751,6 +2763,13 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(host->vmmc);
>> =A0 =A0 =A0 }
>>
>>+ =A0 =A0 =A0host->vsdio =3D regulator_get(mmc_dev(mmc), "vsdio");
>
> comment on name -- should have nothing to do with sdio.
>
