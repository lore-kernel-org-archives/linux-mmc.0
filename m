Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795604486;
	b=LYI0fuX7g6n1NIfjbUYNUtMxQp9ZhyE2bWDCRd/cZUN7jLL0bdh3vTKqP5IzGWuKJjEo
	 MngS9YF9ZrbeX14bWbgR3b68Ovg3GCsZwC/fNxTE4r71XTTC2HWyJXXmF+K8yXTf/prSx
	 aYpE7e9c4JYgRCyy3jA02j5RbuKz65Nbsyq7WNpmGPK2fow8a6miAapfqCHyAR/A73ARP
	 t3J0kUtdAVJmejAPecdfLbUsEHOETYC0Ad2qk1HmRlX28XgZlsmMe8JFZ9m1fOugGgcPe
	 wK0l16YByO4olxUeZm+1nVEqLUKbUYTy+oD+IQzG8L4t1rERQRw2w4NBpBAK0GnvoPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604486;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BnojbAnwkAMpvBOuXktJMYzQNZ/XwP1NQR+jy20tyNA=;
	b=TFYeT8c9geAt5KOAktpnKA4noI3eyJy8nWnSed4Bm/60/MCUDR7kdB1nZyNI1buAzJUE
	 HMVuW85YFAt7EVtjvieEJiTMKTDvRfi/BIVUfoiL/Nh2qgJOgdjIaJJ2z662EbhwI5FZt
	 qJ0tI9PSFq7yjD4wmvTixFFXBb9iES0dHKZ7pcwmCh7wVgectTk8WHjZiR7IqjMgCg1C9
	 ViOAZ7RIJG8C+pijVpEKGk3DVQLV2ZAld5ClS25vMbpg7x0oHrK9m2tdVQRP3pN7GPM+Q
	 nnmtMDX8TkFybrYkf74FiRLBiWrsw6sGY1dLZiVSJ/5kmf1JU8izVIHPG4nar73P7EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=LZYziQ3h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.7
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010007.outbound.protection.outlook.com [52.101.229.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EA606A31E;
	Wed, 25 Nov 2026 11:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B28EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=LZYziQ3h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKzNWZ+vA0me4ctSUT8FbEibjJ3kthmYjfrFbzBeQ9WdoQ6P257aDrTTfOhsCxX0J+hQDHuaM1ALnXFv2is/nATYxNMIQPguyKh29ustwVBkXyVGnjsW5725y3N92eitMDYWlcbODWYeW9Rhzhx7F/y/gtJj5icnKoD9ESSGovhcnYNioNSiDLCIzf8WTWoevtmeexnDDn5NwlDPmNlowP5/iW13PIIZ1dbksXF/v3uTfjBwFt9ybIhMJGx+bW7qJB348RmGjv1AfNnVUeFGMK/RokarCwPzdbweTW493e1W1DN+bctL+N1u/yaZJ1mKETVLjFPtAezOGxmKjYH+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnojbAnwkAMpvBOuXktJMYzQNZ/XwP1NQR+jy20tyNA=;
 b=k5D9bRoBVCGsoVSOvrLxj2FXKTN4R6pZGMJQkbfPwYSthNE2DEuJVCsMFoSJ9umuEu6iUAa27G9aoypzilW+BXlf74cTVDvBSfn0C4ieMW5qvuIFihoALBAAbghTtdDxJu8MS5lBwGmLwgU1EulYkeesThrTxHjXLWaEVm8jZg6QMbz4DifZkKb33KxxI1vHhoWpSdPufnaRtG+DwJ8520OStr/RJgdWNoC7cZ4vazhQ9coOMtWBNt2CAMo4ZzF3xhpSPMXLS1mNFCbV95a+lsXhsqaZS3zZBWRLsk++Gl374Au9PoWL5KaKxI6Rbe7lWOyEqMRUZD/dXjEwlPSrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnojbAnwkAMpvBOuXktJMYzQNZ/XwP1NQR+jy20tyNA=;
 b=LZYziQ3h+fWipzJHcE+PfglX1qUmNZlxn9S3v5w0em3lKgdgNKpaiN5v5NGlgNwb6RHzepeXbPwy7CAOtG7evNmQwwnj3PWPkqabIWGJZFkI/JPbORmqTe/fF5F6BCNsXfshM5DADxtJTBrvAHQ03LrAinrcl6dt7XNsgmHxbV0=
Received: from TYZPR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:400:361::19) by TYRPR01MB13071.jpnprd01.prod.outlook.com
 (2603:1096:405:1ce::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 11:01:19 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:361:cafe::71) by TYZPR01CA0006.outlook.office365.com
 (2603:1096:400:361::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 11:01:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 11:01:19 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.37])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D3F763000271;
	Wed, 25 Nov 2026 20:01:16 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulfh@kernel.org,
	ai.kyuse.uw@renesas.com,
	horms+renesas@verge.net.au,
	yoshihiro.shimoda.uh@renesas.com
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH] mmc: tmio: Scale the request timeout with size
Date: Wed, 25 Nov 2026 11:00:49 +0000
Message-ID: <20261125110049.3640-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYRPR01MB13071:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40e4366b-98c0-45aa-3349-08df4ae36f4f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|261009223027099003|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	uslgBZONmR3DeyXBaQVV45MeVyZnsnP8jVsnvqAw1JnJQzQbW58P/zFVQeVyduUh4+N+iFUhr1l0E4EH/5TRTi+OvySmpFvpvmA7GM1DwvueI7W8f4pxd1EYosimr7ydsRuNOcFVFlt/yY8PZ6f1OEoAHJaHxbf3Td4iYLeDNqnPx4QT8uHD+SEF3SnZWg3WpM6zM1+nyRraQ2JjURr2qFFR3kuTIRGdj1PBAarWHJwwMhGa3mA/zMm8Dw30CsDaVJKwLmhYI6hm1ipAI4KaCMeES1jKYarE50oLL8A+//Dx4mRguQoMAV5VOT5HG4Y2Ryc3RLUJQ33gsg+IsInXbslQ6iBbC31UWB5KM4MDk5QNldX9zixrLB+nTnf/gD/u5/ufY1+up81jP72ix/gVX4Od/Q49aQ5y/3fYpSqiw+u4c2oMd/N1WxqvDiF/izqk0aw2cp80TMdP1BaQXEr2x2nbnFeBucQebGPvpLLRJ/AFGuyC5Cywx9Bfbg8dRqJoO35LTcIBkRv5j3RAThT5LmNYwkS4ZLR4zq8+COjf2kLmB9xIEH5Dnk9MvTenT6FNGPdF12rCr3utA0wP1x18H7dETSQhXiwXPX1cWAMk/SBwc8IkkCdMbNrDs8EEJCYnvS61WgkYvfSApCr023Ix8ECngWD2vMjJvmIfcjurZDfi7N5QGUdpFixgJPN9GDnYLTDSdowYHhFjqnQNTBUvaw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(261009223027099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	znHhMHUC9d4sA3AOAJLxoyJbNuCty/rrOwabRr0z5UQglawURpxPG+P3Ip7Mhq5yj1hgj5C0BJ+pTuQbYBPeDqjtJ9T7hae51q7/EyFU43eU+191NCgBn1B/VAjCubYhsDMG4S3oIPCzWQGw/S7J2X57OFvN4O/CMkXsFTLtTfq9d6jjM8vRQYjMvq4baWk3l2Cw1rrbpirfUA9YxKIifabcN2g6Hgz2CkwZG5KfVOsp9+ByxJ4lNpXbN8c3soHcXAX1MHnT4CO2m+13jbtfzYpe8e/ZT+/AVoq1WMuv2S7K4qNmf5gwrfJdENFJervpXPFzkHXaSjObs3YoHdzP1wmi1q8I2SLiRG/nbJlexGa52PM6hFUn2kSnCrmfLoAz9eNA7R+Zh+a0MKsQ/9GZQYEwk7GOx9RNSKD7AwVSpUReDDqJZ4mzefXTM9ZfpokB
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:01:19.4892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4366b-98c0-45aa-3349-08df4ae36f4f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13071

