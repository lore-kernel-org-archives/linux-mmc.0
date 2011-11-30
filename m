From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Fixup error handling for dma
Date: Wed, 30 Nov 2011 14:06:24 +0100
Message-ID: <CACRpkdaquN0SfXu=Xy6Z2-TyK0LtT9Amg0T1u50CVCFn6dEe+w@mail.gmail.com>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55799 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1K3NGZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 08:06:25 -0500
Received: by iage36 with SMTP id e36so741028iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2011 05:06:24 -0800 (PST)
In-Reply-To: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Tue, Nov 29, 2011 at 3:51 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> When getting a cmd irq during an ongoing data transfer
> with dma, the dma job were never terminated. This is now
> corrected.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
