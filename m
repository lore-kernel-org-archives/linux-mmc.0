From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Sun, 16 Oct 2011 22:34:07 +0200
Message-ID: <CAKnu2MrohC0=1kC2Qo=BrcPxgEQ16B4EczehUbz1JtNRx2Cb4w@mail.gmail.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
	<20111013142914.GZ21648@n2100.arm.linux.org.uk>
	<1318521592.2090.16.camel@linaro1>
	<4E97E6CF.1000601@stericsson.com>
	<20111014074224.GQ21648@n2100.arm.linux.org.uk>
	<4E97EA10.6040800@stericsson.com>
	<20111014080318.GR21648@n2100.arm.linux.org.uk>
	<4E97F131.6090406@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45052 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab1JPUeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Oct 2011 16:34:08 -0400
Received: by ywf7 with SMTP id 7so44917ywf.19
        for <linux-mmc@vger.kernel.org>; Sun, 16 Oct 2011 13:34:07 -0700 (PDT)
In-Reply-To: <4E97F131.6090406@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2011/10/14 Ulf Hansson <ulf.hansson@stericsson.com>:

> So how can we handle to merge it via mmc tree instead? Will you be able to
> "Ack" patches for mmci so Chris Ball can merge them for the mmc tree
> instead?

If you get Russell's ACK on it (provided it is merged on top of
Adrians patch) Chris can surely merge it into his tree.
He's already merging subsystem-wide patches (like Adrians)
to his tree, often touching several drivers in the process, as is
custom.

Have we checked if there are more spin_lock():s in the
other MMC host drivers that also should be removed as a
result of this or is MMCI the sole sinner?

Cross-tree dependencies is a mess, sadly we have no way
of solving that which is perfect. (Yet.)

Yours,
Linus Walleij
