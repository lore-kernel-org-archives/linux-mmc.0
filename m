Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25ACC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 11:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7025A64EC4
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 11:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCOLFZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCOLFK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2021 07:05:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FC7C06175F
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 04:05:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n16so56172057lfb.4
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sgvr9igcXWBKUfY1IE4B67mheq905Em2jQKjOx4y1YE=;
        b=HKhfeeknB7kfXg9qqI7wWyr88d6N6N0MnUy9HDIvwsgFr28rpFNDBeukf2x56mBXZj
         7IlMrOSTUnj7+Vk9EhivUeiQ8sDpaVhccDqZR1tjkHXa2xLNGgg7ZCAwvsXHb3xGij6l
         0gfIx7huASrtnFKcJxIdY/WZww0WvTf8WgknDunIM7IcpqEnJ+aROCHqsrcfZDvir0t9
         hOgKn+wphPfw7jMHzivOFyB9L6174KZg3aYkaifYnqYxRyrGteoLhms1ppDCgZx+gK0p
         RVfXT2Shj+bfkssrku57lF2Gk7O+Mq2REwSnmJFEShEDAG5PMQl/DF/iexdibaQhMMCz
         NmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sgvr9igcXWBKUfY1IE4B67mheq905Em2jQKjOx4y1YE=;
        b=FEKTBhCuHqpjfk1WXp32T/JzBNiRzrpL7QDf9ui6RJXEZwBy9P2lfGBl/qbMhThCpS
         rVqy+D+jzbYiToa/Kda8pKTZM73teq+E3w+S5PlfvAVTsKBmG2EpDUO8b7VPlCwrpRB5
         pNzXJMWLzRBP3LCIe0MzMGNdcHxApJnX2NUi9qci5RvWI/1MtdSaYjRuMBLKp2ti8B1b
         40QzC5SFrCbY31x+lrQwJa+b1sjAl6dWCOpFhA+pIenOQy/13PY466Se4FibV9s9aHL+
         9B2/cJt6R3iyM58zJ1bjm9yyf2wL/255KCDtUEMbvN760qzWONpdas6bQv/A5ymm7I1r
         o8iQ==
X-Gm-Message-State: AOAM533y0EYZI4ywfvYhLRWt7MAa7AhSBwnVM/nL3zh/6XkQiKRfLHu1
        JZ/d4ES1qMf5Sfp1UbTAQvBIJRXP1VIC4JOWY3EYpw==
X-Google-Smtp-Source: ABdhPJxgA++CWYgtrmM/Gv6XPeHInoxEYMwul217KfTlYslgm0DxKCREAH3B2IZa7VtwpBjIvONTWthCpwTuZd52zt8=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr7794596lfo.529.1615806308540;
 Mon, 15 Mar 2021 04:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210313215302.4076765-1-linus.walleij@linaro.org>
In-Reply-To: <20210313215302.4076765-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Mar 2021 12:04:57 +0100
Message-ID: <CACRpkdZCoeb-uFgOrj5QETdiUPim9O=kXTXwqaFCZ-o76qzpuQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert the BCM4329 bindings to YAML and extend
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

By the way, here is a question to the broadcom folks:

On Sat, Mar 13, 2021 at 10:53 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> +          - brcm,bcm43143-fmac
> +          - brcm,bcm4341b0-fmac
> +          - brcm,bcm4341b4-fmac
> +          - brcm,bcm4341b5-fmac
> +          - brcm,bcm4329-fmac
> +          - brcm,bcm4330-fmac
> +          - brcm,bcm4334-fmac
> +          - brcm,bcm43340-fmac
> +          - brcm,bcm4335-fmac
> +          - brcm,bcm43362-fmac
> +          - brcm,bcm4339-fmac
> +          - brcm,bcm43430a0-fmac
> +          - brcm,bcm43430a1-fmac
> +          - brcm,bcm43455-fmac
> +          - brcm,bcm43456-fmac
> +          - brcm,bcm4354-fmac
> +          - brcm,bcm4356-fmac
> +          - brcm,bcm4359-fmac
> +          - cypress,cyw4373-fmac
> +          - cypress,cyw43012-fmac

Here the "-fmac" suffix is added to distinguish the function from
other functions
in a combochip, usually WLAN + Bluetooth.

Are there some of these that are just WLAN and not combochips? In that case they
shall not have the "-fmac" suffix.

Yours,
Linus Walleij
