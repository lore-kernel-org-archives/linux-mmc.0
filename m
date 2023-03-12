Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E28C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 20:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCLUUo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCLUUo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 16:20:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C172F781
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:20:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd5so6971684edb.7
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678652440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBD3saFngHmWAL0vT++GS+KZHgFK9mytKPRQSV1qkzw=;
        b=YFztskzuLekY301pyRV5OCxUgSY9aVg3Ag978+tSo+Si2HzSNw3F3K6ldw0lOULzwq
         GI/9M4GMj3/ZlNp1/CWCZ8TI9N6jqhv8Himk/C2YQCDwEExES3B8YUQzSKLIjmX4MRpJ
         eAhp/HYG1V1ou1Gg7ZVWN/0ovHkKdHUKr91udmQyglLo92m45M0paotWT41m9pkrX+FR
         CMJvXFdunDG9ZgnsZCDKYxYHr4ndhNMutDpYY8NXv9x4sDc9V02WuT5G2xOey0Ci1frj
         jxbBInT3rC4lIzi3684t7kHNtz5ja7Jm9szXt/tup7//ABiRGIEYoBBP7fqYwYEquoBt
         vzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBD3saFngHmWAL0vT++GS+KZHgFK9mytKPRQSV1qkzw=;
        b=XJYX1mWPX6XxXa8mZC+VWb/53UMgfm/ag03mpbZltnpuycMVp+Vt13RK84QWJWhGdf
         sDqXhJR1L++NFgxLR5cySqNWUqqaVOLZ6n0fxba1Sv5akNT7Ly4Gsul44LnILIRaXWNL
         f2l4jQfwF3lRHAfTrVZ67q+Ie2uOjSRMgvRG/pflzMeQnVzIXgaUrONNDmWu1njmv17D
         GrLXmdIPQWuGs1u0KnLWuZp5VJAtPEDG2zpgTgKYkU9HgR4GThGXG7IoSkz1kjV2gZF3
         JVPjtecUsTIsjUCOZOfkrCkt7+qJIkWX/3hrsi5pzTMQnK2x7+KNAz9lBLJXqTJ0RNRt
         eKGg==
X-Gm-Message-State: AO0yUKXZbMGpq/WcE2vx2ljLPODYyw6OXhqQJd8kBCuHKKuTQXODJWrM
        EUaat2Q3ZXhc6bCFS8d59ynlrJNti0agtzplGJjSUu4bWY4=
X-Google-Smtp-Source: AK7set/5UC3YaQhY9aeEwLq6eppdRS1dBWGMyGxVBNnuEH5lFMhvXvVzZ0DAhls0wa6n/qE4sSP9uspy5ark7STsws4=
X-Received: by 2002:a17:906:a3c2:b0:8b1:78b7:6803 with SMTP id
 ca2-20020a170906a3c200b008b178b76803mr16341011ejb.4.1678652440558; Sun, 12
 Mar 2023 13:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <858a592b-ebf4-99b4-74fc-21b4ad3382f8@gmail.com>
In-Reply-To: <858a592b-ebf4-99b4-74fc-21b4ad3382f8@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Mar 2023 21:20:29 +0100
Message-ID: <CAFBinCCRO5vkQN78KfeCM=s1BC8W2dqG1T_C+_Va8e9sz+CWng@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: simplify usage of mmc_regulator_set_ocr
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Mar 11, 2023 at 11:27=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> After 087592395a96 ("mmc: core: Allow invalid regulator in
> mmc_regulator_set_ocr()") we can remove the checks here.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
