From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] MMC updates for 3.16-rc1
Date: Wed, 11 Jun 2014 21:27:31 -0700
Message-ID: <CA+55aFyEbFLFWLKP5kHw85qTRNoviFk8LhivxXJgAMROdvJtsg@mail.gmail.com>
References: <86ha3so84o.fsf@void.printf.net>
	<CA+55aFxBwteZeUHG+Z-cdLU_YCO4f8TDuYvGmXc0-v9M1H11+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:42401 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaFLE1c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jun 2014 00:27:32 -0400
In-Reply-To: <CA+55aFxBwteZeUHG+Z-cdLU_YCO4f8TDuYvGmXc0-v9M1H11+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

On Tue, Jun 10, 2014 at 2:50 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Also, that new drivers/mmc/host/usdhi6rol0.c driver is one f*cking
> noisy compile, and knisr certainly has never been tested in a 64-bit
> environment. Please either fix it, or make it depend on BROKEN.

Guys? Seriously, if that driver isn't fixed, I'm going to mark it
broken myself. It pretty much generates as many lines of warnings as
the rest of my "allmodconfig" build combined.

It's extremely annoying, and the crazy warnings are likely to hide
potential real problems elsewhere, so right now that driver has
negative value. I do a lot of allmodconfig builds during the merge
window, and I am not going to look at that warning much longer.

Fix it promptly, or it gets disabled.

            Linus
