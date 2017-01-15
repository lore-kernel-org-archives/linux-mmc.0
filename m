From: Hans de Goede <j.w.r.degoede@gmail.com>
Subject: Re: Support for various sdio wifi-chips on Allwinner tablets and SBCs
Date: Sun, 15 Jan 2017 11:51:13 +0100
Message-ID: <4cd65c95-94ad-749b-5a00-b91b77c344b2@gmail.com>
References: <5844eef2-71bd-bbb9-dff6-92e01a393b36@gmail.com>
 <4020591484402926@web44j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34465 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdAOKvQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 05:51:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so23160308wmi.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 02:51:16 -0800 (PST)
In-Reply-To: <4020591484402926@web44j.yandex.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.xyz>, linux-sunxi <linux-sunxi@googlegroups.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, Bastien Nocera <hadess@hadess.net>

Hi,

On 14-01-17 15:08, Icenowy Zheng wrote:
>
>
> 08.08.2016, 03:25, "Hans de Goede" <j.w.r.degoede@gmail.com>:
>> Hi All,
>>
>> Recently I've been working on getting the sdio-wifi, found on
>> many a23 / a33 tablets as well as on some a10s hdmi sticks and
>> on various h3 SBCs such as the Orange Pi, to work with the
>> mainline kernel.
>>
>> If you use my sunxi-wip kernel branch (which has some dts bits
>> to enable this as well as some misc. bits, which I'm all
>> trying to get upstream) together with one of the following
>> out of tree drivers, you should be able to get your wifi to
>> work.
>>
>> RTL8723BS or RTL8703AS wifi:
>> ----------------------------
>> git clone https://github.com/jwrdegoede/rtl8723bs.git
>> cd rtl8723bs
>> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- KSRC=../linux
>>
>> Do not forget to copy *.bin to /lib/firmware/rtlwifi/ on
>> the target system.
>>
>> Many thanks to Bastien Nocera for his great work on the
>> rtl8723bs driver, my repo just adds 2 small fixes
>> to also make the rtl8703as work.
>>
>> RTL8189ES / RTL8189ETV
>> ----------------------
>> git clone https://github.com/jwrdegoede/rtl8189ES_linux.git
>> cd rtl8189ES_linux.git
>> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- KSRC=../linux
>>
>> Thanks to Jean-Francois Moine for his initial work on getting
>> the RTL8989ES code to run with upstream kernels.
>>
>> RTL8189FTV
>> ----------
>> git clone https://github.com/jwrdegoede/rtl8189ES_linux.git
>> cd rtl8189ES_linux.git
>> git checkout -B rtl8189fs origin/rtl8189fs
>> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- KSRC=../linux
>>
>
> Excuse me for replying such an old email...
>
> If a distro want to provide both 8189es and 8189fs in a kernel package,
> is blacklisting one of them on boards needed?

I believe not, IIRC the both have a separate sdio device-id, but I'm
not sure...

Regards,

Hans



>
>> ESP8089
>> -------
>> git clone https://github.com/jwrdegoede/esp8089.git
>> git checkout -B cleanup origin/cleanup
>> cd ../linux
>> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- modules M=../esp8089 CONFIG_ESP8089=m
>>
>> Do not forget to copy firmware/*.bin to /lib/firmware/ on
>> the target system.
>>
>> Many thanks to Icenowy for his work on the esp8089 driver.
>>
>> I hope this is useful to at least some of you.
>>
>> A quick note for Orange Pi users, the older models H3 based
>> Pi-s use a soldered on wifi module with the RTL8189ETV.
>> The newer models (the PC Plus, Lite and Plus 2E) use the
>> RTL8189FTV soldered directly onto the PCB.
>>
>> Regards,
>>
>> Hans