Currently, the driver aborts every request that has not completed within
5 seconds. However, the host accepts requests of almost 4 GiB, so big
requests can take longer than that.

For example, on RZ/V2N, a 512 MiB write to an SD card, issued with io_uring
(and no swiotlb bouncing) takes more than 5 seconds and is aborted:

  renesas_sdhi_internal_dmac 15c10000.mmc: timeout waiting for hardware interrupt (CMD25)

Also, on RZ/G2L family and RZ/G3S boards, 16 MiB writes to the on-board
eMMC (Micron G1M15M) may sometimes take up to 6 seconds and are aborted
too. According to the eMMC CSD values in the datasheet, writing one block
might take up to 6.4 seconds, so the transfer is within the spec.

This timeout was added in commit 6ff56e0d8e02 ("mmc: tmio_mmc: handle
missing HW interrupts") to catch lost interrupts and it was raised once
already, from 2 s to 5 s, in commit 0df9d2eae5e1 ("mmc: tmio: Fix timeout
value for command request"), but no fixed value can fit all request sizes.

To fix this, grow the timeout with the amount of data instead, by 1 ms
per KiB. That corresponds to a minimum rate of about 1 MiB/s.

Fixes: 2a68ea7896e3 ("mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index d016306956f9..7b373a9d63d9 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -134,6 +134,16 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
 
 #define CMDREQ_TIMEOUT	5000
 
+static unsigned long tmio_mmc_req_timeout(struct mmc_request *mrq)
+{
+	unsigned int ms = CMDREQ_TIMEOUT;
+
+	if (mrq->data)
+		ms += mrq->data->blocks * mrq->data->blksz / SZ_1K;
+
+	return msecs_to_jiffies(ms);
+}
+
 static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -252,7 +262,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	 */
 	if (IS_ERR_OR_NULL(mrq) ||
 	    time_is_after_jiffies(host->last_req_ts +
-				  msecs_to_jiffies(CMDREQ_TIMEOUT))) {
+				  tmio_mmc_req_timeout(mrq))) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
@@ -827,7 +837,7 @@ static void tmio_process_mrq(struct tmio_mmc_host *host,
 		goto fail;
 
 	schedule_delayed_work(&host->delayed_reset_work,
-			      msecs_to_jiffies(CMDREQ_TIMEOUT));
+			      tmio_mmc_req_timeout(mrq));
 	return;
 
 fail:
-- 
2.34.1

