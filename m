From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: PROPOSED FIX: initialisation freqency patch problem.
Date: Tue, 29 Sep 2009 12:48:16 +0100
Message-ID: <c09aa50a0909290448h181bc6e2t66c3b626e3339214@mail.gmail.com>
References: <c09aa50a0909290412w7c035a9ap90818f59849941bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:57998 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZI2Lsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 07:48:33 -0400
Received: by bwz6 with SMTP id 6so1923622bwz.37
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2009 04:48:36 -0700 (PDT)
In-Reply-To: <c09aa50a0909290412w7c035a9ap90818f59849941bc@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

update: I just tried a quick hack that simply restarts the mmc card
probe at f_min if it fails and this allows my 'weirdo' card/host setup
to function normally again.

I'll knock up a patch implementing this a bit more cleanly and submit
it for opinions shortly.

2009/9/29 Ian Molton <ian@mnementh.co.uk>:
> Ok, I've looked into this and I have a problem.
>
> First off tmio-mmc was (with reason, albeit possibly bad ones) pickin=
g
> a 250 kHz clock for init. I've made a patch to fix that, but it doesn=
t
> solve my card-fails-to-init problem.
>
> I found that this particular card / machine combo just doesnt play
> nice initialising at 400kHz (or 250kHz or 512kHz). It wont initialise
> at anything over 120kHz in fact.
>
> The same card works =A0fine in another device with the same (tc6393xb=
)
> host controller.
>
> BUT the fact is we have a regression - this card used to work, and no=
w
> it doesnt. The cause is the patch I identified below that puts a
> 400kHz lower limit on the initialisation frequency.
>
> So, firstly, is there any real advantage to this lower limit?
>
> Secondly, I now have a problem in that if I want it fixed, it require=
d
> machine specific knowledge in the MMC core, which I dont like.
>
> I propose a more robust solution - if initialisation fails at 400kHz
> try again at f_min (if its lower than 400kHz).
>
> this requires no machine specific knowledge in the core and may
> increase robustness generally, as well as fixing my case.
>
> Comments please?
>
> 2009/9/29 Ian Molton <ian@mnementh.co.uk>:
>> Hi folks,
>>
>> The commit 8dfd0374be84793360db7fff2e635d2cd3bbcb21 is causing one o=
f
>> my MMC cards to fail to initialise.
>>
>> Has anyone else seen initialisation failures since this patch?
>>
>> I suspect the problem is in tmio-mmc but its a weird one - only one =
of
>> my two tc6393xb based hosts has this issue, and none of t7l66 or
>> tc6387, and only with one card.
>>
>> I'll look into it tomorrow and see what actual clock frequency is
>> getting selected.
>>
>> I'm off to bed now.
>>
>> --
>> Ian Molton
>> Linux, Automotive, and other hacking:
>> http://www.mnementh.co.uk/
>>
>
>
>
> --
> Ian Molton
> Linux, Automotive, and other hacking:
> http://www.mnementh.co.uk/
>



--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
