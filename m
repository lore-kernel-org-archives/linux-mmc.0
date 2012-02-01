From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: Init sysfs attr to fix lockdep warnings
Date: Wed, 1 Feb 2012 21:22:09 +0100
Message-ID: <CACRpkdZ5f3rBOkAW-UsrnfjWYkPPVvb3pJCuJiozL7Jso2RCrg@mail.gmail.com>
References: <1328110316-7593-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51928 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab2BAUWK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 15:22:10 -0500
Received: by ggnh1 with SMTP id h1so847772ggn.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2012 12:22:10 -0800 (PST)
In-Reply-To: <1328110316-7593-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>, stable@kernel.org

On Wed, Feb 1, 2012 at 4:31 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Rabin Vincent <rabin.vincent@stericsson.com>
>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This looks like it should go into stable, Chris will you add
Cc: stable@kernel.org to this if/when you apply it?

Yours,
Linus Walleij
