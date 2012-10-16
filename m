From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
Date: Tue, 16 Oct 2012 10:17:59 +0200
Message-ID: <CACRpkdZPbrvfk0QNB7x8YZ+DVibPJMTLsLDSf310CcBEeOTuww@mail.gmail.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
	<CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47739 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab2JPISA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Oct 2012 04:18:00 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so5202377wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Oct 2012 01:17:59 -0700 (PDT)
In-Reply-To: <CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Per Forlin <per.forlin@stericsson.com>

On Tue, Oct 16, 2012 at 9:16 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> This code has not been tested on a "legacy" ARM PL180 but only for
> ux500 boards. Even if it should affect DMA handling we should test
> this properly. Would be great if you were able to help out, I guess
> you still have available hardware for these tests?

I can test the Integrator/CP and Realview in IRQ/PIO mode and
the U300 in DMA mode.

I need some help to provoke errorpath in DMA mode though,
so any hints are welcome...

Yours,
Linus Walleij
