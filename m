Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7311C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 06:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9A420870
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 06:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgEZG32 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 02:29:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:47652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEZG31 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 02:29:27 -0400
IronPort-SDR: Pu2KDcu5ZZkZXjFMj2/momiZD4zZ4ZhcMOIPjE0vo1/WwkGky9x7xv+nkfUTPYkHaevt6nMf8U
 47Wb3tu/MoGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:29:27 -0700
IronPort-SDR: kzO2sf3rdj+1rN1KtOAXe+G7AnuFW1F011oMntagOE9AwBiI6uFM0wr2TUe0apRoTWjxtijmd1
 iU15v4I9o5MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="255301176"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2020 23:29:24 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 0/3] mmc: sdhci-of-arasan: Add support for Intel Keem Bay
Date:   Tue, 26 May 2020 14:27:55 +0800
Message-Id: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi.

The first part is to document the new compatible string required
for eMMC, SD and SDIO support in Intel Keem Bay.

The second part is to add the changes required to support the Host
Controller and its integrated eMMC PHY. The significant change is
to disable 64-bit support.

The patch was tested with Keem Bay evaluation module board.

Thank you.

Best regards,
Zainie

Changes since v1:
- Add patch to convert arasan,sdhci.txt to yaml format.


Wan Ahmad Zainie (3):
  dt-bindings: mmc: arasan: Add compatible strings for Intel Keem Bay
  mmc: sdhci-of-arasan: Add support for Intel Keem Bay
  dt-bindings: mmc: convert arasan sdhci bindings to yaml

 .../devicetree/bindings/mmc/arasan,sdhci.txt  | 150 ---------
 .../devicetree/bindings/mmc/arasan,sdhci.yaml | 293 ++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c            | 123 ++++++++
 3 files changed, 416 insertions(+), 150 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml

-- 
2.17.1

