From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v2 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's caps
 according to erratum ERR-7878951
Date: Fri, 23 Jan 2015 12:12:59 +0100
Message-ID: <CAPv3WKfGtJOYO+t+OzawhHyK4vpGAFFmK487ybUtZB7RL05c1A@mail.gmail.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
	<1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
	<20150123110303.GD23493@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:37208 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbAWLNA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jan 2015 06:13:00 -0500
Received: by mail-ob0-f182.google.com with SMTP id gq1so6524722obb.13
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2015 03:13:00 -0800 (PST)
In-Reply-To: <20150123110303.GD23493@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Mark

2015-01-23 12:03 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> [...]
>
>> +     /*
>> +      * According to erratum 'ERR-7878951' Armada 38x SDHCI
>> +      * controller has different capabilities than the ones shown
>> +      * in its registers
>> +      */
>> +     host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +     if (of_get_property(np, "no-1-8-v", NULL)) {
>
> Please use of_property_read_bool(np, "no-1-8-v")
>
>> +             host->caps &= ~SDHCI_CAN_VDD_180;
>> +             host->mmc->caps &= ~MMC_CAP_1_8V_DDR;
>
> Is SDHCI_CAN_VDD_330 always set elsewhere in this case?

Yes, it's always set in SDHCI_CAPABILITIES register of Armada 38x
(assigned to host->caps few lines above), as well as
SDHCI_CAN_VDD_180. The point is, that in reality they can't be used
simultaneously for this device, i.e. voltage switching is impossible.

Thanks,
Marcin

>
>> +     } else
>> +             host->caps &= ~SDHCI_CAN_VDD_330;
>
