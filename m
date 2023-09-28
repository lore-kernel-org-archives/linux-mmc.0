Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11469CE7B0D
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 08:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjI1IHD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjI1IGx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 04:06:53 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EACC4
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695888383; x=1727424383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OSy2jWIH1FKLfuVo2iY+TSVFyzlzcjgVPwfIJcUsmn8=;
  b=GaqV9vsdyoNG5cmLgoO3H8fB+SNyLbRTha81KQAlsRgyKdG0A3wenhY6
   H7r15XdaVc/fh4K8/DFNop/ISndONqHvH1VwLAiS91mBpOiakzdo2L561
   5FeQNF5xYzps+j96B44qtHWPcpzZfBv62MQvwi8aK6D+eeJ++BZgi6QlG
   dapoeKHmigkPamztzBZUsZ2gzezstgC0DkIMRB3rEC+/tOPwLvU0FfX9p
   2vgBxxy0tZ4F3Z+jfSI9UjLfZgOt1VEHVRO/Fn2rZALL9ClC51FJUMNNw
   KZ6NJzZsVlBc9cZvqhKMN1Lj8DfxRK5JwAoyitDbJfX1G4cIvHcoJS+0K
   Q==;
X-CSE-ConnectionGUID: WXJjhHUlRgCIpUdqHA0Awg==
X-CSE-MsgGUID: t8He9CdQQh2oyLD7K4bpRw==
X-IronPort-AV: E=Sophos;i="6.03,183,1694707200"; 
   d="scan'208";a="357259067"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2023 16:06:23 +0800
IronPort-SDR: ddsvt3unVKtoTxV8E0YxTt7Lp+bOI5Ucm8M/CmpZKwF+nTlUL8kqTMg0m61mzFrM7IX9lHalzt
 tE001/1VXDaH84L+s0Ui5vkYKMitHq2qW4dnXkSUu+nEBmcbb4680kSBgwnSH7VfecvMHiO5+x
 63Dhnk67TGMINlDwa7kYSRFLN7PRLnV8i6LqzsiRsSYRdNousSD755vvl7SPm+0SQOq13PWvhd
 NWXZAj0VQKm6H/8ksUwt8pOKMUtgnuILSSdyLW7wzqcvn5WLxBzdiAvhpizzD5M1BcJ7GZNpsd
 KbA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 00:13:08 -0700
IronPort-SDR: RIkdldSD36W8dh2yHvIcAmoxD/PMGYO/88OsJHDM7MnC1N0R3/D4TcJptR2SffU6LkSx9sjDK3
 B7qHfmxnCQq7d/wxZsoZ+qfsb6aGrAsRj8hsgl9uRCKOH0qVsPZk4FkRSv88btiJnNxr3vlrF+
 MIgi3jDIC0ogaVn/rpzZE4cQ69wWMHFn1jdGpV6+hcMDXB0U4bmC3Vtvqa/evW0syVX1uo1M66
 oa4avu6e0vNj08L8nJewekyqXsizRkCxyDXYgp0glk1d9YBR26oYpf5ckY+zsHJuVA6ZNLwJYi
 ttw=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 01:06:22 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     wanggang26 <wanggang26@xiaomi.com>
Subject: [PATCH v2 4/4] mmc-utils: lsmmc: Fix emmc capacity calculation
Date:   Thu, 28 Sep 2023 11:04:41 +0300
Message-Id: <20230928080441.1793898-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928080441.1793898-1-avri.altman@wdc.com>
References: <20230928080441.1793898-1-avri.altman@wdc.com>
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
index c984d9a..9596722 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -1826,6 +1826,9 @@ static void print_mmc_csd_capacity(unsigned int c_size, unsigned int c_size_mult
 	int block_len = 1 << read_bl_len;
 	unsigned long long memory_capacity;
 
+	if (c_size == 0xfff)
+		return;
+
 	printf("\tC_SIZE: 0x%03x\n", c_size);
 	printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
 
-- 
2.42.0

