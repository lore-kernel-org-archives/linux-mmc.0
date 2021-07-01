Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A3C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 15:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A1F61400
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhGAPlp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhGAPlp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 11:41:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28757C061762
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jul 2021 08:39:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d25so9055686lji.7
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jul 2021 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKPN6zQ/zFXDFSN9MRlfPhvrCodVIfpP+0YXwcAMH2g=;
        b=oTec+1gdJKIinO3Nvyp/vObmavWJ/fcJVmIxqf7efsRXEvye+HJuNtb7wxlIyTHa95
         Famr2t8+8aUd1iZkkyAle+MgWD7igw8GIAR2qR3Qz1vRqnpH5JIxD6vzKDdENLJngtFo
         hrXc5uwLBANAId9+nnbIAD7Hssd2TOCEFpt/NsGhPFyogQO5wo/MpRfJaeWpmen9Zxfp
         uXP55JS1afFQeFvJrb4GnHBe9PmVkdKkGVOpl9EO8/yXRx3V4lZL7smDqMXncm3lj1qa
         UKJWju78nUFuexxbSTVykWj3uDP4zbbHNrgnlbDN3Qgsn9CAvTw6q98Z1NU/Ey+619dk
         IXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKPN6zQ/zFXDFSN9MRlfPhvrCodVIfpP+0YXwcAMH2g=;
        b=jzIZP5gckSudLyCJ4yx2aaIpJCRxXtDBLrUZKNumWUp+T58lvDU72mgnCpBfuFP91x
         gd+GXloEbZjHEy4krvGYlDs87Dg9Q7u7sS95LE43CDCRof+ueVpD8XHAPJbRN2g5VPSi
         SmXzVUsuLVL+Fj4H4aptXSDVvLbLorl312WRKYaxO/K0GbTapXI+Y6J9nqfTEIaodGdf
         0+yr+iVkE41p3ktmUAUSDkdYK6/ncuIGec3riFuABItfJXaBsxm2ZONoPyJupQCZJinU
         YdUuRVJTXi91OsovPcGTCgaef5svaF9DP0qiIOuA5g4u5ytKRYXM4oP9UwmWiM7ouKy9
         gbPg==
X-Gm-Message-State: AOAM531yGbH4xeTw9HkhlB05GghsXfuGtJniA6bQjuR1U4lgbbrUas1Z
        Y74lqfbCHJpw4cUZeknZ7+GYgYM3KmVBkyoIpqUnNA==
X-Google-Smtp-Source: ABdhPJwgIvrrKKt7O5b3zfUqhHjaJ4/oo/kwK3mXH4uEN55uBAC25x0gaLsMitZrflp4XoAyVQWG2nLiZJ5tYHsSQRg=
X-Received: by 2002:a2e:9d15:: with SMTP id t21mr150366lji.200.1625153952495;
 Thu, 01 Jul 2021 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210630102408.3543024-1-linus.walleij@linaro.org> <4b20c870-ee41-6455-bc28-07f89591c3f9@foss.st.com>
In-Reply-To: <4b20c870-ee41-6455-bc28-07f89591c3f9@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Jul 2021 17:39:01 +0200
Message-ID: <CACRpkdbLB2FKFcTjpEJMqoh8NbWM80X0jsRB-Wb0eWmg+9h6Xw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: De-assert reset on probe
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 1, 2021 at 2:39 PM Yann Gautier <yann.gautier@foss.st.com> wrote:

> I was wondering on which HW you saw this issue?

Haven't really seen it, but on ux500 we have no less that 6 (!)
mmci blocks and it wouldn't surprise me if some of them are
left in reset. Better safe than sorry.

> But I've seen this kind of thing is also done in some other drivers, so
> maybe it is just an alignment?

It is good to deassert any reset line explicitly if you have them,
I think.

> Anyway I tested it on STM32MP157C-EV1 board, so feel free to add my:
> Tested-by: Yann Gautier <yann.gautier@foss.st.com>

Thanks!

Linus Walleij
