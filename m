Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9681AC47095
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1166124B
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 09:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhFIJZv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:25:51 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:36850 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhFIJZv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2021 05:25:51 -0400
Received: by mail-vs1-f50.google.com with SMTP id z7so8660016vso.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jun 2021 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0YZpXNbvNe/aSIMfW/fwl9JTlg+qPtxAYhHQZpkJJ4=;
        b=CyVtn6ZSLRs1oFQym5BtCew3deGCkiBozlrFzkPIiKz5Rb7UCB26M8AyNnmSisKHTr
         F1/le1gMmi0RFt6NQF0eucGdqRZgkKDwvYbOOjVt8bCBLLIf3lTcakxEWcNDLAB89nKG
         4IosI3wPfmZwZhHQSynroTq0O6TTShBe35D+FTlwBf+3t0N1a7XKJ8lXf9U7PYgbVrP7
         Tb53lyrs2E+NfzJ/u1vOGHtJLC35qtzM1KkFafmPlmXLBKlKUVybXKgcVnniOCWnuMZX
         J7CXv8iAEtf6FD4DSZOqz4p97tUD7Kj0xj5QL8CMLT6Wb8/FNP0Y5e8EGjMm/b1enD4B
         GOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0YZpXNbvNe/aSIMfW/fwl9JTlg+qPtxAYhHQZpkJJ4=;
        b=NrYeLoE/o9C7WS+29pC3ACjY2Ox6fpGlYHrs2jIH3Wt+l2vJ+6suE+xDgVmB3gTAqn
         17TNlVYoTPsdTjSO3XZGhsdvmcL0xDBPo2CPUR74TJT2mysbTk3fa9sQxn/NMtLH8n2S
         rk1hfv1PmhcuZO/ZqMxEvVKsUWFatm9V4IJdyEKCEiIJra62DeoiaOG11xQ0R3GjIL/a
         VDgBBP9thVyTauhhakwTY7PaZ2T+KiDxUKmUKb7Miaq0SQTMgyAbC/Onm+qhRengoQ8y
         QtPXKiAorApHYqW3aQk4xPsJpTpdbSFyXW4qpRdf5CH4fP3+44w/b5XArQFaojl6+gIg
         oO4g==
X-Gm-Message-State: AOAM531GqJC5yqNXXGuT9hisKJd5NYnjSJ2rmwJEcKXvEMUNsMtU1saF
        /ohFT7k5nijHVrhcfOhBSz3BBIs3ScRqB117CjMwiw==
X-Google-Smtp-Source: ABdhPJwmQWO+A9c4qf5r1Sf38PiCEAqfFiT0xFdSmkConGycXQzCXk0CGXuaUZiTt7ZCa0L/YNo6OIhaj0pjcUYyCjg=
X-Received: by 2002:a67:e359:: with SMTP id s25mr3243979vsm.55.1623230571541;
 Wed, 09 Jun 2021 02:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com> <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
In-Reply-To: <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Jun 2021 11:22:15 +0200
Message-ID: <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
> > On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
> >>
> >> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> >> related SoC's. This includes adding a .shutdown callback to increase
> >> the power savings during S5.
> >
> > Please split this into two separate changes.
> >
> > May I also ask about the ->shutdown() callback and in relation to S5.
> > What makes the ->shutdown callback only being invoked for S5?
>
> It is not only called for S5 (entered via poweroff on a prompt) but also
> during kexec or reboot. The poweroff path is via:
>
> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
> .shutdown()
>
> For kexec or reboot we do not really care about power savings since we
> are about to load a new image anyway, however for S5/poweroff we do care
> about quiescing the eMMC controller in a way that its clocks and the
> eMMC device can be put into low power mode since we will stay in that
> mode for seconds/hours/days until someone presses a button on their
> remote (or other wake-up sources).

Hmm, I am not sure I understand correctly. At shutdown we don't care
about wake-up sources from the kernel point of view, instead we treat
everything as if it will be powered off.

We put devices into low power state at system suspend and potentially
also during some of the hibernation phases.

Graceful shutdown of the eMMC is also managed by the mmc core.

Kind regards
Uffe
