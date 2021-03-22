Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA319C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846B26192E
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 13:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCVNhd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:37:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64814 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCVNhN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 09:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616420234; x=1647956234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+0/KhoYYOTYz7l+Fl3dgX7zNt/I6k2ipuK/IALbFNPM=;
  b=eA5jWIDTRaCqjuyearp9UAXEXKAAWMWdERG7N4gAhYGM4ZTUgqlOEiV4
   guqWCj/ORb2shlrxKjlJcFVaHb+xO9cnKi5691tGjuTEIeiPFyKeNGgs4
   QWZwVyJ1+tZlMMwu7GB+y+ROy1Z/GGwQQwpojk5FQsmXvx7ckqe3yrTO1
   pRD5SLwyJT+ZHDw/GQYyaoMIZuHgYRZpkfpzk4MAjVNERj2t6IzgjMjvO
   Q2vNQydu0AsR47TS9FOwyhz8LNmqqLxxcKewBDwQdYuBSTAtuiiPOoLYA
   aM/gLc/hZcy8hWIK4RN26+TtNNaik2B/wRUSjjxOX7SwdwKI2U+5C3zdO
   w==;
IronPort-SDR: GF7T1nDu3JPNS6K5qUPZKb9jQFwDhEgSFo5rF8ti+HsbwzQz+NZ7PF+hLcVKWZdb3zqZSz002W
 o1NoEbQr1d83feiygAEac6EYKiu2HiJj+xHJeHkECHTAk4n1k8Q/m7NdwQEC2KV54HSoTYuncT
 SMU2kpB6X+wzdUUGxw2oLEhKE7SF1zhjQYx86rbYDyE5i1+5dt07s3c+6+cs5Oe5akjIYFnT5K
 2+BO91627tX1o09UllmoR3/thP21KjreQeZOnzMDEDK2JEB+dYvuaJMAkPaZ/bQFp07kZzkWQ9
 nXI=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; 
   d="scan'208";a="163831408"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2021 21:37:14 +0800
IronPort-SDR: C1iIqvf0LM00KDhOnG9+V+8sieF+4fu8r/hSddjfzaTK62oURW6Pck7MCxzmwWIHFBYeVVrGuu
 9QL4a6lwCSTZTqIQNZYCxcz7N42taHYi3qya23u1mymz4cBX1LIjsgEoPF8Xj5hVZs+zaDjH6l
 /JrQOM3gfv3+6ubCpEBvLcsyW8UtZaWr6LkOUgb8LO5r4NPA6ApnjdGohFHdbR8y/Dh2IgKnrK
 wga586CrP18qTKURSgKAvafk+2ISKqDADI33NtcTVb1cHfD8eoB2TtUcX3N3+II2EmVJeXPeuY
 8J/DPk+MYPHSezJu2WhF1DpO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 06:17:42 -0700
IronPort-SDR: nBxFWyG2AfuOBL9julwH9yo4mifHmHDue+OIzD+XpENAEof5RSgeHtMWRKrNB/Nvj0Iuq4MVDj
 /OFmBlRxcIkL8pn80jNShvczxhVqPAVjttJKkvxUzsOBOMV2NMbnaE6E35ZFhbMvJWM+LbFxFX
 yRFOX10xZC3Xn/WBpMt2zif/Zamonn0G9G9hzcEpXX9FTGsdwqhzyFfFzqJ9MZAOjii1IX1sa0
 byiNDqUn+gNpLLWKpjnShEniqL0TuFBYWg+04bcWNUfhZpXSPgg7I2W5kU6ed377PexekPjqT1
 E4A=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Mar 2021 06:37:11 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/2] Do not flush cache when it is disabled
Date:   Mon, 22 Mar 2021 15:36:43 +0200
Message-Id: <20210322133645.4901-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Cache is a temporary storage space in an eMMC device. Volatile by
nature, the cache should in typical case reduce the access time compared
to an access to the main nonvolatile storage.

The cache function can be turned ON and OFF. Once OFF, the host is not
expected to issue a flush-cache command to the device.


Avri Altman (2):
  mmc: block: Issue flush only if allowed
  mmc: block: Update ext_csd.cache_ctrl if it was written

 drivers/mmc/core/block.c   | 11 +++++++++++
 drivers/mmc/core/mmc_ops.c |  4 +---
 drivers/mmc/core/mmc_ops.h |  5 +++++
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.25.1

