Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA919F40A
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014814; cv=none; b=f+67zAcDo0wtBGiCwSypCxh22tstLdb55zewgqENtGh2gWX3uu2VUjFYjO2PYOvjsxU8NnH6T9Fl+fZcFUbZIskuI7Zjm1w2lJCjqOnRDkBG6jt+/NMbhQiKiTxbZLRm0z2Vxl5TpMIekROLuiR7g3LcB2/Uzw0NmhYqOeE2V74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014814; c=relaxed/simple;
	bh=zmbYH3FSYYP34X0/tALY3dNlbNTmcVhEUoz9fwdIV8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uH+/X53unrlIlMloibz/exNmP/GzKCaGGDLLMLMOVbTncrP04tn+TiRuHZ/6/nmXAHJw8USwtGT4tfnc+OyXQh+skW/w+PUDIvDBv2n4n5Q3qZfvyGI0wu3RudDIt+0n+IIz4XVT9ApbjP0KMfQ6MH2SU75nAAL2Pp4Vt0u/sqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=YQ+84A0V; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="YQ+84A0V"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014812; x=1775550812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmbYH3FSYYP34X0/tALY3dNlbNTmcVhEUoz9fwdIV8o=;
  b=YQ+84A0VXtc8/pxQwolR5mfxv5qppsY2+mYvVbBQAVpnM6L/a8m+cyLD
   vuNA1mvNQu9Dw8WVnfQfTtyfK9M+JRPeblSi7KCDp3Z4CJOPkenzQm2SC
   NVfYDS9fD548CJ/G0s/LB2MzZ6ZxAVJ+JMq8LkW3YJZ499eKm+7mQyzBX
   Vh7oxPAVNFDVQhf9Lq4PEwwWJm5E5Z/xw5+zBdMgV/kwrkzcH3u/m1Epl
   SKWCdhrV+Gqp97V+RvP8SD5Q4bW9f4ts2tZKPyARb55b+P4Eo0VuHSrkz
   ZIT/CvkQkiauBeRzeWWOsa0MjLpql7La4EoovMJhSeTCKWkSP0F+65ZBf
   w==;
X-CSE-ConnectionGUID: hZT+1bdBTr6+jeuu3ptOiA==
X-CSE-MsgGUID: ZxnVlSrRTTGO5jHzCJyLmA==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="78092734"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:25 +0800
IronPort-SDR: 67f37fd6_wsS+Ldj15qucrHzzWRFp2KIjlGwCOfdLMcAWNimIhcZo4/i
 Lo+ocxtTP4lNndNT+t0azlgkyQb+ha98exS+SmQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:33:43 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:24 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 03/10] mmc-utils: Pack rpmb_frame structure to avoid padding bytes
Date: Mon,  7 Apr 2025 11:28:26 +0300
Message-Id: <20250407082833.108616-4-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407082833.108616-1-avri.altman@sandisk.com>
References: <20250407082833.108616-1-avri.altman@sandisk.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@wdc.com>

This patch adds the __attribute__((packed)) attribute to the rpmb_frame
structure to ensure that it is packed without any padding bytes. This
guarantees that each field in the structure corresponds exactly to the
specified offsets, which is crucial for correct data interpretation and
communication with hardware.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 125816d..d53ed9c 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2110,7 +2110,7 @@ struct rpmb_frame {
 	u_int16_t block_count;
 	u_int16_t result;
 	u_int16_t req_resp;
-};
+} __attribute__((packed));
 
 static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
 				  int write_flag, unsigned int blocks,
-- 
2.25.1

