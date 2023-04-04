Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C51EC761A6
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 13:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjDDN5B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjDDN4e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 09:56:34 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9764EE7
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 06:55:39 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54184571389so614868277b3.4
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680616537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHkwTuEK0sRBaJKLMcnB+ss8uWVVS2sTLaR7SSh4ZeE=;
        b=Qq5kv5hhcFuFy0PJtvFX4bmOosaBrR84kqX5KLBFFzUEc6HYu6DcRmucycm+pwLw4z
         c1uAzgS+6IfRZYHJk5KJGH6BUXWCXHUvONFdF36/iOgG9fJm+Or6v5c3zg4rspaHH3g3
         HiltUNh0Van26IVMA9fB0iQ/2JU4EmqjOAKnh9wB4GYotEL+CBZNtjApM3/Mvn7TE8jd
         7annxlm42iGSeOwxHaUKhpp00xjGstfzsDYvTrigHwC9433728mLS/XLnCAvVdN12kQr
         08QyncQY1xCydyx4nySCZClEtVlnx7zpGvVuhHi5DCP1Pb+uzJy0FxU1zuboEdb75qqE
         HUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHkwTuEK0sRBaJKLMcnB+ss8uWVVS2sTLaR7SSh4ZeE=;
        b=7QaBIYE/88L7ap6Eh1VLK5ZNYA2/OtKJBn8iIoPH0UlMMCOA+olEEBOCkWrMpxZ0YJ
         0RWrcgKUxC/JF46hyfV9jyKP8CoDeameGzSFFr2CZBwQAaOk6Em0m//OgZerDpliPnUs
         kwKbIrZoa8OZx5l4ETJSEJWT5mPKQ6ylI0UGYM8QCPFgnFseCQU0VbR0aWH52y0LNZHM
         +BOb5x2gChMlmLg3qa6zdfcXJPGps4z7nt9LdbZaEr2N4TmPb9uptk8NUV0TAmgl0GLu
         iZYQkjckZzLZOT6ek/h8qsCMEiFUi0GFnh51ygpwNV/lxCjBYCaBvUToGOrskWmRkqFQ
         BGAA==
X-Gm-Message-State: AAQBX9dReZLoyGJr0KK32su1G7HgZHhBARwJpvar6zQjwlAXtB7JOXFb
        iuskDqpJTxuqZ6sQ7NG+EW/VS+yOHrgNs9SW9TyjeQ==
X-Google-Smtp-Source: AKy350YrZFFIvslatnz6+JHLJxRXhURuO0Qe/CqTvhzL+6y/s/8tkJIoSvOoisaRTFct5e3xH8itE5OFyL+d4Sx3qSk=
X-Received: by 2002:a81:e545:0:b0:545:8202:bbcf with SMTP id
 c5-20020a81e545000000b005458202bbcfmr1485931ywm.9.1680616536968; Tue, 04 Apr
 2023 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com> <20230203-evk-board-support-v4-2-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-2-5cffe66a38c0@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Apr 2023 15:55:26 +0200
Message-ID: <CACRpkdYSpMD-V0QNGwtiKCA4KAedYfmFpvdCHWhjST9uTricTg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 31, 2023 at 7:55=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:

> This SoC is able to drive the following output current:
> - 2 mA
> - 4 mA
> - 6 mA
> - 8 mA
> - 10 mA
> - 12 mA
> - 14 mA
> - 16 mA
>
> Then drive-strength property is set with enum to reflect its HW capabilit=
y.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

This patch does not apply to my devel branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Ddevel

Can you please rebase and resend?

Yours,
Linus Walleij
