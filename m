Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FC5C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbhLCKye (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbhLCKyd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 05:54:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B8C06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 02:51:10 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q16so2613937pgq.10
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqIEpJFBu65X9hDb8NxCHPjeJJOh6BhtHH1b4rCA9RE=;
        b=oCNN57cGbmN7fBavs6z3WlhS/Pc7jj8H2Z7bDt2EvlgNACNPjE29Fv/1faGPTuOCzl
         VHmxVsjq1x5bnbMWY3GZd/WEfII1x7zaINBd/8cSyYuHriF1i7b9SkdfewNl1UtgV4we
         etaceQ4wFJ3Lz8Dm/536D+JIBDU/BlvnaoSrm0uvA4owLfcsrylKwmmgdrwVrUXMcNet
         7pTUHxGS41Axy09JPwxm9FJU7MNhP5Ttk3jC9ZQlLO1/ax5R+VmBDbn5FHS2NyDtR6mu
         90TRpnN037fYc2cPjVkuJ8hVfDra48pQsjoZJ80LKzdNao7FZJqcCs5ZtD1PxrX9TrAQ
         rhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqIEpJFBu65X9hDb8NxCHPjeJJOh6BhtHH1b4rCA9RE=;
        b=lx5pPVx8LTrm/vSHbW9j+q69/lLFWjtgriEbPyLwSJ3VlyIFYPx2HxFlEYr3QoUc3Z
         TMPiHxfc9KhvbJs5BaSZ1FyvTK7tjxWFv1AVXU9nkUUuz54RmWNvbgMygRJVUqvlfm9P
         FrXEWwIg/K0fBZqs6YN38wZBGtSvE2CQcuUE3QGpIkJc7dsc2dAiWHcqRqxoRB1G3NQc
         0DhfC7kcl0OyeAfURXw5wXCqTIqRILGRsLdqn5iy5iI8ZrVCzeFSqFfrfHdE56bhpVfj
         RRl7hXoxaRyIc4DIu1gPdoPCk1yevqMPZMr6QW64KziFstkkDEngqc/w0rV33eVPdTRQ
         qzYQ==
X-Gm-Message-State: AOAM530R9cW7ezuAu8/iM/srKKk/+gYJcDqjLZbo1syI5Q9EqKdWtgwZ
        RxE8xWNpTzl5/pok3lyjvjc=
X-Google-Smtp-Source: ABdhPJyKKyMzMX0sSU9EXj5j0V3e/1ghZfO/Fk8D89GiRgocnan4iF601kx0kcKco2cH+mAW3bER+Q==
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id j10-20020aa78d0a000000b004a282d71695mr18892951pfe.86.1638528669793;
        Fri, 03 Dec 2021 02:51:09 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x18sm2868699pfh.210.2021.12.03.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:51:09 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH 0/7] Preparations to support SD UHS-II cards
Date:   Fri,  3 Dec 2021 18:50:56 +0800
Message-Id: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

Series [1] that has been posted by Ulf Hansson which provided some guidance
and an overall structure.

Series [2] focused on UHS-II card control side to address Ulf's intention
regarding to "modularising" sd_uhs2.c.

This series is the successor version of post [2], which adopts Ulf's
comments about series [2]:
1. Remove unnecessary debug print.
2. Rephrase description about uhs2_cmd_assemble() in sd_uhs2.c
3. Place UHS-II variables in the appropriate structure.

Kind regards
Jason Lai

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=438509

[2]
https://patchwork.kernel.org/project/linux-mmc/list/?series=539737

Jason Lai (3):
  mmc: add UHS-II related definitions in headers
  mmc: Implement content of UHS-II card initialization functions
  mmc: core: Support UHS-II card access

Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

 drivers/mmc/core/Makefile    |    2 +-
 drivers/mmc/core/bus.c       |   38 +-
 drivers/mmc/core/core.c      |   43 +-
 drivers/mmc/core/core.h      |    1 +
 drivers/mmc/core/host.h      |    4 +
 drivers/mmc/core/regulator.c |   34 ++
 drivers/mmc/core/sd_uhs2.c   | 1081 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd_uhs2.h   |   18 +
 include/linux/mmc/card.h     |   35 ++
 include/linux/mmc/core.h     |    4 +-
 include/linux/mmc/host.h     |   52 ++
 include/linux/mmc/sd_uhs2.h  |  196 ++++++
 12 files changed, 1485 insertions(+), 23 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100644 drivers/mmc/core/sd_uhs2.h
 create mode 100644 include/linux/mmc/sd_uhs2.h


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
2.34.0

