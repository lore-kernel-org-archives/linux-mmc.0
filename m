From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Sun, 6 Mar 2011 13:22:30 +0100
Message-ID: <AANLkTinkwRM3YPwJ7omOdxRjgcnDa3FuriN3UsRsR-tB@mail.gmail.com>
References: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikeQs_eVHYc8vA8+m5tSHRDLnE3Xf9b5yWRj4p=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50403 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab1CFMWa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2011 07:22:30 -0500
Received: by pwi15 with SMTP id 15so618619pwi.19
        for <linux-mmc@vger.kernel.org>; Sun, 06 Mar 2011 04:22:30 -0800 (PST)
In-Reply-To: <AANLkTikeQs_eVHYc8vA8+m5tSHRDLnE3Xf9b5yWRj4p=@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, Gary King <gking@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org

2011/3/6 Andrei Warkentin <andreiw@motorola.com>:

> I think Colin mentioned the emmc spec doesn't subtract the boot
> sectors, just that some out of spec devices do... (sounds like another
> use for mmc blk quirks)

In which case it sounds like it will be the majority of them deviating from
the spec right now given that there aren't very many of them around :-(

Details on this Colin?

Certainly we can come up with some card quirks for this.

Yours,
Linus Walleij
