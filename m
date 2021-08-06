Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E5C4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59219611C5
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbhHFGiK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbhHFGiK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 02:38:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ACBC061798;
        Thu,  5 Aug 2021 23:37:49 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s48so13338386ybi.7;
        Thu, 05 Aug 2021 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e4Tsg3+QaNlK6p5isNd/4qBpPAbKpvm5TqNjXboUpEE=;
        b=O76JziVZ4e6kK/4fPRRSF3MWaRtIJp/aBV2cNRlJZcF+Sb6gxfasxxtaaY6QKjTQzM
         lia2iotpYWqnPjf2Yhs31x7DUP2WGRTWehhCYKxSWR2GmNSVZZe9wc2ofJKGAEXmfNby
         cTdbeelmIfpZgMdUcTE9Pyk16f4uMbZYLGcK4xrRWuzvnuNUxzaEpqIvyYpKduhKY0uo
         tW/HA1tU782iIz6SrvVkyVf44WanTo1Qs0es7NbbMyC2CV8QJ6NtWrlv+yryel6A0mF8
         WJpFpeDDFOeUrHgG7H0EIoN0qpJugmTF3my1hQo0og9AO+R6AG7mMhts8crKz4BQIlTj
         OSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e4Tsg3+QaNlK6p5isNd/4qBpPAbKpvm5TqNjXboUpEE=;
        b=aSQDdxVCZvlUWsGCi/0gWH7Po1xNzc2zRlHNjd6Vk9Ipe77Hf/5hEZjlW1a2jfFaeq
         miYXDhodjpbPWzAI/Jk7BDXnuwZ5vDm5S2cngbsEjqlQ5dc3VRhNbDHYNvCZVmoUFxxZ
         45aB13GGn+A1yjMGCj6dgG5+C4AEupK5YpUyobgTExJxuiKQ9ubauMygmx5bN1+7wK5t
         le4R4jzoQ0eu4tY4KwMF03e91IpeKCfdAUHCngRiMspdDMc58npEYxyLfyRVc4z1U1Yf
         erxBRrgKseE2evzTQaQazDzCh5PV471oT0MIPLGPtAvS7T3YvuEknq6hSktRgwvqWGJE
         3HgQ==
X-Gm-Message-State: AOAM533hZ7tQYhGcXcT2hgorw21FfyhS9VDOk5zbR/WeBf6/33/u3gvt
        BCZkvAqTle7DHyssr1S/DCLgEZVtcbhNp88QIUE=
X-Google-Smtp-Source: ABdhPJw3Yxsc2diSV+uRU7BajgY7nofDMOxLOhMWgCPJwX6wuGoyZFSIRFqbYz98A5Mq6UNcntTVgqP1m0IMgGNjD/s=
X-Received: by 2002:a25:9ac6:: with SMTP id t6mr10758074ybo.190.1628231868666;
 Thu, 05 Aug 2021 23:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210722051414.8331-1-jasonlai.genesyslogic@gmail.com> <CAPDyKFqwiaTNNLKt_O6njyB6HPL35_gYy6KRZXqM4HRKJinShg@mail.gmail.com>
In-Reply-To: <CAPDyKFqwiaTNNLKt_O6njyB6HPL35_gYy6KRZXqM4HRKJinShg@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Fri, 6 Aug 2021 14:37:38 +0800
Message-ID: <CAG0XXUG5q8_o-A3K0LNVXoeJmXHn=N=uyR81p2ai0H827SeS4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3.2 00/29] Add support UHS-II for GL9755
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 03 Aug 2021 at 12:23,   Ulf Hansson <ulf.hansson@linaro.org>  wrote=
:
>
> On Thu, 22 Jul 2021 at 07:14, Jason Lai <jasonlai.genesyslogic@gmail.com>=
 wrote:
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > In these patches we focus on uhs2 side to address Ulf's suggestion whic=
h
> > was mentioned in patch [mmc: core: Preparations to support SD UHS-II ca=
rds].
> >
> >
> > I moved codes in uhs2.c to proper functions in sd_uhs2.c, which should =
meet
> > Ulf's expection.
> >
> > Please review this series (particularly Patch 29/29).
>
> I think you have misunderstood the intent with the series that I
> posted [1] a while ago. The idea was to add the foundation of what
> should be needed in the mmc core to support UHS-II cards. Note, it's
> only the foundation, not the complete code.
>
> In other words, I think you should base the next version of $subject
> series *on top* of my series [1], rather than the opposite.
>
Actually, I understand your intention is to implement functions which
can be applied to control all UHS-II cards.
However, why do I choose to base it on =E2=80=9C[RFC,v3.1,00/27] Add suppor=
t
UHS-II for GL9755=E2=80=9D?
Because it contains a complete UHS-II interface(both host & card side)
and UHS-II card can work normally.

