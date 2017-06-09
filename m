From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/9] mmc: core: Move mmc bkops functions from core.c to mmc_ops.c
Date: Fri, 9 Jun 2017 15:23:55 +0200
Message-ID: <CACRpkdaiHiQApL=uw1SkCvT31Q_00qDhT1s0XJgwf-V5KAo0JQ@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35583 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFINX5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:23:57 -0400
Received: by mail-io0-f182.google.com with SMTP id k93so32995090ioi.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:23:57 -0700 (PDT)
In-Reply-To: <1496928465-25004-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_start_bkops(), mmc_stop_bkops() and mmc_read_bkops_status()
> functions are all specific to eMMCs. To make this clear, let's move them
> from from core.c to mmc_ops.c.
>
> While moving them, get rid of MMC_BKOPS_MAX_TIMEOUT (4 min) and use the
> common default timeout MMC_OPS_TIMEOUT_MS (10 min) instead, as there is no
> need to have specific default timeout for bkops.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Oh then my previous suggestion to mark those static are not
very good.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
