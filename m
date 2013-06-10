From: Daniel Drake <dsd@laptop.org>
Subject: "exclude asynchronous transfer" patch causes boot fail
Date: Mon, 10 Jun 2013 13:53:55 -0600
Message-ID: <CAMLZHHRt=ajakDx6ZFRVx8CUKNojury5fX8R+gBhhJTOstQ6Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:40872 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab3FJTx4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 15:53:56 -0400
Received: by mail-qa0-f49.google.com with SMTP id hu16so2500046qab.8
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2013 12:53:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: tgih.jun@samsung.com

Hi,

Testing the latest linus kernel on OLPC XO-4 (sdhci-pxav3), boot
fails. Userspace does start, and I see that systemd is starting a few
services (feels a bit slower than usual), then it hangs still while
loading initial services - I don't even get to a shell prompt.

git-bisect shows the following commit introduces the problem:

commit 369d321ed1baa7748e770aaaae4d8effad699633
Author: Seungwon Jeon <tgih.jun@samsung.com>
Date:   Wed Dec 26 10:40:17 2012 +0900

    mmc: queue: exclude asynchronous transfer for special request

mmc debug messages from the point of hang:

sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc1:     4096 bytes transferred: 0
mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000
<mmc1: starting CMD23 arg 00000008 flags 00000015>
mmc1: starting CMD18 arg 00023000 flags 000000b5
mmc1:     blksz 512 blocks 8 flags 00000200 tsac 10 ms nsac 0
mmc1:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000002
mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc1:     4096 bytes transferred: 0
mmc1:     (CMD12): 0: 00000000 00000000 00000000 00000000


If I modify the patch as follows, things seem to be back to normal:
#define MMC_REQ_SPECIAL_MASK (REQ_DISCARD)

Whereas setting it as follows causes the boot failure:
#define MMC_REQ_SPECIAL_MASK (REQ_FLUSH)

So I would suspect that there is some incompatibility between
REQ_FLUSH handling and the optimization that this patch introduces.

Any ideas?

Daniel