The functionality of uhs2.c in the previous version of $subject almost
equal to sd_uhs2.c in your series [1].
The only difference is that UHS-II card initialization flow had been
modulated according to different phases(detect / phy_init /
legacy_init=E2=80=A6).
Hence, I decided to apply your architecture of sd_uhs2.c to uhs2.c and
rename uhs2.c to sd_uhs2.c.

All patches are briefed below:
1. Patch #1 to patch #26 are used to create a UHS-II interface, both
in host side and sd card side.
    -  patch#1: add UHS-II support in public headers. (include/linux/mmc).
    -  patch#2: add UHS-II relative features in mmc_power_up() /
mmc_power_off() / mmc_regulator_get_supply().
    -  patch#3: skip set_chip_select().
    -  patch#4: flow of =E2=80=9Cinterface selection and initialization=E2=
=80=9D was a
bit modified for UHS-II card.
    -  patch#5: skip TMODE(field of UHS-II command packet) setup in some ca=
ses.
    -  patch#6 - #7: generate UHS-II SD command packet.
    -  patch#8: add a kernel configuration for enabling UHS-II support.
    -  patch#9: add UHS-II related definitions in sdhci.h and sdhci-uhs2.h.
    -  patch#10: add sdhci-uhs2.c as a module for UHS-II support.
    -  patch#11: dump UHS-II registers
    -  patch#12 - #26: add UHS-II host setting / control / attach,
card detect / attach.
2. Patch #27: drivers/mmc/host/sdhci-pci-gli.c contains
vendor(Genesyslogic) specific operations which are related to hardware
control.
3. Patch #28: remove redundant code.
4. Patch #29: move code from uhs2.c to sd_uhs2.c and place them to
proper functions.

> Moreover, next time, please try to better describe in each changelog
> and in a cover letter what you have changed and why, as it helps me to
> review.
Okay.

So what is the next you suggest to do after my explanation?
1. Update cover letter & change note in current version of $subject.
2. Submit a new version on top of your series [1].
    For example: Series =E2=80=9CAdd Support UHS-II for GL9755=E2=80=9C
    patch #1~#4 are your original series[1] and patch #33 is to apply
your patch to support UHS-II cards. Below is the patch list:
    [0/33] mmc: core: Add Support UHS-II for GL9755
    [1/33] mmc: core: Cleanup printing of speed mode at card insertion
    [2/33] mmc: core: Prepare to support SD UHS-II cards
    [3/33] mmc: core: Announce successful insertion of an SD UHS-II card
    [4/33] mmc: core: Extend support for mmc regulators with a vqmmc2
    [5/33] mmc: add UHS-II related definitions in public headers
    [6/33] mmc: core: UHS-II support, modify power-up sequence
    =E2=80=A6=E2=80=A6
    [33/33] mmc: core: Apply Ulf's patch for supporting UHS-II car

Kind regards,
Jason Lai

