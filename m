Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25765C433F5
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Apr 2022 10:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiDPKzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 Apr 2022 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiDPKzS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2022 06:55:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8063A5CF
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2022 03:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B116DB802BD
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2022 10:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1549C385A1
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2022 10:52:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Cw88ybCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650106362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/cMntdOv78MLKetYV5P/cihm6SFTsJS7OHfJXItwl8=;
        b=Cw88ybCXqpeRxWbfH4By3HM4W4TBo0PfJKsFi8Td1FdI0Guvu23j2/ufxFmyWYDQzjomkn
        bIZmE7K1nmMo5y6ToRNvFDGssyfI1GcuxtF2UPKfUyyp9MMBflHQclqfR9Qk33Tupj6RZY
        9UuKqElFViSbLj+/wkmdZvIXFmQGHUo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34bd8808 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-mmc@vger.kernel.org>;
        Sat, 16 Apr 2022 10:52:41 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id t67so18173229ybi.2
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2022 03:52:41 -0700 (PDT)
X-Gm-Message-State: AOAM532i0Y+F/fzADfk6T3ynl1jwpS+2F9QnqNYs/s1lxtdjzDAERkmD
        zEZDHPk9aKFJDDvTStuFV0CtTXqQOUygn/33A00=
X-Google-Smtp-Source: ABdhPJzUqjXFiOH8LyjnEqZXNXvQxQXpom9gc2nRMRXlrr8HkpZum1/sT/ec4V4nxB346eN1LJKry0zdmnGT+895zHM=
X-Received: by 2002:a05:6902:10c2:b0:63e:986:494e with SMTP id
 w2-20020a05690210c200b0063e0986494emr2545939ybu.267.1650106360798; Sat, 16
 Apr 2022 03:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220415222931.481352-1-linus.walleij@linaro.org>
In-Reply-To: <20220415222931.481352-1-linus.walleij@linaro.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 16 Apr 2022 12:52:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9pL3wySZVp+-HA7O_BVyu=a1aEeVAvFaKYRXg=8vp96VQ@mail.gmail.com>
Message-ID: <CAHmME9pL3wySZVp+-HA7O_BVyu=a1aEeVAvFaKYRXg=8vp96VQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add CIDs for cards to the entropy pool
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

This seems like a pretty nice idea. It seems like a lot of small
embedded boards are fairly deterministic and have lots of identical
board information, with possibly the only thing differing
board-to-board on firstboot being whatever serial number is baked into
the SD card. And the input pool only ever accumulates with
add_device_randomness(), so in the worst case, this won't hurt
anything. So:

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Jason
