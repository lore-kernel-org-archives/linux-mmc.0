Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3036C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE8660230
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhKILV3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245652AbhKILV2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 06:21:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DBC061766
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 03:18:43 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso30341058otv.7
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LoGehQZbk+RzosGck6vjT1zJzmg/lTJbstwTe8XeEc=;
        b=ZpjBczssavdT/zzpwmE93UVRYT1pVggy6ZoN3tdcTDQsLCNgWwBXD+Qw5oLlTaBBbm
         fWEdbQM+yBK/UC6g8kWHLM6lfdnG4ucBcJFRA/jaKQKMWeWw8EMfQy+emulns1FFUP7p
         3/61HH6SdsnEoW4qQKwL/y6/srRqdVhVGgXWpcmyIvacXoWeHbB66GHEr5Du6EGTAy0f
         dQw0shxkL/hA/PD0OR/sieBQlFEPW71AtMzdF9Xi7HCbQACFMnJaxNS34CZuy1ETjEZ1
         H9zi7Rv7iRjfD8I/mX3FX8Nln5+6QgQodeRs1tYGlYr+Kdn/Y4CqXy6rPuelgM0NFxDB
         y/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LoGehQZbk+RzosGck6vjT1zJzmg/lTJbstwTe8XeEc=;
        b=lg2MCaQobT1UsG+dMWhZ8z24tOtwGK5DUBMH5eE/ZwVnhYB7JY82OK8po4RJEfUmj8
         5i7sKN+qSUzR20JZLEZay7GAdbDWZLUizRsdV26nmjzqyRR0gmJ7MdBDZFgX24KSX/9K
         vHEDWOuPEYiclNHy0VTi7pt/CRtBSXwGSQuTITZGHPoR7Y1N7sy/4BsydW9b7bHccKtv
         UHH+yTyGs1BebJ5nPsysj4oE/XRVZX5cbnbwn8hWCsUJLXF1bD1a4/c78cvxRyeAdNOT
         hCkyhGxNpPSB+2HBAdgO8rfgZBlqs5U+eG7H9iPfAhTDUBculm4PFFYjTTOgqXP7GIzO
         17Yw==
X-Gm-Message-State: AOAM530tb/nYSbXmvzkGua6p7dd+9tqtMIoA7o9Ra5FDYCc3h+bytiPn
        dWweFsi6otLpvFwgApMjxV8liUA6KhZRBdpL8O4EUw==
X-Google-Smtp-Source: ABdhPJwUCUJdsq++gtqdxVgLL+2uG9niZtv2/dD/V11M0WhSkdg5mu3IOK/qOq/4OB2+/9kMjmAoxhyxVMYjUJifi9I=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5313708otk.179.1636456722508;
 Tue, 09 Nov 2021 03:18:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <e1337857bbcb044edf4b6fdb4af3f6d887793a37.1635944413.git.hns@goldelico.com>
In-Reply-To: <e1337857bbcb044edf4b6fdb4af3f6d887793a37.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:18:31 +0100
Message-ID: <CACRpkdZ9ECS1YXL3NQa-7gF-kbqiutW-K5tM1b1vR5THCnK7SQ@mail.gmail.com>
Subject: Re: [RFC v3 4/6] mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
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

> This allows to add quirks based on device tree instead of having
> card specific code in the host ops.
>
> We call it just after where host->ops->init_card() can be optionally
> called.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
