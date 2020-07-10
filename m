Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80975C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5905E2077D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJIKXNjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJLHM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLHL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:07:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A844C08C5CE;
        Fri, 10 Jul 2020 04:07:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so2408729pfu.3;
        Fri, 10 Jul 2020 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GuGEjhXorgGIUJW+rnjz22Ly0/e/4bfXGQk4qdpqCog=;
        b=hJIKXNjnUq7FbRtap6nVEA3V/OaX0NY/6iRkcCXAl3wRHxoar9YXQZ4JLeKHy1Bso5
         I6zwqIHthMkuqdc9jDn8CqEdQCXpuH2jfkqgana8/kJPSWqEIHbazFRJljh10QhgKyhK
         k4j9y2i9ZUj/rDfX6sga3N+hjKyc75HC4F1KRnDAnQ6f9OWgzYQPaJDDheYsaETI1iNS
         RHzjBFN2kINezfZmGp4hFFr74SP2H0qK0YMGUVvusNGwY2CmDY6jrTdds58giKqf2U0n
         de49Ov4FsaMMIt7UQNGGEFSA9CWjbAS3hhivQHz8oDqEGNJxPuuw407kVjb0uYW01YD1
         aZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GuGEjhXorgGIUJW+rnjz22Ly0/e/4bfXGQk4qdpqCog=;
        b=RMgZhwqyRYGlfhVbzl+7LNxwLVCMDe7ip4uPy9TEykkINBMvLwAVW46Aij5F04Ax+W
         BXQiiIP4fwawrYjb94Rj+F7ZJUSPSlOfEgpd1o55lEYgmgk5YSnYhCWCN/YDZ/e8q4TG
         nc8o0JqBMgEgY/ED0Nwcmv2TCncRCHKETSc0beptrhp4Br8OqjP22AE/zQiOnsRY/Euk
         qBn/p1fgfDjWvGzTVI/lAvP+llT4bF65XW+DyybqDnyO0Vc5tOvbnU7NDHFxdZc+0QHW
         J9Dy/dnUI8N/fqbqOde9rYzqvH2VR5qxS+kKRBnNNGrx57NI8+M9KR3xed8uLopgpz2A
         s1mg==
X-Gm-Message-State: AOAM533Bg1xtBccpm4lt/JV2PKSyKNNngcZHpdswTxWv4mGNGmZMeLk7
        uU3AjIxz6fOF28zwxA3ydibGnj1G
X-Google-Smtp-Source: ABdhPJzKPq0Ch2b71+XGzwUAWG6n3vLOdULLtginDGQQ9qUgCYbf62DE4IVC7VqBOc0lXPAkKl9KOg==
X-Received: by 2002:a62:1c8b:: with SMTP id c133mr24481584pfc.134.1594379231037;
        Fri, 10 Jul 2020 04:07:11 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x23sm5553409pfn.4.2020.07.10.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:07:10 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 00/21] Add support UHS-II for GL9755
Date:   Fri, 10 Jul 2020 19:07:52 +0800
Message-Id: <20200710110752.28853-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Summary
=======
These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.

About UHS-II, roughly deal with the following three parts:
1) A UHS-II detection and initialization:
- Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
  [2]).
- Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
- In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
  3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
  Setup Sequence.

2) Send Legacy SD command through SD-TRAN
- Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
  compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
  Types and Format Overview[3]).
- Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
  CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).

3) UHS-II Interrupt
- Except for UHS-II error interrupts, most interrupts share the original 
  interrupt registers.

Patch structure
===============
patch#1-#7: for core
patch#8-#17: for sdhci
patch#18-#21: for GL9755

Tests
=====
Ran 'dd' command to evaluate the performance:
(SanDisk UHS-II card on GL9755 controller)
                             Read    Write
UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
UHS-II enabled         :  206MB/s   80MB/s

TODO
====
- replace some define with BIT macro

