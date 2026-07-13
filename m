Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCB3438AB;
	Mon, 13 Jul 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917401; cv=fail; b=tRtx0b5V1J4sHQKO6/5sjARgnKeVaCm2Fogrydn6KL/RtwAsjNK7nNWdC77p80Eq0vho749UvpPbKrkbP4hgw+7XDyuU2VZRTPaT0v4R0pt15KKn1BF6pN+m71KOAouVivL30coMM0G1J0RwRF95KEx35AkxEdK5OtXor8ijovY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917401; c=relaxed/simple;
	bh=2OEDquF6HEXP0sxB0+sQAR8bFLwCWTw51d9L/0BGlEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gn+2LnZcWY/ZuQnewvTQc70L8OqcbvDrFT89jmw+3VbIz49SC5d5+hmzvJ13rTLrEgxYR4gcScBbPByMddeQUEZHtXbB3F0FHJ05W3Dy3W8bCgzFRmUhjVw9pzJ80u+SslyTl/5XBcpfMdNb9nLUwXi0oqeX1eLQ6C0Jpm0QSW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hEer7ZcF; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hEer7ZcF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZAPKbMRcqfmATY9mHu4v0ajiooI/zBOdCHEJ908A+DIw0jz91oVdUZltG249muWbedeCsZx9bKK4LR+GLG8+/u8YuXkMjnxKAKYuKJ83PmrgG04t1YcAbSkRr8CMdugw2v+ZPmYjQD6ASwnM6m5pAMUJ/aR7jpABPxwzin5oXKqCpB++lOqChs+cfNANwQ0dmseA8FbGv395Wz73CJBL4oLl/7NUJUqgmsmrgcimf8PSe2ZywunKJyhjjmouDBSCMwUG812CrKcGYsQNqDtR49YVpiS+tWTnhoGQZ11pdjpXh7vjzMoL8HgaswhHlzgEMRD1RvW944GEnXtkVUoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stNNZ0M5tcRj0eiH5J7xatsBtIVCcGsFGE5+YMHUE5s=;
 b=vZagXt8hzlsl6RjvXSJdvrUTQ4fqmTwVtShHKJF81Qey83kIu3EowIwppzfE/I9bhUTdCaY/7aNJ6YyTT4kZCTnob0Er/em47i6j3HGEX0TgqwN0npW5F0IOz8/Ov9yloiEyVNuhHPLK7hSbZmyFq2JDWs/cYuXhcb4mL/0hu4BVvsvPodtRZFDSPoM7VWwiY/kjcVXxfpo5N1FqqzBgJbhLT3IW5OF+Tja6391aooXIfHMOjmuFOrfM2HrFiyis41weSv11Urj9SJrznBe+7rEBr7ZXGZfUsFJ86RlYHoqwuk+URCWY3j1Zpa1VRdwRR78k8MIrnZTxG+NnCeGIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stNNZ0M5tcRj0eiH5J7xatsBtIVCcGsFGE5+YMHUE5s=;
 b=hEer7ZcFkYLB1zv59gxZ+bqM3y3R/1EcJmBdm6tF+L8aXsZEZ39ymTN/UAQwlQLjz0nFgjMqCJpU9NtJt7bDz8ByUGm9tqW5fLktXK83BWskm2AYB/BTdjmTXftfxws6s/YjOzgqOerxbb75GP6U30hKqjSwc84MNCjdXlW9cKm75STdR+w2GMutTsHFLkIF9Opoewns6kjbKBt6jwPvddmvAPHGP2IPJZDnKRSY2yYKiHgfbzRZSE7HASWlRsdO3z41LFJNdbr5/RvdBrLgzCtLhccrfewc6tEIvrMfjL6YdzmADK/Xh6R7IXyhawyM0lKVcKqzey/NrEUwEVdqzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:36:35 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:36:35 +0000
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
Subject: [PATCH v6 2/8] mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
Date: Mon, 13 Jul 2026 12:38:58 +0800
Message-Id: <20260713043904.4144172-3-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf9f814-de57-4ed9-fb83-08dee0985209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|3023799007|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WCmcq1/WQxqp9YJ3MrN75KM62UwtYRVmbdAMtVurcPODLJJlixTPC69yggm2Xguhq4DpQGztJ3gdBZpuE50mWJ4jIJ2rUgm1qP2kk77QT8g/BysFE1YL6zmV9ADlIamaeNPjS+fuEq8lyJckNyCB+OyBn6Qs/xwtyR7Ajur2/YyKPHX4FlYssHDhH6zuxZ3WU2Dy2y64mDmg7jQConEEF4hiLfA5beh+cdVgX6GEgDNMyFSwOPIfeQfXlAptLFCxbnH/aBFTWGTUmyZDb8sBQfclyZK9gDCACNNJVzT7a52zY3YzgsaI1c39pHlZbKr8aoULAC9ONXa4KhpN0FIsjgpZFX/kZHAOAgk9r3qSK8y+siFZwC9FpNXcYgVg8h4k2C26svH23lPO9PvMLNRtvgYviUcecNMmrI8Zxawq6rwoTRObk50za7xRwKTnYVndC99nVq6zvMhu/+ZJLHd++vupTX2GtKroclvTtooUOpynWOSK2G8oNYjBLK28beGJgUit6pHAttwKOgsCofvEeP6EXvCRhMLZVDFd3gYlKBciMD5SkyBD135nI8bhiaXvUstu7a+02iZ/NqW3fMIV65AdI2KZ9reLlWdMzG4edYS694gN4UEpB0ADNFHXFC8U1iGdPOwGcWJBHpzY/QThMxtS0ATivrnod609KXN4fDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(3023799007)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gZnT4TSKEsfMlR/843K9cR9KTuGb1lUpAHwIozOlIy3df4uvnNDD1y+IktB0?=
 =?us-ascii?Q?A4OCByrS+6ZITO4m7AVDekeYLVGQvUEwvwFN5egryV7OrR/iyEEh0mXcH4IX?=
 =?us-ascii?Q?NEp8N4sXCBqVPP821Q2Pk+sh2UuZHSip+nINsUHv2Aeq2Xt/iWf2byW3DIxu?=
 =?us-ascii?Q?iLhn51GI4r8xS05GuaVoZw9MQy4xZVBYE0tADVf+zNW6mGYnxLKzkOTNp87s?=
 =?us-ascii?Q?iLr3UGY+9GH5WWqjaNECvE9VF9OCZq9RcfSXBURAeVK7hLfqhDtHah0cU2uN?=
 =?us-ascii?Q?AqhGcCQt4Jgrj5VzgawUtluVosz6C9vTGXxeMmevt2kLUWEMb7IJ87Kmie6F?=
 =?us-ascii?Q?z6kv/JDzZ7KmifsV0x+CC/xCtk8Y2kMytvLSHFed+pWXJzNoWbXJlQyYTVm4?=
 =?us-ascii?Q?maai54NfRwWYKC0R3jhsuQT2b326Gqyf17j7PabdNMK5MF0cVY6gTMWjVy6e?=
 =?us-ascii?Q?NFAoaAFiKMlBZ7Bg27rMlsFAFbWcJFAOwOYIRdjxBn0r6M66I7dBwwGENqrZ?=
 =?us-ascii?Q?9cq+cXVmYmKxDanMa/HTfArhpcK+r0yxJ8z6qXOZE4beBjIgy6qzVD8UCply?=
 =?us-ascii?Q?z/YwVyxVaKnCxJ16zfP5gJUIqTdVnDDjp5bg+QTQ1bc+LA0CaKnjVvQUtXMv?=
 =?us-ascii?Q?nBlFhRkU0Zj+qIELE1JztvV8gja6M/8sLEqyQv+Pd5afUKBVxqsQy0UO/9b2?=
 =?us-ascii?Q?wzLeVZVIUwyDz1lJza8pO8lwc/PdkyoLQ1PfjwowqlsdbMmWaHPHNelgS+sZ?=
 =?us-ascii?Q?ZD5d9iobXCz4Kteumw9Ao6V8sGqBnQRi9I6O7utn5E//HskCIdiyxkIeRfN/?=
 =?us-ascii?Q?2pKU8vyh/QXsFIe8SQVv7F5qM5evjzfqxztgDaIYMec1VMuJT7ek8M1B5927?=
 =?us-ascii?Q?LECMogaCD74fJrGsAmaqwLL3ReOQMY9nsShsALWIm0qJx+HXJFCfyPV1bX8Z?=
 =?us-ascii?Q?ZbMvRc9lE3ITCgqXSkKgy9KrhChae3YQmT3i8rBa01vfNjlZUzUySoRTNIDm?=
 =?us-ascii?Q?kTHjoQXVsG3JQ0ufEFY5vKwBSvp22G+TRrW29yTM3tGKOO9qFUR0PdbBPlI0?=
 =?us-ascii?Q?gv2hiYvOnVhxvt5xcRywIIAaHPBm1nytz8dIhS2ep9VCCpe7gqkBv6MrW6Bd?=
 =?us-ascii?Q?4haowGjOkCKneErWttzIXngBpa7/3ZpdtH7hRoX9V/TgmpNqCY6Oc8qECBUA?=
 =?us-ascii?Q?O5AKY4UulH4CwgA4iNQIuZr2fCacZRgi5rYQFD3hX2VPfKG+XiQ/P2bUjXGk?=
 =?us-ascii?Q?kkARJ8IvAVXtqZCSRjaTAzI8JwLuM1f4uOu7HtEff2RUKk7F61dC9DxPsuB1?=
 =?us-ascii?Q?vcuPOhfkgJWIUqKGtQU9MpR84E7I2W21Lp7EId/AZNKvhNBODKLlCWqNM79E?=
 =?us-ascii?Q?MW82lYo5Qo0fORtO/lFcnXfzBuA8Z+2rI6cQM1iRuejEJEq3jnqum0tLAj7X?=
 =?us-ascii?Q?FuaOK5VDVC9uAWtShwNT7EDsca49fvLu9DlDicVRDUJ7TKnM0EkgRTqYZ2sW?=
 =?us-ascii?Q?/O1SMG9vlgJDuDijFtdCBb+mkgjxw5kFmMaYyDuKFwAKj4FlyKOtEfWW3pDS?=
 =?us-ascii?Q?Xe/wy5r9/Sv9iNK0IUSR6NhPsjroapAVAZoX/V7ScjfRHBj8k48kdpSx32jE?=
 =?us-ascii?Q?DXXWPgwUzpDTWwYy+kamsfNe9bb4NfsUGIwUyBPov2hGuBOjpq4k8GQ7zt9E?=
 =?us-ascii?Q?qfFSMVAwnd1k7fdzax1Kv+9W0HcQFXuaeHtnbZPd7XfTB9XAVPdG8BYpo2J1?=
 =?us-ascii?Q?vxh+50pfevz1ko0pRk3Lw3IZoqi5KbG/8Gs7VoY+Jzy8xD6ovdRT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf9f814-de57-4ed9-fb83-08dee0985209
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:36:35.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8bHLfoFe9i2cUIydHiTlzmC5sXXW7yE8nOFa2V6tnGo/i8GG/gZQNMPofRP0cRULmDQIlRbqVf6cCjhH+KBIc0ito1FSRbbl/tKtcWSCr/7pfMGOcyfLOpwjw32u1Z6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

