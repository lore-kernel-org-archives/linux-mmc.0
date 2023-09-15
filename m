Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24529EE6449
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Sep 2023 08:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjIOIwV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Sep 2023 04:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOIwU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Sep 2023 04:52:20 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AAAFB
        for <linux-mmc@vger.kernel.org>; Fri, 15 Sep 2023 01:52:15 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59c00b5c8b2so11808337b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 Sep 2023 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694767935; x=1695372735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQEA2FIOx2kKdYQhqTeGKcS5B9p1K7dbq3FSAP3UBRc=;
        b=YSf0EaQAwBVhJ5wCemEofRT6vFIRuzTBW63Gcmqe3yiE2n0Nm3x5seKVpchsL0QshX
         cp1A4jEKTwYX9wpRgn8z0yfMYdSt9J1YoVwNpGNltDW8PUaTnNf5v5Yor40XZhUHPnD9
         sCgnOZwdKQJvl/KXCyDrTd2R8v0a4GY1izrg2tSiu9dnUfvhgtk+dN62BV5h4OO/wtUW
         WBuIagiSwtDgNtoSXGeqrEnt6BNplU9KKibNomoLfZxHxZvkVje0knC0+m+wLFTeqcMh
         VivUGXWWMYp0JhkP7kqKIRYt6w/9QIY8hIn0yWLETzPBmxIh/vqqXSZyKmABNpxBE6UI
         ZV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767935; x=1695372735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQEA2FIOx2kKdYQhqTeGKcS5B9p1K7dbq3FSAP3UBRc=;
        b=a6w/SemUGjUUHmoWQwhsxTD5liU0g3ecwJ6Hs4TAh2tAxWmECNzUzWRV8ek93yv4SI
         qe4IUHBunpIDvb3eJgcmEjV9j285oSPw8Ysdifu7g4UVALPg8f46UffJfMu0mbVChgN8
         R6ONQnjQ4EZjN6/bVHDuqNs6xtHbNtghpqWxEfZwCOjoLqoA5nWML6Bu7iP4YcFVXoYf
         jF0LTUlI1KYnqiBmQn/LMHEjw7wx978vEJqr7QsRIZ9Vouj6UYEtzMP0O1HTi2hbbAgk
         z1kBr1iGzwTgvVLwSCmIAW1ILRG6jmwLxFur6w12XQSwJpPNT7YNMZXr1zyP6LRAyzf0
         B56Q==
X-Gm-Message-State: AOJu0Yxbl8Cayvu4DDaURWrDozsC9qeImrjav9dMYxNpAQIf6OgF3Y4X
        ydNlrXA7srNm1Q7aaTePXfv1r9JMeesAhZQqU9kEPg==
X-Google-Smtp-Source: AGHT+IF03Cm5Va9hUiFUq1vEzW6LcyQAcPPtXI3kkxlLHejHACO76N1blpi+PQJOeYgaIv7Amr4/YkwX0A4xUwTw4/k=
X-Received: by 2002:a25:3496:0:b0:d80:b87:3299 with SMTP id
 b144-20020a253496000000b00d800b873299mr602004yba.49.1694767934897; Fri, 15
 Sep 2023 01:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230914150904.155630-1-yann.gautier@foss.st.com>
In-Reply-To: <20230914150904.155630-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:52:04 +0200
Message-ID: <CACRpkdasQqbSGhrd7+0M7t5ATsj7krpvmCGZ9uPsYHcu5K87kw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 14, 2023 at 5:09=E2=80=AFPM Yann Gautier <yann.gautier@foss.st.=
com> wrote:

> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Add the support of SDIO in-band interrupt mode for STM32 and Ux500
> variants.
> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> It is not enabled by default on Ux500 variant as this is unstable and
> Ux500 users should use out-of-band IRQs.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

v2 looks good to me,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
