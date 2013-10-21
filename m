From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/8] sdhci: Move real work out of an atomic context
Date: Mon, 21 Oct 2013 16:31:32 +0100
Message-ID: <86hacaprmz.fsf@void.printf.net>
References: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38280 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab3JUPbe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 11:31:34 -0400
In-Reply-To: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com>
	(Jeremie Samuel's message of "Mon, 21 Oct 2013 17:25:49 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: linux-mmc@vger.kernel.org, =?utf-8?Q?Gr=C3=A9gor?= Boirie <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>

Hi Jeremie,

On Mon, Oct 21 2013, Jeremie Samuel wrote:
> Currently the sdhci driver does everything in the atomic context.
> And what is worse, PIO transfers are made from the IRQ handler.
>
> Some patches were already submitted to solve this issue. But there were
> rejected because they involved new issues.
>
> This set of patches is an evolution of an old patch from Anton Vorontsov.
> I tried to fix all the problems involved by the patches. I tested it for
> several time now with SD cards and SDIO.
>
> So, this patch set reworks sdhci code to avoid atomic context,
> almost completely.

Could we get a changelog from patchset v1 to v2, for the record?
(And isn't this more like v4 of your series?)

You don't have to resend the patchset, just replying with the
changelog here is fine.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
