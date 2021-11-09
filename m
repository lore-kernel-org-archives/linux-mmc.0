Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B360C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2A260230
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhKILU0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhKILUZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 06:20:25 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23738C061766
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 03:17:40 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s139so15904715oie.13
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv8ztnlWaPfhP0sypyGkwV20+n53fXJntUU+ZhOap88=;
        b=ur5uAj8bUiNKsDbqu3RvypRYmIvBImcWoP4RkNK3jr6iKCOLACdRYXBzALLZdo/XZZ
         eAp/j0q3aVI5ApL38Hlzy3wTAAWhfmVC5+wiqxtOcVZjFc3uhaaN4G6mvrCVa2Idgjxo
         SkF59Wpz+gBWlis/SZ/bPH0rkg1xcSZ1LYMAs1e9D7PrTYFuKw8NC6YvOxqFwQEbb3x0
         qS5j4kJ6rlZYfM2mvq+xOwwdfRa5ze2oxr8MRea8w68t66bKJGTOxroFIXbKAq1NGsXQ
         LTs+1tTK5IcO5nvWpeJ8bfjZOxBXs/4to+5z+HavHQlkDFO0FRhN/9JpbDQxFzyEOSGn
         1UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv8ztnlWaPfhP0sypyGkwV20+n53fXJntUU+ZhOap88=;
        b=i/mO5aMnW+bzMD6EJsHjI/oM0yoYXRqGsbdhz7Udz9LN5crcVc86DjimeLA2Fk6RFm
         kWcLDbMC8bIvvZZyWCdGmhQdcmOggpU9YTBE8x0TMnrSqDiXFWai/HN9dv+5TUrTq2hg
         TXVVrtbGx/jm7k5nahwMWd8F6sdd9hMLDnE8MYc8Y/ur84aMQm21UzvNXiSnESZJ8JSa
         jXjrn+vvZ7LD6gZ2SDalERNeSaTiLFGUahC58xn4YjqxaM4oeIjKR4iXLw250jRtoqvj
         S3m/dlJroaZ9m40HiAVfe8KnUNbrBEJhO2Bqu82WoKpfcmkdOklYfWhwzjbsjulnobfz
         BcaA==
X-Gm-Message-State: AOAM531yvB01Wp7xfuxTYAhdkkMFYYFpChsiy1LKvR6Y9ntTfdu4vjss
        52bhjRbhR0LYQaVnIo8Tuas2HbSanV7LWMtPsFxsUA==
X-Google-Smtp-Source: ABdhPJzWtxSQXKhCHTrTtoBNQNsjLEb06mFsF/668M++pGpzFhuO5Urfobdic+1HCCyMHPzJ82GQZJ8pE6ibQw2AMSY=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5051120oih.162.1636456659466;
 Tue, 09 Nov 2021 03:17:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <47e753ce9d1e17bbb2910ee24a23a85d27f860ce.1635944413.git.hns@goldelico.com>
In-Reply-To: <47e753ce9d1e17bbb2910ee24a23a85d27f860ce.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:17:27 +0100
Message-ID: <CACRpkdahO0Tes676-uGLxoh=P9ps1Kw0kVT2nT0eBVr1CWUbpg@mail.gmail.com>
Subject: Re: [RFC v3 3/6] mmc: core: provide macro and table to match the
 device tree to apply quirks
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> This (initially empty) table allows to match quirks early based
> on .compatible of the child node of some mmc/sdio interface.
>
> A new macro SDIO_FIXUP_COMPATIBLE makes the definition readable.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
