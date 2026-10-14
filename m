Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED14E01F0;
	Wed, 14 Oct 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979970; cv=fail; b=lIpNCV28OW1s4eI09htq8pN54j8s7jom1vfYe2Vyc2UqFspx3w37IfLYbc5+CAEcSawDyhbptL1l/XZDeOlQhy7np95tECFAKeWe02Oj1H/2n+s0R3+oR6AVemf2VAqqcVA6aE44PrcyTvhPgYOY9oy9LNsnx+WbgIjrm/CBLVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979970; c=relaxed/simple;
	bh=PyeLDJMZFYCg/K21FDDRmdxrMxm5irVQIV+8jcaKOvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izsgN9qLwLzpLttN3Tc+BrxZhJ0hjf/5xhvIMPbcXkzGalEhQrXzbbZL+89aw9BvdzUttlYpJyGicBom5FaWS2GyxwEGBBs/QZx2sGM2hnMzfo/q2JPvIA1HN6cjulIIXRe+krZjASSvnwTjOZ5kp8Te8zaOP4AWQH2cmW4K7FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mykg/As3Y2SU2tSZJXRqex58YPdFndcfzyLmMPDfqE/+n4nacraYTaObRXnCWYCyl0Gr9JLmwzeJvZN8LwxbfPiDzl0U7+0F4uiutXwvYCBTDUL0K/Fk7GGO5hyXn+qinWX3mVU8bfPt1DO1/Y5svO7wD8/+ckZBNrhGTazF2F6qetpfsFr+syoE+UgWHr6VD54lYNngKLwEdoX67OkbixARhTlcNczpVk4bmYH5Tv4RmiOK8wAFNbdULy9WkJdZORThs9DYVhgFs5YS1zrzYyrBUxAqCO4kxtudVZeFB4VHPvnhZwj2IjdP//OVQ3gbxCYqXbIPR6G2BG3YTOqZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P2VEcJMxsR6/WSJqXrAyeL3xn/MciZoHuxJcdqZ+5w=;
 b=MalbZt4KoyPODDchX+Elqgsg1AqzIV13zWrDQ1EbeUTbE4rqgDtGUSNDhaz2ru0o+G9oMzXCmpUT+3D0QwMJYLy7TMLBJAxpV4Axj2RbEs2fHl3B8UA7JwZETk6v9GaTMMpu3DamVdpll7Mg4id9cSfjGlB66Q++kPFQ4Ag1lsFCcbV6Ks3bzK8I9kVp/QsWa9zmoew7zQKt1EJUAjLNUhzJ3QTz0eyCJjXFyim5Dr3Lnh0v1LpIDS/eFL0pLEuTscf7+oMcVBI8aDFRESpBXQHMdHcc6AtaCP4VBnc+8RwAP0t+EHZMBpYJm+ri/xx2RbpTtR/QZR2mUgInxG+eiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1233.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:12:30 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0522.012; Wed, 14 Oct 2026 12:12:30 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 1/2] mmc: cqhci: Add support for setting command idle time in nanoseconds
