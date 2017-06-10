From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: work around broken SDIO with certain WiFi
 chips
Date: Sat, 10 Jun 2017 13:34:05 +0200
Message-ID: <e0844236-ba11-3256-c388-ce2405c3b7b8@gmail.com>
References: <dd12ffc8-e2a4-53bd-caa5-83bb7cbcd5e5@gmail.com>
 <CAFBinCDUNCgwm9YS9w8uQ6i1MX4SR1ZHf-mn8UnObnejjZiQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33023 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdFJLgx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Jun 2017 07:36:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so11846559wrb.0
        for <linux-mmc@vger.kernel.org>; Sat, 10 Jun 2017 04:36:52 -0700 (PDT)
In-Reply-To: <CAFBinCDUNCgwm9YS9w8uQ6i1MX4SR1ZHf-mn8UnObnejjZiQOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Am 10.06.2017 um 00:06 schrieb Martin Blumenstingl:
> Hi Heiner,
> 
> thanks for finding a solution (it didn't even take you long)!
> 
> On Thu, Jun 8, 2017 at 8:43 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> There have been reports about SDIO failing with certain WiFi chips in
>> descriptor chain mode. SD / eMMC are working fine.
>>
>> So let's fall back to bounce buffer mode for command SD_IO_RW_EXTENDED.
>> This was reported to fix this error.
>>
>> Fixes: 79ed05e329c3 "mmc: meson-gx: add support for descriptor chain mode"
>> Cc: <stable@vger.kernel.org> # 4.12.x
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 1842ed34..4cdbe3c0 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -210,6 +210,15 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>         int i;
>>         bool use_desc_chain_mode = true;
>>
>> +       /*
>> +        * Broken SDIO with AP6335-based WiFi on Khadas VIM Pro has been
> nit-pick: Khadas VIM Pro uses an Ampak AP6255 (not AP6335)
> 
Uups, I obviously mixed up the device with one of the S905-based tv boxes.
Will fix it.

>> +        * reported. For some strange reason this occurs in descriptor
>> +        * chain mode only. So let's fall back to bounce buffer mode
>> +        * for command SD_IO_RW_EXTENDED.
>> +        */
>> +       if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
>> +               return;
>> +
>>         for_each_sg(data->sg, sg, data->sg_len, i)
>>                 /* check for 8 byte alignment */
>>                 if (sg->offset & 7) {
>> --
>> 2.13.0
>>
> for the record: wireless performance with this patch applied is excellent
> 
Just curious:
Do you also experience the lagging mentioned by crow?

> # iperf3 --client <server ip>
> Connecting to host <server ip>, port 5201
> [  4] local <khadas vim ip> port 38352 connected to <server ip> port 5201
> [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
> [  4]   0.00-1.00   sec  8.19 MBytes  68.7 Mbits/sec    0    349 KBytes
> [  4]   1.00-2.00   sec  8.56 MBytes  71.8 Mbits/sec    1    287 KBytes
> [  4]   2.00-3.00   sec  8.89 MBytes  74.6 Mbits/sec    0    315 KBytes
> [  4]   3.00-4.00   sec  8.59 MBytes  72.1 Mbits/sec    0    344 KBytes
> [  4]   4.00-5.00   sec  9.11 MBytes  76.5 Mbits/sec    0    355 KBytes
> [  4]   5.00-6.00   sec  8.92 MBytes  74.8 Mbits/sec    0    356 KBytes
> [  4]   6.00-7.00   sec  8.75 MBytes  73.4 Mbits/sec    0    356 KBytes
> [  4]   7.00-8.00   sec  8.79 MBytes  73.7 Mbits/sec    0    356 KBytes
> [  4]   8.00-9.00   sec  8.64 MBytes  72.5 Mbits/sec    0    359 KBytes
> [  4]   9.00-10.00  sec  8.98 MBytes  75.3 Mbits/sec    0    366 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bandwidth       Retr
> [  4]   0.00-10.00  sec  87.4 MBytes  73.3 Mbits/sec    1             sender
> [  4]   0.00-10.00  sec  87.0 MBytes  73.0 Mbits/sec                  receiver
> 
> iperf Done.
> # iperf3 --client <server ip> -R
> Connecting to host <server ip>, port 5201
> Reverse mode, remote host <server ip> is sending
> [  4] local <khadas vim ip> port 38356 connected to <server ip> port 5201
> [ ID] Interval           Transfer     Bandwidth
> [  4]   0.00-1.00   sec  2.04 MBytes  17.1 Mbits/sec
> [  4]   1.00-2.00   sec  2.17 MBytes  18.2 Mbits/sec
> [  4]   2.00-3.00   sec  3.85 MBytes  32.3 Mbits/sec
> [  4]   3.00-4.00   sec  7.60 MBytes  63.8 Mbits/sec
> [  4]   4.00-5.00   sec  6.90 MBytes  57.9 Mbits/sec
> [  4]   5.00-6.00   sec  6.46 MBytes  54.2 Mbits/sec
> [  4]   6.00-7.00   sec  7.49 MBytes  62.9 Mbits/sec
> [  4]   7.00-8.00   sec  7.11 MBytes  59.7 Mbits/sec
> [  4]   8.00-9.00   sec  6.58 MBytes  55.2 Mbits/sec
> [  4]   9.00-10.00  sec  6.83 MBytes  57.3 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bandwidth       Retr
> [  4]   0.00-10.00  sec  58.8 MBytes  49.3 Mbits/sec   30             sender
> [  4]   0.00-10.00  sec  57.4 MBytes  48.2 Mbits/sec                  receiver
> 
> iperf Done.
> 