sdhci_esdhc_imx_hwinit() unconditionally clears ESDHC_DLL_CTRL by
writing zero. For SDIO devices that keep power during system suspend
and operate in DDR mode, the card remains in DDR timing while the host
DLL override configuration is lost.

Extract the DLL override setup from esdhc_set_uhs_signaling() into
a helper esdhc_set_dll_override(), and call it on the resume path
when the card kept power and is using a DDR timing mode.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6526d65538de..7230d70e02ae 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1349,6 +1349,23 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
+static void esdhc_set_dll_override(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+	u32 v;
+
+	if (!boarddata->delay_line)
+		return;
+
+	v = boarddata->delay_line << ESDHC_DLL_OVERRIDE_VAL_SHIFT |
+	    (1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
+	if (is_imx53_esdhc(imx_data))
+		v <<= 1;
+	writel(v, host->ioaddr + ESDHC_DLL_CTRL);
+}
+
 /*
  * For HS400 eMMC, there is a data_strobe line. This signal is generated
  * by the device and used for data output and CRC status response output
@@ -1404,7 +1421,6 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	u32 m;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	/* disable ddr mode and disable HS400 mode */
 	m = readl(host->ioaddr + ESDHC_MIX_CTRL);
@@ -1425,15 +1441,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		m |= ESDHC_MIX_CTRL_DDREN;
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
-		if (boarddata->delay_line) {
-			u32 v;
-			v = boarddata->delay_line <<
-				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
-				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
-			if (is_imx53_esdhc(imx_data))
-				v <<= 1;
-			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
-		}
+		esdhc_set_dll_override(host);
 		break;
 	case MMC_TIMING_MMC_HS400:
 		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
@@ -2123,9 +2131,18 @@ static int sdhci_esdhc_resume(struct device *dev)
 	 * restore the saved tuning delay value for the device which keep
 	 * power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data)) {
 		sdhc_esdhc_tuning_restore(host);
 
+		/*
+		 * Restore DLL override for DDR modes. hwinit unconditionally
+		 * clears ESDHC_DLL_CTRL, but the card is still in DDR mode.
+		 */
+		if (host->timing == MMC_TIMING_UHS_DDR50 ||
+		    host->timing == MMC_TIMING_MMC_DDR52)
+			esdhc_set_dll_override(host);
+	}
+
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
-- 
2.34.1

