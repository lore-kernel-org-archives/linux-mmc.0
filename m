From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND PATCH 1/2] mmc: mmci: Fix incorrect handling of HW flow
 control for SDIO
Date: Wed, 10 Oct 2012 19:32:15 +0200
Message-ID: <CACRpkdYarGEzYoJwHggQh2O=hw_wyhP9KQ2GRruWh64SwnH=VA@mail.gmail.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61817 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab2JJRcT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Oct 2012 13:32:19 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so7482198wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Oct 2012 10:32:15 -0700 (PDT)
In-Reply-To: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, Oct 10, 2012 at 6:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For data writes <= 8 bytes, HW flow control was disabled but
> never re-enabled when the transfer was completed. This meant
> that a following read request would give buffer overrun errors.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks correct to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this goes into Russell's patch tracker.

Yours,
Linus Walleij
