From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: slow eMMC write speed
Date: Fri, 30 Sep 2011 17:33:20 -0700
Message-ID: <4E865FD0.8010309@linux.intel.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com> <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com> <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com> <4E837C89.9020109@linux.intel.com> <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com> <4E838B43.5090605@linux.intel.com> <CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com> <4E839302.5020001@linux.intel.com> <CACRpkdYdrfhFSfLh=Zgjox60KbYCqN+n_WdOaP2sv_mhai+iig@mail.gmail.com> <4E84297C.3060408@stericsson.com> <4E84D20A.4040707@linux.intel.com> <CANz0V+6zKiEs5YdpipM6iid_JwyQaN2cd5y9BKh1mXXgKpxXkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21912 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998Ab1JAAZh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Sep 2011 20:25:37 -0400
In-Reply-To: <CANz0V+6zKiEs5YdpipM6iid_JwyQaN2cd5y9BKh1mXXgKpxXkA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Cc: Praveen G K <praveen.gk@gmail.com>, =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

On 09/30/2011 01:22 AM, Andrei E. Warkentin wrote:
> Hi James,
>
> 2011/9/29 J Freyensee<james_p_freyensee@linux.intel.com>:
>> As I've been playing around with with buffering/caching, it seems to me an
>> opportunity to simplify things in the MMC space is to eliminate the need for
>> a mmc_blk_request struct or mmc_request struct.  With looking through the
>> mmc_blk_issue_rw_rq(), there is a lot of work to initialize struct
>> mmc_blk_request brq, only to pass a struct mmc_queue variable the actual
>> mmc_wait_for_req() instead.  In fact, some of the parameters in the struct
>> mmc_blk_request member brq.mrq (of type mmc_request) wind up just pointing
>> to members in struct mmc_blk_request brq.  Granted, I totally don't
>> understand everything going on here and I haven't studied this code nearly
>> as long as others, but when I see something like this, the first thing that
>> comes up in my mind is 'elimination/simplification opportunity'.
>
> mmc_request is what is actually handled by the SD/MMC host driver -
> compact representation of
> what needs to be done (unneeded fields are NULL pointers).
> mmc_blk_request is basically the backing
> store for these fields, for the block driver. I would guess the
> mmc_request doesn't contain the fields
> because it would be inefficient (or correct me). And since there is
> quite a bit of logic behind running the
> actual MMC commands (esp. w.r.t to mrq->sbc and mrq->stop), it would
> not be a good idea to get
> rid of mmc_request and pull the strings from card drivers either.

So I have a question on write behavior.

Say mmc_blk_issue_rw_rq() is called.  Say the mmc_queue *mq variable 
passed in is a write.  Say that write is buffered, delayed into being 
sent via mmc_wait_for_req() for 5 seconds, and it's sent to 
mmc_wait_for_req() later.  Would that delay of sending the brq->mrq 
entry to mmc_wait_for_req() cause a timeout, ie:

mmc0: Timeout waiting for hardware interrupt.

??

If this is true, how would you extend the timeout?  I would not have 
expected this until mmc_wait_for_req() is called.  It appeared to me 
mmc_set_data_timeout() was just setting a variable in brq to be used 
when mmc_wait_for_req() is called.  I only see this behavior in eMMC 
cards, not MMC cards being stuck into an MMC slot of a laptop.

Thanks!

>
> Praveen:
>
> As for timings on Toshiba cards, you can search "MMC quirks relating
> to performance/lifetime." in the archives.
> There was quite a lot of very interesting data and discussions
> specifically regarding performance, and it would
> be pretty impossible and a disservice to try to summarize it :-). In
> short, I've definitely seen 100ms blips, pronounced
> by extra GC caused by unaligned accesses across allocation units (if I
> remember correctly). You could try and reduce
> the worst case, but it would make the average case worse. It's a bit
> of voodoo. Best solution is interact with your vendor
> and get suggestions on use and errata.
>
> A


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
