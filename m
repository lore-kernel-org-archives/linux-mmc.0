Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D9349CFC;
	Fri,  9 Oct 2026 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512108; cv=fail; b=SOnW6wjS0j4F73is0Zfne6MzPhZVR8XzrlJRjjyTVBnGoNIxJXxQkg7MUWtC/1ev1eTSVzTns102+z+9tBMbltyOxheuUqKbTXqmgLP4n/RwnRh6wB3ZDw6mrCEWz56/XQJOWaS1IbvysYDEl3jmbmIKSCDVFFcqZczgwf04eHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512108; c=relaxed/simple;
	bh=BtFQ2drXP1+MfHNlVUFJGzBH+FGLZGkZ7+ODBNldIgI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFCti4ozDsSda+rki1QZXhks5Hm1WxOg1GhEv7nVWFxsxuDMRqHASU2UIQThI7qJcniYUvmycjkZAHlxDJAiONa2neqGfA+NFBe8dDTv3+FZA1fYljTLEDTs84DM63CO4hF7ZRCK2oG85g0Hv5xEaDvR+xINTIBZGsG5WIeJd8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=O8eDmQBz; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="O8eDmQBz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pzy+OyERQG0nHfrd2iC8raRtAvahQ2YiCyk6DHsfwX7xbbErNLsAKgkcJSfodnxZouuBQgjDuHeuHaF0LwKKTD2qNzkxShE6fyShL8MTzmCVfGtCdwnuEnIptjeD5grYkIRvUwridMZA+veaVRCjDPgWqCkIYPqVwEbaTFzw6QUpAPMt45a1i3sAuwnVhaZWyCJFg+VaXXj1UPogvs1IJlzXIN8gRzwbJoTvkoQix0lSvzppZFshi7f9CQIrnGwx8ZiJQilW540xWqLiv/H7rF6DstdXsrSW1YjRp6zNxurFL2IzrZIRabkwlbIFSZ8ySIoaM1RHYkqu8kc5VdaSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlojmjBlEdXjJxJfYr8Xq6AGDMclnIiVd6oJtadds+U=;
 b=uY3KjaK8btqbsydnQHtQjQyUkk0d2YAuLFaBz7ooKhvLtA47Yt3Wz63zP0Rh8f8S8nQpc6ldj1yU8+rxmV0lG6YRdVOotemki+3mLMgxdwO+SIPxGhHZX1A+96S/c1oY9IxPiKN3Bc/Xtf+gu406W5IWScmq4WGuDE4PLAdGo4JffpQG5vVHHMPmmOtQIZXCXkTYtXZcTfDsuTCxyKPVaSLq5vNWUAzB5rgulbtRGEuxX8p2mOkDb62+n7aYsEZ6JRypKV7F2uKanc4s+bHZMfMhEGzJThb6GK11SIrgm37/OVSW/oBkG8v6LoG1/Bq/fRca2niTl4PSGliAgJp70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlojmjBlEdXjJxJfYr8Xq6AGDMclnIiVd6oJtadds+U=;
 b=O8eDmQBzMtepmUVKAn2kz2amRz9H3DIRCT0D2hPWRIsrPRJ74Q2+cYDV/HNe78R9UAYijwbjcd42jt70MOSAdJEzv1ipD9LSg+VMLMfXkvoQD2XXfxIbqQGZZmIOp4Z6lFRRjJEuXu4LQZEVpmWQfyO/WRE/sQOlKKL7oIsinzr3+vmKVplMgW98LS6QBqrC9Fpd+qYUiuCWuy3OEAgokLAZHbfh+J/YAz/p5fjfPrA1XgzD4+SO3Xl1KYtlUpigKkt3KrZkW7GtkVfq5doD+EuYfMBEsY0QWKlY07t6fQobUNoeOkngoQgw74UdIe8O/TkaAESTQ4BJaxbuQEYLtA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA1PR03MB8063.namprd03.prod.outlook.com (2603:10b6:208:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 02:15:00 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:15:00 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] mmc: sdhci-cadence: add PHY settle after tuning for SD6HC
