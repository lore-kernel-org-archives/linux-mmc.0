From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: core: Fix deadlock when the CONFIG_MMC_UNSAFE_RESUME
 is not defined
Date: Thu, 24 Nov 2011 11:17:25 +0100
Message-ID: <CACRpkdaraRjijt3a290OUwsFVJL4hNp4KRmZKboPpgxjoHieAg@mail.gmail.com>
References: <1322017998-16559-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55275 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab1KXKRZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 05:17:25 -0500
Received: by iage36 with SMTP id e36so2790439iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2011 02:17:25 -0800 (PST)
In-Reply-To: <1322017998-16559-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, cjb@laptop.org

On Wed, Nov 23, 2011 at 4:13 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:

> mmc_suspend_host() tries to claim host during suspend
> and release it only when the bus suspend operation is
> compeleted. If CONFIG_MMC_UNSAFE_RESUME is defined and
> the host is flagged as removable, mmc_suspend_host()
> tries to remove the card. In this process, the file system
> sync can get blocked trying to acquire host which is already
> claimed by mmc_suspend_host() causing deadlock.
>
> Fix this deadlock by releasing host before ->remove() is called.
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

Looks correct!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
