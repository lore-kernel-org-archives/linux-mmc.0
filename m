From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC] sdhci: use ios->clock to know when sdhci is idle
Date: Sun, 2 Jan 2011 22:08:10 +0100
Message-ID: <AANLkTin7OYXzCYty8pDxyzE_Bg83=+L8jmcaoEMSf4QM@mail.gmail.com>
References: <1293023621-3077-1-git-send-email-tardyp@gmail.com>
	<41EFD7A46E18724CAB128DAD00733480193D2AE61C@shsmsx502.ccr.corp.intel.com>
	<AANLkTinYWODS785AefQ7hV+urPkAn1+En-fZEaFQygLG@mail.gmail.com>
	<CE761E84DADF2947A4AF22FB8D97A47331E86F6E@shsmsx501.ccr.corp.intel.com>
	<AANLkTimB7h0ZxvSOt2dUkO90RxE2c3Bu3CRqpasgzxw=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63793 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1ABVIM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Jan 2011 16:08:12 -0500
In-Reply-To: <AANLkTimB7h0ZxvSOt2dUkO90RxE2c3Bu3CRqpasgzxw=@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: "Gao, Yunpeng" <yunpeng.gao@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>

> Not all SDIO cards will work properly if you try to gate them
> so we need a mechanism to selectively do this.
You are right..##??!! HW vendors that does not support standards...

AFAIK (was working on a sdio HW IP team before), the sdio clock is not
supposed to be taken as is for a system clock derivative especially
because it can stop between request.
SDIO IRQ are asynchronous when a command or data is not ongoing

> Any suggestions?
I would personally suggest white list from drivers. With a call to
mmc_host_allow_gate_card(struct mmc_card *card, bool allow)

see following patch..

Regards,
-- 
Pierre
