Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED84C433EF
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Dec 2021 03:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhLZDcG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Dec 2021 22:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhLZDcG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Dec 2021 22:32:06 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B86C061757
        for <linux-mmc@vger.kernel.org>; Sat, 25 Dec 2021 19:32:06 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t204so13816674oie.7
        for <linux-mmc@vger.kernel.org>; Sat, 25 Dec 2021 19:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpSRXjM9kG2rU64CnT289qDrVGElfeL1DhdrYlGUgWM=;
        b=OIgHtYo7xHRxiQHgjF8+g+ssHpKYVV3glYf/4biLu+pBoJZVXQRO41a1wulGtCYX23
         40rNim4t7pR4nNL3Ggy9o8x9SN70RiXEPBmpVbDe5XWVl2bVsCenHuPEeBcq9/Msh9Io
         WJ46G15+nWiEWw5blyy+IIqxyJ1LTwjJJYfE3P1d/DmNqreyALmMyMmTJOTbU4FiOfv6
         4ebTDJidXnz9wzK7wzgZR8gFbibfbu1kgO+y9ISVrXhrVlb83OAi7xtTIwzfRBzzg3bV
         Rj9/4ybRYwc07g43h9g6/erSq6yd3IimAhjjWidNZP7Swe9dgrEp3lLdEhEAozYqCVI/
         3tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpSRXjM9kG2rU64CnT289qDrVGElfeL1DhdrYlGUgWM=;
        b=mkUGNHOgaI8cvYeohOEdaeoHN5Hoo41hZnw0nmM9BgoIskhREhudoDKWvvipAtCtH+
         /sE9FtgjftdkdEpjUj9yp/Cxq/wLh3Gp9fEFllywu51XQo5DKrIRANHQG3f2Vr53QBwG
         l2C+6DD6zZ9bwgHzXmq4Riu8648aUAtVJP7hMfL7iFtk91IERKQG0J/TYaTggsbw/E65
         Y0fNmfaZGpinwT4RyC20Z4QPjrFRjnse1VSBe70idAjLm5e4lacOJmLmXxcOMNC/MT/l
         IAj8E0qEtPCt7FagIJGNBcfGM0shIco/kVHdWMgphTFW/aYHiXje50kjxdTS0GHQhwfE
         OBdg==
X-Gm-Message-State: AOAM530LW60OvZIu5VMm3U81ZojTPe9u3h4kbJPq+WhjRzUU+TDpj/ip
        HZgN3ITgiqoH2x14MfoDroyss1Y9FulYRNdPWSh17w==
X-Google-Smtp-Source: ABdhPJztUoEc1TdEZzCer3ftmiWpd8yh9ma4NkStZRL5zzrUlGrViIzx7eFQAZGqibuH/KPkcT9EBY8sWyRpqa0V6RI=
X-Received: by 2002:aca:120f:: with SMTP id 15mr9083937ois.132.1640489525295;
 Sat, 25 Dec 2021 19:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20211224192545.74528-1-david@ixit.cz>
In-Reply-To: <20211224192545.74528-1-david@ixit.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Dec 2021 04:31:54 +0100
Message-ID: <CACRpkdaVTuzza-gJDgeCV5+cpTQUynM9ja5k5WLF9_L=opsn1A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: PL18x stop relying on order of dma-names
To:     David Heidelberg <david@ixit.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 24, 2021 at 8:25 PM David Heidelberg <david@ixit.cz> wrote:

> We don't care in which order are "rx" and "tx" DMA names supplied.
>
> Fixes: 4df297aaeb9c ("dt-bindings: mmc: Add missing properties used in examples")
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
