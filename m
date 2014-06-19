From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: MMC error on Exynos4210 board
Date: Thu, 19 Jun 2014 09:24:04 +0530
Message-ID: <CAK5sBcHqjmT7rcXLPkP3WHBdcphJjhm2aBfy4ksbXakNUfVYYw@mail.gmail.com>
References: <CAK5sBcEB5GnjiR37DXDAeKYBWKw_4NTDM=pKCVK=0oKFDBjSbw@mail.gmail.com>
	<CAD7vxxJrRd7nrhZBRWH=43r7AMopz1w30aMRHqMO9PvaZYOpHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34603 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaFSDyI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jun 2014 23:54:08 -0400
In-Reply-To: <CAD7vxxJrRd7nrhZBRWH=43r7AMopz1w30aMRHqMO9PvaZYOpHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Markus Mayer <markus.mayer@linaro.org>, Matt Porter <mporter@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

On Wed, Jun 18, 2014 at 7:41 PM, Tim Kryger <tim.kryger@gmail.com> wrote:
> On Wed, Jun 18, 2014 at 4:33 AM, Sachin Kamat <spk.linux@gmail.com> wrote:
>> Hi Tim,
>>
>> I see the below error on Exynos4210 based Origen board with linux-next
>> (20140618).
>> Reverting the below commit works fine.
>>
>> Commit: 8d02e775a6 "mmc: sdhci: Use mmc core regulator infrastucture"
>>
>> Any ideas?
>>
>> ***************
>>
>> -- [    2.068992] sdhci: Secure Digital Host Controller Interface driver
>> [    2.075059] sdhci: Copyright(c) Pierre Ossman
>> [    2.079762] of_get_named_gpiod_flags: can't parse gpios property of
>> node '/sdhci@12510000[0]'
>> [    2.088021] s3c-sdhci 12510000.sdhci: clock source 2: mmc_busclk.2
>> (50000000 Hz)
>> [    2.095322] of_get_named_gpiod_flags: can't parse gpios property of
>> node '/sdhci@12510000[0]'
>> [    2.103794] of_get_named_gpiod_flags: can't parse gpios property of
>> node '/sdhci@12510000[0]'
>> [    2.112478] s3c-sdhci 12510000.sdhci: No vqmmc regulator found
>> [    2.118117] mmc0: Hardware doesn't report any support voltages.
>> [    2.124004] s3c-sdhci 12510000.sdhci: sdhci_add_host() failed
>> [    2.130080] of_get_named_gpiod_flags: can't parse gpios property of
>> node '/sdhci@12530000[0]'
>> [    2.138352] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2
>> (16666667 Hz)
>> [    2.145661] of_get_named_gpiod_flags: can't parse gpios property of
>> node '/sdhci@12530000[0]'
>> [    2.154139] of_get_named_gpiod_flags: can't parse gpios property of
>> node '/sdhci@12530000[0]'
>> [    2.162834] s3c-sdhci 12530000.sdhci: No vqmmc regulator found
>> [    2.168464] mmc0: Hardware doesn't report any support voltages.
>> [    2.174349] s3c-sdhci 12530000.sdhci: sdhci_add_host() failed
>> [    2.180281] Synopsys Designware Multimedia Card Interface Driver
>> [    2.188131] usbcore: registered new interface driver usbhid
>> [    2.192287] usbhid: USB HID core driver
>> [    2.196329] TCP: cubic registered
>> [    2.199362] NET: Registered protocol family 17
>> [    2.203917] NET: Registered protocol family 15
>> [    2.208404] Registering SWP/SWPB emulation handler
>> [    2.214357] of_get_named_gpiod_flags exited with status 0
>> [    2.218430] of_get_named_gpiod_flags exited with status 0
>> [    2.223803] of_get_named_gpiod_flags exited with status 0
>> [    2.229170] of_get_named_gpiod_flags exited with status 0
>> [    2.234560] of_get_named_gpiod_flags exited with status 0
>> [    2.239953] gpio-229: gpiod_set_debounce: missing set() or
>> set_debounce() operations
>> [    2.247773] gpio-230: gpiod_set_debounce: missing set() or
>> set_debounce() operations
>> [    2.255473] gpio-228: gpiod_set_debounce: missing set() or
>> set_debounce() operations
>> [    2.263221] gpio-227: gpiod_set_debounce: missing set() or
>> set_debounce() operations
>> [    2.270918] gpio-226: gpiod_set_debounce: missing set() or
>> set_debounce() operations
>> [    2.278899] input: gpio_keys as /devices/gpio_keys/input/input0
>> [    2.285196] s3c-rtc 10070000.rtc: setting system clock to
>> 2000-01-01 00:00:00 UTC (946684800)
>> [    2.295072] VDD_G3D_1.1V: disabling
>> [    2.304744] VADC_3.3V: disabling
>> [    2.312095] VDD_AUD_1.8V: disabling
>> [    2.319714] VMIPI_1.1V: disabling
>> [    2.327193] VDD_ABB_3.3V: disabling
>> [    2.332779] VMEM_VDD_2.8V: disabling
>> [    2.336148] Waiting for root device /dev/mmcblk0p1...
>>
>> *************
>> Regards,
>> Sachin.
>
> Would you mind reverting just this part of the commit to see if it
> clears up your trouble?
>
>>         if (host->ocr_mask)
>> -               ocr_avail = host->ocr_mask;
>> +               ocr_avail &= host->ocr_mask;

Reverting this did not help. I still get the above error. My diff:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c23a87285a95..f4135094320d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3096,7 +3096,7 @@ int sdhci_add_host(struct sdhci_host *host)
                ocr_avail &= mmc->ocr_avail;

        if (host->ocr_mask)
-               ocr_avail &= host->ocr_mask;
+               ocr_avail = host->ocr_mask;

        mmc->ocr_avail = ocr_avail;
        mmc->ocr_avail_sdio = ocr_avail;

FYI, the board has a 2.8V fixed regulator supply connected to the MMC.
You may refer to arch/arm/boot/dts/exynos4210-origen.dts for more details.

-- 
Regards,
Sachin.
