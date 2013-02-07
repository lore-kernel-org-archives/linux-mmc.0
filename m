From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Add pinctrl support
Date: Thu, 7 Feb 2013 16:30:27 +0100
Message-ID: <CACRpkdbJJq3+BkHwzM_osDxdY5ZuVyTuYDjejaqNRRETMf7a6w@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
	<1360238236-17694-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:46216 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124Ab3BGPae (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Feb 2013 10:30:34 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so3114499iab.9
        for <linux-mmc@vger.kernel.org>; Thu, 07 Feb 2013 07:30:34 -0800 (PST)
In-Reply-To: <1360238236-17694-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>

On Thu, Feb 7, 2013 at 12:57 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> Added support for pin configuration using pinctrl subsystem.
>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

NACK.

In the v3.9 merge window we will merge this patch:
http://marc.info/?l=linux-kernel&m=135887740715083&w=2

That should do the trick. Just define your tables properly.

Yours,
Linus Walleij
