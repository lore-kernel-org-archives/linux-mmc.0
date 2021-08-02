Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E9C4338F
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Aug 2021 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6259C60F55
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Aug 2021 16:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhHBQXp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhHBQXn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2021 12:23:43 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3814FC06179B
        for <linux-mmc@vger.kernel.org>; Mon,  2 Aug 2021 09:23:33 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id v16so9813507vss.7
        for <linux-mmc@vger.kernel.org>; Mon, 02 Aug 2021 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCHbBTSvV+ybTzop9al0+KpJ2EA+BwgcszrzzeHR1XY=;
        b=D15xF5VMF8x34aXn+UmKsK03eThx9BQ4aj3iGJc9kLXYfPtSh1Gl7DuZcAaPxDdiy8
         z6LbuktKfTeMZ1fSZ5fYhRP8QFW45GWqCApjzGmQYHCw8IKk3RkYdaXP79XYIpMybQXI
         BNTNC4M9jTg65/hjvERX7MyyfQARmifLba28Nki7wOEW9e7tY56GiWQtYDTxD5FavYsx
         kczUwcFB1WL2kCNlzugRcr5xXdcBmE13MUAa26x1x8HeBV2Zto2TeEJ7rYE27ciyHJGF
         maOmCzZk6ZHdmkjVEw35t/HP/awLl/PpE8lZI6loZCgx0IJzgngWuHFMg98uQV7y4fnI
         1WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCHbBTSvV+ybTzop9al0+KpJ2EA+BwgcszrzzeHR1XY=;
        b=R+aEVC7OcVIutKrMLMWj/1HzrTj+bi/dtKdMpAoNhwIx0Z6cOt9M4iwgfpwx7qcY8f
         y7Mkf7F3Wj+R4eLxf1QWbCCFNapabkiJw32ERYb6lYiGKe9Fh46zi7/OA7IyeuI3f/oL
         mbMMn27V3F0clCzKgo5Zxa89A28tkKVEvgQb9tran5nZGOsGxSpMWEacGJG60SqGEI48
         EVRGa3afFsTOnP8oNtKp539H1SvKEr32VrJrhN9d1yr5ZvPXutCscjeNXOpBUknpb/Pb
         yIT03abEKLYuS3hsjgmSzp1CKTyE8Jn/lj8pgUECILq1oq/FsqROK91f+dbFb7nfzyDo
         ng3w==
X-Gm-Message-State: AOAM533UlkuoOJVrb0bjhxulveTtIdsVOstx+SmoqgURG7mD1BvGPsvg
        S+QCLuqGq8RrK1IqE7MOfrysAAkuowvMDTzXHf1Gjg==
X-Google-Smtp-Source: ABdhPJwC7zIN5SRTDd2EGydeRTbAgofpCt6tljhx3FbctqkrBka7YbRGbfWWhzjo2xydrwYV9zOYNVLtqRH5auq6uYI=
X-Received: by 2002:a67:7c14:: with SMTP id x20mr2539558vsc.42.1627921412348;
 Mon, 02 Aug 2021 09:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210722051414.8331-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20210722051414.8331-1-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Aug 2021 18:22:55 +0200
Message-ID: <CAPDyKFqwiaTNNLKt_O6njyB6HPL35_gYy6KRZXqM4HRKJinShg@mail.gmail.com>
Subject: Re: [RFC PATCH v3.2 00/29] Add support UHS-II for GL9755
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 22 Jul 2021 at 07:14, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> Summary
> =======
> In these patches we focus on uhs2 side to address Ulf's suggestion which
> was mentioned in patch [mmc: core: Preparations to support SD UHS-II cards].
>
>
> I moved codes in uhs2.c to proper functions in sd_uhs2.c, which should meet
> Ulf's expection.
>
> Please review this series (particularly Patch 29/29).

I think you have misunderstood the intent with the series that I
posted [1] a while ago. The idea was to add the foundation of what
should be needed in the mmc core to support UHS-II cards. Note, it's
only the foundation, not the complete code.

In other words, I think you should base the next version of $subject
series *on top* of my series [1], rather than the opposite.

Moreover, next time, please try to better describe in each changelog
and in a cover letter what you have changed and why, as it helps me to
review.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=438509

