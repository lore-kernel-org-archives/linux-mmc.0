Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85236227E90
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014816; cv=none; b=vE6ynBCwJdnROhyObYxA6dad8AuDTxQ5/0JmsCqswkKm51mslQC22H7dsLJSdHR8izznqZhAbZ1q4YMNwEs4tlB5NtGdYq64C4PYJS36pIMm2zqB+815dYscZmvWDCzIPswEgX0AIycrY0D+lhEPpQ+OqKVez37jflS//It2RI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014816; c=relaxed/simple;
	bh=D7XtQdgkouIkZDvZ5yZU3b1HyN1qkvJVJXoSEnWXIHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLg6Xujq38tcpM5pDR6wHiZL3cparHsXyaLZ76N17fAe8ghCrKkVQLJUOTqh7KiHA5LZQ4y8vpXnlBHmguHNRPz/4SfNSGau/w27Lrt0P3+mJmRNYqZXR8W5f/wgKFE9pAThASMYHEEJa3oBtjAb1FJKk0PJImCI2kVcV4w4JYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=u5q+1i7d; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="u5q+1i7d"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014814; x=1775550814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D7XtQdgkouIkZDvZ5yZU3b1HyN1qkvJVJXoSEnWXIHU=;
  b=u5q+1i7d9UJ5675SA0f0vUtDJFWlc+pxKl9LufLgA5a0tsB3EYna8nvw
   PgT4yA4TaT+Z7CYob1kcGlPQLRlqqfzHB24ZnXbFy0vT1lB4pU5RUPweE
   QpucD8P5/i2tU6tqmtLf3NuSk4GbzJ387MFAk5uXUOhohCVbNv87dYmi0
   A0TDStQJtVTknniM008oiNDYU10APQ2JaTyCxeC0IRI1CiSOFwRXQg/D3
   7oQML/1RKJt2DIo+VQ3wqXTDacg3xnmPup2VXkedwh+Qy1weg6mXdttw4
   APzVKXu+nsAK8x3BcIUvV6Q92DVfnLQQxSNsd2mUow6ZgEuHZh+kBaBnV
   Q==;
X-CSE-ConnectionGUID: DvvjvgMUTqGZFBidVWoF7w==
X-CSE-MsgGUID: fowW1Qb9R/2U0fKf+AFxoQ==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="78092848"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:31 +0800
IronPort-SDR: 67f37fdc_4me/iv/NnejORui2lqI5UAEEeW6XAum6VOjqFfxLU5gRGp2
 +PjmX8yjqwtl4mNHqTxHc1DLRxqoQDPXPAyf11g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:33:49 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:30 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 04/10] mmc-utils: Add byte offset comments to rpmb_frame structure
Date: Mon,  7 Apr 2025 11:28:27 +0300
Message-Id: <20250407082833.108616-5-avri.altman@sandisk.com>
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

Added comments to the `rpmb_frame` structure to document the byte
offsets of each field within the 512-byte packed frame. The
specification defines the frame format in terms of byte offsets, and
these comments make it easier to align the code with the spec and
improve readability.

No functional changes were made.

Signed-off-by: Avri Altman <avri.altman@sandisk.com>
---
 mmc_cmds.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index d53ed9c..7e3ac7e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2101,15 +2101,15 @@ enum rpmb_op_type {
 };
 
 struct rpmb_frame {
-	u_int8_t  stuff[196];
-	u_int8_t  key_mac[32];
-	u_int8_t  data[256];
-	u_int8_t  nonce[16];
-	u_int32_t write_counter;
-	u_int16_t addr;
-	u_int16_t block_count;
-	u_int16_t result;
-	u_int16_t req_resp;
+	u_int8_t  stuff[196];           /* Bytes 511 - 316 */
+	u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
+	u_int8_t  data[256];            /* Bytes 283 - 28 */
+	u_int8_t  nonce[16];            /* Bytes 27 - 12 */
+	u_int32_t write_counter;        /* Bytes 11 - 8 */
+	u_int16_t addr;                 /* Bytes 7 - 6 */
+	u_int16_t block_count;          /* Bytes 5 - 4 */
+	u_int16_t result;               /* Bytes 3 - 2 */
+	u_int16_t req_resp;             /* Bytes 1 - 0 */
 } __attribute__((packed));
 
 static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
-- 
2.25.1

