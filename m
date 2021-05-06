Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B91C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85EE610E9
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEFMxr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhEFMxq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 08:53:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB59C061763
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 05:52:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u20so6853272lja.13
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ODncCv4DxI3Aq/ODkooiUAAKTXprJtoPbmftQgkLcc=;
        b=ZwxR28RuhkC7/43o1A1wHz6J9an0Ie2tKCtYJ8PNtPG0jl9HXqBS6RKpeFVJRCLU/S
         1I3htBcOGHdgpezUSrFlnzjjjIy8QywJQZDmwWZ6uglJxOSyPPNj+qzmkCeqcESLFzGm
         UrSCoQ1dWisvgzl+KLVSHYOq446woRuc53hgfSpJwR0Odo9/QEEP7de/tfWFfZAuX2Ii
         Z8uXuYdtaLGq+MoAerRv1/Gugm0LB80cgnlO+NCvjSV/ObsQ0fbk77k+Wyaaw3v/QeE4
         b2BSH1eWKiPq4Ee8y2TqYruqDgaXqPtLX825/NmgxyeiAyCLFsX7RXwhU3CWfM3bkmB1
         c4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ODncCv4DxI3Aq/ODkooiUAAKTXprJtoPbmftQgkLcc=;
        b=HAor3YBZcpuF4Cz9s9Ckz0cgAHH8Wz5lsfV1CWwjDO9B4++iNBjkKxNwUk7DUzHyYr
         lDJL/jT2oDrZ0TXqPRClwLbxOoAbUHFehczfJwRxthmD3vT9/1VK5j62aYAqw+4kvEh6
         fXhU3KR6WmheA/6AnPZ70a1M4UoRZdx1FxH2GN+P9AtiWk6bBaHsy1rplssZf53+2QqA
         AULET6HkCh5kUkNcFEgo9Vkd+AQXVbVj4sUz9CCO6nh+GqQZy1J6KRCJS/ZqPmtJETH+
         /Xceb1DKQKpgtIURpyNK7GSSNbfDoNK26/+O2Cqqclx8tFvb4CRB/BXuXDC0h85wiYi6
         M9Kw==
X-Gm-Message-State: AOAM533xvXD39BmnsEKHuarrcyBtirQSXzUut+DH7DmBVlftveXqgsxO
        LicL3+xJhae90nSHUaMEV8FmvR2+r1eLXLB5ZjcY2w==
X-Google-Smtp-Source: ABdhPJygGY4usiqBZQDVEXG3fwiyD+vj4s7NE1eKJr/9nYwn9ZurB0Ua8qc/N3VK7O/hDVMeWZIisrVzAoIWqSMkJo0=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr3151869lji.438.1620305566928;
 Thu, 06 May 2021 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-4-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-4-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:52:35 +0200
Message-ID: <CACRpkdZfnbnD5uBT+K9bEo+cEEZWWnLuTO6K6O-CiTVL_S4s6w@mail.gmail.com>
Subject: Re: [PATCH 03/11] mmc: core: Re-structure some code in __mmc_poll_for_busy()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To make the code a bit more understandable, let's move the check about
> whether polling is allowed or not, out to the caller instead. In this way,
> we can also drop the send_status in-parameter, so let's do that.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
