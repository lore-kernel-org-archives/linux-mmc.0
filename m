From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: core: Remove MMC_CAP2_HC_ERASE_SZ
Date: Thu, 15 Jun 2017 14:45:49 +0200
Message-ID: <CACRpkdYcWjW1zv1_5jPZkKGdPU0XpibxbFYA=NziDZui7oBF2Q@mail.gmail.com>
References: <1497270250-11353-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35742 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFOMpv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 08:45:51 -0400
Received: by mail-io0-f179.google.com with SMTP id k93so11299809ioi.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2017 05:45:50 -0700 (PDT)
In-Reply-To: <1497270250-11353-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Mon, Jun 12, 2017 at 2:24 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The MMC_CAP2_HC_ERASE_SZ is used only by a few mmc host drivers. Its intent
> is to enable eMMC's high-capacity erase size, as to improve the behaviour
> of the erase operations.
>
> We should strive to avoid software configuration options that aren't
> necessary, but instead deploy common behaviours. For these reasons, let's
> remove the capability bit for MMC_CAP2_HC_ERASE_SZ and make it the default
> behaviour.
>
> Note that this change doesn't affect eMMCs supporting trim/discard, because
> these commands operates on sectors and takes precedence over erase
> commands.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Make the behaviour from MMC_CAP2_HC_ERASE_SZ the default.
>         - Update changelog to reflect the change.

Looks correct to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
