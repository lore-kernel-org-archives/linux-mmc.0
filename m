From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: block: delete packed command support
Date: Tue, 22 Nov 2016 15:44:19 +0100
Message-ID: <44199908.WIlGo4b061@wuerfel>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org> <22ef57c2-4e09-afaa-8349-32e4ae687c8d@samsung.com> <CAPDyKFqVJeurr2jZcKRMxbvEuJfttnnFz_JWjqoCvP584h_byg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61992 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbcKVOoi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 09:44:38 -0500
In-Reply-To: <CAPDyKFqVJeurr2jZcKRMxbvEuJfttnnFz_JWjqoCvP584h_byg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Luca Porzio <lporzio@micron.com>

On Tuesday, November 22, 2016 9:49:26 AM CET Ulf Hansson wrote:
> On 22 November 2016 at 04:53, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> > On 11/21/2016 11:23 PM, Alex Lemberg wrote:
> >> On 11/21/16, 1:11 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >>> On Monday, November 21, 2016 11:08:57 AM CET Linus Walleij wrote:
> >>>
> >>> Packed reads don't make a lot of sense, there is very little
> >>> for an MMC to optimize in reads that it can't already do without
> >>> the packing. For writes, packing makes could be an important
> >>> performance optimization, if the eMMC supports it.
> >>>
> >>> I've added Luca Porzio  and Alex Lemberg to Cc. I think they
> >>> are subscribed to the list already, but it would be good to
> >>> get some estimate from them too about how common the packed
> >>> write support is on existing hardware from their respective
> >>> employers before we kill it off.
> >>
> >> Correct, in general there is no value in using packed for Read.
> >> But I can’t say this for all existing flash management solution.
> >> The eMMC spec allows to use it for Read as well.
> >
> > As i know, when packed command had implemented, early eMMC had the firmware problem
> > for Packed Read operation. but so I can't say Packed Read doesn't have the benefit for performance.
> > But Packed Write command can see the benefit for performance.
> 
> Regarding "performance", are you merely thinking about increased
> throughput? With packed command we decrease the communication overhead
> with the card so less commands becomes sent/received.
> 
> Or, did you also observed an improved behaviour of the card from a
> garbage collect point of view? In other words also a decreased latency
> when the device is becoming more and more used?
> 
> Finally, did you compare the packed command, towards using the
> asynchronous request mechanisms (using the ->pre|post_req() mmc host
> ops)?

The main point of command packing is that the device can be smarter
about garbage collection as well as combine sub-page sized writes.

The communication overhead is nearly irrelevant in comparison,
and we would probably not have done anything for that.

> >> As far as I can say from reviewing the mobile (Android)
> >> platforms kernel source (from different vendors),
> >> many of them are enabling Packed Commands.
> >
> > Actually, some shipping Samsung devices with eMMC4.5 might be used packed command.
> > (For Android/Tizen OS and ARTIK boards)
> 
> Thanks for sharing this information!
> 
> It seems like we need to run another round of performance
> measurements, as to get some fresh number of the benefit of packed
> command.
> I would really appreciate if you could help out with that.

As far as I'm concerned, there are already two conclusions and
I don't think those measurements would help much:

- It's a problem that none of our upstream drivers support this
  feature, and we really want them to do so, at least after the
  blk_mq change.

- Linus' analysis is still valid: there is no regression in removing
  it from the traditional blk code today, anyone who has a private
  driver that uses it can simply revert the removal in their next
  private product release.

If removing it helps us enable blk_mq support more easily, then
I think we can take out the packed command handling, but we have
to be prepared to put it back later on top of blk_mq.

	Arnd
