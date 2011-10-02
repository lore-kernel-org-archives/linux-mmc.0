From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: slow eMMC write speed
Date: Sun, 2 Oct 2011 02:20:42 -0400
Message-ID: <CANz0V+5dcZ_kn2qp4T=WbfstfqBqf--E+zD2QS1o-wE5qGhqyQ@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
	<CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
	<4E838B43.5090605@linux.intel.com>
	<CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com>
	<4E839302.5020001@linux.intel.com>
	<CACRpkdYdrfhFSfLh=Zgjox60KbYCqN+n_WdOaP2sv_mhai+iig@mail.gmail.com>
	<4E84297C.3060408@stericsson.com>
	<4E84D20A.4040707@linux.intel.com>
	<CANz0V+6zKiEs5YdpipM6iid_JwyQaN2cd5y9BKh1mXXgKpxXkA@mail.gmail.com>
	<4E865FD0.8010309@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55143 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1JBGUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Oct 2011 02:20:43 -0400
Received: by wyg34 with SMTP id 34so2163900wyg.19
        for <linux-mmc@vger.kernel.org>; Sat, 01 Oct 2011 23:20:42 -0700 (PDT)
In-Reply-To: <4E865FD0.8010309@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Praveen G K <praveen.gk@gmail.com>, =?UTF-8?Q?Per_F=C3=B6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

Hi James,

2011/9/30 J Freyensee <james_p_freyensee@linux.intel.com>:
>
> So I have a question on write behavior.
>
> Say mmc_blk_issue_rw_rq() is called. =C2=A0Say the mmc_queue *mq vari=
able passed
> in is a write.

You mean the struct request?

>=C2=A0Say that write is buffered, delayed into being sent via
> mmc_wait_for_req() for 5 seconds, and it's sent to mmc_wait_for_req()=
 later.
> =C2=A0Would that delay of sending the brq->mrq entry to mmc_wait_for_=
req() cause
> a timeout, ie:

Are you working off of mmc-next? Sounds like you don't have Per
=46=C3=B6rlin's async work yet.
I don't want to sound lame (yes, I know your Medfield or whatever
projects build on a particular baseline),
but you would be doing yourself a huge favor by doing your interesting
investigations on top of the top of
tree.

The old code indeed calls mmc_wait_for_req in  mmc_blk_issue_rw_rq,
while the new code does a
mmc_start_req, which waits for a previous async request to complete
before issuing the new one.

Could you describe in greater detail what you're doing? What exactly
do you mean by buffering?
As far as I understand, until you call mmc_wait_for_req (old code) or
mmc_start_req (new code), your
request only exists as a data structure, and the host controller
doesn't know or care about it. So it doesn't
matter when you send it - now, or five seconds in the future (of
course, you probably don't want other requests
to get ahead of a barrier request).

The mmc_set_data_timeout routine is used to calculate the time the
host controller will wait for the card to
process the read/write. This is obviously tied to the transfer size,
type (read or write), card properties as inferred
from its registers and technology.

>
> mmc0: Timeout waiting for hardware interrupt.
>
> ??
>
> If this is true, how would you extend the timeout? =C2=A0I would not =
have
> expected this until mmc_wait_for_req() is called.

The fact that you got a timeout implies that the host was processing a
struct mmc_request already.

=C2=A0It appeared to me
> mmc_set_data_timeout() was just setting a variable in brq to be used =
when
> mmc_wait_for_req() is called. =C2=A0I only see this behavior in eMMC =
cards, not
> MMC cards being stuck into an MMC slot of a laptop.
>

It's hard to say what is going without seeing some code. My other sugge=
stion is
instrument the host driver (and block driver as well) and figure out
what request is failing
and why.

A
