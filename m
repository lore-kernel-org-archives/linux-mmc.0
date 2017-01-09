From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/21] mmc: sdhci: Include leds.h
Date: Mon, 9 Jan 2017 16:15:31 +0100
Message-ID: <CACRpkdZhnOnPHoDTmpMSL_jGe32w5ce8qjdoLPQTA=GkGVdQVQ@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34727 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969821AbdAIPPe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:15:34 -0500
Received: by mail-qt0-f172.google.com with SMTP id l7so89206548qtd.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:15:32 -0800 (PST)
In-Reply-To: <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Don't rely on host.h to include the mmc.h header, but instead include it
> explicitly because the driver depends on it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

As noted, the commit message is bogus.
Refer to <linux/leds.h>

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
