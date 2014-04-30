From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: poll if CD is broken
Date: Wed, 30 Apr 2014 17:17:56 +0200
Message-ID: <53611424.4050901@linutronix.de>
References: <1398865484-527-1-git-send-email-bigeasy@linutronix.de> <CAELcNGT7Ei35tmZzAJ4iCdwMCamd5tC-onRmNG3JL+78_6B0-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52592 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422649AbaD3PSB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 11:18:01 -0400
In-Reply-To: <CAELcNGT7Ei35tmZzAJ4iCdwMCamd5tC-onRmNG3JL+78_6B0-w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 04/30/2014 04:57 PM, Jae hoon Chung wrote:
> Hi, Sebastian.

Hi Jaehoon,

> I didn't know which Soc you used.

Altera socfpa.

> Do you use the Device-tree? if you use the device-tree, just add the
> "broken-cd" property.

and with this property the code will rescan the card every few secs? I
didn't see this in v3.12. I do have "broken-cd" set. And the card will
not be detected if it is inserted after the driver probed.

But now that you pointed me at it. You say that "broken-cd" will be
scanned by the core, right? Shouldn't the driver then call
mmc_of_parse() or am I missing something?

> Best Regards,
> Jaehoon Chung

Sebastian
