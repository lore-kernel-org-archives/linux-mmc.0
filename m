From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Tue, 8 Dec 2015 21:35:20 +0100
Message-ID: <CAPDyKFpcsKihuOiF5=RwoWrF0Jf7hRsXVSU5uV8qZf1mUsa-iQ@mail.gmail.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
	<CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
	<CAOQ7t2aJAPWd3Xmvu7n0EWL-KC8ZriM3KryfsYEh556uXhuR+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32922 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbLHUfV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2015 15:35:21 -0500
Received: by vkca188 with SMTP id a188so28717467vkc.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2015 12:35:20 -0800 (PST)
In-Reply-To: <CAOQ7t2aJAPWd3Xmvu7n0EWL-KC8ZriM3KryfsYEh556uXhuR+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, Jerry Cao <jerry.cao@amlogic.com>, Victor Wan <victor.wan@amlogic.com>, linux-meson@googlegroups.com, Carlo Caione <carlo@endlessm.com>

[...]

>
> I have actually a problem and a question related to this value. On the
> boards I'm currently using to test this driver I have no CD GPIO. In
> this case do I have to specify the MMC as "non-removable"? Also if I

"non-removable" is intended to be used for eMMC or other cards
(SD/SDIO) that is not possible to remove/insert at runtime.

> try to change an SD card at runtime I have to wait 3 times the timeout
> before being able to do it successfully.

I guess you are using the "broken-cd" binding, which will enable
MMC_CAP_NEEDS_POLL and thus the mmc core will poll to detect cards
being inserted or removed.

[...]

Kind regards
Uffe
