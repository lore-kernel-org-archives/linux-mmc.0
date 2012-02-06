From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V4] mmc: core: Detect card removal on I/O error
Date: Mon, 6 Feb 2012 18:31:57 +0100
Message-ID: <CACRpkdb+F8y8t1Mw+2mVORLfBJgYsR6S7YByO4em1jhhCRb0=A@mail.gmail.com>
References: <1328521359-31962-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47701 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab2BFRb6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 12:31:58 -0500
Received: by ggnh1 with SMTP id h1so2907478ggn.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Feb 2012 09:31:57 -0800 (PST)
In-Reply-To: <1328521359-31962-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Mon, Feb 6, 2012 at 10:42 AM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> To prevent I/O as soon as possible at card removal, a new
> detect work is re-scheduled without a delay to let a rescan
> remove the card device as soon a possible.
>
> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
> "slowly" removed cards that a scheduled detect work did not
> detect as removed. To prevent further I/O requests for these
> lingering removed cards, check if card has been removed and then
> schedule a detect work to properly remove it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
