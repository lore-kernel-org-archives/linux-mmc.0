From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: Re: [linux-sunxi] Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sun, 6 Sep 2015 20:09:20 +0800
Message-ID: <CAECwjAhe3g0T2icEExE_tBbZ2D1z+BpVNCd0dGZVNU=7zH-LHw@mail.gmail.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com> <55EB8508.9030009@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35814 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbIFMJk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Sep 2015 08:09:40 -0400
Received: by obuk4 with SMTP id k4so45935005obu.2
        for <linux-mmc@vger.kernel.org>; Sun, 06 Sep 2015 05:09:40 -0700 (PDT)
In-Reply-To: <55EB8508.9030009@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.lin@rock-chips.com
Cc: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, dev@linux-sunxi.org

Hi,

On 6 September 2015 at 08:12, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2015/9/5 22:58, Hans de Goede wrote:
>>
>> Hi Shawn Lin,
>>
>> On 05-09-15 16:07, Shawn Lin wrote:
>>>
>>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>>>
>>>> A SD card with sunxi-mmc can fail with the following error message
>>>> (RCD for
>>>> response CRC error) when trying to switch to highspeed mode.  Setting
>>>> the bus
>>>> clock before the access mode switch fixed it.
>>>
>>>
>>> No, that's wrong!
>>>
>>> Before this card is switched to highspeed, it works under
>>> identification mode(From spec: bus clock <= 400KHz). How could you
>>> raise bus clock to higher clk rate which I _guess_ is 52MHz before you
>>> notify sd cards to run into highspeed mode?
>>>
>>> Althought it works for this card, this patch will not please the other
>>> cards that they might not reply CMDs any longer including the
>>> following CMD6.
>>
>>
>> Thanks for the feedback, this is exactly why I asked Yousong Zhou to
>> take this
>> to the mmc list.
>>
>> So if this is not the proper fix for the problem that Yousong Zhou is
>> seeing, then
>> what might be the proper fix ?
>>
>
> From my knowledge of mmc, there hadn't have a way to deal with this "broken"
> case. In another word, IMO,it's ANTI-SPEC. We can't be too spec sometimes,
> but at least we shouldn't violate it.
>

Maybe the fix is anti-spec.  But the fact is that the card works on
many other platforms with the builtin card reader (not through an USB
adapter), including Mac OS X, my old Nokia Symbian phone, and Windows.

>> Could it be that the sunxi-mmc is doing some things in the wrong order
>> when
>> changing the clock, or is this all under control of the mmc core ?
>>
>
> all of this is under control of the mmc core.
> So if Yongsong does want this card to work for any linux-based mmc stack, I
> guess something like that should be "better"?
>
> if (switch to HS fail) {
>         set_bus_clk
>         goto retry switch to HS
> }
>
> BUT...I admit it seems strange as well.
>

The SD Specification (simplified version) says "If CRC error occurs on
the status data, the host should issue a power cycle.", so I guess the
above approach is anti-spec in some way :)

In case it may help debug this problem, I'd like to add that the card
previously worked fine with U-Boot before commit [1].  This can also
be confirmed by Debian Jessie installer image with which the old
U-Boot there worked fine while the kernel (3.16) did not.

 [1] sunxi: mmc: Properly setup mod-clk and clock sampling phases,
http://git.denx.de/?p=u-boot.git;a=commit;h=fc3a832576ce7bb597b1823935bfb7dcca235c3c

Cheers

                yousong
