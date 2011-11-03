From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Quirk for long data read time
Date: Thu, 3 Nov 2011 12:32:06 +0100
Message-ID: <CAKnu2Mqr2Vi8f3KkgmQxywucAS9BN4rY-SxSOiFd5oV06sZ12w@mail.gmail.com>
References: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59421 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab1KCLcG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2011 07:32:06 -0400
Received: by gyc15 with SMTP id 15so127289gyc.19
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2011 04:32:06 -0700 (PDT)
In-Reply-To: <1320309852-21893-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, stable@kernel.org

2011/11/3 Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>:

> Adds a quirk that sets the data read timeout to a fixed value instead
> of relying on the information in the CSD. The timeout value choosen
> is 300ms since that has proven enough for the problematic cards found,
> but could be increased if other cards require this.
>
> This patch also enables this quirk for certain Micron cards known to
> have this problem.
>
> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

And I thought it was enough with *people* who didn't deliver stuff
they promised in due time, now even *memory cards* miss their
own promised deadlines.... :-)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This should go into stable as well right?

Thanks,
Linus Walleij
