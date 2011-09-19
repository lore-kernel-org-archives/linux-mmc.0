From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: sdio: Workaround for dev with broken CMD53
Date: Mon, 19 Sep 2011 10:55:27 +0200
Message-ID: <CACRpkdb_hDiDzefc9mRb=DAWPLcGzuspN8TL6qQrZ5dAm7yg=g@mail.gmail.com>
References: <1316101384-21009-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39816 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab1ISIz2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2011 04:55:28 -0400
Received: by pzk1 with SMTP id 1so10528189pzk.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2011 01:55:27 -0700 (PDT)
In-Reply-To: <1316101384-21009-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

On Thu, Sep 15, 2011 at 5:43 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> Adds a quirk which can be turned on for SDIO devices
> that do not support 512 byte requests in byte mode during
> CMD53. These requests will always be sent in block mode
> instead.
>
> This patch also enables this quirk for ST-Ericsson
> CW1200 WLAN device.
>
> Change-Id: Id31787fcbfeb0b97ba2e8c583e9363a7c08811d2
> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf HANSSON <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
