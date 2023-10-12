Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC0CDB46E
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Oct 2023 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjJLSmS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Oct 2023 14:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLSmS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2023 14:42:18 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C1BE
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2023 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697136136; x=1728672136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MosrZeBf2s6wR0jVSKnezskd7VuMqNI6n4vQAl+objg=;
  b=dHNHcQZGNt18fBzlLuuKsBz1xe0/ehm1fLWQzdjAthXmqTcETLAbcfZk
   NL70QxYNQjSZIxwA2ge8Oi2AUOQ6VHQo6IO31iWTv5abC8OvACF1jbeCn
   TPuG4kTIp7C10OeCeH3MbRPszQ37WOIhg3LECsJDm1j4NcOf7cCcYIZvA
   tizvYf5W0WSTd/Q4dqj/t54dvV5uJGrIrGm2w7NgVXyU0eM0RkacY5nuH
   JzQ7MWwtPp1aJaIpl7cDb4GrYm7DK24RgM7aKL3k0uqT2tzLyhx5tuCrC
   B+9oIGywvUG/7pdKQACt4jChiRguVgUhQEs/ufnT6NsIPtYkRgI6zAplW
   g==;
X-CSE-ConnectionGUID: +DslIIKET/q8SK2L+VlkqA==
X-CSE-MsgGUID: NXHdAwNLQ3SBOJgIprWQSA==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351770268"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 02:42:16 +0800
IronPort-SDR: PEHU1agb2ldsw4I0w45cepvQeGo/oRSl3NKK/NizQrHm56MdNCf4K69gibjAI05ZMQtJSOdHpQ
 L/X4Mrafj/d+VrlYc7d+tv9HSaO77oTAQk4VyRWlTpukMiTHB2ITyMYrgQP8aQ3SlfFrwuM1vN
 7aB0wovPos9eYodt1WmJZRt9qHQqGkf3OhyrwTjPUPX1bWM3L+WmnpG/CxljVyx0aiJjaoBJtp
 xa/3BppX+YSWnTW+JvQyMB0BZC1QbJOL5geL35VRrf6D8r32saqZgIb5lF8OLyb7f+WE27q5Ay
 LTs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 10:54:24 -0700
IronPort-SDR: TQQX09UIm1ygRFROa0gd50rCG2XaBwn0M96k+E04RuH4vqbq3lGZKpvMTWRbO0dc2jG8DMpPY7
 Fe+e5UQorAfJa9U1hef3R+N32e90O4ARbtKSOABu9Lc4x1D/Tp6oLupUoFb/7wcsgMVdu7qPPP
 vA+IK652ENaVykEguLUEF3qNLZYAyiTvVTKcVv9ANnjTNMmkke5245p0p/6WLlJu0XrFvpghhC
 fxYTu8aco6a6Ve+WE7T0aIi9VidRHenuxTWKVsq1wq5eapWSL3g29DCMwvF00MtKAbk85TLcaI
 jYc=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Oct 2023 11:42:14 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/3] mmc: host: Disable auto-cmd12 during ffu
Date:   Thu, 12 Oct 2023 21:40:38 +0300
Message-Id: <20231012184041.1837455-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode.

Some platforms generate auto command error interrupt when it shouldn't,
e.g. auto-cmd12 while in close-ended ffu sequence.  Therefore, add a
quirk that disable auto-cmd12 while close-ended ffu is in progress.

I encounterd this issue while testing fwupd (github.com/fwupd/fwupd) on
HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.

Avri Altman (3):
  mmc: host: Quirk - Disable auto-cmd12 during ffu
  mmc: core: Mark close-ended ffu in progress
  mmc: host: sdhci-msm: Apply SDHCI_QUIRK2_FFU_ACMD12

 drivers/mmc/core/block.c     | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-msm.c |  3 ++-
 drivers/mmc/host/sdhci.c     |  8 +++++++-
 drivers/mmc/host/sdhci.h     |  2 ++
 include/linux/mmc/core.h     |  3 +++
 include/linux/mmc/mmc.h      |  1 +
 6 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.42.0

