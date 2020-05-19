Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DCC433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6AA2075F
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 15:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFDIdf1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgESPaj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgESPah (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 11:30:37 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF406C08C5C1
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 08:30:37 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v192so3462274vkd.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rnSyU5f4PrzmexMJlgXOLUxtZCdHxKJvdv/zUlkAcrA=;
        b=uFDIdf1+QUnCUyeb3hS0KTf1RU83RdK39E8uD55PKtjZVNtGka7FbU96itQXslCa3v
         DBf1jMaS0xKuLCHFJcuI7M8Mg9AkIPcrVFepYErgEehXvkrtxdty6I1QwJXnoAcmTNg0
         AVHL3RW8MyuTnQLz/F0B+CkFXCjFj3IMVZZKMReDU7+GoMDGHD1R/XSzfjUizPauPxG5
         YyffwHfYRRQ86kbn0GzRL0AI98LNK2SIx4AI9Fdb/faRU6JCpYcjuSxfyPrVp1FjwR+E
         qNuH4yOtO3RNGh73/dQW5BHCznhU0oV1R8GElfWHP1z620/sPMHAJtS3/c1QwkteKu7q
         eEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rnSyU5f4PrzmexMJlgXOLUxtZCdHxKJvdv/zUlkAcrA=;
        b=jqePRRbLMk8/YohRcBrHcoCaTr3ZcXFlQ0CLt2JGJ1wdiWrE1up19SizA2hccXhYgf
         RhpiX/HilIBzfWLJUi5Oli9rQkEKsuMzShyWXv2WEVloQZ6RJYoG2m0Ghf7qWzDqCdfv
         vm2Xt8Wpode3ywu2c7ypeAQ0F4Ze7cr699Tg3TBtliScbumBvLx4eg/a6zpWNWlNBw0J
         8w4mg7AWKnlPVK2S+HgLDRE6i5zcc6GnsIGLW0Yqm2ANvKkeSz5HZv4qJwaCCbKii1kE
         tx2hOEriwMy+V2h2jYnEWV+ATE2k9T4knU5fL4ahS+S98hhtqILsMrraYryjv9Y0bleW
         yw8A==
X-Gm-Message-State: AOAM530t5drKecIGdw+RTtbPFZI/CDaK0dkf6by4w+5hMhZ4yEFiHCYq
        7yV+9tzX2ewz/oTTzYLrUTf4et2yVjgOFSnPqBzb7Q==
X-Google-Smtp-Source: ABdhPJwaSFdjHczLXzH9xCa6keZ5wUU3dU1twsfttZ1EL/Ani+DZymqchdVlLIbyjUH+aWh/LxEzie1suQrANmZB0Dk=
X-Received: by 2002:ac5:cded:: with SMTP id v13mr222021vkn.59.1589902236878;
 Tue, 19 May 2020 08:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200516154314.14769-1-digetx@gmail.com> <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
 <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
In-Reply-To: <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 17:29:59 +0200
Message-ID: <CAPDyKFq4MoEzLr3Mgk0-4JWeB3khKawMC+bCEKDNiNKn3tUarg@mail.gmail.com>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 16:05, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> Several people asked me about the MMC warnings in the KMSG log and
> >> I had to tell to ignore them because these warning are irrelevant to
> >> pre-Tegra210 SoCs.
> >
> > Why are the warnings irrelevant?
>
> That's what the DT binding doc says [1].
>
> [1]
> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/nvidia%2=
Ctegra20-sdhci.txt
>
> Although, looking at the driver's code and TRM docs, it seems that all
> those properties are really irrelevant only to the older Terga20 SoC. So
> the binding doc is a bit misleading.
>
> Nevertheless, the binding explicitly says that the properties are
> optional, which is correct.
>
> >> It should be up to a board's device-tree writer to
> >> properly describe all the necessary properties. Secondly, eventually a=
ll
> >> device-tree bindings will be converted to YAML, which allows to valida=
te
> >> board DT files, giving a warning about missing properties. Hence let's
> >> remove the noisy warnings to stop the confusion.
> >
> > Yep, makes sense. However, perhaps we should do this conversion then,
> > rather than first drop the warnings?
>
> I don't mind to postpone this patch. But again, IIUC, all these
> properties are optional, and thus, there is no critical need to verify
> them in DT right now, it could be done later on.

Ok, fair enough.

Applied for next, thanks!

Kind regards
Uffe
