Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B2C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Jan 2022 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiAJQOG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Jan 2022 11:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiAJQOF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2022 11:14:05 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E8EC061748
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2022 08:14:05 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id l10-20020a4a840a000000b002dc09752694so3675485oog.12
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2022 08:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJLKks7mMz5zAbTW1qfceg36EeT2Nhf9/lRvR9fz3nM=;
        b=nXk0k93/zcVIUREQUt57Ii1XtGc5diY/ebE4G4Y5ya1J/YRlKWjEyws1caPVNWxkGj
         0S+1Obs36kQnbWPoZcVkqxxFhT+Js9Xlaj+foce2iGE7tjIGH1S63iz18Ee3XEt6HcOc
         gcQ21N8DcJBofwkGWtnRFlCaMnob4/ohPIeO+B8DfTtEkcmzFd+SbwPxhLkhqyPCW7sF
         5tdrqGaNiGh4R/6jm2a1K0kAAQ7uWBMjqmkOwLxNAbolkuEfrLspxvmtY9IaITSQtjSE
         30gHk90RyANmjd+HM4voQK7fwCS00mo4a0HCxWnhKDlPt81hDX7Puumu3zgsM2ys4ssS
         DocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJLKks7mMz5zAbTW1qfceg36EeT2Nhf9/lRvR9fz3nM=;
        b=MoCmlzadEv3Xxp7Ra5dUjodvtxe03SezwCYzUKb5cOgVFP0X15rGZ071/1cEINrRUD
         jLyTFwV3U3lK/cT3D+UiNBIkEgl1bOMb8dUW8FwFUso1xqeFjxbetaXOGKpALaUGkDeX
         h95ncblPe0B0+T4Gwm/VXD6t9u/8wjklJOZ2dwvsfgyPevjZ0EDq1MW7sBpr8zonBCnC
         FNCXxya/99b19TPhchqa/46Jy5rkWkaWRmJV9G/DqR+Lpv08b1tsA4nS171B50KVtx/S
         H5CSOPpDtamAHfIp//D1VVC6myrozfaSZVsh12BOhe9mWSnigumJCuVGg7fqgwgMv/w3
         eSeQ==
X-Gm-Message-State: AOAM5304kdENr3XqhvFTZ4bp/IyEIrWp3jgsxS8f6ruTfHbvA84j/ZWv
        OFxlpow4o1FDEhphPIN7UTsVxbsaB+FafRR0VLs86Q==
X-Google-Smtp-Source: ABdhPJyVCZH4rsnx8VTd3EB+R7EDQUfR+emeKokFEvWa74elIyCVNst9si8+xT3Bm6Fdn9qSafCuz0Bj7p443QYPQjQ=
X-Received: by 2002:a4a:dc9a:: with SMTP id g26mr305294oou.71.1641831244122;
 Mon, 10 Jan 2022 08:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20220106182518.1435497-6-robh@kernel.org>
In-Reply-To: <20220106182518.1435497-6-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Jan 2022 17:13:52 +0100
Message-ID: <CACRpkdajaDmkoS3JkD6qSPQwV5JRPMiz8JPsins=4b3HGCoZCw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arm,pl18x: Make each example a separate entry
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 6, 2022 at 7:25 PM Rob Herring <robh@kernel.org> wrote:

> Each independent example should be a separate entry. This and dropping
> 'interrupt-parent' allows for 'interrupts' to have different cell sizes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

This is neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
