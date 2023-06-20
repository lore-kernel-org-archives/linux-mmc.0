Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60765EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjFTKTw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjFTKTt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:19:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581419A
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:19:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so6583540276.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687256387; x=1689848387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19eMQ3qZWWLiGLUNf1tkcMTs05sX8DwJDDX3p3R6+Y0=;
        b=lbA7PLuiaPD62ChuFBnruR0rXg0pSU4GgX3PGfj9Dyw7PCZV90oMRCREjtPafB6y4b
         /yyY62QYrHsGQqFqjGfKmqZFL5IVwY2EcDdCThXt5yT9UECrxYJmCwbTxvpm9n25JXh1
         YCbM6rOtjNpxXlYmvWuWbeJ8ZGuVcGCtX/pKBLpBQkuffVqlLpwBCBYYOjgOZgZbhnG8
         TahTRAx0sNGUgSs3SUu8C2+ZDN8q/65hJdik8Fv9SKMrxi4LwUU63WqVwV+skEP1t6yX
         okE4NzByrMj/fw7epbN17NUXBAsdYWwejBHyx/5i89tWLEOzl1fGjd5KehB2THQF44U/
         DxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256387; x=1689848387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19eMQ3qZWWLiGLUNf1tkcMTs05sX8DwJDDX3p3R6+Y0=;
        b=QdonzXQFXAeVrcZs+Kg1/oZI9oOA6nb3z6NZUp4ieAOpv/2mB1BkavbcpK+N99MC4n
         mnpMgTr4say3fZgyQjNgLtNS8BCYnsWzgdx9dhVV0Xp6qjF67dxnQSX6h9+gxu3TDCzt
         4u50bLVsSH/h3lAaFeZmoaGDPFnAe+JtoN8b6MucQiHwjulT+TC/s/Kjn8Ck7c8zJr9W
         cRi2ReR5Vzo6JW76ZBai0INhUnsQd1QGIwF/WBHYm/r9YF6XKiB5SK6BnIEeSC4+pFkq
         3vQ/Tt2DSF/7S9LAszhkLlNf2r9joN5RMP0NgCYJUNdOl+vNMsqEH6pQ1ctpurzVMauF
         iBbQ==
X-Gm-Message-State: AC+VfDyHLTvK+khdMGG3nbu30aG2gucqST3v0yt4wJqLjxzeyp5Edrpz
        FNg9ko7DHzUw94hX2qHk7Z6ouH3FlAqU0j06bgX1PT/QEk4e+6U9+eg=
X-Google-Smtp-Source: ACHHUZ6MrQY/X5hhkI4N/SekoJYR6wjq0x7tcYbgiDYdpFA24jMyUVUDNmSr11NOFWPmU2UJtCTzNd5y2uuMPAEVb4Q=
X-Received: by 2002:a25:bccd:0:b0:bad:6997:be19 with SMTP id
 l13-20020a25bccd000000b00bad6997be19mr11025704ybm.1.1687256387368; Tue, 20
 Jun 2023 03:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org> <a09b7efa-c74d-bc5a-44c0-5710c1aa078b@foss.st.com>
In-Reply-To: <a09b7efa-c74d-bc5a-44c0-5710c1aa078b@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Jun 2023 12:19:35 +0200
Message-ID: <CACRpkdYJeE9s_A04jvMSAbHpvPC2cSLuW_e+dnc2hK40qML7+g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 20, 2023 at 11:27=E2=80=AFAM Yann Gautier <yann.gautier@foss.st=
.com> wrote:

> STM32 variants also have busy_detect =3D true.
> Could that be an issue to initialize this work, which seem dedicated to
> ux500?

As Ulf says it is just initialized then it is left unused.

I renamed the software timeout ux500_busy_timeout_work() from the
previous name busy_timeout_work() but I actually thought it could
make sense to enable it on STM32 as well. It is essentially a last
resort fallback if the card does not properly report busy end or the block
fails to detect it for some reason.

Yours,
Linus Walleij