Date: Fri,  9 Oct 2026 10:14:48 +0800
Message-ID: <073f81c6e6dcc931d6e12c358b48679b2855a72a.1791459448.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1791459448.git.tze.yee.ng@altera.com>
References: <cover.1791459448.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA1PR03MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: cb052b90-eef7-47d1-c52c-08df25ab1efc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|22082099003|55112099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NIWyJhvxs/IXWyFxQ35o//5TRGKzU0i9dAFg1H2n8yVZVQarcfxVH1tEpH/qWhepnBpyiMLX91XRXEbMV2i11/f+fKG65pj5b4Mj+J7PXJ6EZWGDS/NzE/b/+rsP5TX33etuL84qm9TZALMjruHvV7YWB7gXfGy0OLBqmMKFFFpVbiCNRKAYmTDyS+A76Tz1Yk31BjL4et5mXF6b0Zac8DVCZUY01wZKVXUNymf1srDlQoF0frJPupfdeQGV7uvKZ0fhSJmInIbelRKljNAAbLnsNml0EKuqLaKRG4AQwThTTJEIsHRPPr3cr6+9YpGQYafYLQkH9LkPRg47METwlBunhru647sE4XMQoDYKtRUkpXTdkdc9Jl9uhjsFRl1GzBPbHiJk2BPu+3rF1sH334qHhSPpebJf+mSNhk6iVbLuT0CpCtxshIYPsdyp/bA+/lqwpES2cZQOBPedof0lwoiyEdeXGyA66QnlvKRbe3WOs+tcbrjqGQc1IjRz021wvrl7w2/zLQH+CjcjosCLDv1kLjK5YkpUv2rjkSXVbzAy5P7Jg7IsiOpbTyOm2cgkIxmXYsEkUaF/R5V15CxRFr9JJe/Tnh3OIUbtBF4a7+aX2LTWFjAzr+u8DkvXsCVu57g41RH/GU43NgaMWHxJpApozYjkYgf5t5vb5py1x8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(55112099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hlo3kJQHITIKRL5dcl00iQ4lzNTc3aVdLEFcqBYAr42YLcyCwW5F1da4Cazc?=
 =?us-ascii?Q?XreKjIP6gFFqI4Trj5FUCZVhGQEcOPyP7yFBK4iDczqCQS34ZhEZGCTLG9NZ?=
 =?us-ascii?Q?gSgFqlN4acfjQpZwfX503Av4KZZOEA/tAFfvLRw6DhsA1vroLPiYxWCcsByn?=
 =?us-ascii?Q?tmv/5ToZTffyaIsT/kv+NmEPksMjjyq/AEKIJsCGsYZNrrQz3/jjW/9CzccD?=
 =?us-ascii?Q?SjcNfmaYf/amsF+CA3sLRxdiB3yvDeDRSJmUsHsuAS1WBS+2KtD2CKFFvYn4?=
 =?us-ascii?Q?vpyfYhfwNX4f+zMTgVwyRfvwrJX5Z502NRu7YzS8pWJpv1bcYqOx/VHonY8N?=
 =?us-ascii?Q?8IL9avt6OzQoTOz6oqZydMnZLyXYWJMcuf8F9x7r5JKfONrWkOByRH/AZQSA?=
 =?us-ascii?Q?AYJTVhLxL2FsmT5mKlr7xQDUVi0P1HnIYCFlEg+HeB0bxd3l10WxWtO/BEaS?=
 =?us-ascii?Q?sfz1dmHywt9g1JN40bnpGOjzQmA4e4N3kUQbPDN7If6TtvbwrK18OTZMkgnJ?=
 =?us-ascii?Q?QsReRcexBIQYtR1xzzDlVy4DYkzZ8UHqMtlmLtC1L+z87TDuQdcFZoNYNDUU?=
 =?us-ascii?Q?7OPKHjQ9J6uMgxfuoLKBPna/SCud0XWJkkhDeOVeNsOa0RqZU2UnX8gV407L?=
 =?us-ascii?Q?YgEMJB8kFGsdWStlGvlltuR617lkjvox616ABg6t+WOvGLMbRS/gRaz+VQJL?=
 =?us-ascii?Q?UVt2Ha6CfBf4nmUJ0onOzFSWzA/S0z5Aeu4aD3FrnpWPriXwgVCarCYGOaqJ?=
 =?us-ascii?Q?MFhUFBBaZTVPL/mWm08bfXDbP2yR5080FNmeZeVj/isrblgCGfjqpfMKXsau?=
 =?us-ascii?Q?lPyy2GJWgicW5f1uuft8qtWOTGoMjilGIHdI+2DXEGtjiJfB0L9wGZ68hlnc?=
 =?us-ascii?Q?UTZnb7+8PloyPYnDVImY4nwy9U2GQoCmG+tZU0N89rLvTZTXcXleC2Ctkdv5?=
 =?us-ascii?Q?sgtoeatbpaT/+ZfVC1nsIJ/HJNcDI1p4fhJMM6ctKW3KkM4jmHD3Cv5BxNCM?=
 =?us-ascii?Q?uuxJXyWzRXYXPUc6XbqFhYHKc6Cp0HAV7VS3p28qIYegMotlOOzBh8l3aelc?=
 =?us-ascii?Q?nAueuL6Ih8/06cFzxjD5UiBB6yGNaDdGoOlXFYTqEwGy4eobM/awAUaxThZn?=
 =?us-ascii?Q?CbX7jthH++VJrKXRLv3ViWOyYFUWiz7opIbNcbtFae1gm17JI6Ut30b/80H1?=
 =?us-ascii?Q?t62WwceEou8CuIRvYnEnTf9uwUeh6gVFDW3q/7HXRfv9T5bFW9TF4E8NLKj9?=
 =?us-ascii?Q?RLJDJeuOlHvThhBZSB+nK4+hYHYc8Yr9ds8VbO5Bwx5yRAX3cqkdjMm5DO9A?=
 =?us-ascii?Q?SX1GPWBBtjge41L0l4XHUOgHZgU8YCB/FQQXFjo/bwsyhoVK7ae6DLSd+902?=
 =?us-ascii?Q?dBqt6uaEwStqtBKCLrPGovEQc8bGoRGNrPq9puM1koBawYJ6tnW1aQGHHlnr?=
 =?us-ascii?Q?+Uh4Ni8RwqahGHJCqh0YvKwmVHOyevaNipbpY25CDy3YoOcuEiiSNvm5juMa?=
 =?us-ascii?Q?bI2I3ZDHpQyC+HM2ufEIxSAOsTtwOndmFF0bYmjfbmRX59wvrjFKBKJ3uOga?=
 =?us-ascii?Q?mPYHDz6CzakNduU/J1gYZ58unXxp4c+2Z5UZrrjAn9pfDZ88VGac/Dp3PRio?=
 =?us-ascii?Q?AJeWLnWDDCypAQWMs8H7Jk4xR1GX5SONwZsFMa75F3bi/YRvbJ3E03w1I3Sr?=
 =?us-ascii?Q?xqBX3+eH/GoCDSe3OFiyTy9YV3zZJhJREaIECqvI6v9f4ohlXo+QF7Ebk5ct?=
 =?us-ascii?Q?S3FIEh5XMg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb052b90-eef7-47d1-c52c-08df25ab1efc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:15:00.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbr7Uxuc7PMhbxTLgVtAfej6PzlWiyocjXpQLXIWk9P25XsBGBwFVgSCzuggPCNeQvrfQ+l4RrxBg00FlXqANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8063

