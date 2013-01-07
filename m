From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: FW: SD card reader stopped working in kernel 3.6:
 CONFIG_REGULATOR troubles (solved)
Date: Mon, 7 Jan 2013 00:57:06 -0500
Message-ID: <CADz5_gLHusqpoKGYzu7uXLsGM9KeXX7bmj2V-YXVu=hGMxSfCg@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B026B6EC@SC-VEXCH1.marvell.com>
	<CADz5_gK-=66A3L5LBDr094j0SKDzA1QMkynf0yx90Y9TsNiWJw@mail.gmail.com>
	<1070431758.905763.1357514941888.JavaMail.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:39686 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab3AGF5I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 00:57:08 -0500
Received: by mail-we0-f181.google.com with SMTP id t11so9471187wey.40
        for <linux-mmc@vger.kernel.org>; Sun, 06 Jan 2013 21:57:06 -0800 (PST)
In-Reply-To: <1070431758.905763.1357514941888.JavaMail.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ich@rainer-kaluscha.de" <ich@rainer-kaluscha.de>
Cc: Rainer Kaluscha <rainer.kaluscha@web.de>, linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

2013/1/7 ich@rainer-kaluscha.de <ich@rainer-kaluscha.de>:
> Thanx for the quick reply.
>
> The patch doesn't change anything. However, I've done some research and I'm
> now pretty sure that the trouble came from the dummy regulator.
>
> My kernel config is based on OpenSuse's defaults which is to set
> CONFIG_REGULATOR and CONFIG_REGULATOR_DUMMY. That worked fine until kernel
> 3.5.
>
> With kernels 3.6 and 3.7, as no real regulator could be found, the dummy has
> been used which probably denies any voltage settings (compare the following
> extract from /var/log/messages):
>
>  sdhci-pci 0000:0e:06.1: SDHCI controller found [1180:0822] (rev 22)
>  sdhci-pci 0000:0e:06.1: Will use DMA mode even though HW doesn't fully
> claim to support it.
>  0000:0e:06.1 supply vqmmc not found, using dummy regulator
>  0000:0e:06.1 supply vmmc not found, using dummy regulator
>  mmc0: Hardware doesn't report any support voltages.
>
>
> Disabling CONFIG_REGULATOR (or CONFIG_REGULATOR_DUMMY) resolved the issue
> with kernels 3.6 and 3.7:
>
>  sdhci-pci 0000:0e:06.1: SDHCI controller found [1180:0822] (rev 22)
>  sdhci-pci 0000:0e:06.1: Will use DMA mode even though HW doesn't fully
> claim to support it.
>  Registered led device: mmc0::
>  mmc0: SDHCI controller on PCI [0000:0e:06.1] using DMA
>  sdhci-pci 0000:0e:06.2: SDHCI controller found [1180:0843] (rev 12)
>  Registered led device: mmc1::
>  mmc1: SDHCI controller on PCI [0000:0e:06.2] using DMA
>
>
> Enabling CONFIG_REGULATOR and any others REGULATOR options except for the
> dummy (e.g. CONFIG_REGULATOR_MAX8649 which is not present on my laptop) also
> works:
>
>  sdhci-pci 0000:0e:06.1: SDHCI controller found [1180:0822] (rev 22)
>  sdhci-pci 0000:0e:06.1: Will use DMA mode even though HW doesn't fully
> claim to support it.
>  mmc0: no vqmmc regulator found
>  mmc0: no vmmc regulator found
>  sdhci-pci 0000:0e:06.1: Will use DMA mode even though HW doesn't fully
> claim to support it.
>  Registered led device: mmc0::
>  mmc0: SDHCI controller on PCI [0000:0e:06.1] using DMA
>
>
> It's also possible to set only CONFIG_REGULATOR, but none of the other
> REGULATOR options in the kernel config (works also).
>
> However, be careful when setting CONFIG_REGULATOR_DUMMY.
>
> Thanx again and sorry for any inconvenience,
>
> Rainer
>
>

I remembered Marek ever met the same issue and try to fix it with
regulator_can_change_voltage/regulator_count_voltages.
But I think only the dummy case should be special. The fixed regulator
is ok and can be checked.
So I just sent out a patch to introduce the function
regulator_is_dummy in regulator/core.c and another patch to fix this
issue in sdhci.c
Added Marek and Mark.

