From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 2/9] mmc: core: Move mmc bkops functions from core.c to mmc_ops.c
Date: Thu, 15 Jun 2017 14:43:54 +0200
Message-ID: <CACRpkdamKdCr7ABtxgbyez_xLsf=4ae+xUBgYM-z7JYFaQO6=g@mail.gmail.com>
References: <1497010501-17302-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:33811 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdFOMn4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 08:43:56 -0400
Received: by mail-it0-f50.google.com with SMTP id m47so5359000iti.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2017 05:43:56 -0700 (PDT)
In-Reply-To: <1497010501-17302-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Jun 9, 2017 at 2:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_start_bkops(), mmc_stop_bkops() and mmc_read_bkops_status()
> functions are all specific to eMMCs. To make this clear, let's move them
> from from core.c to mmc_ops.c and take the opportunity to make
> mmc_read_bkops_status() static.
>
> While moving them, get rid of MMC_BKOPS_MAX_TIMEOUT (4 min) and use the
> common default timeout MMC_OPS_TIMEOUT_MS (10 min) instead, as there is no
> need to have specific default timeout for bkops.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Convert mmc_read_bkops_status() to static.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