>
> Thanks.
> -Jason Lai
>
> ------ original cover letter from v3 ------
> This is an interim snapshot of our next version, v4, for enabling
> UHS-II on MMC/SD.
>
> It is focused on 'sdhci' side to address Adrian's comments regarding
> "modularising" sdhci-uhs2.c.
> The whole aim of this version is to get early feedback from Adrian (and
> others) on this issue. Without any consensus about the code structure,
> it would make little sense to go further ahead on sdhci side.
> (Actually, Adrian has made no comments other than "modularising" so far.)
>
> I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> set to meet what I believe Adrian expects; no UHS-II related code in
> Legacy (UHS-I) code or sdhci.c.
>
> Nevertheless, almost of all changes I made are trivial and straightforward
> in this direction, and I believe that there is no logic changed since v3
> except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-II
> command sequences in addition to UHS-II errors. So I added extra handlings.
>
> I admit that there is plenty of room for improvements (for example,
> handling host->flags), but again the focal point here is how sdhci-uhs2.c
> should be built as a module.
>
> Please review this series (particularly Patch#8-#26 and #27) from this
> viewpoint in the first place.
> (Ben is working on 'host' side but there is no change on 'host' side
> in this submission except a minor tweak.)
>
> Thanks,
> -Takahiro Akashi
>
> ------ original cover letter from v3 ------
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
>   Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> ===============
> patch#1-#7: for core
> patch#8-#17: for sdhci
> patch#18-#21: for GL9755
>
> Tests
> =====
> Ran 'dd' command to evaluate the performance:
> (SanDisk UHS-II card on GL9755 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> UHS-II enabled         :  206MB/s   80MB/s
>
> TODO
> ====
> - replace some define with BIT macro
>
> Reference
> =========
> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
>
> Changes in v3 (Jul. 10, 2020)
> * rebased to v5.8-rc4
> * add copyright notice
> * reorganize the patch set and split some commits into smaller ones
> * separate uhs-2 headers from others
> * correct wrong spellings
> * fix most of checkpatch warnings/errors
> * remove all k[cz]alloc() from the code
> * guard sdhci-uhs2 specific code with
>       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> * make sdhci-uhs2.c as a module
> * trivial changes, including
>   - rename back sdhci-core.c to sdhci.c
>   - allow vendor code to disable uhs2 if v4_mode == 0
>       in __sdhci_add_host()
>   - merge uhs2_power_up() into mmc_power_up()
>   - remove flag_uhs2 from mmc_attach_sd()
>   - add function descriptions to EXPORT'ed functions
>   - other minor code optimization
>
> Changes in v2 (Jan. 9, 2020)
> * rebased to v5.5-rc5
>
> AKASHI Takahiro (23):
>   mmc: core: UHS-II support, modify power-up sequence
>   mmc: core: UHS-II support, skip set_chip_select()
>   mmc: core: UHS-II support, skip TMODE setup in some cases
>   mmc: core: UHS-II support, generate UHS-II SD command packet
>   mmc: core: UHS-II support, set APP_CMD bit if necessary
>   mmc: sdhci: add a kernel configuration for enabling UHS-II support
>   mmc: sdhci: add UHS-II related definitions in headers
>   mmc: sdhci: add UHS-II module
>   mmc: sdhci-uhs2: dump UHS-II registers
>   mmc: sdhci-uhs2: add reset function
>   mmc: sdhci-uhs2: add set_power() to support vdd2
>   mmc: sdhci-uhs2: skip signal_voltage_switch()
>   mmc: sdhci-uhs2: add set_timeout()
>   mmc: sdhci-uhs2: add set_ios()
>   mmc: sdhci-uhs2: add detect_init() to detect the interface
>   mmc: sdhci-uhs2: add clock operations
>   mmc: sdhci-uhs2: add set_reg() to initialise the interface
>   mmc: sdhci-uhs2: add request() and others
>   mmc: sdhci-uhs2: add irq() and others
>   mmc: sdhci-uhs2: add add_host() and others to set up the driver
>   mmc: core: add post-mmc_attach_sd hook
>   mmc: sdhci-pci: add UHS-II support framework
>   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
>
> Ben Chuang (4):
>   mmc: add UHS-II related definitions in public headers
>   mmc: core: UHS-II support, try to select UHS-II interface
>   mmc: sdhci-uhs2: add pre-detect_init hook
>   mmc: sdhci-uhs2: add post-mmc_attach_sd hook
>
>  drivers/mmc/core/Makefile         |    2 +-
>  drivers/mmc/core/block.c          |    7 +-
>  drivers/mmc/core/bus.c            |    5 +-
>  drivers/mmc/core/core.c           |  118 +-
>  drivers/mmc/core/regulator.c      |   14 +
>  drivers/mmc/core/sd.c             |   32 +
>  drivers/mmc/core/sd_ops.c         |   12 +
>  drivers/mmc/core/uhs2.c           |  883 +++++++++++++++
>  drivers/mmc/core/uhs2.h           |   21 +
>  drivers/mmc/host/Kconfig          |   10 +
>  drivers/mmc/host/Makefile         |    1 +
>  drivers/mmc/host/sdhci-pci-core.c |   16 +-
>  drivers/mmc/host/sdhci-pci-gli.c  |  318 +++++-
>  drivers/mmc/host/sdhci-pci.h      |    3 +
>  drivers/mmc/host/sdhci-uhs2.c     | 1697 +++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h     |  224 ++++
>  drivers/mmc/host/sdhci.c          |  333 +++---
>  drivers/mmc/host/sdhci.h          |  117 +-
>  include/linux/mmc/card.h          |    1 +
>  include/linux/mmc/core.h          |    6 +
>  include/linux/mmc/host.h          |   31 +
>  include/linux/mmc/uhs2.h          |  268 +++++
>  22 files changed, 3961 insertions(+), 158 deletions(-)
>  create mode 100644 drivers/mmc/core/uhs2.c
>  create mode 100644 drivers/mmc/core/uhs2.h
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
>  create mode 100644 include/linux/mmc/uhs2.h