Date: Wed, 14 Oct 2026 05:12:21 -0700
Message-Id: <20261014121222.31385-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1233:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b295ea-6906-46d5-cd5a-08df29ec6b6a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|23010399003|38350700014|56012099006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FiwW+DrWkH9M3ZvArwfqsfFvyT2QQvr7+uD/eTfTtunu3h+nIJUyxKlL/L0d/eoIS8OoX81nenwJ/Kvj2nMssGoiPXL4e+GWlpxVJQI6c6bG9DVrWY0QjXBoNt7d5kzGGLiRMgA1K/0qGL3NMzZ007Yzh0yjcBUSmy1cUJHb2GHE0R+cDxCBD4SU3cdrO56VmLfDsLNgvoU6ZymHzXckDybleXJq7g/zTfNAEkcRTpvArmopI0wqrxfcZYk/ASOq4n8euUEmfjZ0CG33BboRAt5V9kMyqzTJnY1IrZ3usoinZRkeSNqwVNJu6e7vjJwIVqGmxIFGEhyqPx1vBkRS3Ck/eln9GPA+o94qR93zj2JAtB67J0/oEW5kr8DMyEpGfxLIDz1UfJVaWGm/Y97+lj77RTopMA3EMWGm6UjvLQ3vVVcuM3tjCioKcai+fEwo16UBwEJPFOpwdwYvJlt/zmsTni6R11jHd9iVDeoJGgDAGai93uixbCJ5t2Z7jEimrT7L69OGa0BQHrYHboslt8muV3D0r89yk1mzUGw4SAkm2jlpGkkcMMtKmlclPOvM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(23010399003)(38350700014)(56012099006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZtD4ZtcDaFF7fKVilcGaQ5+s1G28xbt8L1CXLKX7Qgl3i+oQ8Nt++VDSxZh?=
 =?us-ascii?Q?Ufchzf4BYIYbgvallyaQNXA0NCrRAHecsi8iG7tKzduRb9hFkjt3GSOH25gq?=
 =?us-ascii?Q?n9GdaxVwqsYQ4aT6P4kxfytt0+nh9Y/xCRmf1gLknLawqKQfaWTa65qtRfEP?=
 =?us-ascii?Q?9CzRUkPs1mCbs8zyiRlDyHv5FmDz63iUTW8eFIWTWlpf9L4ZCUtlQHjb4XYK?=
 =?us-ascii?Q?IE6gAtdoqOKlCfQH8Xr2gbgcas/V8346gKlSOaW+ZicWC6HEQHc9xgh3RBSH?=
 =?us-ascii?Q?bZeNbgl0vKZEfvyMcLvMsYbXGPBMHxFkN0msETlHKV8jJ+enjw3sfln0C2NH?=
 =?us-ascii?Q?XCzl/Hy3QiyixM9Atfsy8mSVNCOwgttrmLrNEG6YH8iSIPeuj78pzLMXVvt9?=
 =?us-ascii?Q?BK2R1XbVC03GLohkTaOs8TrXgKySDSp4yQIc7U1gs9RGxiabrjtVCYLGUiFT?=
 =?us-ascii?Q?yW92s1ldAQ7tf4KWmQ5sEfJWGBXPbhlOnULKU5w4cKtg/YmpLYFZzG/BMd3x?=
 =?us-ascii?Q?P/uAVfzqbuddOxOtZEk6f7um5UcgAyV/A8nM0j7ka942+/iRdF4zsdLhQsPV?=
 =?us-ascii?Q?7BBwflwzCEZnQsrBOLC1rab3oIFJKu2r8FXmtmbxUUwb10dm6njnEm9azZcu?=
 =?us-ascii?Q?h9klghdSMTclJzs76aut93LcPJDLuoLjHJ/qQyRPVEgMMT3fQVrKr+7R1g8s?=
 =?us-ascii?Q?cqpfS5HnXDshF4edjrEfvNMSMHF+v/OyD+yDy5alohytP3xNGgth9dyQlqA2?=
 =?us-ascii?Q?ZnvzMUR2oX8Px6gvhK1mu8INWFQm8TCmxCZ4s3ZXG9bjjddeXODv8XAxwftT?=
 =?us-ascii?Q?7Xz/1LpMTisbl8D9IyOgI9AcQx9M1enbOxSCt8JXmS4xiXvE4hIhBTyKIMBu?=
 =?us-ascii?Q?8pYGmfZvFoamelKyc3rlJiWzF9pRCv5RKQfl+ptnTMYUhjb0BriTycoHJMrD?=
 =?us-ascii?Q?WQJ6n26tV7txZPB3QXEkCRkM2hN7PA47GnNAEobj5cqjlSL/XdxHyzYyO4lt?=
 =?us-ascii?Q?DotNo6gPXaTLIV+ztoMTj/stSrF3OhWLNYl7Cxhsl4vjFjYvT0zjFerxaiMt?=
 =?us-ascii?Q?nOePXTccB7sDBIgzptjQcqFruRAx9fKJqeuWhVuHeJBGEtfaNoNjcUDOzH3N?=
 =?us-ascii?Q?p4qvyeXiYw5q/T2ETcKRaQ7UYFmT7miCjKwAYVpqeWnyU1s0E6nkvA5hOHOX?=
 =?us-ascii?Q?A1XsbfetihwIQsyGHCPxQM1nqkom7AmYRkOVVxPgP3hVX0zyzjGIDxUPYyfr?=
 =?us-ascii?Q?VyIIKOf2k+XmJro14OIWDY4xMcIihjSrmxZ4U2EJIIEUbiYDZYiz3H5Uyw7g?=
 =?us-ascii?Q?fC3qz2wG19iMY+af55cL2GCYv3JxeK9w/3mBBS2PSEX+AKZ0x5F7UtuHyqSn?=
 =?us-ascii?Q?8FSpWRhjzt/loMT7nU4AMCKLx/nTJgpR8pb/SGfr2zAIQCg849bxMwUpk7WA?=
 =?us-ascii?Q?TYEbO3uYmg92ak41r2fwOK3jsE3rasCVwu02U30rwNYTJTKzL4+qRtQSu58k?=
 =?us-ascii?Q?xNCnxHTMJt9ZsxHaEHbe8P9uy4MUfI6puViQnXDADAWXbsNfC8QB+f5dtMzo?=
 =?us-ascii?Q?y2a4/rTYAjPVCFOxg4w0ZyaDdxWywC5IvJK6lG+M3q/D5IAUo8kO1fx7WE2X?=
 =?us-ascii?Q?peedFJAFjO9kcBOUkqsA5EofCgkYl6ABc2eplm2R+kiXI4RCY/RIMvqlCfL/?=
 =?us-ascii?Q?DyLldIUevCLi0Yt0MBb2Can48IA9kml5Ib5XODAyiHavrsM+UKEpOL+1q21z?=
 =?us-ascii?Q?aUEnQn7rusgBfDjrC3yHuMcMRdgLdhs2UjzMn2tBdATOAVgfIT2z?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b295ea-6906-46d5-cd5a-08df29ec6b6a
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:12:30.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23bQ3xeh3Ugt67S2f/RaP80i2fpWEa0vWELKLD0DggW7RCZmdj4q+qavCG5nzOS9sDPks4WGDp4in5BF4piF8O11mSmcNqUtKZ/1FtTSP0VzlhjBHMJXQXIPOj2uTWJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1233

Add a helper that derives the internal timer clock frequency (ITCF) of
the CQE from the ITCFMUL and ITCFVAL fields of the CQHCI capabilities
register, and export cqhci_set_cmd_idle_time() to let host drivers
program the Send Status Command Idle Timer (CIT) in CQHCI_SSC1 using a
value in nanoseconds.

The CIT defines how long the bus has to be idle, in internal timer clock
cycles, before the CQE issues CMD13 to poll the Queue Status Register.
Its reset value is controller specific and can be far from optimal, so
host drivers may need to tune it for their platform. Doing the
conversion in the core avoids every host driver re-implementing the
ITCFMUL/ITCFVAL decoding.

The requested time is rounded up to whole clock cycles so that the
programmed idle time is never shorter than requested. The helper returns
-EOPNOTSUPP when the controller does not report a usable ITCF and
-ERANGE when the result does not fit the 16-bit CIT field, so callers
can report the failure instead of silently running with the reset
default.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/mmc/host/cqhci-core.c | 60 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h      |  6 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a466cd88b043..aff8d6619ea9 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -12,6 +12,7 @@
 #include <linux/scatterlist.h>
 #include <linux/platform_device.h>
 #include <linux/ktime.h>
+#include <linux/units.h>
 
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
@@ -1163,6 +1164,63 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(cqhci_pltfm_init);
 
+static u64 cqhci_itcfmul_to_hz(u32 itcfmul)
+{
+	/* CQHCI_CAP.ITCFMUL: 0 = 1 kHz, 1 = 10 kHz, ..., 4 = 10 MHz, others reserved */
+	if (itcfmul > 4)
+		return 0;
+
+	return HZ_PER_KHZ * int_pow(10, itcfmul);
+}
+
+static void cqhci_itcf_init(struct cqhci_host *cq_host)
+{
+	u32 cap = cqhci_readl(cq_host, CQHCI_CAP);
+	u64 itcf;
+
+	itcf = cqhci_itcfmul_to_hz(CQHCI_ITCFMUL(cap)) * CQHCI_ITCFVAL(cap);
+	if (!itcf || itcf > U32_MAX) {
+		pr_debug("%s: cqhci: internal timer clock frequency not available (CAP 0x%08x)\n",
+			 mmc_hostname(cq_host->mmc), cap);
+		return;
+	}
+
+	cq_host->itcf_hz = itcf;
+}
+
+/**
+ * cqhci_set_cmd_idle_time - program the Send Status Command Idle Timer (CIT)
+ * @cq_host: CQHCI host
+ * @ns: idle time in nanoseconds
+ *
+ * Set the number of internal timer clock cycles the CQE waits on an idle bus
+ * before issuing CMD13 to poll the Queue Status Register. The cycle count is
+ * rounded up so that the resulting idle time is never shorter than @ns.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the controller does not report its
+ * internal timer clock frequency, or -ERANGE if @ns does not fit the CIT field.
+ */
+int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns)
+{
+	u32 ssc1;
+	u64 cit;
+
+	if (!cq_host->itcf_hz)
+		return -EOPNOTSUPP;
+
+	cit = DIV_ROUND_UP_ULL((u64)cq_host->itcf_hz * ns, NSEC_PER_SEC);
+	if (!cit || cit > FIELD_MAX(CQHCI_SSC1_CIT_MASK))
+		return -ERANGE;
+
+	ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
+	ssc1 &= ~CQHCI_SSC1_CIT_MASK;
+	ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cit);
+	cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
+
+	return 0;
+}
+EXPORT_SYMBOL(cqhci_set_cmd_idle_time);
+
 static unsigned int cqhci_ver_major(struct cqhci_host *cq_host)
 {
 	return CQHCI_VER_MAJOR(cqhci_readl(cq_host, CQHCI_VER));
@@ -1207,6 +1265,8 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
 		goto out_err;
 	}
 
