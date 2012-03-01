From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Clean up after mmc_pre_req if card was removed
Date: Thu, 1 Mar 2012 19:42:07 +0100
Message-ID: <CACRpkdaUh-U7nW0PzhmBRZH2vYsmqgGcQWthQyiyr6+uU0ua1w@mail.gmail.com>
References: <1330616671-11952-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61403 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139Ab2CASmH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 13:42:07 -0500
Received: by iagz16 with SMTP id z16so1146265iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 01 Mar 2012 10:42:07 -0800 (PST)
In-Reply-To: <1330616671-11952-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Mar 1, 2012 at 4:44 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Make sure mmc_start_req cancel the prepared job, if the request
> was prevented to be started due to the card has been removed.
>
> This bug was introduced in commit:
> mmc: allow upper layers to know immediately if card has been removed
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
