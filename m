From: Philip Rakity <prakity@marvell.com>
Subject: Re: A MMC card transfer issue
Date: Mon, 31 Jan 2011 08:40:58 -0800
Message-ID: <5CBEE3CD-E95A-4657-8842-D87B5F1F9AC1@marvell.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com>
 <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com>
 <001701cb814c$71926bf0$66f8800a@maildom.okisemi.com>
 <001201cb90f4$4be8f790$66f8800a@maildom.okisemi.com>
 <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com>
 <4D2E0464ABB54FFF9C10583336E27879@hacdom.okisemi.com>
 <4C4E7DE5-7CF1-4D97-9CAD-F600FCBE477A@marvell.com>
 <20110119174233.GA30494@void.printf.net>
 <F6E8C422FB8A4D78A5BDF7B6ECDA1E00@hacdom.okisemi.com>
 <D8E7AFC5-6B9E-414E-81A8-292FCD2F6E3C@marvell.com>
 <629816F753974155B62FF8FA718A26CA@hacdom.okisemi.com>
 <6076934B-27C2-4766-B101-793C7447C71C@marvell.com>
 <0F933C1424BF45E3BD2E13358BD3C89E@hacdom.okisemi.com>
 <7BDF62B4-A11A-4CB4-9F80-F2206C2655F9@marvell.com>
 <A32C38D81702478B9AB8626F523E79BB@hacdom.okisemi.com>
 <0DBFCBB8-B4A3-46A6-A68D-14FAED451619@marvell.com>
 <9992F28C7C0C445E956D351E3774C821@hacdom.okisemi.com>
 <82CB4E44-6543-4578-ACE4-37850FC4A49A@marvell.com>
 <EE9384C765994E26857C78E3D3A19304@hacdom.okisemi.com   > <AF584C10-A796-4	3
 5 B-8AB2-DA6D6C0E3FD7@marvell.com>
 <DE7D3AAF538943459079D18D0CE6ED44@hacdom.okisemi.com>
 <DDF13C55-A8A1-45C1-AE9A-A76754ED7008@marvell.com>
 <4425BB0054B748C68A25DD1DFBBB52A7@hacdom.okisemi.com>
 <5E1B7BBD-C96E-4CC0-B03B-ADCEB0120085@marvell.com>
 <0C438F11-132E-4639-820D-0E42EEDCD6E7@marvell.com>
 <671E3EC021E946A383C65F07A0101B27@hacdom.okisemi.com>
 <16706427-F00E-46F3-B0B4-9B7F06AD0E71@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:47164 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756060Ab1AaQnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 Jan 2011 11:43:01 -0500
In-Reply-To: <16706427-F00E-46F3-B0B4-9B7F06AD0E71@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Toshiharu Okada <toshiharu-linux@dsn.okisemi.com>, Manabu Miyata <miyata669@dsn.okisemi.com>, Takahiro Shimizu <shimizu394@dsn.okisemi.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Nico,

Need some advice on how to solve a problem with mmc.  Some background

>>>
>>> mmc cards have NO card specific data field to say the bus
>>> width that is supported.  SD cards have this field.
>>>
>>> The only way to know what width a mmc card supports is to
>>> probe the card sending CMD14/CMD19. (JEDEC standard 84- A441).
>>>
>>> In my system with the mods we made we can detect all mmc
>>> cards correctly.  The CMD14/CMD19 does not work correctly on Tomoya's system.
The CMD14/CMD19 times out. (see below)  The CMD14/CMD19 works on multiple Marvell SoC chips, Tomoya's
uses a PCI controller.

The transcend mmc card does not have the PHYSICAL pins for 4 bit mode; only 1 bit can be supported.

Testing the bus width is the recommend way to find out the bus width.  The current behavior when the
QUIRK is not defined is to default to 4 bit mode (same as has been done historically).

The only way to guarantee that cards really do work would be to default to 1 bit mode but this has a
4x performance degradation.

One possible solution would be to try to do a test read operation on the mmc card if the bus test failed
and see if there is an error.  In this case change the bus width to 1 bit.

a) Do you think this is a good idea?  --
b) How to plumb it in ?  -- can you sketch something out and I will try to implement it.

regards,

Philip

On Jan 30, 2011, at 9:57 PM, Philip Rakity wrote:

