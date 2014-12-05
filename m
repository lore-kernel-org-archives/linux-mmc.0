From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Help on Info for Linux SD/MMC userspace utils/test frameworks
Date: Fri, 5 Dec 2014 11:23:32 +0100
Message-ID: <CAPDyKFry0NJCvJN9o6FQkR3txhanZbBVndJuodw=urgNhCVKJg@mail.gmail.com>
References: <CAOZ77ohJE=V56YjmbR8QVsp0fXVVoUUnhDwj7zD=kbv4ZWf8aA@mail.gmail.com>
	<CAOZ77oixi8zLB=ZTDcLqiCjHuv24HvnDFe4nem8BnbmGFnjH7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:42689 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaLEKXd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Dec 2014 05:23:33 -0500
Received: by mail-qg0-f43.google.com with SMTP id q108so212531qgd.16
        for <linux-mmc@vger.kernel.org>; Fri, 05 Dec 2014 02:23:32 -0800 (PST)
In-Reply-To: <CAOZ77oixi8zLB=ZTDcLqiCjHuv24HvnDFe4nem8BnbmGFnjH7Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suneel G <suneelgarapati@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 5 December 2014 at 07:41, Suneel G <suneelgarapati@gmail.com> wrote:
>
> Hello Ulf/Chris,
>
> mmc-utils.git seems to be limited and handles specific eMMC commands from
> userspace.

That's not a limit. It's per design.

>
> Can you help me with info/web links to repos/utils which help in issuing
> desired commands to SD/eMMC cards from userspace in Linux using SDHCI
> framework?

There are no SDHCI framework available to userspace. Besides the usual
device information though sysfs/debugs nodes.

>
> Also, does Linux MMC subsystem support SD Host Compliance test suite or
> certifications?

Nope. We have a test module (drivers/mmc/card/mmc_test.c) which has
support for a bunch of test cases.

Feel free to extend those!

Kind regards
Uffe