From: Tze Yee Ng <tze.yee.ng@altera.com>

On SD6HC the first command after tuning may be an R1b busy command (e.g.
the HS200->HS CMD6 during HS400 selection) that can time out on some eMMC
unless the PHY is given a brief settle after the final tap and DLL
re-lock.

Add a single 5 to 5.5 ms settle at the end of the SD6HC tuning path,
after the winning tap is applied, rather than on every set_tune_val()
call in the scan.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Moved the 5ms PHY settle out of the per-tap tuning loop to a single
  settle after the winning tap, on the success path only.
  (Adrian Hunter, Tanmay Kathpalia)
- Rewrote the comment to explain this specific call site.
  (Tanmay Kathpalia)
---
 drivers/mmc/host/sdhci-cadence-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
index 745455743b01..c25b235ee909 100644
--- a/drivers/mmc/host/sdhci-cadence-core.c
+++ b/drivers/mmc/host/sdhci-cadence-core.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -352,8 +353,11 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return ret;
 
 	/* Block gap tuning is only required for SD4HC, not for SD6HC */
-	if (host->version >= SDHCI_SPEC_420)
+	if (host->version >= SDHCI_SPEC_420) {
+		/* Let the PHY settle after the final tap and DLL re-lock. */
+		usleep_range(5000, 5500);
 		return 0;
+	}
 
 	return sdhci_cdns_tune_blkgap(host->mmc);
 }
-- 
2.43.7

