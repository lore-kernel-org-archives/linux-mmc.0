Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDABC43381
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EBA23432
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAMNIx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbhAMNIw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 08:08:52 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A965C06179F
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 05:08:12 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id d23so494076vkf.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1VCZY/xQ+vpNaSDs4SQBOLwRNdfsfyajYOieVemPvE=;
        b=Ymt+5sQxFikWk16r7SfFK77X/rN1bJIfBj6jyTKFNxEBjIcK+Th6zxAkw/Lw9nZW6Q
         1I/hwM7Jn6RxpVxdl8TVZu7v/IZaX6wXF4utZ1ZzOV5qDXY38AYWml8eUYkjazwqgBF2
         5jDrcvtufb47T0ST8IjVPkdvv41vNqxD+JqFMnC/jAs0UQNJrKgzMwgQP96uuhUBHq0e
         1bIoYBqOyBa/7aaIlwxkDTygkPpXSEgmJt1PLBsMdVNyzeyeVVX6HfxVpOciQqC8xR2t
         790F2xDghJJatj2mYU4sV75kHSMOM9PUNIxlrcJCqyekCeijcGHS1/V0mCjRQsIWnyLH
         8UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1VCZY/xQ+vpNaSDs4SQBOLwRNdfsfyajYOieVemPvE=;
        b=gekrliL1aPlqZN7glRAu36Yfb96KWG/j7pqe14MMcV3wTJWFdPaVlfK4fJ4SAngI4y
         bbFrJVvjAAHHIHbFdKNGcOd7Zvo2zqObuLIbDiPwJ/L3yXq4bGy7qDnuR2giWRJBk3Xi
         XC4g+6m+vdGDKM8efI7LLDBl4YOyqNk4LRcN1zNOG6LYhX/uVHCixDjAJsQ7GwiLm59R
         yKDb2qnzrYwXCywbR7bMNvrZu56W+0zjHbaI/qI1gWVOWpI+KbFehS+/0FScXtocNfla
         WM7W1mRXJbhXEovW4xFg+thS5t6er8tQEDQmSghgvUTOpvaj8oe5E/ZdgxrAkIt0pmGk
         p4yA==
X-Gm-Message-State: AOAM533m5jo6Mc834CX4Hnn5FHwDKq3w76OdbUIZYmANH2LFzI5okcqq
        3ui2vhBk2aMJhiv8QBuHUMB/bljHjL7gPz9yZj4qAA==
X-Google-Smtp-Source: ABdhPJx13VI/0VizHXnDWHCUsAA4PZBjhuZON6WlckJx25fnR3SWumOpr705uMTSxBv2Cby3FvToHokULHVrsB8KR1s=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr1772016vka.7.1610543291449;
 Wed, 13 Jan 2021 05:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20210113115908.3882-1-a-govindraju@ti.com>
In-Reply-To: <20210113115908.3882-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 14:07:34 +0100
Message-ID: <CAPDyKFojZXy156mdh1VP2vAXFugRj2dOEitPfc6qs25sNk7qmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: AM64: Add new compatible string and driver support
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Jan 2021 at 12:59, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The following series of patches,
> - Adds new compatible string for AM64 SoC
> - Adds support for AM64 SoC in sdhci_am654 driver
>
> This patch series is a combination of the patches [1] and [2].
>
> [1] - https://lore.kernel.org/patchwork/patch/1361560/
> [2] - https://lore.kernel.org/patchwork/patch/1364589/
>
> Aswath Govindraju (1):
>   dt-bindings: mmc: sdhci-am654: Add compatible string for AM64 SoC
>
> Faiz Abbas (1):
>   mmc: sdhci_am654: Add Support for TI's AM64 SoC
>
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  |  2 ++
>  drivers/mmc/host/sdhci_am654.c                | 28 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
