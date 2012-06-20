From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: card: Do not scan boot partitions
Date: Wed, 20 Jun 2012 13:38:01 -0400
Message-ID: <87txy53mva.fsf@octavius.laptop.org>
References: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
	<87oboe4ibk.fsf@octavius.laptop.org>
	<CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
	<CACRpkda6gbAT1=qnHmvGv9UhqDVokvobcqw65vdsXHsrz8=QQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35750 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab2FTRiG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 13:38:06 -0400
In-Reply-To: <CACRpkda6gbAT1=qnHmvGv9UhqDVokvobcqw65vdsXHsrz8=QQw@mail.gmail.com>
	(Linus Walleij's message of "Wed, 20 Jun 2012 10:55:36 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Johan Rudholm <jrudholm@gmail.com>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Wed, Jun 20 2012, Linus Walleij wrote:
> On Wed, Jun 20, 2012 at 9:27 AM, Johan Rudholm <jrudholm@gmail.com> wrote:
>> 2012/6/20 Chris Ball <cjb@laptop.org>:
>>>
>>> Would it be impossible to add a partition table to mmcblkXbootY,
>>> or just unlikely?
>>
>> I believe this is just an unlikely scenario since the boot partitions
>> are supposed to contain boot code and also because of their relatively
>> small size (a few MBs), but there is no technical problem. Perhaps it
>> should be left up to the user?
>
> Like we add a Kconfig bool option "support partition scanning on boot
> partitions" and then we default that to "n", so systems that really
> want to do that can turn it on the day they need it.

I'm not so happy with adding Kconfig options for configuring driver
behavior -- it's usually a failure to just do the right thing.

If we think that people might want to use a partition table on their
boot partitions then we should just support doing that, as we do now.

In fact, the original patch submission for supporting boot partitions
used a Kconfig entry for turning on boot partition support, but we
decided to ditch the Kconfig entry and made it just happen by default.
I think we should continue that precedent and avoid a new entry here.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
