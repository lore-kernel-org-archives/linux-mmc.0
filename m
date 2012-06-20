From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: card: Do not scan boot partitions
Date: Wed, 20 Jun 2012 10:55:36 +0200
Message-ID: <CACRpkda6gbAT1=qnHmvGv9UhqDVokvobcqw65vdsXHsrz8=QQw@mail.gmail.com>
References: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
	<87oboe4ibk.fsf@octavius.laptop.org>
	<CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49926 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645Ab2FTIzh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 04:55:37 -0400
Received: by qcro28 with SMTP id o28so4038799qcr.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jun 2012 01:55:36 -0700 (PDT)
In-Reply-To: <CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

On Wed, Jun 20, 2012 at 9:27 AM, Johan Rudholm <jrudholm@gmail.com> wrote:
> 2012/6/20 Chris Ball <cjb@laptop.org>:
>>
>> Would it be impossible to add a partition table to mmcblkXbootY,
>> or just unlikely?
>
> I believe this is just an unlikely scenario since the boot partitions
> are supposed to contain boot code and also because of their relatively
> small size (a few MBs), but there is no technical problem. Perhaps it
> should be left up to the user?

Like we add a Kconfig bool option "support partition scanning on boot
partitions" and then we default that to "n", so systems that really
want to do that can turn it on the day they need it.

Could you augment the patch like that?

Yours,
Linus Walleij