+	cqhci_itcf_init(cq_host);
+
 	spin_lock_init(&cq_host->lock);
 
 	init_completion(&cq_host->halt_comp);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 8fbbc48c3f85..07eb753f9586 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -26,6 +26,8 @@
 #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
 #define CQHCI_CAP_ITCFMUL		GENMASK(15, 12)
 #define CQHCI_ITCFMUL(x)		FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
+#define CQHCI_CAP_ITCFVAL		GENMASK(9, 0)
+#define CQHCI_ITCFVAL(x)		FIELD_GET(CQHCI_CAP_ITCFVAL, (x))
 
 /* configuration */
 #define CQHCI_CFG			0x08
@@ -234,6 +236,9 @@ struct cqhci_host {
 	int num_slots;
 	int qcnt;
 
+	/* Internal Timer Clock Frequency (Hz), 0 if not reported by CQHCI_CAP */
+	u32 itcf_hz;
+
 	u32 dcmd_slot;
 	u32 caps;
 #define CQHCI_TASK_DESC_SZ_128		0x1
@@ -318,6 +323,7 @@ struct platform_device;
 irqreturn_t cqhci_irq(struct mmc_host *mmc, int cmd_error, int data_error);
 int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
 struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
+int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns);
 int cqhci_deactivate(struct mmc_host *mmc);
 void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
 static inline int cqhci_suspend(struct mmc_host *mmc)
-- 
2.25.1

