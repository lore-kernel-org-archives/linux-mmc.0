Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34DC43217
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 13:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351291AbiDZN6o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiDZN6n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 09:58:43 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B698BF56
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:35 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7b815ac06so106872757b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGnnsOro0fTXcSX75g0Ywninw1vwEOc38VMslUYvHZE=;
        b=ou4OCBxLogQNNf8C6zhUpKLSHiGc3WCvh0CNrGET0ELwEcHPQyIO8lythpvVt5NhYa
         oCBY1DvCQmYF6ZQ4TEu/nyUUUKhzFEdtRquDmZejzk2utI8slhzSQjnwZIdzdy0R3P8L
         flPjin7Npxygkx5yX4hYsC2z70tKosRQWT3nQw5gB4QB0vZ68iXUZCg38XyB3+r31Bv9
         VtZ4jrKnnjvRl4Ywdnq+xwintuDuIj6GDGeuws5SP2Gq4UT72BzRD238stCxkyNEM5N3
         3GKEKyo1nl4pJ95rtndCzYE9PnhYNnqtCxC2mYqsFaArqkgfkOErCyhGIlJdG6urxNEt
         3kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGnnsOro0fTXcSX75g0Ywninw1vwEOc38VMslUYvHZE=;
        b=TYf4FlSakHT0FykH18rUsXx4qg41uAdvevINanvvkzkLjeRzDoZhHHRR33h9cmS2lo
         CgtoSk+axIAfAPzGw7TDK2681INRE3yH2R4HDGvg1JhFHNpvZx2Z3WAdQe8XqS1B7vGa
         zDIDMruTFq83+itnEvMlpbAPXyUUlbAOocAC003OfGz8TR2dYPIAKafqH90b5NaPbfve
         rALjNMAAnfVJMFTapQ7L18jAZxpFn25iiVqLPA33g33o8CRaOYPBmSFeavuYXxMm++vc
         FCo/H8mleYoNUOlLST+ndf4bOdrq6H43pi9b3TXx68HhlM857dEsEDdKRM0DjWXFdVky
         bl4w==
X-Gm-Message-State: AOAM532+k1hlS/X4CMj2VSUMYuCnRKUnyxWx+/vTdN/4vFWOP6FyB+ns
        RRqHjVppePWTg2mJOXUqA+0sDXh11luvTnqtvIbGiw==
X-Google-Smtp-Source: ABdhPJwaDHorEVacERGa/V+qc+V5d8PTrwAODlB0texVMiYzB5A4RvNHZtZNRufKjNleEX1dYBFdKo0sZDhbnGGNlik=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr22378985ywd.495.1650981335233; Tue, 26
 Apr 2022 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220425063120.10135-1-a-govindraju@ti.com>
In-Reply-To: <20220425063120.10135-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 15:54:58 +0200
Message-ID: <CAPDyKFrXogNFhdyHbo_KF3uA0nTc_MRV3tvv3v6Q+K3-KhsO=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MMC: Add quirk to set the TESTCD bit
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 25 Apr 2022 at 08:31, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The following series of patches add support for setting TESTCD bit
> when SDCD line is connected to the controller, in the sdhci_am654.c
> driver.
>
> Changes since v1:
> - Rephrased the commit message in patch 1 to decribe the hardware
>   and not the sw support
> - Made the reset function static in patch 2
>
> Aswath Govindraju (1):
>   dt-bindings: mmc: sdhci-am654: Add flag to force setting of TESTCD bit
>
> Vignesh Raghavendra (1):
>   drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit
>
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  |  7 ++++++
>  drivers/mmc/host/sdhci_am654.c                | 23 ++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>

Applied for next, thanks!

Kind regards
Uffe
