Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDAC4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Dec 2022 21:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLHVPV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLHVPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2022 16:15:20 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E989492A
        for <linux-mmc@vger.kernel.org>; Thu,  8 Dec 2022 13:15:19 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3e45d25de97so28973977b3.6
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2022 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLb6c3pV8MZQYOARt7wFYg4IvcTRaFrHi+WtxF8Db4=;
        b=lzDTGWDELDro1riwKG0siQz477cfqDaZbigVvRWIM9kyY1Y2ZaJm/6ScdYxqWk9A4w
         uRmTBk+AqMNB04d/2u8RFSfjO/sZaLnK/+RSu1G1PCfoRN/7l4y3s1OgBF7gG+tEAHtg
         glOHd1mrJtx3STLEzzYRw3xMVS32DpaFeEoFKQ6boob1WvMYQ6BVxDhPiyNUzW4YQ+Ar
         ntAI80HJc7iAx3daDrBeh9b9JJcM4FeHPiNNaUOOHs81KxK3kgoRompSSYsDBFxlqiXD
         jceM7dEHfsFCreLJOAxonQfz708upMPU89xbrmpPaV01mo6mWZo/qUFR1s3aj6zTZTtS
         2ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxLb6c3pV8MZQYOARt7wFYg4IvcTRaFrHi+WtxF8Db4=;
        b=h7kpBTBmw5hvzZZ0mJH3o6qamhAwFa1ESYNczHGvN5GZStcWVJwMLHnqZ7y8Jd9cwu
         svGF0bnOpkbhVtT1IId8HfMdNhYPBhWErsfkD8bfXBNMKvV4JNMpfCAVeNZr1iOXsmQa
         fA5N9IfPBQqZfSooxBotdvoVCtdtOvwH2GI6sb8raCQffr1d0Nj34ztLHEitNOEWS7fD
         9eanN+7+ukK8fQG84C1mQJkTWpKz8BtYJrpfZULy/WOi4hFpf22TL3LQ0s4r1+PmFGXb
         EUsRQl6oMS3A06CvOnEc00p+2NXIaD6yW84vYXWRqFbBvEknn+wDiKAiG0eBB/u5iMUM
         sFKw==
X-Gm-Message-State: ANoB5plKHOG7vRFTREajaq8GHKwcci5w79b8UlNT9Ys32g3BiMO8bGFV
        zC+cAua0goYLufiGvoYIxjjeftA/Ncx+dPtHqZAB0A==
X-Google-Smtp-Source: AA0mqf5TMIaMGikCivHSN8QB/ySrGFpStI9jdjJ5wqz3y8/sxy4rK7Alc1fze08qJAV5K9Tf5G1tnU9ey8KciS44t3Q=
X-Received: by 2002:a81:5d8:0:b0:3f5:b69c:387 with SMTP id 207-20020a8105d8000000b003f5b69c0387mr10437422ywf.359.1670534118538;
 Thu, 08 Dec 2022 13:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <20221207131731.1291517-4-william.qiu@starfivetech.com>
In-Reply-To: <20221207131731.1291517-4-william.qiu@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:15:07 +0100
Message-ID: <CACRpkdbjaiDhPcVH115w25oxseWrz=Yb-ugkmCOiqhRDmDZj5A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi William,

thanks for your patch!

On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:

> +                       starfive,sys-syscon = <&sys_syscon 0x14 0x1a 0x7c000000>;
(...)
> +                       starfive,sys-syscon = <&sys_syscon 0x9c 0x1 0x3e>;

These are registster offsets and shifts. Don't define such stuff in your device
tree, use #defines in the code and just provide the phandle.

Yours,
Linus Walleij
