From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: mmci: add capabilities2 for MMC_CAP2
Date: Thu, 17 Nov 2011 08:42:21 +0100
Message-ID: <CACRpkdYLoQowxtg3qqSyi5cS26z1e_=p12EKKkSzvcKP96YLnQ@mail.gmail.com>
References: <1321268548-21933-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39933 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1KQHmW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 02:42:22 -0500
Received: by yenq3 with SMTP id q3so695365yen.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2011 23:42:21 -0800 (PST)
In-Reply-To: <1321268548-21933-1-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, Nov 14, 2011 at 12:02 PM, Per Forlin <per.forlin@stericsson.com> wrote:

Some more verbose blurb on the patch here maybe?

> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> ---
> This patch depends on patches adding CAP2 available on mmc-next.
> Chris, would you mind merging this through your tree when it
> has been accepted.

Seems like the right way to pass caps from the platform.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
