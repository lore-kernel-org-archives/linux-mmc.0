From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Mon, 7 Mar 2011 14:39:19 -0600
Message-ID: <AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
	<AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
	<AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:43556 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab1CGUjV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 15:39:21 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p27Kc3wG005990
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 15:38:03 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p27KVfiD003196
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 15:38:03 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so5392341vws.15
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2011 12:39:19 -0800 (PST)
In-Reply-To: <AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, tardyp@gmail.com
Cc: linux-mmc@vger.kernel.org

On Mon, Mar 7, 2011 at 2:16 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Sun, Mar 6, 2011 at 3:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> 2011/3/6 Linus Walleij <linus.walleij@linaro.org>:
>>> 2011/3/5 Andrei Warkentin <andreiw@motorola.com>:
>>>
>>>> Quirks are card-specific workarounds. Usually they involve
>>>> tuning mmcblk parameters at mmc_blk_probe time.
>>>
>>> Can't you just drop off all the *block* and *blk* pre- and
>>> suffixes off filenames and functions?
>>>
>>> It's inevitably going to be used for all kind of card quirks
>>> soon enough, not just those relating to block issues
>>> (could be power quirks etc) won't it?
>>>
>>> "Card quirks" is more intuitive to me.
>>
>> Or rather - if you check out Chris latest tree or the next
>> tree - you will find the new quirks.c file that Pierre Tardy
>> created for some SDIO quirks.
>>
>> Can you re-use this infrastructure and refactor/expand
>> with the quirks you need for the block stuff?
>>
>> Yours,
>> Linus Walleij
>>
>
> I'll check it out. I wish I looked earlier :-).
>
> A
>

I took a look at quirks.c in linux-next. It's a bit sdio-specific... I
would extend mmc_fixup to contain card type (to know if cis
vendor/device should be checked) as well as name/manfid/oemid and rev
id (which is just a combination of hwrev, fwrev and date).

Vendor_fixup would be the top-level card fixup.
I would add blk_fixup (so block specific information like desired
write align size can be kept inside mmc_blk_data instead of polluting
mmc_card).

...and to support part reliability workarounds for Toshiba cards, will
add a blk_adjust method to be invoked inside blk req handling.

Arnd, what do you think?

Pierre, what do you think about my above ideas of extending the
current quirks.c? Please see the following patches, which were my
original submissions...
http://article.gmane.org/gmane.linux.kernel.mmc/6468/match=
http://article.gmane.org/gmane.linux.kernel.mmc/6467/match=
http://article.gmane.org/gmane.linux.kernel.mmc/6469/match=
http://article.gmane.org/gmane.linux.kernel.mmc/6470/match=
http://article.gmane.org/gmane.linux.kernel.mmc/6466/match=

Thanks,
A
