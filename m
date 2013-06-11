From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12] mmc: core: mmc_bus to handle suspend|resume|shutdown
Date: Tue, 11 Jun 2013 11:24:49 +0200
Message-ID: <CACRpkdb7Xn88zsZ2Dg2GxC1sG9h=zn15ZrJUsV8R+TSFncjyUg@mail.gmail.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48541 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab3FKJYt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 05:24:49 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so11484620obb.18
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2013 02:24:49 -0700 (PDT)
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Pierre Ossman <pierre@ossman.eu>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Mon, Jun 10, 2013 at 5:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The MMC/SD/SDIO cards are registered on the mmc_bus and should from a power
> management perspective be controlled from there. As of today each and every
> host driver needs to issue mmc_suspend|resume_host from their respective
> .suspend|resume methods, which seems like an unnecessary requirement to
> put on them. Additionally, a shutdown sequence shall be initiated from the
> mmc_bus.
>
> This patch set moves the responsiblity to suspend the cards into the mmc_bus.
> It also invents the shutdown sequence, also to be handled from the mmc_bus.
> In the SDIO case, the shutdown sequence will not involve any SDIO specific
> operations. If this would be desired, I suggest to handle that as and separate
> step, since it would involve the sdio bus and potentially the sdio drivers.
>
> As a part of the patches releated to adding the shutdown sequence, specific
> issues to handle eMMC power off notification properly are included in this
> patch set as well.
>
> The mmc_suspend|resume_host functions are not removed, but will instead always
> return successful. A separate patch(es) build on top of this patch set, shall
> remove the API:s together with updating each and every host driver.
>
> Do note, that patch 1 to 4 has been sent earlier in the set "mmc: core: Let the
> mmc_bus handle suspend|resume sequence". Since the functionallity are very close
> releated I decided to fold them in into this patch set.
>
> A big thank you to Jaehoon Chung who has tested the patches 1 to 4.

Hm a significant portion of this patch set hits code which has not
been touched since Pierre Ossman wrote the first MMC code.
E.g. patch 1.

I know Pierre has long since moved on to other things, but I'm
pinging him anyway since it's his code after all...

Pierre: tell us if you want a copy of this patch set.

Yours,
Linus Walleij
