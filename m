From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Mon, 7 Mar 2011 14:51:18 -0600
Message-ID: <AANLkTi=AEMhOfbBtBfyqeuo9P85Qme=YirrYbF9gAGgf@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
	<AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
	<AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
	<AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:42783 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab1CGUvV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 15:51:21 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p27KpY1n010091
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 15:51:34 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p27ISBZg004705
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 15:51:34 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 39so5249198vxb.15
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2011 12:51:18 -0800 (PST)
In-Reply-To: <AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, tardyp@gmail.com
Cc: linux-mmc@vger.kernel.org

On Mon, Mar 7, 2011 at 2:39 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Mon, Mar 7, 2011 at 2:16 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> On Sun, Mar 6, 2011 at 3:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> 2011/3/6 Linus Walleij <linus.walleij@linaro.org>:
>>>> 2011/3/5 Andrei Warkentin <andreiw@motorola.com>:
>>>>
>>>>> Quirks are card-specific workarounds. Usually they involve
>>>>> tuning mmcblk parameters at mmc_blk_probe time.
>>>>
>>>> Can't you just drop off all the *block* and *blk* pre- and
>>>> suffixes off filenames and functions?
>>>>
>>>> It's inevitably going to be used for all kind of card quirks
>>>> soon enough, not just those relating to block issues
>>>> (could be power quirks etc) won't it?
>>>>
>>>> "Card quirks" is more intuitive to me.
>>>
>>> Or rather - if you check out Chris latest tree or the next
>>> tree - you will find the new quirks.c file that Pierre Tardy
>>> created for some SDIO quirks.
>>>
>>> Can you re-use this infrastructure and refactor/expand
>>> with the quirks you need for the block stuff?
>>>
>>> Yours,
>>> Linus Walleij
>>>
>>
>> I'll check it out. I wish I looked earlier :-).
>>
>> A
>>
>
> I took a look at quirks.c in linux-next. It's a bit sdio-specific... I
> would extend mmc_fixup to contain card type (to know if cis
> vendor/device should be checked) as well as name/manfid/oemid and rev
> id (which is just a combination of hwrev, fwrev and date).
>
> Vendor_fixup would be the top-level card fixup.
> I would add blk_fixup (so block specific information like desired
> write align size can be kept inside mmc_blk_data instead of polluting
> mmc_card).
>
> ...and to support part reliability workarounds for Toshiba cards, will
> add a blk_adjust method to be invoked inside blk req handling.
>
> Arnd, what do you think?
>
> Pierre, what do you think about my above ideas of extending the
> current quirks.c? Please see the following patches, which were my
> original submissions...
> http://article.gmane.org/gmane.linux.kernel.mmc/6468/match=
> http://article.gmane.org/gmane.linux.kernel.mmc/6467/match=
> http://article.gmane.org/gmane.linux.kernel.mmc/6469/match=
> http://article.gmane.org/gmane.linux.kernel.mmc/6470/match=
> http://article.gmane.org/gmane.linux.kernel.mmc/6466/match=
>
> Thanks,
> A
>

The other real issue I see is that it's kind of nasty to put
block-related workarounds into core/quirks.c. The later seems more of
generic card interface workarounds, rather than workarounds for
specific functionality. It would be like putting workarounds for, say,
sdio_uart into core/quirk.c, IMHO block workarounds are still
function-level workarounds, and so should be dealt with at the
function-level under mmc/card. Thoughts? Keep in mind also that for
various emmc brokeness (from writing to erasing), there is an express
need to be able to modify actual mmc commands during request
processing, or base behavior on per-card tunables (which are block
specific and shouldn't be in struct mmc_card). Can't get away with
just setting a quirk flag...

A
