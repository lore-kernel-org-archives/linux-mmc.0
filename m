Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F1DCE7B09
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 08:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjI1IG7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1IGr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 04:06:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797D2691
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695888362; x=1727424362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4vrNvPsor6W5j3vWLM9VYVa49YrhHPxgzNFDaI+GY2w=;
  b=dacpHtV31g/hyov9zb5M58sKvNjblUUbT78qlSurYtZ9648hxcZ/uLgQ
   JWmphDAmg3Kdasjp7I+lseea01XC+UxItyDQmuCLLlQuDJTUmdg7tfrdi
   oHmXL78geC++h7XWx7jc4nUpS8PW2ZdOCt5dorhhAQ6OxbYF6TrHsX2Fk
   brBEiIFqb4q7jWBrIGG+H0K1lgWKAFzkSIRlBUyy0R9kd0pLsevDZEz13
   jfDWc1PDEY7r6Hbe7FqIAgVlTE8uT7os8CsgkINmxIW6bdKjDlWdwNi8Y
   3mEGvJZ3McVkKceGyXY/YtmQ5Rt4Ngb9NjCShY+hKeJJdvkaKGahABqZJ
   g==;
X-CSE-ConnectionGUID: 2PwAa1VSSW6ntHfdcG7Glg==
X-CSE-MsgGUID: gvZzaV3LTf+dlrYwYGlbQg==
X-IronPort-AV: E=Sophos;i="6.03,183,1694707200"; 
   d="scan'208";a="357259027"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2023 16:06:01 +0800
IronPort-SDR: RE5hDqgEfJJTcnWHeEyD80cHNx4kvpZNlN5A9GH6pAViJ5w5dcAARf5xc9df0BNoZBdBLrfJBZ
 70O8baMgD8eeG9/VjDGvDwZvWU85MS42W8nFgctDIpmSBq8v77YcRH24dgrpNBvdq5o08K3Wbk
 9uHxK3ToqkmDlTwv7mTyLAFoVHIWEqh6JzbwbskGT2H6KlIQVdIc/KgaZ/jNt5wEULEVR/8b3T
 V3iantoFhdGRRVpLhtdNZ4o9CwMCfGkVEkQIl8+BTUJQUoq1r6MwUb36APNG/D64WCEsxCNa0E
 ZMo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 00:18:28 -0700
IronPort-SDR: oCgp3c13VUJ06fLQszFCPpzVc3UXjdnCxzEBzrgVju0OoZF8SWIuUW9z6TdWI6w9vFjT3J8+9J
 lv9WkMKTrVuhAiQSBdhjGN1ErpOk/Yiw9Vj8Pq0M3bbxkCO8yDiQSb9T1PzqxF7Jo/ipInJa60
 c10zkm6l9RRw7RtYNU8oM/AtamJVKMNJZJlUS8mIhSmVSMDerisRR+5qVsE3XCRsfoWdklRbY2
 BcQIQ91Wioyfr++xP+/dD1FuyMbndc39oE2GrJSt1fRGkLC+BpeFS8BEpW1Tk5T0d7v9BnSIKr
 BY0=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 01:06:00 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/4] mmc-utils: Revamp CSD register parsing
Date:   Thu, 28 Sep 2023 11:04:37 +0300
Message-Id: <20230928080441.1793898-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dust-up this old code that practically left untouched since lsmmc got
merged into mmc-utils.

The first 3 patches are mostly cleanups, where the 4th is fixing a
capacity calculation bug.

v2:
 - remove the first patch from the original series (got accepted)
 - Fix an ARM64 compilation warning
 
 
Avri Altman (3):
  mmc-utils: lsmmc: Simplify prinitng manufacturer name
  mmc-utils: lsmmc: Simplify interface processing functions
  mmc-utils: lsmmc: Disintegrade print_mmc_csd

wanggang26 (1):
  mmc-utils: lsmmc: Fix emmc capacity calculation

 lsmmc.c | 1548 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 719 insertions(+), 829 deletions(-)

-- 
2.42.0

