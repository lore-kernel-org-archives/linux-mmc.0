From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 20 Nov 2018 23:26:23 +0100
Message-ID: <CAPDyKFr+PhPhZLbHa0bS+yxB_H+NyuAFd1mpJOw3of4JVpHRQQ@mail.gmail.com>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com> <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai> <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai> <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
 <CAPDyKFrFz9bHa5EmiBmQvXnoRibbL4-Gq9E7E5vDBbd=uj_2kA@mail.gmail.com>
 <515b72f2bd526d144fdc662126aa6e1e8484a25c.camel@collabora.co.uk>
 <CAPDyKFoCyXSQ9bVD9iYYcr4Y7e87Ltdt2+QNg0euvNijRGi83Q@mail.gmail.com> <9f63ea203ec54a86f1edc636e44acc9b5e51aea1.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9f63ea203ec54a86f1edc636e44acc9b5e51aea1.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Faiz Abbas <faiz_abbas@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>, Hal Emmerich <hal@halemmerich.com>
List-Id: linux-mmc@vger.kernel.org

On 20 November 2018 at 15:55, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> On Tue, 2018-11-20 at 15:24 +0100, Ulf Hansson wrote:
>> On 20 November 2018 at 15:00, Sjoerd Simons
>> <sjoerd.simons@collabora.co.uk> wrote:
>> > On Tue, 2018-11-20 at 14:08 +0100, Ulf Hansson wrote:
>> > > + Hal Emmerich
>> > >
>> > > On 20 November 2018 at 12:38, Sjoerd Simons
>> > > <sjoerd.simons@collabora.co.uk> wrote:
>> > > > On Tue, 2018-11-20 at 11:23 +0100, Wolfram Sang wrote:
>> > > > So if you know the pattern, or just happen to hit it often in
>> > > > e.g.
>> > > > automated testing, it does show up during development.
>> > > > Otherwise it
>> > > > can
>> > > > appear to "happen once in a while randomly".
>> > >
>> > > I don't quite follow. As far as I understand, the extended
>> > > timeout is
>> > > needed when turning the cache on.
>> > >
>> > > The above seems more related to flushing the cache, no? Flushing
>> > > have
>> > > no timeout (also reported to be an issue [1]), which happens
>> > > either
>> > > at
>> > > _mmc_hw_reset() or at _mmc_suspend().
>> > >
>> > > What is the relation here?
>> >
>> > Yes it's the kinda of behaviour you would expect on a flush indeed!
>> > I
>> > don't know what the card actaully does when turning the cache on,
>> > whether it's actually flush of something persistent when turning
>> > the
>> > cache on after a hard poweroff or doing some other validation.
>> >
>> > All i can share is what our testing seems to indicate, which is
>> > that
>> > there is a wide spread in the time the card needs *and* there seems
>> > to
>> > be strong correlation to the I/O activity before the hard power off
>> > and
>> > the time taken by "cache on".
>>
>> So the hard power off, means that you are cutting the power to the
>> platform and not doing a graceful power off? Just so I understand
>> correctly.
>
> Correct. With hard power off i mean cutting the power to the board in
> some way. When doing a gracefull power off, the issue does not occur on
> my boards (cache on is fast). Presumably as the eMMC got its cache
> flushed as part of the shutdown procedure..

Okay, got it.

>
>> > > Using no limit of the timeout, would mean we may hang for ~10
>> > > minutes
>> > > (MMC_OPS_TIMEOUT_MS) instead, no thanks.
>> >
>> > Probably a silly question, but would this actually cause e.g. boot
>> > to
>> > hang while waiting for the card (assuming rootfs is somewhere
>> > else)?
>>
>> Nope.
>>
>> [...]
>
> Then i'm probably just being dense, but i'm unsure what the issue is
> with waiting for 10 minuts in this case. Apart from having to wait for
> 10 minutes before the user gets an indication in the kernel that the
> card is not usable?

Exactly, to long timeouts is never good. Then it's better to timeout
in a reasonable time and log some error message to the let user know
of what went wrong.

To sum up, if someone wants to send a patch changing the timeout for
enabling the cache to let's say 1500 ms (and by adding a comment why),
I am fine to take it. In other words, lets drop the quirk-approach as
people seems more in favor of general change of the default behavior.

Kind regards
Uffe