Thanks
Kevin

> Kevin Liu <keyuan.liu@gmail.com> hat am 6. Januar 2013 um 02:19 geschrieben:
>> > -----Original Message-----
>> > From: linux-mmc-owner@vger.kernel.org
>> > [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Rainer Kaluscha
>> > Sent: Sunday, January 06, 2013 12:20 AM
>> > To: linux-mmc@vger.kernel.org
>> > Subject: SD card reader stopped working in kernel 3.6: CONFIG_REGULATOR
>> > troubles (solved)
>> >
>> > My SD card reader which worked fine with kernel 3.5 stopped working with
>> > kernel
>> > 3.6 and 3.7. It is a "SD Host controller: Ricoh Co Ltd R5C822
>> > SD/SDIO/MMC/MS/MSPro Host Adapter (rev 22)", PCI-ID 0e:06.1
>> >
>> > I finally noticed messages like "mmc0: Hardware doesn't report any
>> > support
>> > voltages." so I tried disabling CONFIG_REGULATOR in kernel config which
>> > solved
>> > the issue.
>> >
>> > Maybe this is also of interest to others. Feel free to contact me if you
>> > need
>> > more details.
>> >
>> >
>>
>> Can you try below patch? or you can try with latest 3.8 kernel which
>> has integrated the patch.
>>
>> From cec2e216f72c6b5ccdadb60aadbe99821d744503 Mon Sep 17 00:00:00 2001
>> From: Kevin Liu <kliu5@marvell.com>
>> Date: Tue, 20 Nov 2012 08:24:32 -0500
>> Subject: [PATCH] mmc: sdhci: Use regulator min/max voltage range according
>> to
>> spec
>>
>> For regulator vmmc/vmmcq, use voltage range as below
>> 3.3v/3.0v: (2.7v, 3.6v)
>> 1.8v: (1.7v, 1.95v)
>> Original code uses the precise value which may fail in regulator
>> driver if it does NOT support the precise voltage.
>>
>> Signed-off-by: Jialing Fu <jlfu@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>> drivers/mmc/host/sdhci.c | 18 ++++++++----------
>> 1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2f62fe4..ec3e984 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1618,7 +1618,7 @@ static int
>> sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
>> sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> if (host->vqmmc) {
>> - ret = regulator_set_voltage(host->vqmmc, 3300000, 3300000);
>> + ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);
>> if (ret) {
>> pr_warning("%s: Switching to 3.3V signalling voltage "
>> " failed\n", mmc_hostname(host->mmc));
>> @@ -1662,7 +1662,7 @@ static int
>> sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
>> */
>> if (host->vqmmc)
>> ret = regulator_set_voltage(host->vqmmc,
>> - 1800000, 1800000);
>> + 1700000, 1950000);
>> else
>> ret = 0;
>>
>> @@ -2860,8 +2860,8 @@ int sdhci_add_host(struct sdhci_host *host)
>> }
>> } else {
>> regulator_enable(host->vqmmc);
>> - if (!regulator_is_supported_voltage(host->vqmmc, 1800000,
>> - 1800000))
>> + if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
>> + 1950000))
>> caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
>> SDHCI_SUPPORT_SDR50 |
>> SDHCI_SUPPORT_DDR50);
>> @@ -2925,16 +2925,14 @@ int sdhci_add_host(struct sdhci_host *host)
>>
>> #ifdef CONFIG_REGULATOR
>> if (host->vmmc) {
>> - ret = regulator_is_supported_voltage(host->vmmc, 3300000,
>> - 3300000);
>> + ret = regulator_is_supported_voltage(host->vmmc, 2700000,
>> + 3600000);
>> if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
>> caps[0] &= ~SDHCI_CAN_VDD_330;
>> - ret = regulator_is_supported_voltage(host->vmmc, 3000000,
>> - 3000000);
>> if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
>> caps[0] &= ~SDHCI_CAN_VDD_300;
>> - ret = regulator_is_supported_voltage(host->vmmc, 1800000,
>> - 1800000);
>> + ret = regulator_is_supported_voltage(host->vmmc, 1700000,
>> + 1950000);
>> if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
>> caps[0] &= ~SDHCI_CAN_VDD_180;
>> }
>> --
>> 1.7.9.5
>>
>> Thanks
>> Kevin
