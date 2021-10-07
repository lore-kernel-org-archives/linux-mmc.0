Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF5C433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Oct 2021 21:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C764D61152
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Oct 2021 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhJGVlL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhJGVlL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Oct 2021 17:41:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E8EC061755
        for <linux-mmc@vger.kernel.org>; Thu,  7 Oct 2021 14:39:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so6468103pff.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 Oct 2021 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mABlAwLHsZ2a12EUjiNkKav9QrrHKT70s/HzdqkWE9E=;
        b=KOXShFYrpT17QDKG0QhwkvnzbPTN/YOi70RVHOLm1gt/YtfyuuNn1yHFuZsNlYYbI/
         Ytl+mCjoVpFHGlAf+mQsNd8MKB8YXWFPthHCMjoR0qJeUcKjCLVcx1CI/kUFjRxswbc4
         U11nPNpmz6ZGzj9bYnUXKEs3XpDXH7tqGkVrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mABlAwLHsZ2a12EUjiNkKav9QrrHKT70s/HzdqkWE9E=;
        b=V+aa00IjudxYXKwQ7Wqje/0kJ53xYlB4I77aAOt0lQa+GaNb5eFTgW1GZV09pgGUf8
         dlq9251lvlkm/7HikGKzTdtSsB1vOidAS9unTUjfUJ1tpZ538v8m/bTsa4eN3qV/tpmx
         tokTCO7PtfyLpOTPZ0JXyMwhDORex924gffYThQgywbaEnO/K8mdp/DDQ75K0klOfQIK
         uBHijWmQBLy+g0D8mu4I2OXGHo6107uzp6f0dTa4dCaAAM3FFf6YtF3/0Srz3tNqCA3p
         d4TJ4lGszReWehmlRUn8A2veauX5fgM/CNYQKklZxaGwtYi8VBBiTa8JwEu7TO/l8sGi
         iqYQ==
X-Gm-Message-State: AOAM531bJkC8BTJHurWjVF34g0dsKfcsE7/tpOlVynQ++Ic3jDd8uAEg
        qw4++OUuRfcIg6hTn2PTS26X94zI4ySuhw==
X-Google-Smtp-Source: ABdhPJxvbA/4rbO9TRSd5ktXNt2aF6zSgyORSZNtDfGY4hRoTZWjZpVgsk1GUcCi++RinXgl215IWQ==
X-Received: by 2002:aa7:8891:0:b0:44c:255d:391f with SMTP id z17-20020aa78891000000b0044c255d391fmr6802303pfe.26.1633642755461;
        Thu, 07 Oct 2021 14:39:15 -0700 (PDT)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id k17sm336789pff.214.2021.10.07.14.39.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 14:39:14 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id p1so6434034pfh.8
        for <linux-mmc@vger.kernel.org>; Thu, 07 Oct 2021 14:39:14 -0700 (PDT)
X-Received: by 2002:a63:1a64:: with SMTP id a36mr1565093pgm.225.1633642753857;
 Thu, 07 Oct 2021 14:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com> <YV8jfavX/W9T25YX@smile.fi.intel.com>
In-Reply-To: <YV8jfavX/W9T25YX@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 7 Oct 2021 15:39:02 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BbXA0GEuzUy68=W94ArMiO=3Sbg-HQNqUdtSTcvWOF0A@mail.gmail.com>
Message-ID: <CAHQZ30BbXA0GEuzUy68=W94ArMiO=3Sbg-HQNqUdtSTcvWOF0A@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It looks like you were previously using the `cd-gpios` DT property to
determine this. It also sounds like you switched from DT to ACPI so
you lost the ability to use this field?

Can you not use something like the following:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/drivers/mmc/host/sdhci-acpi.c;l=945

p.s.,
Sorry for resending. I sent it as rich text before.


On Thu, Oct 7, 2021 at 10:47 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 05, 2021 at 01:24:24PM +0300, Andy Shevchenko wrote:
> > It appears that one of the supported platform magically worked with the
> > custom IRQ handler (any hints how?) while having two PCB designs with
> > an opposite CD sense level. Here is an attempt to fix it by quirking out
> > CD GPIO.
> >
> > Patch 1 introduces two additional quirks (it's done this way due to
> > patch 3, see below). Patch 2 is an actual fix for the mentioned platform.
> > If backported need to be taken with patch 1 together. Patch 3 is (RFT)
> > clean up. The questionable part here is the locking scheme. Shouldn't
> > we do something similar in the generic IRQ handler of SDHCI? Or Broxton
> > case has something quite different in mind?
> >
> > Patches 4-6 are dead-code removals. Patch 4 accompanying patch 2, patches
> > 5-6 just similar to it, but (functionally) independent. Would like to hear
> > if it's okay to do.
> >
> > Any comments, hints, advice are welcome!
>
> Adrian, Ulf, any comments on this? At least first two fix the regression and
> would be nice to have them in sooner than later (I can split them separately
> if required).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