> Kind regards
> Uffe
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=3D438509
>
> >
> > Thanks.
> > -Jason Lai
> >
> > ------ original cover letter from v3 ------
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
> > it would make little sense to go further ahead on sdhci side.
> > (Actually, Adrian has made no comments other than "modularising" so far=
.)
> >
> > I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> > set to meet what I believe Adrian expects; no UHS-II related code in
> > Legacy (UHS-I) code or sdhci.c.
> >
> > Nevertheless, almost of all changes I made are trivial and straightforw=
ard
> > in this direction, and I believe that there is no logic changed since v=
3
> > except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-=
II
> > command sequences in addition to UHS-II errors. So I added extra handli=
ngs.
> >
> > I admit that there is plenty of room for improvements (for example,
> > handling host->flags), but again the focal point here is how sdhci-uhs2=
.c
> > should be built as a module.
> >
> > Please review this series (particularly Patch#8-#26 and #27) from this
> > viewpoint in the first place.
> > (Ben is working on 'host' side but there is no change on 'host' side
> > in this submission except a minor tweak.)
> >
> > Thanks,
> > -Takahiro Akashi
> >
> > ------ original cover letter from v3 ------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
> >
> > TODO
> > =3D=3D=3D=3D
> > - replace some define with BIT macro
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> >   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > AKASHI Takahiro (23):
> >   mmc: core: UHS-II support, modify power-up sequence
> >   mmc: core: UHS-II support, skip set_chip_select()
> >   mmc: core: UHS-II support, skip TMODE setup in some cases
> >   mmc: core: UHS-II support, generate UHS-II SD command packet
> >   mmc: core: UHS-II support, set APP_CMD bit if necessary
> >   mmc: sdhci: add a kernel configuration for enabling UHS-II support
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci: add UHS-II module
> >   mmc: sdhci-uhs2: dump UHS-II registers
> >   mmc: sdhci-uhs2: add reset function
> >   mmc: sdhci-uhs2: add set_power() to support vdd2
> >   mmc: sdhci-uhs2: skip signal_voltage_switch()
> >   mmc: sdhci-uhs2: add set_timeout()
> >   mmc: sdhci-uhs2: add set_ios()
> >   mmc: sdhci-uhs2: add detect_init() to detect the interface
> >   mmc: sdhci-uhs2: add clock operations
> >   mmc: sdhci-uhs2: add set_reg() to initialise the interface
> >   mmc: sdhci-uhs2: add request() and others
> >   mmc: sdhci-uhs2: add irq() and others
> >   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> >   mmc: core: add post-mmc_attach_sd hook
> >   mmc: sdhci-pci: add UHS-II support framework
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >
> > Ben Chuang (4):
> >   mmc: add UHS-II related definitions in public headers
> >   mmc: core: UHS-II support, try to select UHS-II interface
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >   mmc: sdhci-uhs2: add post-mmc_attach_sd hook
> >
> >  drivers/mmc/core/Makefile         |    2 +-
> >  drivers/mmc/core/block.c          |    7 +-
> >  drivers/mmc/core/bus.c            |    5 +-
> >  drivers/mmc/core/core.c           |  118 +-
> >  drivers/mmc/core/regulator.c      |   14 +
> >  drivers/mmc/core/sd.c             |   32 +
> >  drivers/mmc/core/sd_ops.c         |   12 +
> >  drivers/mmc/core/uhs2.c           |  883 +++++++++++++++
> >  drivers/mmc/core/uhs2.h           |   21 +
> >  drivers/mmc/host/Kconfig          |   10 +
> >  drivers/mmc/host/Makefile         |    1 +
> >  drivers/mmc/host/sdhci-pci-core.c |   16 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  |  318 +++++-
> >  drivers/mmc/host/sdhci-pci.h      |    3 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 1697 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  224 ++++
> >  drivers/mmc/host/sdhci.c          |  333 +++---
> >  drivers/mmc/host/sdhci.h          |  117 +-
> >  include/linux/mmc/card.h          |    1 +
> >  include/linux/mmc/core.h          |    6 +
> >  include/linux/mmc/host.h          |   31 +
> >  include/linux/mmc/uhs2.h          |  268 +++++
> >  22 files changed, 3961 insertions(+), 158 deletions(-)
> >  create mode 100644 drivers/mmc/core/uhs2.c
> >  create mode 100644 drivers/mmc/core/uhs2.h
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/uhs2.h


Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B48=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:23=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, 22 Jul 2021 at 07:14, Jason Lai <jasonlai.genesyslogic@gmail.com>=
 wrote:
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > In these patches we focus on uhs2 side to address Ulf's suggestion whic=
h
> > was mentioned in patch [mmc: core: Preparations to support SD UHS-II ca=
rds].
> >
> >
> > I moved codes in uhs2.c to proper functions in sd_uhs2.c, which should =
meet
> > Ulf's expection.
> >
> > Please review this series (particularly Patch 29/29).
>
> I think you have misunderstood the intent with the series that I
> posted [1] a while ago. The idea was to add the foundation of what
> should be needed in the mmc core to support UHS-II cards. Note, it's
> only the foundation, not the complete code.
>
> In other words, I think you should base the next version of $subject
> series *on top* of my series [1], rather than the opposite.
>
> Moreover, next time, please try to better describe in each changelog
> and in a cover letter what you have changed and why, as it helps me to
> review.
>
> Kind regards
> Uffe
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=3D438509
>
> >
> > Thanks.
> > -Jason Lai
> >
> > ------ original cover letter from v3 ------
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
> > it would make little sense to go further ahead on sdhci side.
> > (Actually, Adrian has made no comments other than "modularising" so far=
.)
> >
> > I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> > set to meet what I believe Adrian expects; no UHS-II related code in
> > Legacy (UHS-I) code or sdhci.c.
> >
> > Nevertheless, almost of all changes I made are trivial and straightforw=
ard
> > in this direction, and I believe that there is no logic changed since v=
3
> > except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-=
II
> > command sequences in addition to UHS-II errors. So I added extra handli=
ngs.
> >
> > I admit that there is plenty of room for improvements (for example,
> > handling host->flags), but again the focal point here is how sdhci-uhs2=
.c
> > should be built as a module.
> >
> > Please review this series (particularly Patch#8-#26 and #27) from this
> > viewpoint in the first place.
> > (Ben is working on 'host' side but there is no change on 'host' side
> > in this submission except a minor tweak.)
> >
> > Thanks,
> > -Takahiro Akashi
> >
> > ------ original cover letter from v3 ------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
> >
> > TODO
> > =3D=3D=3D=3D
> > - replace some define with BIT macro
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> >   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > AKASHI Takahiro (23):
> >   mmc: core: UHS-II support, modify power-up sequence
> >   mmc: core: UHS-II support, skip set_chip_select()
> >   mmc: core: UHS-II support, skip TMODE setup in some cases
> >   mmc: core: UHS-II support, generate UHS-II SD command packet
> >   mmc: core: UHS-II support, set APP_CMD bit if necessary
> >   mmc: sdhci: add a kernel configuration for enabling UHS-II support
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci: add UHS-II module
> >   mmc: sdhci-uhs2: dump UHS-II registers
> >   mmc: sdhci-uhs2: add reset function
> >   mmc: sdhci-uhs2: add set_power() to support vdd2
> >   mmc: sdhci-uhs2: skip signal_voltage_switch()
> >   mmc: sdhci-uhs2: add set_timeout()
> >   mmc: sdhci-uhs2: add set_ios()
> >   mmc: sdhci-uhs2: add detect_init() to detect the interface
> >   mmc: sdhci-uhs2: add clock operations
> >   mmc: sdhci-uhs2: add set_reg() to initialise the interface
> >   mmc: sdhci-uhs2: add request() and others
> >   mmc: sdhci-uhs2: add irq() and others
> >   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> >   mmc: core: add post-mmc_attach_sd hook
> >   mmc: sdhci-pci: add UHS-II support framework
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >
> > Ben Chuang (4):
> >   mmc: add UHS-II related definitions in public headers
> >   mmc: core: UHS-II support, try to select UHS-II interface
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >   mmc: sdhci-uhs2: add post-mmc_attach_sd hook
> >
> >  drivers/mmc/core/Makefile         |    2 +-
> >  drivers/mmc/core/block.c          |    7 +-
> >  drivers/mmc/core/bus.c            |    5 +-
> >  drivers/mmc/core/core.c           |  118 +-
> >  drivers/mmc/core/regulator.c      |   14 +
> >  drivers/mmc/core/sd.c             |   32 +
> >  drivers/mmc/core/sd_ops.c         |   12 +
> >  drivers/mmc/core/uhs2.c           |  883 +++++++++++++++
> >  drivers/mmc/core/uhs2.h           |   21 +
> >  drivers/mmc/host/Kconfig          |   10 +
> >  drivers/mmc/host/Makefile         |    1 +
> >  drivers/mmc/host/sdhci-pci-core.c |   16 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  |  318 +++++-
> >  drivers/mmc/host/sdhci-pci.h      |    3 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 1697 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  224 ++++
> >  drivers/mmc/host/sdhci.c          |  333 +++---
> >  drivers/mmc/host/sdhci.h          |  117 +-
> >  include/linux/mmc/card.h          |    1 +
> >  include/linux/mmc/core.h          |    6 +
> >  include/linux/mmc/host.h          |   31 +
> >  include/linux/mmc/uhs2.h          |  268 +++++
> >  22 files changed, 3961 insertions(+), 158 deletions(-)
> >  create mode 100644 drivers/mmc/core/uhs2.c
> >  create mode 100644 drivers/mmc/core/uhs2.h
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/uhs2.h