>
> On Jan 30, 2011, at 8:16 PM, Tomoya MORINAGA wrote:
>
>> Hi Philip,
>>
>>> The only way to know what width a mmc card supports is to
>>> probe the card sending CMD14/CMD19. (JEDEC standard 84- A441).
>>>
>>> In my system with the mods we made we can detect all mmc
>>> cards correctly..
>>
>> What's your system ? Linux ?
>
> linux -- 4 different Marvell SoC chips.  Running linux-next.   SD Host cotnroler
> supports  SD2.0 and now SD 3.0 specs.
>>
>>> The current code without BUS_WIDTH QUIRK defined -- breaks
>>> the transcend card in 1 bit mode but allows 4 bit cards to work.
>>> do you agree ?
>>
>> Yes,
>> Currently, since MMC driver works as 4-bit mode,
>> MMC-v4-1bit doesn't work.
>>
>>>
>>> I do not know how to fix the problem in any other way...
>>>
>>
>> possible choices are like below, I think.
>> 1.  always going into 1 bit mode (Like Windows)
>> 2.  As mentioned previous my mail, support 1-bit mode option by kernel configuration.
>
> Propose patch for this or we could extend existing QUIRK or CAP for 1 bit mode
> will look in the morning.
>
>> 3. Not support like the 1bit-MMC card (current spec)
>
> In some systems.
>
> The good news is that the transcend card IS REALLY STRANGE ! and quite an EXCEPTION.
> The bad news is things don't work all the time. Let me think how we could go into 1 bit mode.
> Let me post something to the mmc/ list on this -- Nico  has good good ideas on how to do things like
> this in the mmc/core layer.
>
> Philip
>
>
>
>>
>> Thanks,
>> -----------------------------------------
>> Tomoya MORINAGA
>> OKI SEMICONDUCTOR CO., LTD.
>>
>>> -----Original Message-----
>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>> Sent: Monday, January 31, 2011 6:49 AM
>>> To: Tomoya MORINAGA
>>> Cc: Toshiharu Okada; Manabu Miyata; Takahiro Shimizu
>>> Subject: Re: A MMC card transfer issue
>>>
>>>
>>> Back to the beginning ..
>>>
>>> We also discovered that having a SD  controller that supports
>>> 8 bit data and a board design that does not -- does not all
>>> the 8 bit card to work at full speed.
>>> Using the controller values is not sufficient.
>>>
>>> We discovered that the transcend 1 bit card does not work in linux.
>>> The transcend mmc card does NOT have the electrical pins to
>>> support 4 bit mode --- compare the card against some other SD
>>> cards you have and you will see the missing pins.
>>>
>>> mmc cards have NO card specific data field to say the bus
>>> width that is supported.  SD cards have this field.
>>>
>>> The only way to know what width a mmc card supports is to
>>> probe the card sending CMD14/CMD19. (JEDEC standard 84- A441).
>>>
>>> In my system with the mods we made we can detect all mmc
>>> cards correctly..
>>>
>>> I understand it does not work on your system.
>>>
>>> The current code without BUS_WIDTH QUIRK defined -- breaks
>>> the transcend card in 1 bit mode but allows 4 bit cards to work.
>>> do you agree ?
>>>
>>> I do not believe the code worked before the bus width test
>>> otherwise I would not have seen to problem and we would not
>>> have generated any patches.
>>>
>>> You could guarantee all mmc cards work with bus_test by
>>> always going into 1 bit mode -- but his has a severe
>>> performance impact.
>>>
>>> I do not know how to fix the problem in any other way...
>>>
>>> Any suggestions
>>>
>>> Philip
>>>
>>>
>>>
>>>
>>> On Jan 28, 2011, at 8:13 AM, Philip Rakity wrote:
>>>
>>>>
>>>> On Jan 28, 2011, at 12:44 AM, Tomoya MORINAGA wrote:
>>>>
>>>>> Hi  Philip,
>>>>>
>>>>> It doesn't detect the 1bit-MMC correctly.
>>>>>> cmd.flags &= ~MSP_RSP_CRC;
>>>>> BTW, the above is not MSP_RSP_CRC but MMC_RSP_CRC.
>>>>>
>>>> My topo
>>>>>
>>>>> Root cause is MMC driver can't judge whether the interted
>>> MMC-v4-card is 1-bit or not.
>>>>> Thus, I think a user can only set "Use MMC-v4-1bit" or not.
>>>>
>>>> this is why the QUIRK is there.
>>>>>
>>>>> Though sent the following last November, How about the
>>> following line
>>>>> valid or invalid with compile option (Kconfig) ?
>>>>>
>>>>> In fact, invalidating the following line, the MMC-v4-1bit
>>> card can be detected correctly.
>>>>
>>>> which line ?
>>>>
>>>> The bus width test is needed for 8 bit cards.
>>>>
>>>> Philip
>>>>
>>>>>
>>>>>> linux/drivers/mmc/core/mmc.c
>>>>>>
>>>>>> 505        /*
>>>>>> 506         * Activate wide bus (if supported).
>>>>>> 507         */
>>>>>> 508        if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
>>>>>> 509            (host->caps & (MMC_CAP_4_BIT_DATA |
>>>>>> MMC_CAP_8_BIT_DATA))) {
>>>>>> 510                unsigned ext_csd_bit, bus_width;
>>>>>> 511
>>>>>> 512                if (host->caps & MMC_CAP_8_BIT_DATA) {
>>>>>> 513                        ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
>>>>>> 514                        bus_width = MMC_BUS_WIDTH_8;
>>>>>> 515                } else {
>>>>>> 516                        ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
>>>>>> 517                        bus_width = MMC_BUS_WIDTH_4;
>>>>>> 518                }
>>>>>> 519
>>>>>> 520                err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>>> 521                                 EXT_CSD_BUS_WIDTH,
>>> ext_csd_bit);
>>>>>> 522
>>>>>> 523                if (err && err != -EBADMSG)
>>>>>> 524                        goto free_card;
>>>>>> 525
>>>>>> 526                if (err) {
>>>>>> 527                        printk(KERN_WARNING "%s: switch
>>>>>> to bus width %d "
>>>>>> 528                               "failed\n",
>>>>>> mmc_hostname(card->host),
>>>>>> 529                               1 << bus_width);
>>>>>> 530                        err = 0;
>>>>>> 531                } else {
>>>>>> 532                        mmc_set_bus_width(card->host,
>>> bus_width);
>>>>>> 533                }
>>>>>> 534        }
>>>>>> 535
>>>>>
>>>>> With Best Regards,
>>>>> -----------------------------------------
>>>>> Tomoya MORINAGA
>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>> Sent: Friday, January 28, 2011 2:28 PM
>>>>>> To: Tomoya MORINAGA
>>>>>> Cc: Toshiharu Okada; Manabu Miyata
>>>>>> Subject: Re: A MMC card transfer issue
>>>>>>
>>>>>>
>>>>>> The SD controller you are using is broken.  It does not
>>> handle bus
>>>>>> width testing (CMD19/CMD14) gives CRC errors.  Not sure
>>> now to fix
>>>>>> this... or work around it.
>>>>>>
>>>>>> It is possible we should define a new RSP type that does
>>> not specify
>>>>>> CRC  (this is contained in the RESP_R1 see mmc_ops.c when
>>> doing the
>>>>>> send_bus_test().
>>>>>>
>>>>>> as a fast hack. add a line after
>>>>>>
>>>>>> cmd.flags = MMC_RSP_SPI_R1 |  MMC_RSP_R1 | MMC_CMD_ADTC;
>>>>>>
>>>>>> cmd.flags &= ~MSP_RSP_CRC;
>>>>>>
>>>>>>
>>>>>> and see what happens.
>>>>>>
>>>>>>
>>>>>> This is the problem I saw before in 2.6.20 and we could
>>> not figure
>>>>>> out a work around.
>>>>>>
>>>>>> Philip
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Jan 27, 2011, at 5:31 PM, Tomoya MORINAGA wrote:
>>>>>>
>>>>>>> Hi Philip,
>>>>>>>
>>>>>>> I attached boot log with  CONFIG_MMC_DEBUG.
>>>>>>>
>>>>>>> With Best Regards,
>>>>>>> -----------------------------------------
>>>>>>> Tomoya MORINAGA
>>>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>>>> Sent: Friday, January 28, 2011 9:59 AM
>>>>>>>> To: Tomoya MORINAGA
>>>>>>>> Cc: Toshiharu Okada; Manabu Miyata
>>>>>>>> Subject: Re: A MMC card transfer issue
>>>>>>>>
>>>>>>>>
>>>>>>>> ouch
>>>>>>>>
>>>>>>>> please send complete console log.  Want to see what
>>> startup looks
>>>>>>>> like.
>>>>>>>>
>>>>>>>> you will need to enable CONFIG_MMC_DEBUG
>>>>>>>>
>>>>>>>> it is the only way to get a trace from the linux point of view.
>>>>>>>>
>>>>>>>> PHilip
>>>>>>>>
>>>>>>>> On Jan 27, 2011, at 4:29 PM, Tomoya MORINAGA wrote:
>>>>>>>>
>>>>>>>>> Hi Philip,
>>>>>>>>>
>>>>>>>>> According to your saying,
>>>>>>>>> I deleted the following 2-lines in drivers/mmc/core/mmc.c
>>>>>>>>>
>>>>>>>>>> if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
>>>>>>>>>>       break;
>>>>>>>>>
>>>>>>>>> However, the issue remains to be seen.
>>>>>>>>> I attached the dmesg log.
>>>>>>>>> The error log differs from previous log.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> -----------------------------------------
>>>>>>>>> Tomoya MORINAGA
>>>>>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>>>>>> Sent: Friday, January 28, 2011 6:33 AM
>>>>>>>>>> To: Tomoya MORINAGA
>>>>>>>>>> Cc: Toshiharu Okada; Manabu Miyata
>>>>>>>>>> Subject: Re: A MMC card transfer issue
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Are you comfortable just deleting the test for the CAP for
>>>>>>>> bus width
>>>>>>>>>> in mmc.c ?
>>>>>>>>>>
>>>>>>>>>> I see you are using PCI  and SD -- this is where we
>>> had problems
>>>>>>>>>> before.
>>>>>>>>>>
>>>>>>>>>> In drivers/mmc/core/mmc.c
>>>>>>>>>>
>>>>>>>>>> change
>>>>>>>>>>
>>>>>>>>>>                       if (!err) {
>>>>>>>>>>
>>>>>>>>>> mmc_set_bus_width_ddr(card->host,
>>>>>>>>>>
>>>>>>>>>> bus_width, MMC_SDR_MODE);
>>>>>>>>>>                               /*
>>>>>>>>>>                                * If controller can't handle
>>>>>>>>>> bus width test,
>>>>>>>>>>                                * use the highest
>>> bus width to maintain
>>>>>>>>>>                                * compatibility with
>>> previous
>>>>>>>>>> MMC behavior.
>>>>>>>>>>                                */
>>>>>>>>>>                               if (!(host->caps &
>>>>>>>>>> MMC_CAP_BUS_WIDTH_TEST))
>>>>>>>>>>                                       break;
>>>>>>>>>>                               err =
>>> mmc_bus_test(card, bus_width);
>>>>>>>>>>                               if (!err)
>>>>>>>>>>                                       break;
>>>>>>>>>>                       }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> to
>>>>>>>>>>
>>>>>>>>>>                       if (!err) {
>>>>>>>>>>
>>>>>>>>>> mmc_set_bus_width_ddr(card->host,
>>>>>>>>>>
>>>>>>>>>> bus_width, MMC_SDR_MODE);
>>>>>>>>>> #if 0
>>>>>>>>>>                               /*
>>>>>>>>>>                                * If controller can't handle
>>>>>>>>>> bus width test,
>>>>>>>>>>                                * use the highest
>>> bus width to maintain
>>>>>>>>>>                                * compatibility with
>>> previous
>>>>>>>>>> MMC behavior.
>>>>>>>>>>                                */
>>>>>>>>>>                               if (!(host->caps &
>>>>>>>>>> MMC_CAP_BUS_WIDTH_TEST))
>>>>>>>>>>                                       break; #endif
>>>>>>>>>>                               err =
>>> mmc_bus_test(card, bus_width);
>>>>>>>>>>                               if (!err)
>>>>>>>>>>                                       break;
>>>>>>>>>>                       }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This will tell us more about what if going on.
>>>>>>>>>>
>>>>>>>>>> Philip
>>>>>>>>>>
>>>>>>>>>> On Jan 26, 2011, at 10:36 PM, Tomoya MORINAGA wrote:
>>>>>>>>>>
>>>>>>>>>>> Hi Philip
>>>>>>>>>>>
>>>>>>>>>>> Thank you for you help.
>>>>>>>>>>> I attached my kernel configuration file for 2.6.38-rc2.
>>>>>>>>>>>
>>>>>>>>>>> With Best Regards,
>>>>>>>>>>> -----------------------------------------
>>>>>>>>>>> Tomoya MORINAGA
>>>>>>>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>>>>>>>
>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>>>>>>>> Sent: Thursday, January 27, 2011 12:42 PM
>>>>>>>>>>>> To: Tomoya MORINAGA
>>>>>>>>>>>> Subject: Re: A MMC card transfer issue
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Lets go off list.
>>>>>>>>>>>>
>>>>>>>>>>>> send me the linux dot_config.
>>>>>>>>>>>>
>>>>>>>>>>>> I can go from there.
>>>>>>>>>>>>
>>>>>>>>>>>> Philip
>>>>>>>>>>>>
>>>>>>>>>>>> On Jan 26, 2011, at 7:20 PM, Tomoya MORINAGA wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Philip,
>>>>>>>>>>>>>
>>>>>>>>>>>>>> which MMC driver are you using.
>>>>>>>>>>>>> According to boot message, it seems sdhci.c is loaded.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Do I add only  "mmc->caps |=  MMC_CAP_BUS_WIDTH_TEST"
>>>>>>>> in sdhc.c ?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> -----------------------------------------
>>>>>>>>>>>>> Tomoya MORINAGA
>>>>>>>>>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>>>>>>>>>> Sent: Thursday, January 27, 2011 10:44 AM
>>>>>>>>>>>>>> To: Tomoya MORINAGA
>>>>>>>>>>>>>> Cc: Chris Ball; Kyungmin Park; linux-mmc@vger.kernel.org;
>>>>>>>>>>>>>> linux-kernel@vger.kernel.org;
>>>>>> andrew.chih.howe.khor@intel.com;
>>>>>>>>>>>>>> kok.howg.ewe@intel.com; Toshiharu Okada
>>>>>>>>>>>>>> Subject: Re: A MMC card transfer issue
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> There is no good answer.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Doing this patch for 2.6.20 or so a long time ago
>>>>>> had problems
>>>>>>>>>>>>>> because some controllers did not work.  The failures
>>>>>>>>>> were equally
>>>>>>>>>>>>>> unpleasant.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The failure you see today is at least not a
>>> regression since
>>>>>>>>>>>>>> 1 bit did not work before.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We hope that developers who know their h/w works add
>>>>>> the CAP.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Jan 26, 2011, at 5:31 PM, Tomoya MORINAGA wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hi Philip,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> which MMC driver are you using.
>>>>>>>>>>>>>>> Could you teach me how to get the information ?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> you need to have the driver or the low level code enable
>>>>>>>>>>>>>> this QUIRK.
>>>>>>>>>>>>>>> BTW, Is the above permanent treatment?
>>>>>>>>>>>>>>> I think modifying kernel source code isn't preferred.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> -----------------------------------------
>>>>>>>>>>>>>>> Tomoya MORINAGA
>>>>>>>>>>>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>>>>>>>>>>>> Sent: Thursday, January 27, 2011 10:04 AM
>>>>>>>>>>>>>>>> To: Tomoya MORINAGA
>>>>>>>>>>>>>>>> Cc: Chris Ball; Kyungmin Park;
>>> linux-mmc@vger.kernel.org;
>>>>>>>>>>>>>>>> linux-kernel@vger.kernel.org;
>>>>>>>> andrew.chih.howe.khor@intel.com;
>>>>>>>>>>>>>>>> kok.howg.ewe@intel.com
>>>>>>>>>>>>>>>> Subject: Re: A MMC card transfer issue
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> yes
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> you need to have the driver or the low level code enable
>>>>>>>>>>>>>> this QUIRK.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> which mmc driver are you using.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Jan 26, 2011, at 5:00 PM, Tomoya MORINAGA wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Hi Philip,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Thursday, January 27, 2011 12:42 AM, Philip
>>>>>> Rakity wrote:
>>>>>>>>>>>>>>>>>> Did you define the CAP for BUS WIDTH ?
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> MMC_CAP_BUS_WIDTH_TEST
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> in the driver or the platform driver ?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Let me make the above meaning clear.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I don't modify kernel source code
>>> "drivers/mmc" at all Is
>>>>>>>>>>>>>> the above
>>>>>>>>>>>>>>>>> mean I must modify something kernel source code ?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>> -----------------------------------------
>>>>>>>>>>>>>>>>> Tomoya MORINAGA
>>>>>>>>>>>>>>>>> OKI SEMICONDUCTOR CO., LTD.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>> <config.config>
>>>>>>>>>>
>>>>>>>>> <Transcend_log>
>>>>>>>>
>>>>>>> <Transcend_log_debug_on>
>>>>>>
>>>>>
>>>>
>>>
>>
>

