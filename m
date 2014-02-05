From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/17] i2c: nomadik: Convert to devm functions
Date: Wed, 5 Feb 2014 15:32:10 +0100
Message-ID: <CACRpkdawmeE3+UAddXhn0OcwgKQhBYXyGYmZa115b7poiEtRZA@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-12-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:39841 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaBEOcL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2014 09:32:11 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so491643obc.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 Feb 2014 06:32:11 -0800 (PST)
In-Reply-To: <1391529538-21685-12-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Rubini <rubini@unipv.it>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-spi@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Feb 4, 2014 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Use devm_* functions to simplify code and error handling.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

However make sure this (and the rest) applies on top of this patch:
http://marc.info/?l=linux-i2c&m=139142325809973&w=2

Because I expect that to be applied first.

Yours,
Linus Walleij
