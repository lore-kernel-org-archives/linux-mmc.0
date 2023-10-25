Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76808C0032E
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Oct 2023 11:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJYLcW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Oct 2023 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjJYLcW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2023 07:32:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372F510A
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2023 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698233540; x=1729769540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SalXc0c05c3K5J4BUFkjXBvJb9EHMPgsAoBeFLUZJmA=;
  b=i14oAp99OSfM0xkIljGsxtnPy2DSCG6jL0H37/PDxoAIDfX5uECAMUoB
   5e+m1+XUFE0Bi/PTJ0MFm52QVbo/SKW6DnhQXqDE9TVkw89+N9iiankIT
   /kU8fLrKd178o5On1+veyL9MbKtHpWDW0l0fTwTShjlAulTJIdRFVi6H2
   UZ49gmcpTDH6OkOfzJwrz0UOYdThWehYMUF6GLPTAAZsaeoelLbKqZz7X
   K36LHkXq6wfnVAbdrhxlMaKZX1fqEpXgpduSzMTGG30E3Q1OqkZojuPnL
   iQNQ6V4x8/lpSKJa9/wxx0IKQv6LdTg/2PJtm7wnRTDoGExjCen9FHMRh
   g==;
X-CSE-ConnectionGUID: 3Qff8cg+T6uJItYoXiV5rw==
X-CSE-MsgGUID: lAO6ubZiSK2JN0Qa0E7Zew==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="558381"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2023 19:32:16 +0800
IronPort-SDR: eQsUir7EIMGNCCLuB01A5lt6VWS+2kT0Rrr52UWHb2H43Al10YB6qlFRX5UOhnPf21vPn7vzIf
 NyHpWAv3ONFj7O56NvqV2SB5RIVFU29CJ+yTMHtPgAleQPmbJ8tadha5Aq3GQnXEd1zpRjZGO7
 QINRGW6W/NspCRGvBtV9fJK3vTrjXVZJfZHUKVvvR4/o4ZqHpC7+vlCS1KCbSY/UUYftHMU0QJ
 gq2xfmEgPpOvSyRpmdHtpFh6NKJ9Ku0bqFGWMIDx798bOt2FyoXFzmvVHWYatTMGOe3yLvbIUL
 OUA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 03:38:27 -0700
IronPort-SDR: jObiwYqhHfsXYYoxEK4u7ufsS0Ucq1hP4l2klSD9P2Ka/4d30faLxEDrIrmhgPMuqZ1WqM9iAC
 yB/ySmnJSn/DF3WIJo8BtLBM3iqizHeKl7Tmz9oLU57DA6Jna4+TgZYVgdV9VnKoynF0M4KWvq
 P2LIhXJa6NYSH1Kdk5pDPByIEanCXgoqgpb9tZmlrpopX1yL1jsFNLbfR8mnPw5PkvUaqtJwh3
 fkfDGhStlx0iPl02IT0CnHO42lnyMdS4gF9iVsvLDzZN4F9sXwsuHJA6JSRjeD1/9j784rMOou
 YAw=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2023 04:32:15 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
Date:   Wed, 25 Oct 2023 14:30:33 +0300
Message-Id: <20231025113035.1881418-1-avri.altman@wdc.com>
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
e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook x2,
a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
sure it disable auto-cmd12 while close-ended ffu is in progress.

v2 -> v3:
 - fix an issue Reported-by: kernel test robot <lkp@intel.com>

v1->v2:
 - Attend Adrian's suggestions

Avri Altman (2):
  mmc: core: Mark close-ended ffu in progress
  mmc: host: msm: Disable auto-cmd12 during ffu

 drivers/mmc/core/block.c     | 34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
 include/linux/mmc/host.h     |  1 +
 include/linux/mmc/mmc.h      |  1 +
 4 files changed, 60 insertions(+)

-- 
2.42.0

