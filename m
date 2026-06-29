Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F9403AE5;
	Mon, 29 Jun 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724667; cv=fail; b=jfyxHQ+0MNOvTLKrEbbPfUFtdU3ZY7O5GD6d/tsc60m0DCnpiLEWA6d6/eAbb8Fk01eZ/y5JHvZUkowB+Lfkf5/gi3wwZlJV2NQDpFWUCgpTlKSti1g6wmWwltnuLJnHSYXSSze+dxT/V8XEpnNccK+y7Nm3uOExzBmFGySQIQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724667; c=relaxed/simple;
	bh=C3FS2VCyXD4MvfBGAkmNSYN1P4h3O/WepeYk6scX5oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HubvKQzAOzGsKKicC0eNOBrzj+CstgOMORKVl6ClxMfYWtgi+yniCKkd3ifpBKr0XM7fRvrVnHp/QOwPRh+MayWe6qPaBXli2ANWCrQF+1+ox7qCazDnPgdIn7OkXCv7ilf/9l2mAqhgP4Hx5LT+8L673W1Idj2gZW0zQnB0PHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dghn6Dlv; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dghn6Dlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg+fPXA1afxBnvNYoZBRyV/adBpkDLXBdELJphqDW5jfLkkFSKvlUfh4tRN1D8NBlf3KooKxpYQnIApf4YyPJWl+fL4Gf0M4I5O/Y0Nh3TkJGfp/ojqS+u73Q3ZrxAHoM7DVBUtUzBg1PFoe1MGMoELG0A317QiEEeHz891ZSby6a/99kQfn8/65mZm7XzzPVBii6XifulLVs3hBjLeTByUQaokicbWesTuPLgJ8KHbAlflAFECq78pWujrBum1cC0Z42ho49fV1oxapOWAd0fCR7eCFM6sy8tt2rgUgKlIDx7CX6qc3ggz/a/VHUAcRHSVpGRXvsWfJMJQ4y0DSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlAG0+B7AU3fAjuvLkfu2quz5fq1Uz57Tpq5Fr7Z/zA=;
 b=Y15RQJo02pXshE8L/nZFGIAPO84dG08cvq3uNsKh/kjgkuq7WN3N10GO3Bc02San93h8rfaMZufhns3TaWoHeLTkd+b4mCkwe/0hleKs7nZiZFX4LNYWXKT6/dxAXCaO3+F5xYcazPBT5ns3e2b9riidlbqAjh32LJ6GM/yt5EUyVQsfBi7gZ4P/dBYQWvd9rT8l883y26uT3YH2Ug0tqM2bX7T2oW03P8y1tZPtzcHrTBWdWny7t6H4jEQOP77UIclQhsCT5YLubggnh5mUQMutCH607XvcrVX3AqQcYjMFg8uihzWEHGwvbUOxePRTHWPd7925S4l3rkOXngJQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlAG0+B7AU3fAjuvLkfu2quz5fq1Uz57Tpq5Fr7Z/zA=;
 b=dghn6DlvNqHzgXhuj+wIDlJVnd+sbFsFIRxI2vuMdAH0C38OtXZ2OczV4xRe7lmiL3tj6PQFkp5TQj48LX8qo0zmERYUKPv1xhQ6ZnpQm4Ah06FugIDRBCnk5UIAwoyJ48dHAEubjRYvWWWfjwDtf3tZNeNmIXXhk1NvsKCXPJBYWJhGhznuGFgtEhqceJ4GwDLBmfauWiZ4q6kEeMQ+lgFDXWDmDIrJJfAms4Q0eZAQJg6Iw2Pky+3mrSMT8x2KwJO8dy3629qHXk9TWs75vuIcXisQx8n5BL6sC9V0dnHLOhMCTDdRLg+nDbSASKKmoMiLqIsPu8h0KIWY5v5SGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI0PR04MB12663.eurprd04.prod.outlook.com (2603:10a6:800:342::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:42 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:42 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
Date: Mon, 29 Jun 2026 17:19:50 +0800
Message-Id: <20260629091954.3227151-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI0PR04MB12663:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e4c03a-66ba-46fe-4a32-08ded5bf461d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8rPfBfK4hV+i37gTtWF6P0jFy5JkKkdnFRrbjlNedlJ9wVXaO1rQBmtFaJYBAslQ9vECOcMphgMEBO4kR6AjjOjH8k2jhwaosljD0RnzimQqhKaLtRSpab5ArH+0EuhbC3XZbe82qS/R5Ynqs+5zzMEs3GPjjZGfSv2V+n58MkADZMGYZym1k+BWZJDPDOcowlDRMzrfW1i1xJy8/ezxEIDthfaWrRbA1xlgte+LdraE9c7PhVRd+hD7ds4YnjjUAY5lwLUG6h0mhed/RuJTXgEgg+J3P5CBnmkDOEHb1CUYG8N11FodilZ7uTzeR9W46iQbOrGL1uowhK/3Mbo3RMqnJ5VDzVQCw9RxBcO1GJu4/8OhcDMHh6YuLJa5LcGs14iv377CAf0NDc3uCKuCAVptNjbVAu4VFyMqU+pgvpALVLz1Wy96XaASNRDo4juS9EJlqD07JG1OyXZTPBwCgGvQcNz+tvniZToFYaAOn9OTqosrW9UwCkgmTyednC9rlZG75Zm5bz+PxEu8+NvyfZv+VYgEA7Jn6ymhmrR2fX+btRgxv0qXibccYRT3qutZ8rKmVSpZ7PIIAWGmoaHbfbXf+pvpnlxmumBl5KiguzsGsz7ewWYcGSI45pOFITjrbCwtyQJ1wCjvd55lX0U37IWMVjrhAbI/v40vbWmab8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wyv3q9z9GY7YDgVLF+TtAciZzC7kUWVyiZ6qf7O+BzCRi3ZAr+wqDwHiVqmt?=
 =?us-ascii?Q?8snxW1DoeE96Stp5oWHvCk0Clu0WzJ5iDuPYZEUBP4seITaSPybc2QCTE2D6?=
 =?us-ascii?Q?7qr7p0o77dhSOpR+SxBbyWJHPFUdT1ZizN9BjarvaImVZh+kimdYCXcSw2yL?=
 =?us-ascii?Q?ISGb82Y9Sin0AFiY//ILiVgnaPIALEwnh5AkrlUtIiZN8hqFgN4MN2b78lIH?=
 =?us-ascii?Q?+bEZ2e1v6KX7yALLUhyBK/zmTR7Ip8F5rWi9JN6+LDmE9lVubFRY4+Ldw1R+?=
 =?us-ascii?Q?MVbwsSQLYvgZt5oHTe4rMi1NFBq3RP22rP1TDwqCva97TUpe+dmNK/W4XHr7?=
 =?us-ascii?Q?AUKqOZWhJULrw2YKbjaShOfWI9OzbBTKzYy/X0cAUcRgbOm5DKOgtjwrj5lQ?=
 =?us-ascii?Q?hKa96TMn0hVcAEExQoKy8N1Sl9ZN5JUh8SYhOpbYi2q0TrqEkcNDOcU4IDFF?=
 =?us-ascii?Q?qzEfSgMBHilCDqE/W92Syi47P2hBGaLF+CQNv5PxZIZXpEP2DL1rZ1widZW9?=
 =?us-ascii?Q?J7wzQi1dCUepsDzDUjsZPSBdSwbIRCGHEph7BUNUnvmWfrd+/0TQ4nICNvqC?=
 =?us-ascii?Q?rBLur7iDdzpvhbpmgRMWPlSefB4GMMdIlX48jtEfEcuoSYFYZ6LaoxGr/pPl?=
 =?us-ascii?Q?Ud+lbr4F+plSuf7vrQ5A8L60cTIwvOOob8tITC8djaRAlXW//a9JDWP6bJas?=
 =?us-ascii?Q?lD3s2btMAhIiq945jtIPLFZuQMcm2H0VHnfsikQgXuzBHDh+vDUnXaUSddi3?=
 =?us-ascii?Q?bGhqjD7rDjdiUgooIBiVNSLbs+MjzxaC7fUfoTUv8z0sY0K4s+HDytrQGSBR?=
 =?us-ascii?Q?iQP45BzqCwjTz9isblGmyxlgRkPr9R31598gMjpYL9S6zzRuh2CBFT9d0gPy?=
 =?us-ascii?Q?ccG693qK9uglHCCWeiCdB6D4iX49MsIYCSUzMpD7nrTJ9b2mtDR3/gpy+VfL?=
 =?us-ascii?Q?CHRxT3UmEINgPCZ4kQAi4dbiV+7GFG/dM5prV9fhffrwdLng+JtgGwWnzcby?=
 =?us-ascii?Q?sU/PynJp1zhdYoTXWLyQwHjXsybP3YpSO0WzS+9BupjRmSpNk1Uwvt1ieeRs?=
 =?us-ascii?Q?JhsdmX6KOiP1OpW44JJWhutz2cW7amSkafEmQQskVeGd5S9O8VNikFQVFbug?=
 =?us-ascii?Q?m87Ii/7G3+6vysa/9GCEAfH6p7o35gZhDm9wNUvK8uBQC6nA2gD31iNSGDI3?=
 =?us-ascii?Q?U9Fl5EcV710i3v3hlfydBg0rRc/pfTlgHi36aLk5QmPzsgcb+h9D9ELfqyKf?=
 =?us-ascii?Q?mMy2qkN2IEB6SRsIuWmDsZaxw8bkRn1If2HEKiqVipxTXaOkSOxQvKTIqZ+F?=
 =?us-ascii?Q?LUrMULfPeRYvZkCtBT+t1+3yqjddiG98DSIjhq0rPjvGg3CaQ7fKCYKnawBb?=
 =?us-ascii?Q?GhOIBnum7g4m9/ybKCtkY2dR4Q82+uGpRAmVZY4iPc6uKxfFNWum7u3nU0Wt?=
 =?us-ascii?Q?E/N4TzB9YUB4V5bHOyE8ZlG3WgXJHNkqoxRkHKjoRUlE5qp7nzrsgssfFJcN?=
 =?us-ascii?Q?xWQQXuHMINpro7PJ/XH26x+T9kRr2nOrFz7WDBRhr2OMylKBomPy5aGxdJcR?=
 =?us-ascii?Q?xkWntOm9W05Y3Y8YL0GABMuD0+FI/hWctc1atbio5DBUC3ZM803xlKZHrjTG?=
 =?us-ascii?Q?1nMXqP1P5Sas6gvG/0WxInl6rHcYZMMLbZuViB1nps3QFbGeeMtiCNHnhJet?=
 =?us-ascii?Q?tvW7nSeQPnQUz0kSIb1AFvocEOVVim+wtzTXakTfX75rowV6Hg02O2wa29cG?=
 =?us-ascii?Q?MdVaYtY8eqfXSEqYPP0jHKw/TcxlCDonkGlU/5B7piSslCe8yAu1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e4c03a-66ba-46fe-4a32-08ded5bf461d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:42.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ss939eR+h1o/o1/L5o7OuBmo85d298VVHNycaScsB9zDT8dszWjZOM1KISQCeRGqG4eX3FUXSqEfxXcEFM5gJfKAe2KPr8kVFSmHQC1Wey5aWJaKZ/TeKgfOcDZ2vBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12663

From: Luke Wang <ziniu.wang_1@nxp.com>

SDIO devices such as WiFi may keep power during suspend, so the MMC
core skips full card re-initialization on resume and directly restores
the host controller's ios timing to match the card. For DDR mode,
pm_runtime_force_resume() sets DDR_EN before the pin configuration is
restored from sleep state.

This is related to the SoC IP integration: switching pinctrl setting
(changing alt from GPIO to USDHC) impacts the internal loopback path.
If pinctrl configures the pad to GPIO function, once DDR_EN is set, the
DLL delay will be fixed based on the GPIO function loopback path. When
the pinctrl is later changed to USDHC function, the internal loopback
path changes, making the original fixed sample point no longer suitable
for the current loopback path. This causes persistent read CRC errors on
subsequent data transfers.

SD/eMMC running in DDR mode are unaffected as they are fully
re-initialized from legacy timing after resume.

Fix this by restoring the pinctrl state based on current timing mode
using esdhc_change_pinstate() before pm_runtime_force_resume(). This
ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
is applied before DDR_EN is set. Only restore for non-wakeup devices
since wakeup devices kept their active pin state during suspend.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a944351dbcdf..7fcaecdd4ec6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2114,6 +2114,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (!device_may_wakeup(dev)) {
+		ret = esdhc_change_pinstate(host, host->timing);
+		if (ret)
+			dev_warn(dev, "Failed to restore pinctrl state\n");
+	}
+
 	pm_runtime_force_resume(dev);
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
-- 
2.34.1