Reference
=========
[1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
[2] SD Host Controller Simplified Specification 4.20
[3] UHS-II Simplified Addendum 1.02

Changes in v3 (Jul. 10, 2020)
* rebased to v5.8-rc4
* add copyright notice
* reorganize the patch set and split some commits into smaller ones
* separate uhs-2 headers from others
* correct wrong spellings
* fix most of checkpatch warnings/errors
* remove all k[cz]alloc() from the code
* guard sdhci-uhs2 specific code with
      'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
* make sdhci-uhs2.c as a module
* trivial changes, including
  - rename back sdhci-core.c to sdhci.c
  - allow vendor code to disable uhs2 if v4_mode == 0
      in __sdhci_add_host()
  - merge uhs2_power_up() into mmc_power_up()
  - remove flag_uhs2 from mmc_attach_sd()
  - add function descriptions to EXPORT'ed functions
  - other minor code optimization

Changes in v2 (Jan. 9, 2020)
* rebased to v5.5-rc5

AKASHI Takahiro (15):
  mmc: core: UHS-II support, modify power-up sequence
  mmc: core: UHS-II support, skip set_chip_select()
  mmc: core: UHS-II support, skip TMODE setup in some cases
  mmc: core: UHS-II support, generate UHS-II SD command packet
  mmc: core: UHS-II support, set APP_CMD bit if necessary
  mmc: sdhci: add a kernel configuration for enabling UHS-II support
  mmc: sdhci: add UHS-II related definitions in headers
  mmc: sdhci: UHS-II support, dump UHS-II registers
  mmc: sdhci: UHS-II support, export host operations to core
  mmc: sdhci: UHS-II support, skip signal_voltage_switch()
  mmc: sdhci: UHS-II support, handle vdd2 in case of power-off
  mmc: sdhci: UHS-II support, modify set_power() to handle vdd2
  mmc: sdhci: UHS-II support, export helper functions to a module
  mmc: sdhci: UHS-II support, implement operations as a module
  mmc: core: add post-mmc_attach_sd hook

Ben Chuang (6):
  mmc: add UHS-II related definitions in public headers
  mmc: core: UHS-II support, try to select UHS-II interface
  mmc: sdhci: UHS-II support, add hooks for additional operations
  mmc: sdhci-uhs2: add pre-detect_init hook
  mmc: sdhci-uhs2: add post-mmc_attach_sd hook
  mmc: sdhci-pci-gli: enable UHS-II mode for GL9755

 drivers/mmc/core/Makefile         |   2 +-
 drivers/mmc/core/block.c          |   7 +-
 drivers/mmc/core/bus.c            |   5 +-
 drivers/mmc/core/core.c           | 119 +++-
 drivers/mmc/core/regulator.c      |  14 +
 drivers/mmc/core/sd.c             |  32 ++
 drivers/mmc/core/sd_ops.c         |  12 +
 drivers/mmc/core/uhs2.c           | 874 ++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h           |  21 +
 drivers/mmc/host/Kconfig          |  10 +
 drivers/mmc/host/Makefile         |   1 +
 drivers/mmc/host/sdhci-omap.c     |   2 +-
 drivers/mmc/host/sdhci-pci-core.c |   4 +-
 drivers/mmc/host/sdhci-pci-gli.c  | 361 +++++++++++-
 drivers/mmc/host/sdhci-pxav3.c    |   4 +-
 drivers/mmc/host/sdhci-uhs2.c     | 797 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h     | 215 ++++++++
 drivers/mmc/host/sdhci-xenon.c    |   4 +-
 drivers/mmc/host/sdhci.c          | 321 +++++++++--
 drivers/mmc/host/sdhci.h          | 113 +++-
 include/linux/mmc/card.h          |   1 +
 include/linux/mmc/core.h          |   6 +
 include/linux/mmc/host.h          |  31 ++
 include/linux/mmc/uhs2.h          | 268 +++++++++
 24 files changed, 3151 insertions(+), 73 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h

-- 
2.27.0

