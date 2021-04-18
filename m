Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADEC433ED
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Apr 2021 06:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A5761207
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Apr 2021 06:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhDRGAo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Apr 2021 02:00:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45200 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhDRGAn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Apr 2021 02:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618725632; x=1650261632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nU6S7B5lK8WSZMSaIf7imhanpSisxP9GOuPk61T7k6Q=;
  b=Vt4XnxyBRTg9ifeViEDprBz0ywGJMwt6UkxL6KWUHq4+AhNXtLf+Ynvy
   iQFy5/zX0ucaiqIOX7dpDUrlAHhkd/uRcSnQp7r8Jat7EoJrrfUda5mHs
   lHZHm20B0zVTEB3QjBiCN1cCebCcUrgF43DWqq5guVZx5/RvIsoMVpvXw
   xYmxxctEdk8Aqr6J0CeQF9SM6NihUbeSq8NDozsw7k1wHnJyK1W7iZguw
   y3q7XSt03DmyI2uT4Jb1jqsvV/Jma0R4kyxuwt0ViqMP/7JZSzXi4qipw
   qYi3xdKFVmkq2etXY4EkPmYXl/Si+zfGubsNNsFi6QoveCFLOnyUq5nWJ
   A==;
IronPort-SDR: j8PJXMbCaVuX/bZeAIsGIIbcd2K/Vu40IWpnLwa4Qnz3ZIauFCaTy3QHXlUD/dhDOK5LttunrY
 3vViGir9qpnGu+gLKTHF8up19aoP+L9thWJcuvK1MM+KWnBiQu1jN7amKkkq2O28QTcZz64/tn
 i93NEj9x53m2vZNxFeipw6jpuTiZTRajayy4EcGDeNAL9ICRkw2y1lD6bHrj7s3dkqKJ9fL0RR
 qvmPMdJWRBUHs91C5DtVL9i4q7DCEOTdSkJs51Kkc8O6FNrffRXQwptxMuBZNACegoMlrFrm9X
 +bo=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="269256773"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 14:00:29 +0800
IronPort-SDR: tOMb+GqDhk4qAO4nRXsFtxDDQzhrLeeJIVd9ri/UDwL8oxsyF2EXmoLgvJfSbnrnIQVbBCGvVJ
 f9uOktIwqBDUTphIGNKKYvFENb0X6EHMOhapTHFtsKkF6F98pIFRup0p5mfCbR8kXS4uQZKwE1
 VqdJ87Zgn+Dg80JbSI92KIvf923JaCFyakMqAWohvszVXmrLC6xSxb952e7OQiMkxrdV47IVv6
 ZVdI7oJyg1C2pzh1/2cWsdn+4hR4xkKGi3jkdi2vf2MALcLbLFHtYFfHvPTwJ5rQSabFJPpwjs
 b9qIG/4T3lKzCR7F5Gos6y8C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 22:41:00 -0700
IronPort-SDR: HhzCEtSnfREDOPwZtFhIBHDhFZGX71isTnP7ckz9wI1TrNNVjp3vRRgN1JJx3JSeuwxvf4gmTo
 Ag89GyD8EBUXXgXo4g56ct9su/jjk0xvoFOkrSRMOwHAaajQ4eajKUwcswPrkWq/gQIT3o5tMg
 Y1L0iSYcukh1jEicLI5XyrxHDAO6WCO15SXh2XUgR1E63qFCktKRtvRvumrg0h8/KA6yFDsykW
 nCoGuGbjWcorgXwMnSObCVSrqAw6fFQjO4X6sDisnjNiN6pRSgqN2QEBGxxJ8vcaA/m1zh9dBU
 NSk=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Apr 2021 23:00:13 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/2] Do not flush cache when it is disabled
Date:   Sun, 18 Apr 2021 08:59:51 +0300
Message-Id: <20210418055953.26959-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

v1 -> v2:
 - Attend Adrian's comments

Cache is a temporary storage space in an eMMC device. Volatile by
nature, the cache should in typical case reduce the access time compared
to an access to the main nonvolatile storage.

The cache function can be turned ON and OFF. Once OFF, the host is not
expected to issue a flush-cache command to the device.

Avri Altman (2):
  mmc: block: Issue flush only if allowed
  mmc: block: Update ext_csd.cache_ctrl if it was written

 drivers/mmc/core/block.c   | 19 +++++++++++++++++++
 drivers/mmc/core/mmc_ops.c |  4 +---
 drivers/mmc/core/mmc_ops.h |  5 +++++
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.25.1

