From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi: spi-pl022: Adjust probe() to of_get_named_gpio()
 returning -EPROBE_DEFER
Date: Mon, 18 Jun 2012 13:47:32 +0200
Message-ID: <CACRpkdYTE0imxEAdq0=wJO49iBAj=8xGjn_PevFm1Bsr3MvUQg@mail.gmail.com>
References: <1340011219-31657-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:59956 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab2FRLrd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 07:47:33 -0400
Received: by qafi31 with SMTP id i31so1507687qaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jun 2012 04:47:33 -0700 (PDT)
In-Reply-To: <1340011219-31657-1-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org, spi-devel-general@lists.sourceforge.net

On Mon, Jun 18, 2012 at 11:20 AM, Roland Stigge <stigge@antcom.de> wrote:

> The patch to gpiolib-of.c providing -EPROBE_DEFER as a hint to defer
> of_get_named_gpio*() to a later probe() breaks spi-pl022.c.
>
> This patch adjusts to this change, using -EPROBE_DEFER as indication to defer.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Should this patch be joined with gpiolib-of's patch to of_get_named_gpio()? Or
> should they just be issued as a series?

If it's not bisectable unless you change this in the same patch then join
them. Else I'd put them in a series and try to figure out a good tree for
merging them.

Yours,
Linus Walleij
