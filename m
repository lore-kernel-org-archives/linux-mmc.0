From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Prevent too long response times for suspend
Date: Thu, 20 Oct 2011 00:09:12 +0200
Message-ID: <CAKnu2MraxuB=cWme7OkX7k6K6c+1oNQ_+iJrswCw5YU0vjyayw@mail.gmail.com>
References: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51804 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab1JSWJM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2011 18:09:12 -0400
Received: by ywf7 with SMTP id 7so2150667ywf.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2011 15:09:12 -0700 (PDT)
In-Reply-To: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

2011/10/13 Ulf Hansson <ulf.hansson@stericsson.com>:

> While trying to suspend the mmc host there could still be
> ongoing requests that we need to wait for. At the same time
> a device driver must respond to a suspend request rather quickly.
>
> Instead of potentially wait "forever" by claiming the host we now
> "try" to claim the host instead. If it fails, -EBUSY is returned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
