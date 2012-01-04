From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Force a "detect" to handle non-properly
 removed cards
Date: Wed, 4 Jan 2012 10:40:51 +0100
Message-ID: <CACRpkdZmiaOGah00UBmhWEcbhc7=xFrc3p0VFB=tFmpo5hEmGA@mail.gmail.com>
References: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46461 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab2ADJkw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 04:40:52 -0500
Received: by iaeh11 with SMTP id h11so32301358iae.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jan 2012 01:40:51 -0800 (PST)
In-Reply-To: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Jan 3, 2012 at 11:33 AM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Removing a card "slowly" can trigger a GPIO irq to be raised far
> before the card is actually removed. This means the scheduled
> detect work will not find out that the card were removed and thus
> the card and the block device will not be unregistered.
>
> Let the mmc_detect_card_removed function trigger a new detect
> work immediately when it discovers that a card has been removed.
> This will solve the described issue above. Moreover we make sure
> the detect work is executed as soon as possible, since there is
> no reason for waiting for a "delayed" detect to happen.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

This looks way more solid than the simple variable.
The old detect_change variable does not seem to be
protected by any lock either.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
