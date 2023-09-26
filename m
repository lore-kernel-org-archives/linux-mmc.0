Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDFE7D271
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 10:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjIZKC7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjIZKC6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 06:02:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77383136
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695722570; x=1727258570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcqSpfHBQ0Qsu49muu5nz5nVW+RjSHg1/kEmKm33Pp4=;
  b=IYXlentoB8v6wmCVee7py7ixSVcC78t+fJ4QLh8vucyg4Nd81mK1/Zq1
   A7Q6xXdr77BZDf5xCe2fVKC5A9GfB39Ez5W+aUTiATMnarfKPsabcGqr0
   fEz2UyddT640yBBJ3xgATdhuCdsFmIt6F2RzTo1iq8kSI5TgfAVc9gL+W
   h6IEFjO9vKVghCj+VBeUTWwdIDgPTYS9X3qnhIS/5VW2bERipaiZSDAqp
   5aCJH4d3c3n66s1/GnS+zt3AHMosuKavxladYn6jpOXwEUBq03XuEX7c0
   eUTqQEatA/+EMGVE8AHvOfYdXHDT1NuIwR+DJr3LqLK1I3zHr/6p7Rq57
   Q==;
X-CSE-ConnectionGUID: jRCzUENaSuSyaWHBNp2ORQ==
X-CSE-MsgGUID: MNpx8SXbSF+D7sUZrjT+UA==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="249466771"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 18:02:50 +0800
IronPort-SDR: HrmON6gdSQ9L91UQ8DtvTlVqWR+DLcUsGJ/FdXUEgGomuJJOIXK2ZJ9bSHL7I+WTnJnxIAsNJq
 js3mc8DJrpXctnLvnc/V/U/bXVmOqGQuYDKYui6pq1lbdlEKtJOqtL17ldvojGlfzj+mN98/Mm
 phn7n0yEw3yScaDa+Hz78tSpjGEFswOul4uvp8rMHxUQ//ZIg2HWnqpA3c+E28nj/hn4shvQy/
 iWev6Z9ThtkK83giML6wDJfyOvm4duAU1q1ALDAlpkXBm7Cj6gcTndi4hs7IXln33Od5plDIUj
 ink=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 02:15:18 -0700
IronPort-SDR: sS5y1I1dHMh9QTLnOtWk0jizWeLPWwlyehT1mzdzcMAGaJXP9i5ERpTY9iW2p8N5wgAc2dMH9H
 Dz2oKh31bKWqJEO0SCz+83KZLChFOc79Q0e7uM2e5zF13SOrPfms0MgnFErXE6RZ4CmWpmytCK
 1IjAxtmRYw7k8UVc6o1EUiV2DFZMCid7YOK+FV3nf2ElxDjlIZAOY21AnfPyZD6PhRDObqjarw
 kjOjb7BDw2AGh72YKJaJgoR9JqEzBaPymnICUgOf26j/pm3c4cxFFX06BblkeX0TQmUo3iWu+F
 xgA=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2023 03:02:49 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     wanggang26 <wanggang26@xiaomi.com>
Subject: [PATCH 5/5] mmc-utils: lsmmc: Fix emmc capacity calculation
Date:   Tue, 26 Sep 2023 13:00:06 +0300
Message-Id: <20230926100006.1789276-6-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926100006.1789276-1-avri.altman@wdc.com>
References: <20230926100006.1789276-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: wanggang26 <wanggang26@xiaomi.com>

When the device capacity is larger than 2GB, it shouldn't use c_size but
instead it follows a different calculation using the SEC_COUNT field of
the ext-csd[215:212] - see eMMC spec JESD84-B51 paragraph 7.3.12.

This bug was already in lsmmc when it got merged into mmc-utils, hence
the fixes tag.

Fixes: 4af1749d2350 (mmc-utils: Merge the lsmmc tool into mmc-utils)
Signed-off-by: wanggang26 <wanggang26@xiaomi.com>
---
 lsmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lsmmc.c b/lsmmc.c
index ef8fab1..b7d1c58 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -1819,6 +1819,9 @@ static void print_mmc_csd_capacity(unsigned int c_size, unsigned int c_size_mult
 	int block_len = 1 << read_bl_len;
 	unsigned long long memory_capacity;
 
+	if (c_size == 0xfff)
+		return;
+
 	printf("\tC_SIZE: 0x%03x\n", c_size);
 	printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
 
-- 
2.42.0

