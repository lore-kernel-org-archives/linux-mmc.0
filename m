From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] msm_sdcc: remove needless cache flush after dma_unmap_sg()
Date: Sat, 26 Feb 2011 13:01:40 +0100
Message-ID: <AANLkTikju_TmJpPceg0BNvfGx1w1yuNUZcqcSc1ttLhv@mail.gmail.com>
References: <1297895333-5551-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61189 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1BZMBl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Feb 2011 07:01:41 -0500
Received: by qwd7 with SMTP id 7so1826270qwd.19
        for <linux-mmc@vger.kernel.org>; Sat, 26 Feb 2011 04:01:40 -0800 (PST)
In-Reply-To: <1297895333-5551-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sahitya Tummala <stummala@codeaurora.org>, San Mehat <san@google.com>, Linus Walleij <linus.walleij@linaro.org>

On Wed, Feb 16, 2011 at 11:28 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> dma_unmap_sg() already flushes the cache, I don't get what this
> code is doing here.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Any feedback on this? I'd prefer the maintainer(s) Acked-by,
but the patch is pretty clear as it stands I believe and I will
request Chris to include it anyway, intuitively it is correct.

Yours,
Linus Walleij
