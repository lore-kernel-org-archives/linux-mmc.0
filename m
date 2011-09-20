From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Set correct bus mode before card init
Date: Tue, 20 Sep 2011 08:48:49 +0200
Message-ID: <CACRpkdY6nTa+zSmEbucUFZwXYd+qy3Sy_2ffDHTwEvGryWtEZg@mail.gmail.com>
References: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43523 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1ITGsu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2011 02:48:50 -0400
Received: by gxk6 with SMTP id 6so125728gxk.19
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2011 23:48:50 -0700 (PDT)
In-Reply-To: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

On Thu, Sep 15, 2011 at 5:50 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> Earlier all cards where initiated with bus mode set as OPENDRAIN, and then
> later switched to PUSHPULL. According to the MMC/SD/SDIO specifications only
> MMC cards use OPENDRAIN during init. For both SD and SDIO the bus mode shall
> be PUSHPULL before attempting to init the card.
>
> The consequence of having incorrect bus mode can lead to not being able
> to detect the card. Therefore the default behavior have now been changed to
> PUSHPULL in mmc_power_up, and will only be temporarily switched when trying
> to attach or init a MMC card.
>
> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf HANSSON <ulf.hansson@stericsson.com>

Looks solid to me,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
