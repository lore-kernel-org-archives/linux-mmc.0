From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: card: Do not scan boot partitions
Date: Thu, 21 Jun 2012 10:05:08 +0200
Message-ID: <CACRpkda+9G6Xawk14NOx05Osm9rmJNNe8wbiDKbMgrrEP1CPJw@mail.gmail.com>
References: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
	<87oboe4ibk.fsf@octavius.laptop.org>
	<CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
	<CACRpkda6gbAT1=qnHmvGv9UhqDVokvobcqw65vdsXHsrz8=QQw@mail.gmail.com>
	<87txy53mva.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62650 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab2FUIFJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 04:05:09 -0400
Received: by wgbdr13 with SMTP id dr13so373313wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jun 2012 01:05:08 -0700 (PDT)
In-Reply-To: <87txy53mva.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Johan Rudholm <jrudholm@gmail.com>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

On Wed, Jun 20, 2012 at 7:38 PM, Chris Ball <cjb@laptop.org> wrote:
> On Wed, Jun 20 2012, Linus Walleij wrote:
>>
>> Like we add a Kconfig bool option "support partition scanning on boot
>> partitions" and then we default that to "n", so systems that really
>> want to do that can turn it on the day they need it.
>
> I'm not so happy with adding Kconfig options for configuring driver
> behavior -- it's usually a failure to just do the right thing.

This is not for drivers but for the core. But I get the idea...

> If we think that people might want to use a partition table on their
> boot partitions then we should just support doing that, as we do now.

OK in that case I think it's better to disallow partition tables
on the boot partitions, then the day someone has a valid usecase
we can add it back.

So then the patch is good as it is to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
