From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc/sdio: remember new card RCA when redetecting card
Date: Wed, 2 Mar 2011 17:04:54 +0100
Message-ID: <AANLkTimP2nQVHb51oyXLZf-ve_Gzp-7mBQwW_ZZia=ex@mail.gmail.com>
References: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57859 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBQEz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 11:04:55 -0500
Received: by pvg12 with SMTP id 12so9194pvg.19
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2011 08:04:54 -0800 (PST)
In-Reply-To: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

2011/3/1 Linus Walleij <linus.walleij@stericsson.com>:

> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> During redetection of a SDIO card, a request for a new card RCA
> was submitted to the card, but was then overwritten by the old RCA.
> This caused the card to be deselected instead of selected when using
> the incorrect RCA.

Chris can you look at this, I think it's a bug as in "-rc bug" that
needs fixing.

Yours,
Linus Walleij
