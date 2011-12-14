From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is first claimed
Date: Wed, 14 Dec 2011 11:28:55 +0100
Message-ID: <201112141128.56029.rjw@sisk.pl>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <4EE865CA.8000407@stericsson.com> <CACRpkdZnmCUfk0h+wK=KUvrv5oCudEAdEc_TY6=yZg_3uTqkgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZnmCUfk0h+wK=KUvrv5oCudEAdEc_TY6=yZg_3uTqkgw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, December 14, 2011, Linus Walleij wrote:
> On Wed, Dec 14, 2011 at 10:00 AM, Ulf Hansson
> <ulf.hansson@stericsson.com> wrote:
> > Guennadi Liakhovetski wrote:
> 
> > Using PM QoS as you propose, might prevent some hosts from doing
> > runtime_suspend|resume completely and thus those might not fulfill power
> > consumption requirements instead. I do not think we can take this decision
> > at this level. Is performance more important than power save, that is kind
> > of the question.
> 
> I agree with this point. The problematic part of the patch (IMHO) is this:
> 
> >> + This constraint prevents runtime-suspending the
> >> + device, if the expected wakeup latency is larger than 100us.
> (...)
> >> +                       int ret = dev_pm_qos_add_request(host->parent,
> >> +                                                        &host->pm_qos, 100);
> 
> So we hardcode 100us (is that really 100us by the way? I cannot
> follow this code path but usually these figures are in ms, but what
> do I know) as the in-between back-to-back transfers.

They are in microseconds.

> But this delta is dependent on a lot of stuff that only the platform
> knows, like nominal CPU frequency, bus speed etc, so certainly the
> platform must be able to modify that number.

You seem to be confusing things.  The exact meaning of this number is:
"I may want to use the device 100 us from now (but not earlier), so please
make it possible to do that".  [It roughly means "don't put the device into
a low-power state that takes more than 100 us to resume from", but it's a bit
more complicated than that.]  It doesn't mean "don't suspend the device for
the next 100 us".

> At the very least, please make this stuff optional using Kconfig
> so it can be shut off, because I fear it will screw up our PM usecases.

I'm not sure how that's possible, at least until your platform starts
to use device PM QoS.

> Ulfs patch to the mmci driver actually use 50ms for back-to-back
> intergap between any two hardware-affecting calls into the driver.

Which is kind of independent.

Thanks,
Rafael
