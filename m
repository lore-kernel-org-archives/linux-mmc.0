From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/9] mmc: core: Move mmc_interrupt_hpi() from core.c to mmc_ops.c
Date: Fri, 9 Jun 2017 15:24:42 +0200
Message-ID: <CACRpkdYY0gg4tJCOQkZBz9CPgtF+fMnzD7zqwwOJdm7goMpTKA@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:35032 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFINYo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:24:44 -0400
Received: by mail-it0-f49.google.com with SMTP id m62so136804212itc.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:24:43 -0700 (PDT)
In-Reply-To: <1496928465-25004-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_interrupt_hpi() is a eMMC specific function, let's move it to
> mmc_ops.c to make that clear. The move also enables us to make
> mmc_send_hpi_cmd() static, so let's do that change as well.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
