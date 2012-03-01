From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND PATCH] mmc: core: Fixup suspend/resume issues for UHS-I cards
Date: Thu, 1 Mar 2012 19:42:49 +0100
Message-ID: <CACRpkdbz9gBUZUabL5n8eQRebSo0EdW=8WLMpLNARHjV4h1g5Q@mail.gmail.com>
References: <1330616897-12032-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:32798 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab2CASmt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 13:42:49 -0500
Received: by iagz16 with SMTP id z16so1147392iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 01 Mar 2012 10:42:49 -0800 (PST)
In-Reply-To: <1330616897-12032-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Mar 1, 2012 at 4:48 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Even if cards supports 1.8V I/O voltage those should anyway be
> initialized at 3.3V I/O according to (e)MMC, SD and SDIO specs.
> Some eMMC and embedded SDIO devices are able to be initialized
> at 1.8V as well, but it is better to be safe.
>
> Do note that initialization in this context means that the card
> has been completely powered off, otherwise the card will remain
> at the last I/O voltage level that were negotitiated.
>
> Due to the above being taken care of the suspend/resume issues
> for UHS-I SD-cards has been fixed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
