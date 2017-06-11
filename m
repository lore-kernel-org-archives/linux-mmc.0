From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] mmc: meson-gx: work around broken SDIO with certain WiFi chips
Date: Sun, 11 Jun 2017 22:31:54 +0200
Message-ID: <CAFBinCBOS7mDja3EdfNViCqzuk_=ur0bQOG+6ZeL-xFQZM7+Ug@mail.gmail.com>
References: <dd12ffc8-e2a4-53bd-caa5-83bb7cbcd5e5@gmail.com>
 <CAFBinCDUNCgwm9YS9w8uQ6i1MX4SR1ZHf-mn8UnObnejjZiQOw@mail.gmail.com> <e0844236-ba11-3256-c388-ce2405c3b7b8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34412 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdFKUcQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Jun 2017 16:32:16 -0400
Received: by mail-wr0-f173.google.com with SMTP id g76so76900190wrd.1
        for <linux-mmc@vger.kernel.org>; Sun, 11 Jun 2017 13:32:16 -0700 (PDT)
In-Reply-To: <e0844236-ba11-3256-c388-ce2405c3b7b8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Jun 10, 2017 at 1:34 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Am 10.06.2017 um 00:06 schrieb Martin Blumenstingl:
>> Hi Heiner,
>>
>> thanks for finding a solution (it didn't even take you long)!
>>
>> On Thu, Jun 8, 2017 at 8:43 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> There have been reports about SDIO failing with certain WiFi chips in
>>> descriptor chain mode. SD / eMMC are working fine.
>>>
>>> So let's fall back to bounce buffer mode for command SD_IO_RW_EXTENDED.
>>> This was reported to fix this error.
>>>
>>> Fixes: 79ed05e329c3 "mmc: meson-gx: add support for descriptor chain mode"
>>> Cc: <stable@vger.kernel.org> # 4.12.x
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 1842ed34..4cdbe3c0 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -210,6 +210,15 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>>         int i;
>>>         bool use_desc_chain_mode = true;
>>>
>>> +       /*
>>> +        * Broken SDIO with AP6335-based WiFi on Khadas VIM Pro has been
>> nit-pick: Khadas VIM Pro uses an Ampak AP6255 (not AP6335)
>>
> Uups, I obviously mixed up the device with one of the S905-based tv boxes.
> Will fix it.
>
>>> +        * reported. For some strange reason this occurs in descriptor
>>> +        * chain mode only. So let's fall back to bounce buffer mode
>>> +        * for command SD_IO_RW_EXTENDED.
>>> +        */
>>> +       if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
>>> +               return;
>>> +
>>>         for_each_sg(data->sg, sg, data->sg_len, i)
>>>                 /* check for 8 byte alignment */
>>>                 if (sg->offset & 7) {
>>> --
>>> 2.13.0
>>>
>> for the record: wireless performance with this patch applied is excellent
>>
> Just curious:
> Do you also experience the lagging mentioned by crow?
I just made a quick ping test:

Khadas VIM Pro (AP6255, directly connected to my 802.11ac wifi AP):
30 packets transmitted, 30 received, 0% packet loss, time 29057ms
rtt min/avg/max/mdev = 2.263/13.614/20.336/4.583 ms

on my workstation (connected via ethernet to a router running LEDE,
which is also connected via wifi to my 802.11ac wifi AP):
30 packets transmitted, 30 received, 0% packet loss, time 29040ms
rtt min/avg/max/mdev = 1.040/1.405/5.977/0.862 ms

(distance between my Khadas VIM Pro and my AP vs the router running
LEDE vs my AP is roughly the same, less than 50cm difference in
distance, no additional walls etc.)

so the delay is definitely "higher" than with other devices, but an
average pin time of ~14ms still doesn't seem to cause any lags for me
