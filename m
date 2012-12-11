From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Tue, 11 Dec 2012 15:35:59 +0100
Message-ID: <CACRpkdbhOJxr9M1BjRD5=F4vX33WfWRMY-hkD=J+EVtZ2vSFgg@mail.gmail.com>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:60701 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab2LKOgB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 09:36:01 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1522674eaa.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Dec 2012 06:35:59 -0800 (PST)
In-Reply-To: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Dec 11, 2012 at 3:17 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The amba bus is already performing same actions but for the apb_pclk.
> So here we just make sure the clock to card is gated as well to save
> more power. At runtime resume we will thus restore the clock again.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks correct to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
