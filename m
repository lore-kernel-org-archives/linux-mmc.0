Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119CC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 07:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B668721775
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 07:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvPo0O0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgGTHGX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTHGW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 03:06:22 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F63C0619D2;
        Mon, 20 Jul 2020 00:06:22 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a15so7798233ybs.8;
        Mon, 20 Jul 2020 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNpI/M/lodtD3bMxBFq9KWF3f+wOZiZ1YyX4woKE7VM=;
        b=UvPo0O0w2d3vzAuShlPvhku2YquKaFq7MEjWEV3stlDM7Aj3SGr0FXfFjGihGMbxzO
         XbaqkLJec66jefVoNu9g3/Hj4aW7YpIkuNv0a80/LSXXJQWFNx8/wOaqdR9GWhFWuHc1
         HKihJUL0HziFgzL1VVJzzIOW/eyTPCymSM7LdrbBkZ5oWgJhmGB9JDa+rt+bsW/GoHoT
         +fojEYnGEgDYyaYtUsyhsYiNimhg8ODzuO4uSPWfAbk4YWL4aDKPR1F+RBXzQ6qIj2UP
         NlNxp8ZH7nOOUdwfvdhoiRbQv/XAGOGd5JpFR4+dr2DOMjhwRmMuizYAzCtsntqfWd/o
         z94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNpI/M/lodtD3bMxBFq9KWF3f+wOZiZ1YyX4woKE7VM=;
        b=rvDyQGTJ10DEJqWZZBMDiXRdnvCJO507WijkV5w+WbU+bzrJIXxibz6ynfJLaImISh
         aWrbAjVlfFgpd67DUssI5+i2NFG3XwuX3Na8YEnS69RgB9b0DvDJdQvHyKUPAF6X6lFC
         xNa4Yk34lc5du3EMk7TQCcptLc6tERw59tjDxZdWoBUTJrOIOoBuNRYAxEfHshgrC+Kg
         7+1W/B0GV1AQYFnQifOa7GAj6L1KmK8lRxCL3aThNl1URra9nXPtcvDaMMwdfzaxkzpW
         TU5HFRfMasnoR0VIxXs4WfAUrqOxxJ2dpIBFaNCLnQf+XgrSXA2IxqAt0I1GWDhQxqQ/
         p5Sw==
X-Gm-Message-State: AOAM531Mfez/Y7sclc3Svx/8JXqsIH2zuRSEZcrJCJILjbHeAeiJL3Ar
        eBBamsH6yrU3nFRvq+J5ILGiy0LUvY2WhX+PdGCbnAVlhYs=
X-Google-Smtp-Source: ABdhPJzweLAaK0Z3fYb6E0HOOnj4ZMMVVmVr2KHbrpCIA/Ho2onbFx4K9dgG5rU+O0L7QUbNixBeMlgEoENfbKi8aaM=
X-Received: by 2002:a25:3f81:: with SMTP id m123mr35108107yba.476.1595228781661;
 Mon, 20 Jul 2020 00:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200710110752.28853-1-benchuanggli@gmail.com> <CAPDyKFqUOdDCe6DAQMP-1GL3uAgLcKpaT7Hq-esi+nATbiiD2w@mail.gmail.com>
In-Reply-To: <CAPDyKFqUOdDCe6DAQMP-1GL3uAgLcKpaT7Hq-esi+nATbiiD2w@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Mon, 20 Jul 2020 15:06:10 +0800
Message-ID: <CACT4zj__3LM9_kz3ZYRG=dv-BPdpTByHF_W_20LeR15Toz9rNQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/21] Add support UHS-II for GL9755
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 17, 2020 at 6:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 10 Jul 2020 at 13:07, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Summary
> > =======
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> First of all, thanks for posting this - and my apologies for not
> having the bandwidth to review the earlier versions.
>
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the original
> >   interrupt registers.
>
> The above points to some specifications, which is good, but what I
> really need to be able to do a proper review -  is an explanation of
> *what*, *why* and *how* the series implements the UHS-II support.

What:
 1. detect UHS-II interface of a card
 2. change card to UHS-II mode
 3. send SD command through SD-TRAN
 4. go back to legacy interface if not detect UHS-II interface

Why:
 1. UHS-II card support Legacy Interface and UHS-II interface

How:
  a) Using 3.13.2 Card Interface Detection Sequence
  1. power up, host provides RCLK and STB.L to D0.lane.
  2. host waits D1.lane to change EIDL to STB.L
  3. host starts UHS-II initialization if STB.L

