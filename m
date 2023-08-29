Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C1C6FA8F
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Aug 2023 07:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjH2HTT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Aug 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjH2HSx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2023 03:18:53 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F84AD
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 00:18:51 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7801f1f608so3858778276.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293530; x=1693898330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/le9lg8HNXw+xNcfMZ2DkxbxE28NZz/pHklIKly6GE=;
        b=hn2jJWDupwjUSCe5USg8z0TOEuTKNjSNKVVInIU12YCkp2e0zxjVnQz59MEN4u+ukn
         V18Z8z0bHbD4rPRBwjbH26NuP+P74oKJ/7J4iHMCh/sMGkXw0VryhNbeCdJrrY7hkNrN
         0VtHqfc+JElXXuVxhwn8yEVYaxXRwfzRm4UhM+2HORD7t6WYhPed66n1RiCM447NJRSc
         X4bxXID9uR0JGutjZKcPLHKcjZq3TqlP5dOHkkEnO8lmHxQ764OMHZVdnIb0SfnIiIzJ
         bHsb3YVLtS+R8wFHif8mhMt9oOGaI2hMakjuWbiC/CCOqVcSl2e8IeShyM0++XyhAql+
         l/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293530; x=1693898330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/le9lg8HNXw+xNcfMZ2DkxbxE28NZz/pHklIKly6GE=;
        b=SqVjGAfJbv3TgsrrPfcU+Gi9LEoUVgI/j9we5LEq6O5VIfH/LTRI+KHcTXbU6hgDtP
         lvwgtXnd+08YiFzJlFUAOsTDY7GeFVhaUEpjNoaeDV8CTWnnO8N5t42nbTD0qRzOAiLV
         i9+Ia6Vr8v1mZYPrRWbzLNa28wdw84/abf/rZbb1YQgtCVO5DkptogUTDoZOgNorLHeR
         c7bfnkU0WMlbzF0Kewgmdj3dA5qgP9JordAsYrZlf/JnTGV3J9h76OU3WAa90MTe9L6q
         Oe8QtK/3v8pz8tHY6pF1cFfhwE8k1kUQ6HIiKbm7zOjvbOiysth8eS2/0y+Y+dK/CkGV
         KY7Q==
X-Gm-Message-State: AOJu0Yyk0ugo/mR8jzH0ulMbRtZSNYVzuo8Ak/ai8zQVXYnpfy8hxI7F
        rFNrhxb5x2UoyaqhkZs+ocQb6uq5/Y/1MTWL78XNHw==
X-Google-Smtp-Source: AGHT+IHh9savmxG2TT0gLsT3nt4v87OMyIMGiKB6sqLe0uJYi1H9dQl6Yr1wfWx4InznhxXRV59j+8WblbAF5kYo6Zw=
X-Received: by 2002:a25:ccc3:0:b0:d77:f99e:7b1e with SMTP id
 l186-20020a25ccc3000000b00d77f99e7b1emr15286296ybf.48.1693293530259; Tue, 29
 Aug 2023 00:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Aug 2023 09:18:39 +0200
Message-ID: <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Remove preprocessor directive
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 28, 2023 at 12:04=E2=80=AFPM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) while
> checking if the device is compatible with atmel,hsmci. Instead handle it =
in
> the if() condition. The compiler optimizes out the entire if() clause if
> the first expression in the if() clause is constant false.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for tidying this up Balamanikandan!

Yours,
Linus Walleij
