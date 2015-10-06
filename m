From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 4/8] mmc: sdhci-pxav3: enable proper resuming on Armada
 38x SoC
Date: Tue, 6 Oct 2015 17:08:29 +0200
Message-ID: <CAPv3WKcPMk4pZPaUR9GG0-nFKtb1gB-G3DS2NY257dsPp4ZFQQ@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-5-git-send-email-mw@semihalf.com>
	<877fn09hjw.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35555 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbbJFPIa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 11:08:30 -0400
Received: by obbzf10 with SMTP id zf10so156271592obb.2
        for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2015 08:08:29 -0700 (PDT)
In-Reply-To: <877fn09hjw.fsf@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>

Gregory,

2015-10-06 16:51 GMT+02:00 Gregory CLEMENT <gregory.clement
>> +     if (of_device_is_compatible(np, "marvell,armada-380-sdhci"))
>> +             ret = mv_conf_mbus_windows(dev, pxa->mbus_win_regs,
>> +                                        mv_mbus_dram_info());
>
> I would find it cleaner to not rely on the device tree outise the probe
> function. What about just testing pxa->mbus_win_regs ? As it is set only
> if we need it, it should be a good test.
>

Sure, it will ease calling the function.

Thanks,
Marcin
