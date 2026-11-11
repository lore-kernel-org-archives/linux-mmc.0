Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398985;
	b=EhpBssnpxs++9krqDMwnj5ygmiR3MzbXzWl4Qwh9ZJggpVvwYth332z8PwnBkcJN4OQG
	 cxzH6ETWhMATHGvKuBKkdxen5vtmhcC007IOo4hpn58kRn17+z0580CItpLz0MzlqNhn0
	 Hj8h4TV/8PK2DQddBBcWTEvi7UzKU1So+/J8yuQ6GgcDxjaRVqxId3e4PP6etsltl97wt
	 DAnewuIeUDQnkhzh0xWRT3d3qMcWnrxY7FZXGlqJn548OJxs1VuRf78KyrRWy9y+2iUDk
	 wEpuJvySgfapO9E8+ayoAOyzEZsg8o7uq8DEE8tSjPU/odSN+6AMFZDz3UXcaKNgqLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398985;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=1rurHZ0wTY/YPriBMTBu68etXAQxqOR8Khf34iiOSFw=;
	b=j1eIcj2DXIseFlWQkbiQonAlNETiTOpkB2NMKnuiqZRxlZDYIgnycFQhJnVbDAScW5YE
	 2zmb3ktHGqQpT0OPsx4ak+b0PpNLi1zvck8htdoXUPIJuJXNo1mIfuLsdMKqpGSAx+WB/
	 aLzAqgQJA+5g28JIwTV30PGJTQtixx5FrdnMmvYkP7WqDPLEva5q2GTRqIXa5qct3/LOZ
	 a5vanwOqKy6AaXXcpUwnC2AprpDCypWsr+PWybAmzh+wq6WBw+LeJtVqgYU0++Nf2bqaX
	 o21Mzurs8Ng60dRJsXum7xbC1qsTAv+yjS6092d48yHVXvOmCuWidi5NpXtDVsYqA8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=XWTRJ1wb;
	arc=none smtp.remote-ip=185.136.65.227
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D15606A327
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7D15606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=XWTRJ1wb
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261111120936bb0fda0047000207ad
        for <linux-mmc@vger.kernel.org>;
        Wed, 11 Nov 2026 13:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1rurHZ0wTY/YPriBMTBu68etXAQxqOR8Khf34iiOSFw=;
 b=XWTRJ1wb0cn2erbCjGGZ13Dz2oa7tOsIi0yVTjFdvWet4i9AdEd9SDUDb0OWE3WweTVvKu
 X2BQ3wLX+TjebA61jJEUgkX2Hrkv0f+K/SlJSN/E0K6vhDMyFISkgqDRQmz/7wEwF0HlgAx8
 Mxm16yVuF9cncbxe9lwd3zRnGs3HEvQLX9ScMj2TLGDSj7yUBtsNKZRowNtBaQ9OCpQ8vvD8
 COJcf04RO0Og+k2vtfY9T1tZxu9opsCi1bh+vsJKYGAFhl8qs1I9b60xDUu/xaeW2td0Flko
 VER9nLq/bVUwuzJQghBbqvxpmRrluwqYM8OeOJVJu35/6uPTf4ompN3w==;
From: Michael Haener <michael.haener@siemens.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Michael Haener <michael.haener@siemens.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mmc: add ISSI IS22TF128G to fixed secure erase time quirk
Date: Wed, 11 Nov 2026 13:07:58 +0100
Message-Id: <20261111120759.100830-2-michael.haener@siemens.com>
In-Reply-To: <20261111120759.100830-1-michael.haener@siemens.com>
References: <20261111120759.100830-1-michael.haener@siemens.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

The ISSI IS22TF128G eMMC (CID manfid 0x9d, oemid 0x0101, name "IS128G")
reports SECURE_REMOVAL_TYPE 0x01 (overwrite, then erase) and has a large
per-command overhead for secure erase. Secure erasing a 33.5GiB
partition with blkdiscard -s on an NXP i.MX8 (sdhci-esdhc-imx, HS400ES)
is split into max_discard sized requests of about 3.5MiB, i.e. roughly
10000 secure erase commands, which takes 5-7 hours once ~27GiB of the
partition have been written.

Since the per-command overhead dominates, apply
MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME so secure erase requests are no
longer limited by max_discard. With the quirk, secure erasing the same
partition with ~27GiB written takes about 6 minutes.

Card parameters: ERASE_GROUP_DEF 0x01, HC_ERASE_GRP_SIZE 0x01 (512KiB),
ERASE_TIMEOUT_MULT 0x12, SEC_ERASE_MULT 0x64, SEC_TRIM_MULT 0x64.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/mmc/core/card.h   | 1 +
 drivers/mmc/core/quirks.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index a7c364d0030a..dc99242a0af2 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -93,6 +93,7 @@ struct mmc_fixup {
 #define CID_MANFID_SWISSBIT     0x5D
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
+#define CID_MANFID_ISSI		0x9D
 #define CID_MANFID_KINGSTON_SD	0x9F
 #define CID_MANFID_NUMONYX	0xFE
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 98cb680e3ace..be29be8ec413 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -162,6 +162,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
 
+	/*
+	 * ISSI IS22TF128G has a large per-command overhead for secure erase
+	 * once data has been written: splitting a 33GB secure erase into
+	 * max_discard sized chunks takes hours, while a single command over
+	 * the same range finishes in about 10 seconds.
+	 */
+	MMC_FIXUP("IS128G", CID_MANFID_ISSI, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
+
 	END_FIXUP
 };
 
-- 
2.56.0

