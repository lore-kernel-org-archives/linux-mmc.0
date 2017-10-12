From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: eMMC tuning issue on Odroid C2 and a possible solution
Date: Thu, 12 Oct 2017 23:04:50 +0200
Message-ID: <4c7bb23a-e072-1c5d-e74d-c4c222beec5b@gmail.com>
References: <b931985f-16b2-0a90-e73b-b6c349ad7d6c@gmail.com>
 <1507821759.16356.225.camel@baylibre.com>
 <aa13028e-b42a-094f-7bd1-ef22e8cdacbd@gmail.com>
 <1507836874.16356.258.camel@baylibre.com>
 <fa52e311-bafe-0a6a-1b85-ac8f40db62ed@gmail.com>
 <1507838745.16356.270.camel@baylibre.com>
 <08c2642a-06b2-f36b-80b1-3be82c346887@gmail.com>
 <1507841952.16356.285.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:56028 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdJLVE5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 17:04:57 -0400
Received: by mail-wm0-f45.google.com with SMTP id u138so16728716wmu.4
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 14:04:56 -0700 (PDT)
In-Reply-To: <1507841952.16356.285.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>

Am 12.10.2017 um 22:59 schrieb Jerome Brunet:
> On Thu, 2017-10-12 at 22:29 +0200, Heiner Kallweit wrote:
>> Am 12.10.2017 um 22:05 schrieb Jerome Brunet:
>>> On Thu, 2017-10-12 at 21:49 +0200, Heiner Kallweit wrote:
>>>>> The result of the tuning does not depends on starting point, so I don't
>>>>> really
>>>>> understand how it would significantly change things.
>>>>>
>>>>
>>>> I think it depends on the tx phase starting point.
>>>>
>>>
>>> If the result of the tuning is not independent of the starting, instead of
>>> just
>>> telling me, it is fairly easy for you to give actual result, like I asked
>>> you:
>>>
>>
>> With hs200@200 and tx phase starting point 0 I get the following with no
>> further CRC errors.
>>
>> [    0.726572] meson-gx-mmc d0074000.mmc: d0074000.mmc#rx phase/delay
>> tunning...
>> [    0.728664] hctosys: unable to open rtc device (rtc0)
>> [    0.728827] USB_OTG_PWR: disabling
>> [    0.728831] TFLASH_VDD: disabling
>> [    0.728833] TF_IO: disabling
>> [    0.753183] Waiting for root device /dev/mmcblk0p1...
>> [    0.754352] meson-gx-mmc d0074000.mmc: success with phase: 270
>> [    0.758386] meson-gx-mmc d0074000.mmc: d0074000.mmc#tx phase/delay
>> tunning...
>> [    0.768050] meson-gx-mmc d0074000.mmc: success with phase: 120
>> [    0.771235] meson-gx-mmc d0074000.mmc: d0074000.mmc#rx phase/delay
>> tunning...
>> [    0.780902] meson-gx-mmc d0074000.mmc: success with phase: 0
>> [    0.784036] mmc0: new HS200 MMC card at address 0001
>> [    0.789090] mmcblk0: mmc0:0001 DJNB4R 116 GiB
>> [    0.793328] mmcblk0boot0: mmc0:0001 DJNB4R partition 1 4.00 MiB
>> [    0.799198] mmcblk0boot1: mmc0:0001 DJNB4R partition 2 4.00 MiB
>> [    0.805048] mmcblk0rpmb: mmc0:0001 DJNB4R partition 3 4.00 MiB, chardev
>> (249:0)
>> [    0.812799] mmcblk0: response CRC error sending r/w cmd command, card
>> status 0x900
>> [    0.819727] meson-gx-mmc d0074000.mmc: d0074000.mmc#tx phase/delay
>> tunning...
>> [    0.827007] meson-gx-mmc d0074000.mmc: success with phase: 210
>> [    0.832559] meson-gx-mmc d0074000.mmc: d0074000.mmc#rx phase/delay
>> tunning...
>> [    0.839848] meson-gx-mmc d0074000.mmc: success with phase: 0
>>
>>
>>>>> Ok, starting from Rx:0 Tx:270 then tuning gives you Tx:300 Rx:90
>>>>> And what different did it gives you starting Rx:0/Tx:0 ?
>>>
>>> And if the result are indeed vastly different, let's debug and get a real
>>> explanation.
>>>
>>>> Tuning does:
>>>> rx phase tuning
>>>> tx phase tuning
>>>> rx phase tuning
>>>>
>>>> Result of each step depends on result of previous step.
>>>
>>> Again, we don't agree. 
>>>
>>>> So also the initial
>>>> rx phase tuning result depends on the starting point of tx phase.
>>>
>>> The first Rx tuning is there only to get a sane starting point for the tx
>>> tuning
>>> ,as explained in the code. This is the reason why is not done when re-
>>> tuning.
>>>
> 
> Heiner, This is the same story again and again !
> Getting clear status is just really painful. It's like half the message is
> ignored each time. 
> 
> I can clearly see that, this result comes from your hack, and this hack makes no
> sense. I don't care about this result. This is not what I asked.
> 
No, the log provided is w/o my hack. The debugfs values just represent the current
values, interesting is how they change from tuning step to tuning step.

> What I asked is:
> 1) From linux-next what is tuning result in hs200@200Mhz with the starting :
> * Rx:0/Tx:270/Core:180 (current setting)
> * Rx:0/Tx:0/Core:180 (the setting you keep on mentioning)
> 
> Please don't send your logs: the phase set are displayed in
> debugfs/clk?clk_summary
> 
> 2) Try to come up with a real explanation: "It just happens ..." is not an
> explanation. 
> 
>>>
>>>
>>
>>
> 
> 

