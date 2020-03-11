Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B96C10F27
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 11:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA3D20727
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsBcjGxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgCKLxz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:53:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33863 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgCKLxz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 07:53:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id f3so1751779qkh.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1xSL1o+NqyKd9I8sPs8mTSFO8utbom2U4a4ZHzmx0g=;
        b=bsBcjGxeXd3uADDos9L3SQ8vFNJ3HKyVV5Kcw7OTM2yU9mVnmkgMT7KZcl+4AQhrIW
         MajRDcOX6xlUx2B3s0gAydnUZv6DOG6Ar7EmoGcnWHLAiCwRIRhz7VDm1wu+PVKNY4AM
         QKvwpSwEzoZ44wSH54M0RsnkBZkOAUTxVgvj6j23H2bz9a0v6lmTPxywWI+VGuADAqLi
         ggopWIeq5ZZSBuO/TPFTKKINU3yzOS9iEjrE2pvE20DxQpdRVDtRXdGJ5vb2H1GkfyBz
         V0fwzJfHSBaHVLuq+5WK50DFBxcKn+AhZwQc8xp7Bgfi+AhDJOmR6Vz4DYonwZHjwTEm
         JW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1xSL1o+NqyKd9I8sPs8mTSFO8utbom2U4a4ZHzmx0g=;
        b=p8UL+7jwW1vvd3xPe2JBjo+zEb7vuwwGhCne8Pk70qF3YCvqnmC4KQaj7xZ9hXcvb8
         Ge4nHFQG2IP1de7nq13lNP9sNMwepGFt4qAOLgkNYMP+FZvZ6kVjCM7rK99Imyw+eiHA
         8PpTc1bRiUx6nJdE0TYpOzNAA/Eq9NATUwgYEQmhiU4PO6FaCuE2WOAYdJkx0ueAOgHG
         Koq8WgG5bXVF9rkONQaM84UxSwIyZbUsQQvHU5A2gRgB1PF/F1zy/a8UEDBlN+2jbA04
         agGUniZ/h6mIuzvIsd+NyjdiQYTRXyaya9Q9LTg8ArQeN9iV0ZIAG4V5uBAe9SkyhP2F
         Rw3g==
X-Gm-Message-State: ANhLgQ06YQbdXnAnngjoYq0gyOhm4HzuiYiib2hLBcH4bbAwFu9bAmhC
        oZXkJiVZD96PKByfhEPyK4oUIhijgg48JhzZiME=
X-Google-Smtp-Source: ADFU+vvshmjJVirmHrJPNPzQwewRgIaE52Gm16dc/Gvkso+CXQiM14OZvNOLZWD83FAp/kcgUT0B5OiL2Zbe3W1fCHE=
X-Received: by 2002:ae9:e202:: with SMTP id c2mr2462428qkc.224.1583927632263;
 Wed, 11 Mar 2020 04:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200310153340.5593-1-ulf.hansson@linaro.org> <CAPDyKFq_Lxhs1T4V2G-au9YZHe_CVz-XWapXeECADS4K3yWyuA@mail.gmail.com>
In-Reply-To: <CAPDyKFq_Lxhs1T4V2G-au9YZHe_CVz-XWapXeECADS4K3yWyuA@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 11 Mar 2020 07:53:28 -0400
Message-ID: <CAMdYzYoWr6gJcBPP1Re9XfJYg3tcj38twXYZ36bviDt9jVCBNg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: Fix busy detection timeouts for some SDHCI variant
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 11, 2020 at 5:03 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 10 Mar 2020 at 16:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > The mmc core may decide (for CMD6 and erase/trim/discard operations) to convert
> > from using an R1B response into using an R1 response, in cases when the needed
> > busy timeout exceeds the host's maximum supported HW max_busy_timeout. The core
> > does this to prevent the host from doing HW busy detection and instead rely on
> > polling, as to cope with the needed busy timeout.
> >
> > However, it has turned out that some SDHCI variants (tegra, omap), really
> > requires R1B for all commands that have this response associated with them. This
> > became especially obvious when commit 24ed3bd01d6a ("mmc: core: Specify timeouts
> > for BKOPS and CACHE_FLUSH for eMMC") (and a few other commits on top) got
> > introduced in v5.6-rc1, as several people reported errors (thanks!). More
> > precisely, the mentioned commit triggered the existing problems described above
> > in the SDHCI variant drivers, when an eMMC cache flush command (CMD6) was
> > issued.
> >
> > This series fixes these problems, but the changes are also targeted for stable
> > releases as the problems have existed since a long time back.
> >
> > Please help out in testing this!
>
> FYI, this is now applied on my fixes branch.
>
> [...]
>
> Kind regards
> Uffe

Short term this appears to resolve the issue on Ouya (Tegra30).
I'll let you know if anything comes up long term, but for the reported issue:

Tested-By: Peter Geis <pgwipeout@gmail.com>
