From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Fixup handling of MCI_STARTBITERR
Date: Fri, 11 Nov 2011 16:17:17 +0100
Message-ID: <CACRpkdazenok0RHQL0kXLKk2i3bcrWZ9aWDmoCGfjF6JpEoySA@mail.gmail.com>
References: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57045 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1KKPRS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 10:17:18 -0500
Received: by gyc15 with SMTP id 15so2973218gyc.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Nov 2011 07:17:18 -0800 (PST)
In-Reply-To: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, stable@kernel.org

On Thu, Nov 10, 2011 at 4:33 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> The interrupt was previously enabled and then correctly cleared.
> Now we also handle it correctly.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This should also go to -stable I think?

Linus Walleij
