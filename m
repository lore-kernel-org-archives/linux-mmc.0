From: Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Thu, 26 Jul 2018 12:39:52 -0400
Message-ID: <12ae1da9-cd09-b15d-9a81-461ca9cc06d7@gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
 <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
 <1553c44e99b96a813af129d1c4169222@agner.ch>
 <553f9ed6-8f7c-775b-d731-fd9732f74b07@gmail.com>
 <7edc8c666dbbc0743221c86286ff583a@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7edc8c666dbbc0743221c86286ff583a@agner.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>>>> I finally got around to testing this on the Ouya (Tegra 3).
>>>
>>> Thanks for testing!
>>>
>>>>
>>>> I found that the "Got command interrupt 0x00010000 even though no
>>>> command operation was in progress." error occurred when the interface
>>>> is unstable.
>>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
>>>> Mhz, probably due to the fact that they are using the internal cmd and
>>>> clock pull-up resistors, against the TRM's instruction.
>>>> At 39Mhz, I saw the error this patch corrects.
>>>> With the patch, the error went away, but the interface is still
>>>> unstable under load.
>>>
>>> How does this instability manifest exactly?
>>>
>>
>> At the very edge of stability, you see write errors under heavy load.
>> As clock rate increases, the write errors occur more frequently.
>> At a certain point, you start getting read errors.
>> Following that you get constant io errors during card probing.
>> Eventually the emmc will fail to initialize, with errors 87 or 110.
> 
> What mode are you running at actually? E.g. what is the ios file saying?
> cat /sys/kernel/debug/mmcX/ios

This is the best functionality I've been able to get prior to the patches:
root@ouya:~# cat /sys/kernel/debug/mmc0/ios
clock:          30000000 Hz
actual clock:   29142858 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

Now I am trying DDR, but even with the patches I'm not able to remain 
stable above 17Mhz (34Mhz clock).

I've also tried just straight mmc-hs mode, but even that makes no 
difference.

> 
>>
>> I've been tweaking the pull up/down values to try and improve the
>> stability, but without access to anything but the TRM it's a lot of
>> trial and error.
>>
> 
> Hm, maybe Marcel's recent fixes in our device tree are helpful?
> https://lkml.org/lkml/2018/7/22/165
> 
> Also make sure to have a complete pinmux such that alternative pins for
> sdmmc4 are *not* muxed as sdmmc4.

That was my first issue, which was preventing sdmmc4 from working at all.
Just double checked all of the spare function pins, they are all 
assigned elsewhere.

> 
>>>>
>>>> Lowering down to 32Mhz, without the patch there are no errors.
>>>
>>> So the patch does not make it less stable right?
>>>
>>
>> No, it did not affect stability.
>> Although I'd conduct some performance testing to check for degradation.
>> Of course I'm nowhere near the limits of the controller, so it is
>> doubtful I'd see a hit.
> 
> Ok, and this is with the complete patchset applied correct?
> 
> Btw, what device tree are you using? Ouya is not upstream as far as I
> can tell?

Indeed, I have the full patchset.

Ouya is an old android game console that I've been working on getting 
mainline working on.
I've written most of the device tree, with contributions from Matt Merhar.
It's almost bit for bit a cardhu dev board, but with everything not 
necessary to function removed.
They cut a lot of corners with the board design.
Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it 
reported it was running mode 5.

To get this speed, I have the pins all driven down at 4, and up at 24.
Default is 2 down and 18 up from driver init.
The pin pull ups are exactly as the original kernel, all pins pulled up 
except reset, which is pulled down.

> 
> --
> Stefan
> 
>>
>>> --
>>> Stefan
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
