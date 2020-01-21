Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6D8C2D0CE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0111C217F4
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 09:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9QszvYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgAUJhE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:37:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38741 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJhE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2020 04:37:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so2320875edr.5;
        Tue, 21 Jan 2020 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjbOfycbMXADN0Mq2KkmMGoMuT5PMUjYvWEFyCEUP7Y=;
        b=g9QszvYY6IuYcBoSfX0lEEAuAU6/IaT4deJUh02a+H8d2rChHKE6LmeXDdHjtzW4ph
         LIgLC/ZdzpZtsESBwuC9w4klE90HBy2fksU9wr8gsSpg0bajrh1KZsbn2jRie7Q+Y5SJ
         a1hmJSMnUL/Cxul+qG2kjQhmu2fFF/dWy56rox3MfYgrJ2Djy+PkKGXu9swQlpABWdlK
         zpPfnMVD3Gv8WoUUbgfTHQUwAdzjZBcUJ4YVqq9pHVxn36VDTKnhz0for33CuLYr2ZJs
         3+VyqVkNu0AgwZ3nu/bEt3/gkODkZ2edEcfpIl3cIQAbA0FP4tYrbbZef4bCI85S6Vbk
         oawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjbOfycbMXADN0Mq2KkmMGoMuT5PMUjYvWEFyCEUP7Y=;
        b=DwfkuAk4mzhZa2NDNNcfcdEoZgJR1xkfTCoYmsz98sPAkSpJvuzBZ3M8GtIaQUV0KX
         k4jJkuXuLN6AT/siuQMEf2dFvf8hpbWtSoXZVof9wI7hEtJfgXm4FoPMElVXOJKqhcjM
         V8SrO9QfgYXL8rZmz6AsjeM+OzEk3bnqehh9CyPsKUyc3cGXSNPKtOApdPY5nSYUMcVW
         DpV8i1jHf42UuePXkWiOSy1RW5JNy1FuWQyBohK5QG2YSiPDjicUrZXrOp4KJsb5HJQA
         dTMxvHlKKPlN9d9DlbT/bXgPAqFgM7fkok+Cc1zovFGACPujtO9U7NwyZWgqm1YmaLHr
         mcyg==
X-Gm-Message-State: APjAAAX4BxPwgr4zWm4gyz39gcS17IMDu8qK4SnhsUYVV2/7bIcGk387
        c+KzCHFu+mRybe58pmtz0mCa/MFrMv+QN4tk0Fs=
X-Google-Smtp-Source: APXvYqw0v0yzEPKMmKN0yxJabc8zTANNBDVY4v8l+JGTZ7upPwUupD05k1F85YJCpnGd4rZGKL62nxjw7AJsQEQg/sY=
X-Received: by 2002:a17:906:7c47:: with SMTP id g7mr3479180ejp.281.1579599422453;
 Tue, 21 Jan 2020 01:37:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578560282.git.benchuanggli@gmail.com>
In-Reply-To: <cover.1578560282.git.benchuanggli@gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Tue, 21 Jan 2020 17:36:51 +0800
Message-ID: <CACT4zj9B8BSebZgf5-nc3zGYhsAGQ6gTRvfFf9r1DBB_mpRtHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] Add support UHS-II for GL9755
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe and Adrian,

On Thu, Jan 9, 2020 at 5:13 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Uffe and Adrian,
>
> These patches support UHS-II and fix GL9755 UHS-II compatibility.
>
> The parts of UHS-II are based on [1][2] and porting to Linux 5.5-rc5.
> I have seen that Uffe comment that splitting the UHS-II parts into smaller
> patches. Other than splitting into small patches, could you give me some
> suggestions for refactoring/splitting files?
>
> Best regards,
> Ben

Gentle Ping, Any comments?

Best regards,
Ben

>
> References:
> 1. [RFC,1/2] mmc: core: support UHS-II in core stack.
>    (https://patchwork.kernel.org/patch/5544441/)
> 2. [RFC,2/2] mmc: sdhci: support UHS-II in SDHCI host.
>    (https://patchwork.kernel.org/patch/5544451/)
>
> v2:
>   - base on Linux v5.5-rc5
>
> Ben Chuang (6):
>   mmc: Add UHS-II support in public headers
>   mmc: core: Add UHS-II support in core layer
>   mmc: host: Add UHS-II support in host layer
>   mmc: uhs2: Introduce a uhs2_post_attach_sd function
>   mmc: sdhci-uhs2: Introduce a uhs2_pre_detect_init function
>   mmc: sdhci-pci-gli: Fix power/reset/ZC/timeout for GL9755 UHS-II mode
>
>  drivers/mmc/core/Makefile                  |   3 +-
>  drivers/mmc/core/block.c                   |   7 +-
>  drivers/mmc/core/bus.c                     |   5 +-
>  drivers/mmc/core/core.c                    |  65 +-
>  drivers/mmc/core/core.h                    |   3 +-
>  drivers/mmc/core/regulator.c               |  14 +
>  drivers/mmc/core/sd.c                      |  27 +-
>  drivers/mmc/core/sd_ops.c                  |  12 +
>  drivers/mmc/core/uhs2.c                    | 995 +++++++++++++++++++++
>  drivers/mmc/core/uhs2.h                    |  23 +
>  drivers/mmc/host/Makefile                  |   1 +
>  drivers/mmc/host/{sdhci.c => sdhci-core.c} | 285 +++++-
>  drivers/mmc/host/sdhci-milbeaut.c          |   4 +-
>  drivers/mmc/host/sdhci-of-arasan.c         |   4 +-
>  drivers/mmc/host/sdhci-of-at91.c           |   4 +-
>  drivers/mmc/host/sdhci-omap.c              |   2 +-
>  drivers/mmc/host/sdhci-pci-core.c          |   4 +-
>  drivers/mmc/host/sdhci-pci-gli.c           | 361 +++++++-
>  drivers/mmc/host/sdhci-pxav3.c             |   4 +-
>  drivers/mmc/host/sdhci-uhs2.c              | 754 ++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h              |  34 +
>  drivers/mmc/host/sdhci-xenon.c             |   4 +-
>  drivers/mmc/host/sdhci.h                   | 286 +++++-
>  drivers/mmc/host/sdhci_am654.c             |   4 +-
>  include/linux/mmc/card.h                   |   1 +
>  include/linux/mmc/core.h                   |   6 +
>  include/linux/mmc/host.h                   |  31 +
>  include/linux/mmc/uhs2.h                   | 270 ++++++
>  28 files changed, 3137 insertions(+), 76 deletions(-)
>  create mode 100644 drivers/mmc/core/uhs2.c
>  create mode 100644 drivers/mmc/core/uhs2.h
>  rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (94%)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
>  create mode 100644 include/linux/mmc/uhs2.h
>
>
> base-commit: c79f46a282390e0f5b306007bf7b11a46d529538
> --
> 2.24.1
>
