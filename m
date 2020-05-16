Return-Path: <SRS0=UNP7=66=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACABC433E0
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 09:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02082076A
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 09:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAEkQNb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgEPJ1n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 May 2020 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgEPJ1n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 May 2020 05:27:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C00C061A0C
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2020 02:27:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so4773252ljj.1
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2020 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc+4aO8aFIulf7k1TOFeuWQ//GucwDJjGxDygO1lS1E=;
        b=hAEkQNb6xMmfSCoCOZnm1h3QOuWeAE8eZ0BvIEVZ0RwUdIZlTevRi6xvqYfqcOl+hZ
         8mwr4gjIiYZB4LP3f3DqVYsA9kZhXxE93YI2no+1OnTg7O/VPYpJQO94LTuDkx37J12y
         uqM2Yb5zj8dyQqaIrfwti2xUC2sYhNhsdnatlz4WfN8SmD+y7kRYtCLodKffsx0f641V
         ybOhCHuNNbNCcAjRJrfZfit9coXa0v22zofWM4h38ewXBLjdQ6oxUy0aFRRm852YRFto
         91s3Uwq/Mvh9KLB8oDzhmcqvApYhRL/Pxbp2lIsc5qNZmiBcEl/3fQNH2tGq5fGyBsPz
         gCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc+4aO8aFIulf7k1TOFeuWQ//GucwDJjGxDygO1lS1E=;
        b=PGFfj64Xn+8oyhJbzLCkiTVIjJqv/JS+IB1zR9vegnlJWn4ptBie76n9sOZbQogqDe
         qwP1BJRQtSpepvu4cyRuibcboF0GlMfTr2QJ/w58jHLdOpY5b6HtgeCzVaQ7e3ydFL0H
         y8geg3Y8RQS4e0vlEQdGIc7zj9iT+A/AsvClUwiWrr+TGZa5fg4EUNDZPc6ki+YIPNLM
         RpXQMxqpKleUwLuN2x/TnVurntkt4+hAmIdHNFGrAqOWeIWa0NxG9n9Ha/BE6Jg+0yup
         +fzrMnWlyX2hrFeai+ljCjcvOKUOFDCjWdNtq9PjZQjvGkMAubSYd/1Un/dtdrlZQFap
         UaBQ==
X-Gm-Message-State: AOAM533D3PDF1Tp22y0WWx6fuKbBmB6HOzEpH1dFCHxap6BQKrFt5dV9
        rCCeeZ12Sk4RntmrBaaKeGKd8MCSfjgYRe82grKD3w==
X-Google-Smtp-Source: ABdhPJyzZ3Zr3OZI0sDWE4KMLhPH1HNySbygUm4XIcIVSV3ERYb8N2UM1wTEGYb821UITlukKlpxC9cnqxIeRw9f85Q=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr4637416ljg.258.1589621261050;
 Sat, 16 May 2020 02:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200508112853.23525-1-ulf.hansson@linaro.org>
In-Reply-To: <20200508112853.23525-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:27:30 +0200
Message-ID: <CACRpkdYjqgu_-CH_t1pbwREitK39Q2TkoW4zzXgCOWEiUQU_CA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Enable erase/discard/trim support for all
 mmc hosts
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 8, 2020 at 1:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Step by step, mmc host drivers and the mmc core have been improved in
> regards to support erase/discard/trim operations. We have now reached a
> point when it no longer seems reasonable to use an opt-in approach to
> enable the functionality. Therefore, let's switch to make the operations
> always supported.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Excellent, the cars says it can do this, then we should use it, and
it would be so weird if hardware was so broken that it can't handle this.
We were working around something else I think?
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
