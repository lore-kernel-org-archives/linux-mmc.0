From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v2 2/5] mmc: sdhci-pxav3: enable usage of DAT3 pin as HW
 card detect
Date: Fri, 9 Oct 2015 16:45:25 +0200
Message-ID: <CAPv3WKddfCOSCCOSByAEzyZ3qnAX22TFi2acrNDcTgEvy+ioFA@mail.gmail.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
	<1444352635-21965-3-git-send-email-mw@semihalf.com>
	<20151009201356.78488116@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33779 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbbJIOpZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 10:45:25 -0400
Received: by obbbh8 with SMTP id bh8so64109015obb.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 07:45:25 -0700 (PDT)
In-Reply-To: <20151009201356.78488116@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Jisheng,


>>
>> When using DAT3-based detection Armada 38x SDIO IP expects its internal
>> clock to be always on, which had to be ensured twofold:
>
> What happen if runtime suspend disables its core clk and axi clk? I guess
> dat3-based detection isn't compatible with runtime pm. If so, do we also
> need to disable runtime pm in probe function?

Is runtime resume supposed to be triggered by card detection? Is there
a way to manually trigger runtime suspend and resume of sdhci? Anyway
coreclk is not a problem, as it's not used by A38x.

>
>> - Each time controller is reset by updating appropriate registers. On the
>>   occasion of adding new register @0x104, register @0x100 name is modified
>>   in order to the be aligned with Armada 38x documentation.
>> - Leaving the clock enabled despite power-down. For this purpose a new
>>   quirk had to be added to SDHCI subsystem - SDHCI_QUIRK2_KEEP_INT_CLK_ON.
>
> As seen from other mails, Ulf calls for no more quirks...
>

Ok, I'll try to find another solution.

Best regards,
Marcin
