From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/5] mmc: core: change quirks.c to be a header file
Date: Wed, 8 Feb 2017 12:15:51 +0100
Message-ID: <CAPDyKFrXkcXbcwiEbBzZJbpKL9-34C7jBap5rfBkpD0YtP+VUA@mail.gmail.com>
References: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com> <1486516546-187771-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33096 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932145AbdBHRWW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 12:22:22 -0500
Received: by mail-ua0-f172.google.com with SMTP id i68so114446443uad.0
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 09:22:22 -0800 (PST)
In-Reply-To: <1486516546-187771-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

[...]

> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.h
> similarity index 95%
> rename from drivers/mmc/core/quirks.c
> rename to drivers/mmc/core/quirks.h
> index bf25a9c..f3bbfcb7 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.h

As you are rename this to become a header file, please also clean up
the included headers from the new quirks.h.

For example, you don't need these:

#include <linux/kernel.h>
#include <linux/export.h>

Instead you need:
#include <linux/device.h>
#include <linux/string.h>


> @@ -53,7 +53,8 @@
>         END_FIXUP
>  };
>
> -void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
> +static inline void __maybe_unused

The "__maybe_unused" shouldn't be needed here, or is it?

> +mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>  {
>         const struct mmc_fixup *f;
>         u64 rev = cid_rev_card(card);
> @@ -82,4 +83,3 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>                 }
>         }
>  }
> -EXPORT_SYMBOL(mmc_fixup_device);

[...]

Kind regards
Uffe
