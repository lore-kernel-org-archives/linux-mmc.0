From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Gate the clock when freq is 0
Date: Wed, 12 Dec 2012 19:57:16 +0100
Message-ID: <CACRpkdabPfZ0mmU3XYh_NT-w6ZYZeJaGLiQK8__1H9qA-dWAAw@mail.gmail.com>
References: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36420 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab2LLS5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 13:57:17 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so715946eek.19
        for <linux-mmc@vger.kernel.org>; Wed, 12 Dec 2012 10:57:16 -0800 (PST)
In-Reply-To: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Dec 12, 2012 at 4:50 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Johan Rudholm <johan.rudholm@stericsson.com>
>
> In the ST Micro variant, the MMCI_CLOCK register should not be used to
> gate the clock. Use MMCI_POWER to do this.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I don't know if I'm qualified to ACK anything more today after
misunderstanding so many patches, but this seems correct to
me and won't affect any non-ST IP, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
