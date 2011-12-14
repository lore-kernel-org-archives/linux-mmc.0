From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
 first claimed
Date: Wed, 14 Dec 2011 10:27:30 +0100
Message-ID: <CACRpkdZnmCUfk0h+wK=KUvrv5oCudEAdEc_TY6=yZg_3uTqkgw@mail.gmail.com>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
	<4EE76CC2.9080308@stericsson.com>
	<Pine.LNX.4.64.1112131658330.20293@axis700.grange>
	<4EE865CA.8000407@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4EE865CA.8000407@stericsson.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 14, 2011 at 10:00 AM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:
> Guennadi Liakhovetski wrote:

> Using PM QoS as you propose, might prevent some hosts from doing
> runtime_suspend|resume completely and thus those might not fulfill power
> consumption requirements instead. I do not think we can take this decision
> at this level. Is performance more important than power save, that is kind
> of the question.

I agree with this point. The problematic part of the patch (IMHO) is this:

>> + This constraint prevents runtime-suspending the
>> + device, if the expected wakeup latency is larger than 100us.
(...)
>> +                       int ret = dev_pm_qos_add_request(host->parent,
>> +                                                        &host->pm_qos, 100);

So we hardcode 100us (is that really 100us by the way? I cannot
follow this code path but usually these figures are in ms, but what
do I know) as the in-between back-to-back transfers.
But this delta is dependent on a lot of stuff that only the platform
knows, like nominal CPU frequency, bus speed etc, so certainly the
platform must be able to modify that number.

At the very least, please make this stuff optional using Kconfig
so it can be shut off, because I fear it will screw up our PM usecases.

Ulfs patch to the mmci driver actually use 50ms for back-to-back
intergap between any two hardware-affecting calls into the driver.

Yours,
Linus Walleij
