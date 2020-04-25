Return-Path: <SRS0=TOBz=6J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C0C54FCB
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 20:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0300C206D4
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 20:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NoqOhSgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgDYU1N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYU1N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Apr 2020 16:27:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C40C09B04D;
        Sat, 25 Apr 2020 13:27:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l3so10224963edq.13;
        Sat, 25 Apr 2020 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPXP9AG6CyMHwvhiLeR0KlplmUcjSJkUmZp77wk1l9g=;
        b=NoqOhSgZhoRYluDHJHUFB+kauGxccJeVEPHUgz8N8fBKJFAd/GOfMrebVzOQYadHOS
         DlyyXSCPLxaQdQ/XsKLePfS/8qguUJN9jsgFjzu7G3KJJXza69whjanHRB2KXhMddniw
         Ya5GKJrAVP7QLjXcITtFOs8gQMUWa7iz4WeKXe/6Z/wQA8Aj51aSYKrlC9BX/b6voHqK
         JAWBNoPRXGGsYcLssKYt6xyBoj6KtJqgL/GQOfA6H3Mn7QYqwmqorn7IHvS9f+yb3trI
         p+LXosikOE8zhHI2/hKzUbfhmj59vZ8zpCK4nVc1A2IYhbGMhMU/8d7x//wnLTrPN6C7
         FW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPXP9AG6CyMHwvhiLeR0KlplmUcjSJkUmZp77wk1l9g=;
        b=jfl7f70KD92q5748CMipgCCRDVaLnPgsjR4H/WURnM8fTDe99a1XZmSG0RGz1EK9Mw
         amcFs+TZSC3YvMB6TLfCSS3c/HqPx4TlNMMnUDdwqlmenN6UfZJaBYHGUAsuPgp+OXy3
         GfiUvXYQWgL9EYVbYHycuZEe9UQk56j6XRJjWDvCmEk4S/j2UiMdGwQkoZWsmkzzTu5+
         L+v+Bd6yeV96QviPNRrgHYdkcK+Tdl5ipv81UL9qmddKPaH9fOUvzypeHmMoAS3TqbJG
         Owk1CLaLcVkm/Hz66moaIei25cV0MAgue6/XolkNE1QmdLDW8iz9QPnN/5SMi3Og7kja
         q4zg==
X-Gm-Message-State: AGi0Pua5xs7Y8ejvmi2C1XmuJga/IZ6hSgczEAIIvnKOFW9lB0Q/K1Rz
        A8d/23FJ8PVpirzvDLiPRwv516KgajzW/WcOccQ=
X-Google-Smtp-Source: APiQypIBtvX95XX9qITNRM1xgR8d73vnd6WA5gESMb4+LvaDjbdFZ/1FUtmDRTVkhas2VMNe8G2kSLrWfJjsR6sr6sE=
X-Received: by 2002:a05:6402:1496:: with SMTP id e22mr13037214edv.301.1587846430298;
 Sat, 25 Apr 2020 13:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Apr 2020 22:26:59 +0200
Message-ID: <CAFBinCDCv-zNf1FX+8FHMxcNdJ_69yog+O_=QPz3Fzryg3ynAw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
To:     ulf.hansson@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Sat, Mar 28, 2020 at 1:33 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> Martin Blumenstingl (3):
>   dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
>   clk: meson: add a driver for the Meson8/8b/8m2 SDHC clock controller
>   mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host
I have Rob's reviewed-by for the dt-bindings patch and three
tested-by's for the MMC driver in patch #3 (which means that patch #2
was implicitly tested as well)
I tried to answer all your previous questions where possible, but for
some of your questions I simply don't have an answer.

is there anything from your side which is holding this driver back
from being merged?

+Cc Jerome, because he is the maintainer of the Amlogic clock
controller drivers - where this series adds another one, so we need to
coordinate where patches go.


Thank you!
Martin
