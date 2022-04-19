Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAADC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 18:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbiDSSst (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbiDSSss (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 14:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E128E17
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 11:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FF76148F
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 18:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57920C385A5
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 18:46:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="klliPhS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650393961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJy3U56tX0o9ITKTwWnY4vlXUywXc/O2/3AbbXALMZY=;
        b=klliPhS3z+bqbXYfyUccv3KQhXi93H2jFs0AtodfsssUWMpYA7E+bEVLxLga15ni9Mk+23
        vLfHMKEXbDpZ8Kl8HN/Hj9tK2xSihu5Vcc9HlbjQIuMRB/kM65SpivH13Ko8ZQ83VIcMk6
        m1v1bxWYcmA3iwx1cTKwNqgm39hMLCo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id da1317c2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-mmc@vger.kernel.org>;
        Tue, 19 Apr 2022 18:46:01 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id h8so32662956ybj.11
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 11:46:01 -0700 (PDT)
X-Gm-Message-State: AOAM530wLndoUtMljLfyy/Vosy3yN6MxZRCKm9VE6d+x20lJJUjI7n9r
        wTAVpiIUMHVh4NXllouU0Czk5KnkGNw9GqWfcsM=
X-Google-Smtp-Source: ABdhPJxmNeY/HBsI5Pm0gx0bJdafR5I5Wwfo/4rb+q9Yc57Rol74Pja8Tvn06jgHi1OSvIHPKzB2liZFXsL51B22xzE=
X-Received: by 2002:a05:6902:154d:b0:644:b2e7:146 with SMTP id
 r13-20020a056902154d00b00644b2e70146mr16445142ybu.271.1650393960765; Tue, 19
 Apr 2022 11:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220415222931.481352-1-linus.walleij@linaro.org> <CAPDyKFq23tHDtEYs9OoEedNbtZ+ytdeLDEc_4qOH6qtbcAZPFg@mail.gmail.com>
In-Reply-To: <CAPDyKFq23tHDtEYs9OoEedNbtZ+ytdeLDEc_4qOH6qtbcAZPFg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Apr 2022 20:45:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9ohNT62hnSg+5waZ5TzVvS8A_=_X6Eu32Vy279X7KijSg@mail.gmail.com>
Message-ID: <CAHmME9ohNT62hnSg+5waZ5TzVvS8A_=_X6Eu32Vy279X7KijSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add CIDs for cards to the entropy pool
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, Apr 19, 2022 at 8:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> We can move this into mmc_decode_cid() instead, to avoid open coding.
> Moreover, this would make it work for SDIO/SD combo cards too,
> whatever that matters.

Making it work in more places sounds good.

> One thing though, what is the typical execution time to do this?
> Probably negligible, but as this may be a card that holds the rootfs,
> it could delay the boot to be completed.

Extremely negligible. Basically the only place you shouldn't call
add_device_randomness() is from a hard IRQ handler, but other than
that, go wild. It's actually used all over the boot sequence pretty
liberally.

Grep around a bit and you'll see all the odd drivers it's called from.
And perhaps in the process you'll notice a few other places that might
benefit from calling it. In general, if you have a strong sense of
niche hardware things where you notice that a certain identifier or
field is "probably quasi-unique-ish", an initiative like the one Linus
took with this patch seems like a positive thing to me.

Jason
