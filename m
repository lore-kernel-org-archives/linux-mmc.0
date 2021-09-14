Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5FC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01CC61151
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhINJGQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhINJGP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2021 05:06:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF7C061766
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 02:04:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g14so22457531ljk.5
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJGnWAchz/HDqF7HydjX2fUZvRJTYMKYHvyvKYF6LTA=;
        b=gsRYdLNT2BSVgBpZbeqTFVqbuZ67wWkrXvsQwtq0WLXmHe/pl4s2ggGSn5W150c6NX
         fqT6OzdCP/P+GMEGsvZfkMrRsKlKoV3bs+aoh/pJox88oCfQMj88wXcJE7q+p0vyhBwM
         4Z3Hfsw8LQ9OEXmd1bMlCw/9a0W4y/J57kJYDMkw8QFf+RZVkF1pgx66wlTAyPzANWAB
         EDg5+DOWidgpAJINmPs8zJ6LA2IrDSsIJkDGlR+E6bSssBbgs0qkB4oM8g1NGMpIdX16
         KVwjrQ8QX9r0CbMGHrPAXko2ja5ROaV1asQSeSU6nAMbC8+DA0OSoV/OUL75BLVJ5Y8b
         iKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJGnWAchz/HDqF7HydjX2fUZvRJTYMKYHvyvKYF6LTA=;
        b=mx3px0xHkY11PkTtru1qmVTL5pih8CAxpO1qyA3BXYm6Q0wi9dT37AF5lDjs9IZqNT
         ILWOtpfCQFuPHSK3kleSG0MGF/n+aEz8I+l+Z1dQxnvZCQBA+YFheV1YRpr3txXhYV5W
         KShEDpqD1mAr3BcjrdOiFzJcxPhL50W+2C7UCshQ2KsYTUZtgv1b9fnjTygKnFNjWCqI
         GocCtkzdKUz2RuSy5VxdE5n3zzDLEKXZC0qkMll+OYZ3uh4rh4kBAsCmU8UzJCkAN7uU
         iEXyspLUJH8aMrtxiCi+n/5gLth9F6c0Sr83j6x5abamuz/1TKRT0fWD558lgFvWgqk6
         nVxA==
X-Gm-Message-State: AOAM532YL8iCpmNuXWZsBPCHOLZKDpZhXf4sqM9qLya0uSCIvGp+xqsw
        ULhG3229WlAVaNN5XbewPcccX6xloKQL3ehl/u9BAA==
X-Google-Smtp-Source: ABdhPJxZC/j49j+CcIzIqzNYUN//TpHs73k6VRwmbWS0R4xoDibBWk/HYQNi25ajG7KIqw46sDy4K+S8GNnu6KTzYqE=
X-Received: by 2002:a2e:960c:: with SMTP id v12mr14672590ljh.300.1631610296769;
 Tue, 14 Sep 2021 02:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210913013135.102404-1-ebiggers@kernel.org> <20210913013135.102404-5-ebiggers@kernel.org>
In-Reply-To: <20210913013135.102404-5-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 11:04:20 +0200
Message-ID: <CAPDyKFpvZAQ+5niZkw2tk-q_6w=VAuK=P-OVGjQA7QbJW7OvgQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] blk-crypto: rename blk_keyslot_manager to blk_crypto_profile
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>, dm-devel@redhat.com,
        Satya Tangirala <satyaprateek2357@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Sept 2021 at 03:35, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> blk_keyslot_manager is misnamed because it doesn't necessarily manage
> keyslots.  It actually does several different things:
>
>   - Contains the crypto capabilities of the device.
>
>   - Provides functions to control the inline encryption hardware.
>     Originally these were just for programming/evicting keyslots;
>     however, new functionality (hardware-wrapped keys) will require new
>     functions here which are unrelated to keyslots.  Moreover,
>     device-mapper devices already (ab)use "keyslot_evict" to pass key
>     eviction requests to their underlying devices even though
>     device-mapper devices don't have any keyslots themselves (so it
>     really should be "evict_key", not "keyslot_evict").
>
>   - Sometimes (but not always!) it manages keyslots.  Originally it
>     always did, but device-mapper devices don't have keyslots
>     themselves, so they use a "passthrough keyslot manager" which
>     doesn't actually manage keyslots.  This hack works, but the
>     terminology is unnatural.  Also, some hardware doesn't have keyslots
>     and thus also uses a "passthrough keyslot manager" (support for such
>     hardware is yet to be upstreamed, but it will happen eventually).
>
> Let's stop having keyslot managers which don't actually manage keyslots.
> Instead, rename blk_keyslot_manager to blk_crypto_profile.
>
> This is a fairly big change, since for consistency it also has to update
> keyslot manager-related function names, variable names, and comments --
> not just the actual struct name.  However it's still a fairly
> straightforward change, as it doesn't change any actual functionality.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/blk-crypto-fallback.c        |  60 ++--
>  block/blk-crypto-profile.c         | 518 ++++++++++++++---------------
>  block/blk-crypto.c                 |  25 +-
>  block/blk-integrity.c              |   2 +-
>  drivers/md/dm-core.h               |   2 +-
>  drivers/md/dm-table.c              | 168 +++++-----
>  drivers/md/dm.c                    |   8 +-
>  drivers/mmc/core/crypto.c          |  11 +-
>  drivers/mmc/host/cqhci-crypto.c    |  31 +-
>  drivers/scsi/ufs/ufshcd-crypto.c   |  32 +-
>  drivers/scsi/ufs/ufshcd-crypto.h   |   9 +-
>  drivers/scsi/ufs/ufshcd.c          |   2 +-
>  drivers/scsi/ufs/ufshcd.h          |   4 +-
>  include/linux/blk-crypto-profile.h | 164 +++++----
>  include/linux/blkdev.h             |  18 +-
>  include/linux/device-mapper.h      |   4 +-
>  include/linux/mmc/host.h           |   2 +-
>  17 files changed, 548 insertions(+), 512 deletions(-)
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

[...]

Kind regards
Uffe
