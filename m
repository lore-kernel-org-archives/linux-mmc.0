From: Ian Molton <ian@mnementh.co.uk>
Subject: PROPOSED FIX: initialisation freqency patch problem.
Date: Tue, 29 Sep 2009 12:12:25 +0100
Message-ID: <c09aa50a0909290412w7c035a9ap90818f59849941bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38242 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZI2LMm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 07:12:42 -0400
Received: by fxm18 with SMTP id 18so4362910fxm.17
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2009 04:12:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Ok, I've looked into this and I have a problem.

First off tmio-mmc was (with reason, albeit possibly bad ones) picking
a 250 kHz clock for init. I've made a patch to fix that, but it doesnt
solve my card-fails-to-init problem.

I found that this particular card / machine combo just doesnt play
nice initialising at 400kHz (or 250kHz or 512kHz). It wont initialise
at anything over 120kHz in fact.

The same card works  fine in another device with the same (tc6393xb)
host controller.

BUT the fact is we have a regression - this card used to work, and now
it doesnt. The cause is the patch I identified below that puts a
400kHz lower limit on the initialisation frequency.

So, firstly, is there any real advantage to this lower limit?

Secondly, I now have a problem in that if I want it fixed, it required
machine specific knowledge in the MMC core, which I dont like.

I propose a more robust solution - if initialisation fails at 400kHz
try again at f_min (if its lower than 400kHz).

this requires no machine specific knowledge in the core and may
increase robustness generally, as well as fixing my case.

Comments please?

2009/9/29 Ian Molton <ian@mnementh.co.uk>:
> Hi folks,
>
> The commit 8dfd0374be84793360db7fff2e635d2cd3bbcb21 is causing one of
> my MMC cards to fail to initialise.
>
> Has anyone else seen initialisation failures since this patch?
>
> I suspect the problem is in tmio-mmc but its a weird one - only one of
> my two tc6393xb based hosts has this issue, and none of t7l66 or
> tc6387, and only with one card.
>
> I'll look into it tomorrow and see what actual clock frequency is
> getting selected.
>
> I'm off to bed now.
>
> --
> Ian Molton
> Linux, Automotive, and other hacking:
> http://www.mnementh.co.uk/
>



-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
