From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 0/8] Armada 38x SDHCI driver improvements
Date: Thu, 8 Oct 2015 15:21:11 +0200
Message-ID: <CAPv3WKfQk9DkD+0=Nh736sGhF99rcEVPP7bb00PzT2oAGLmoaw@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<87lhbg9hx7.fsf@free-electrons.com>
	<CAPv3WKcFDVwdnBbTAbV2FGQu5s+WbLmM7s98mAJQc8hpUhW+9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35598 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560AbbJHNVM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 09:21:12 -0400
Received: by oigi138 with SMTP id i138so4553548oig.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2015 06:21:11 -0700 (PDT)
In-Reply-To: <CAPv3WKcFDVwdnBbTAbV2FGQu5s+WbLmM7s98mAJQc8hpUhW+9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>

Hi Gregory,

I have an update about s2ram status - after adding suspend/resume
support to pinctrl driver rootfs on SDHCI card survived suspend/resume
sequence without any problem (with broken-cd software polling, I also
have GP < v1.5).

Best regards,
Marcin

2015-10-06 17:48 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> Gregory,
>
>>
>> Thanks for this series, it looks good I have only one or two comments.
>>
>> I also want to test it, how do you test the resume?
>> using standby or suspend to ram (by hacking the kernel as currently we
>> disbaled it) ?
>>
>
> Standby works even without the patch, as the registers' contents do
> not disappear. I added rejected s2ram support on top of 4.3-rc4 and
> used it. Today however I changed my card to another one and got -110
> error (timeout) - I have to re-check it. Anyway the patch is needed
> for sure, because without MBUS window configuration any access to the
> card ends up with a kernel hang.
>
> Best regards,
> Marcin
