From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 17/21] mmc: omap: Don't use mmc_card_present() when
 validating for inserted card
Date: Mon, 9 Jan 2017 19:24:17 +0100
Message-ID: <CACRpkdbUR3g46BV2zyXG7uo-=6Vq-QRcrdqfgBrrEpn3+kn6aQ@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36484 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033951AbdAISYS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 13:24:18 -0500
Received: by mail-qk0-f177.google.com with SMTP id 11so51100728qkl.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 10:24:18 -0800 (PST)
In-Reply-To: <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_card_present() function helps the mmc core to track an internal
> state of the card device. More importantly, it's not intended to be used by
> mmc host drivers to check for an inserted card. Therefore, let's stop using
> it and instead rely on checking for a valid pointer to a struct mmc_card,
> as it should be good enough.
>
> Cc: linux-omap@vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
