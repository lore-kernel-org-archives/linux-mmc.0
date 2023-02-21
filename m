Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E026FC61DA3
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Feb 2023 11:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjBULLL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Feb 2023 06:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjBULKj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2023 06:10:39 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA326867
        for <linux-mmc@vger.kernel.org>; Tue, 21 Feb 2023 03:10:16 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v78so4425087ybe.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Feb 2023 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgIp62pzwCObd0eefLyPJFxxjkrzYi1dSStE7mQL2AA=;
        b=M+mG5uA81xf5aCvrdEKImP+VJGXmDOoJqSV+r/Np9pAPGarh/3KigKLHAJduKrCRrX
         yfJAUE+hTAKS4vY7r8f5gvgY/CCnf51ekJzzaqpFUufySN7hmYPkqflap430IybImOOV
         bysqaiyN8VG6pdJTvCkgxh5hG635ywJ2G1YnNDixu/CS+86I97Ku+HDjgDeTo+cO5bUz
         uLh4nS++PloEufwI+uVZIg+qkue9hI+AVhJ2h+utR2qlu49BI66EA7YwwwQuWRN3HxZg
         qEnQRj4XxbadSrvYNlII99cbV/eSB/63sjPluNknszurQNkgnBShrbyuPI9O4DUKberX
         c/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgIp62pzwCObd0eefLyPJFxxjkrzYi1dSStE7mQL2AA=;
        b=vcTmufz4opLI+imp2mykVPZCoGaIrTIEf8xhlEIg4tN/g/uR3wgmLOXbYdwg+IL02G
         8+6mbvELQ6DQoPkvzEaP4OBhMKLsIAIk5MtnT62CtpZkpNm3qKN096JHrG/t/B8PSsNs
         cgEwAT31E9u4gO0iZcrN5PXJkqVMPP3cbwM+s84Q1oamSHdJBlqfCUtZpdj6B+5YX5zI
         pRLwMaUu6SCzvQ3/t4QIICEHqpaYYYIAyyvRUf6hQcn2YHMkxj1cOQE1ga4vY3tjsGMM
         xoGdQ5vYGOL0i9k7olUqRvQEt6QFYbH7Yb9L743oZ1FIoKKQxi2aO6trbP7o/HpgPd5i
         SDng==
X-Gm-Message-State: AO0yUKWcNMebytXSxodeExLEIXqQTQhTsEtCFc6bY9OZhAHYp5NCMAw0
        NpF50SssGvJx4VDvTieaUAIYUhmzlZVob+hBt4wTzw==
X-Google-Smtp-Source: AK7set9bxLWCg+I02dYRE6AtkeWcj7QVPcohWSsIO7j40qyvzrzqQVQ+iv+8opivluVMuJWItWi6KI8Sggt391jf/lE=
X-Received: by 2002:a05:6902:10ca:b0:9ed:13e9:fe68 with SMTP id
 w10-20020a05690210ca00b009ed13e9fe68mr366317ybu.3.1676977816195; Tue, 21 Feb
 2023 03:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20230221094207.102006-1-balamanikandan.gunasundar@microchip.com> <20230221094207.102006-2-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230221094207.102006-2-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Feb 2023 12:10:05 +0100
Message-ID: <CACRpkdb65OondM07Uje7UWy3Gc8BDT2eFg=tjE1diELxFJNaUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Feb 21, 2023 at 10:42 AM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> Replace the legacy GPIO APIs with gpio descriptor consumer interface.
> To maintain backward compatibility, we rely on the "cd-inverted"
> property to manage the invertion flag instead of GPIO property.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
