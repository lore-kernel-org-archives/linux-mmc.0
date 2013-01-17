From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: mmci: Fixup clock gating when freq is 0 for ST-variants
Date: Thu, 17 Jan 2013 11:23:56 +0100
Message-ID: <CACRpkdbHWtyDVApiZZjueZA=60SK39ZuCS6Kmhz88OupSqNENQ@mail.gmail.com>
References: <1357748222-26829-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:50639 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493Ab3AQKX4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 05:23:56 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so4482648ieb.34
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jan 2013 02:23:56 -0800 (PST)
In-Reply-To: <1357748222-26829-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Jan 9, 2013 at 5:17 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Johan Rudholm <johan.rudholm@stericsson.com>
>
> In the ST Micro variant, the MMCICLOCK register must not be used to
> gate the clock. Instead use MMCIPOWER register and by clearing the
> PWR_ON bit to do this.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
