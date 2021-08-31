Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BAFC432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D3760FE8
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhHaLBs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhHaLBq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 07:01:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B52C061575
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:00:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2096208pjq.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2PtMzLNvGsm54bjcuOBG35lNtH0D/4aWH77HJBHj3I=;
        b=N16bam9wPdqOWWo5JdU33nWCJ9rG8kVVHmgoYBT1x5Q/ZJYmMyPUIWrBqi9WKDdyNt
         t9iEHiBeCq7j9Xrr2FREVlaG9qideTvhk4jphkLs/MiSQVRfn8P2rjRTHvnTgfWdMMGZ
         hBzRO86rsr579YdiVHxK32X6epJQiBT2CU6R1U/Kcb7YSewwurcYvwQVwhCuJaGoASRr
         hOddq8JDXeFjtXtowYqhrsHmmdwbdZRke2FVELhrLTjWhvez0xQctN1xff1L1tX90SYm
         bbW8O9x2JrTRFuMLZ5UpGxVrd1HXIIY3W8KNkK2HaUnmJmluEcIj2xEdQNN2erqn3Hqn
         11uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2PtMzLNvGsm54bjcuOBG35lNtH0D/4aWH77HJBHj3I=;
        b=Pra5GnU+n7vDExs4OuWAeD341N7e0wkH2YBkz1Gr7cBj2W3kVIWEekb8LVA8Unu8gr
         uSpz3krjpPz59xN+pdMTNECmxymdWHBOULSlStU524LFudUDYkWqVhaw8U89k9gwVqNt
         SPUwa/Uck5l9yF+oy/GnLKhDizzCIi1Fmw0AP5do4p1+vKsV6g+WGqmNGaIIZX4tfWdh
         gyzSPjktbkOlFFVrni9w59oyVeGiVd05GMP48eDp1YndJWHZ6HR2k10uLaBSlsIXQwgE
         Vd2ZfjuPiG31Hm1gCAEXKQaASUBEEKxJhxuLsZa6i+IU8aLfuAmPUcvrULJ2RjzXteud
         Fu7g==
X-Gm-Message-State: AOAM530/xtJ5UIzUo1rGclmS7s1/lhwWZNYgbvVsgEbiBjhgU23/krxa
        u05syaypXZU9MVPmtPstJ6ka+VoEpdxymw==
X-Google-Smtp-Source: ABdhPJxDbEbj2sXc+Y7fOWFcQuV/hJ46HYmnzAleGTsT88CH+HnAbCBRf6fitdIt60/dM1XIfi8WjQ==
X-Received: by 2002:a17:90a:5147:: with SMTP id k7mr4787157pjm.73.1630407647586;
        Tue, 31 Aug 2021 04:00:47 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id b7sm17271211pfl.195.2021.08.31.04.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:00:47 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: [PATCH 0/7] mmc: core: Preparations to support SD UHS-II cards
Date:   Tue, 31 Aug 2021 19:00:43 +0800
Message-Id: <20210831110043.50447-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

From: Jason Lai <jason.lai@genesyslogic.com.tw>

A series [2] that has been posted by Ulf Hansson which provided some
guidance and an overall structure. This post is the successor version of
series [2]. It is focused on UHS-II card control side to address Ulf's
intention regarding "modularising" sd_uhs2.c.

Some functions in mmc host part must be modified in order to support UHS-II
card control. Those changes are not included in this post.

Kind regards
Jason Lai

[2]
https://patchwork.kernel.org/project/linux-mmc/list/?series=438509

Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2
Jason Lai (3):
  mmc: add UHS-II related definitions in headers
  mmc: Implement content of UHS-II card initialization functions
  mmc: core: Support UHS-II card access

 drivers/mmc/core/Makefile    |    2 +-
 drivers/mmc/core/bus.c       |   38 +-
 drivers/mmc/core/core.c      |   43 +-
 drivers/mmc/core/core.h      |    1 +
 drivers/mmc/core/host.h      |    4 +
 drivers/mmc/core/regulator.c |   33 +
 drivers/mmc/core/sd_uhs2.c   | 1184 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd_uhs2.h   |   21 +
 include/linux/mmc/card.h     |    7 +
 include/linux/mmc/host.h     |   31 +
 include/linux/mmc/sd_uhs2.h  |  269 ++++++++
 11 files changed, 1613 insertions(+), 20 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100755 drivers/mmc/core/sd_uhs2.h
 create mode 100755 include/linux/mmc/sd_uhs2.h

 ------ original cover letter from Ulf's series ------
A series [1] that has been collaborative worked upon by Takahiro Akashi
(Linaro) and Ben Chuang (Genesys Logic) is targeting to add SD UHS-II
support
to the mmc subsystem.

Throughout the reviews, we realized that the changes affecting the mmc core
to
support the UHS-II interface/protocol might not be entirely straightforward
to
implement. Especially, I expressed some concerns about the code that
manages
power on/off, initialization and power management of a SD UHS-II card.

Therefore, I have posted this small series to try to help to put some of
the
foundation in the mmc core in place. Hopefully this can provide some
guidance
and an overall structure, of how I think the code could evolve.

More details are available in the commit messages and through comments in
the
code, for each path.

Kind regards
Uffe

[1]
https://lkml.org/lkml/2020/11/5/1472


Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

 drivers/mmc/core/Makefile    |   2 +-
 drivers/mmc/core/bus.c       |  38 +++--
 drivers/mmc/core/core.c      |  17 ++-
 drivers/mmc/core/core.h      |   1 +
 drivers/mmc/core/host.h      |   5 +
 drivers/mmc/core/regulator.c |  34 +++++
 drivers/mmc/core/sd_uhs2.c   | 289 +++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h     |   6 +
 include/linux/mmc/host.h     |  30 ++++
 9 files changed, 404 insertions(+), 18 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c

-- 
2.32.0