>
> To be clear, I don't need in-depth details, as that should be
> described in each patch's commit message, but I would appreciate an
> overall description of the approach you have taken to implement this.
>
> The reason I need this is because UHS-II is a completely new
> interface/protocol. If it wasn't because that a UHS-II card is also
> required to be backwards compatible with the legacy SD interface, one
> could even consider introducing an entirely new subsystem. Not saying
> that we should, but just pointing out that the series is not trivial
> to review.
>
> That said, I am going to give it a real try to do the review. I will
> try to focus on the overall approach, rather than on the details, at
> least to start with.
>

Thank you, I will be patient.

> >
> > Patch structure
> > ===============
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =====
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
>
> I like these comparisons, thanks for sharing!
>
> What UHS-II interface mode does you HW support? FD156, HD312, FD312 FD624?

GL9755 supports up to HD312.

>
> >
> > TODO
> > ====
> > - replace some define with BIT macro
> >
> > Reference
> > =========
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> >
> > Changes in v3 (Jul. 10, 2020)
> > * rebased to v5.8-rc4
> > * add copyright notice
> > * reorganize the patch set and split some commits into smaller ones
> > * separate uhs-2 headers from others
> > * correct wrong spellings
> > * fix most of checkpatch warnings/errors
> > * remove all k[cz]alloc() from the code
> > * guard sdhci-uhs2 specific code with
> >       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> > * make sdhci-uhs2.c as a module
> > * trivial changes, including
> >   - rename back sdhci-core.c to sdhci.c
> >   - allow vendor code to disable uhs2 if v4_mode == 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > AKASHI Takahiro (15):
> >   mmc: core: UHS-II support, modify power-up sequence
> >   mmc: core: UHS-II support, skip set_chip_select()
> >   mmc: core: UHS-II support, skip TMODE setup in some cases
> >   mmc: core: UHS-II support, generate UHS-II SD command packet
> >   mmc: core: UHS-II support, set APP_CMD bit if necessary
> >   mmc: sdhci: add a kernel configuration for enabling UHS-II support
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci: UHS-II support, dump UHS-II registers
> >   mmc: sdhci: UHS-II support, export host operations to core
> >   mmc: sdhci: UHS-II support, skip signal_voltage_switch()
> >   mmc: sdhci: UHS-II support, handle vdd2 in case of power-off
> >   mmc: sdhci: UHS-II support, modify set_power() to handle vdd2
> >   mmc: sdhci: UHS-II support, export helper functions to a module
> >   mmc: sdhci: UHS-II support, implement operations as a module
> >   mmc: core: add post-mmc_attach_sd hook
> >
> > Ben Chuang (6):
> >   mmc: add UHS-II related definitions in public headers
> >   mmc: core: UHS-II support, try to select UHS-II interface
> >   mmc: sdhci: UHS-II support, add hooks for additional operations
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >   mmc: sdhci-uhs2: add post-mmc_attach_sd hook
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >
> >  drivers/mmc/core/Makefile         |   2 +-
> >  drivers/mmc/core/block.c          |   7 +-
> >  drivers/mmc/core/bus.c            |   5 +-
> >  drivers/mmc/core/core.c           | 119 +++-
> >  drivers/mmc/core/regulator.c      |  14 +
> >  drivers/mmc/core/sd.c             |  32 ++
> >  drivers/mmc/core/sd_ops.c         |  12 +
> >  drivers/mmc/core/uhs2.c           | 874 ++++++++++++++++++++++++++++++
>
> Nitpick:
>
> I would prefer to prefix any new needed file with sd_*. In this case,
> sd_uhs2.c|h.

OK, change uhs2.c and uhs2.h to sd_uhs2.c and sd_uhs2.h later.

>
> >  drivers/mmc/core/uhs2.h           |  21 +
> >  drivers/mmc/host/Kconfig          |  10 +
> >  drivers/mmc/host/Makefile         |   1 +
> >  drivers/mmc/host/sdhci-omap.c     |   2 +-
> >  drivers/mmc/host/sdhci-pci-core.c |   4 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  | 361 +++++++++++-
> >  drivers/mmc/host/sdhci-pxav3.c    |   4 +-
> >  drivers/mmc/host/sdhci-uhs2.c     | 797 +++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     | 215 ++++++++
> >  drivers/mmc/host/sdhci-xenon.c    |   4 +-
> >  drivers/mmc/host/sdhci.c          | 321 +++++++++--
> >  drivers/mmc/host/sdhci.h          | 113 +++-
> >  include/linux/mmc/card.h          |   1 +
> >  include/linux/mmc/core.h          |   6 +
> >  include/linux/mmc/host.h          |  31 ++
> >  include/linux/mmc/uhs2.h          | 268 +++++++++
> >  24 files changed, 3151 insertions(+), 73 deletions(-)
> >  create mode 100644 drivers/mmc/core/uhs2.c
> >  create mode 100644 drivers/mmc/core/uhs2.h
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/uhs2.h
> >
> > --
> > 2.27.0
> >
>
> Kind regards
> Uffe
