From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: block: Use __mmc_send_status() and drop get_card_status()
Date: Tue, 23 May 2017 22:53:15 +0200
Message-ID: <CACRpkdbuU2B60CFME9sU=SbiYRFGr+CWekN3PmMA9DLc9WhBqw@mail.gmail.com>
References: <1495441438-5129-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34995 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032788AbdEWUxR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 May 2017 16:53:17 -0400
Received: by mail-io0-f177.google.com with SMTP id f102so105107584ioi.2
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2017 13:53:17 -0700 (PDT)
In-Reply-To: <1495441438-5129-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Mon, May 22, 2017 at 10:23 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The only reason to why the mmc block device driver needs to implements its
> own version of how to get the status of the card, is that it needs to
> specify a different amount of retries.
>
> Therefore add a new exported function which allows the caller to specify
> the number of retries and convert everybody to use it, as this simplifies
> the code.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Allow callers to specify retries.

Im allergic to __prefixes so I would call this:

> -int mmc_send_status(struct mmc_card *card, u32 *status)
> +int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries)

mmc_send_status_command()

Either way, it's a clever patch so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
