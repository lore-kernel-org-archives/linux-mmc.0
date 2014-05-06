From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: TRIM timeout calculation
Date: Tue, 6 May 2014 09:41:12 +0200
Message-ID: <CAPDyKFpSpT_XJycC+_i-_Y_fKgjmG7YfRu-TrSaqaOw_3diVGA@mail.gmail.com>
References: <OF5115E52C.11615B85-ONC1257CCF.005BB35E-C1257CCF.005CF8B5@transmode.se>
	<CAPDyKFo8ir0aKCE9HgEQj2jbNQVxSt2ENPdEshDpuuy7MYE6CQ@mail.gmail.com>
	<OF5C054324.0517D62C-ONC1257CD0.0025B7D9-C1257CD0.00280C60@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:51186 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934206AbaEFHlO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 May 2014 03:41:14 -0400
Received: by mail-qc0-f176.google.com with SMTP id r5so2208602qcx.21
        for <linux-mmc@vger.kernel.org>; Tue, 06 May 2014 00:41:13 -0700 (PDT)
In-Reply-To: <OF5C054324.0517D62C-ONC1257CD0.0025B7D9-C1257CD0.00280C60@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 6 May 2014 09:17, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> wrote on 2014/05/05 22:50:39:
>>
>> On 5 May 2014 18:55, Joakim Tjernlund <joakim.tjernlund@transmode.se>
> wrote:
>> > I got a Micron eMMC 4.41 memory and I am trying to use the TRIM
> function.
>> > my EXT_CSD_TRIM_MULT is 15 which gets me a tmo of 15*300=4500 ms
>> > Then in  mmc_calc_max_discard() I have:
>> >         max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
>> >         if (mmc_can_trim(card)) {
>> >                 max_trim = mmc_do_calc_max_discard(card,
> MMC_TRIM_ARG);
>> >                 if (max_trim < max_discard)
>> >                         max_discard = max_trim;
>> >         } else if (max_discard < card->erase_size) {
>> >                 max_discard = 0;
>> >         }
>> >         pr_debug("%s: calculated max. discard sectors %u for timeout
> %u
>> > ms\n",
>> >                  mmc_hostname(host), max_discard,
> host->max_busy_timeout);
>> > Now  mmc_do_calc_max_discard(card, MMC_TRIM_ARG) returns 0 because the
>> > initial trim
>> > timeout is so high, 4500 ms:
>> >   mmc0: calculated max. discard sectors 0 for timeout 2684 ms
>> >
>> > How is this supposed to work?
>>
>> This piece of code in the mmc core/block layer is somewhat broken :-(
>
> :) good to know. I got the impression that it is the eMMC tmo spec that
> is broken. How can TRIM have 4.5 s tmo when ERASE is way, way below that?

So, that's good know. No matter what, we need to cope with these
strange timeout values.

>
>>
>> For 3.15 we merged quite some patches to fixup the hardware busy
>> detection mechanism supported by some host drivers/controllers.
>> Trim/erase may utilize hardware busy detections, it's therefore I
>> gives you this background.
>
> I did browse the linus tree but I didn't really see this, but I am new to
> MMC
> so I don't really know what to look for.
>
>>
>> Now, those fixes did not mean any improvements immediately for
>> erase/trim, but made some preparations for us to fix it. :-) I have it
>> on the top of my mmc-TODO list - that's all I can give you sorry. :-)
>
> Top of mmc TODO list is great( I hope you don't have several TODO lists :)
>
>
>>
>> Anyway, what host driver / controller are you using?
>
> Freescale's esdhc driver/controller for P2040. This controller is
> compliant to eMMC 4.2 but I don't think that should be a problem?
> As far as I can tell a 4.2 controller should be able to drive a 4.5 eMMC
> memory without loss of 4.5 functionality sans the new 4.5 speeds, do you
> agree?

Yes; as long as new features from the spec don't require any
electrical changes, which is typical for new speed modes.

So, this means you have a variant of the sdhci controller, which has
some support for hardware busy detection - great. Then you might be
able to help out testing some patches, once they are available?

>
>>
>> Kind regards
>> Ulf Hansson
>
>
