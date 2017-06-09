From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/9] mmc: core: Don't export some eMMC specific functions
 from core.c
Date: Fri, 9 Jun 2017 15:22:22 +0200
Message-ID: <CACRpkdaMEJkHznewPdUmaKc454tqEVaqF3aAMvEep6FOjnJSmA@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34481 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdFINWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:22:25 -0400
Received: by mail-io0-f181.google.com with SMTP id i7so32930747ioe.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:22:24 -0700 (PDT)
In-Reply-To: <1496928465-25004-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_start|stop_bkops(), mmc_read_bkops_status() and mmc_interrupt_hpi()
> functions are all used from within the mmc core module, thus there are no
> need to use EXPORT_SYMBOL() for them, so let's remove it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> @@ -428,7 +428,6 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>  out:
>         mmc_release_host(card->host);
>  }
> -EXPORT_SYMBOL(mmc_start_bkops);

For this one, you can also mark it static, and remove the prototype in
mmc_ops.h.

It is only called from inside the same file!

>  int mmc_read_bkops_status(struct mmc_card *card)
>  {
> @@ -887,7 +884,6 @@ int mmc_read_bkops_status(struct mmc_card *card)
>         kfree(ext_csd);
>         return 0;
>  }
> -EXPORT_SYMBOL(mmc_read_bkops_status);

Same for this, but you may have to move the function above
the call site so it compiles.

Yours,
Linus Walleij
