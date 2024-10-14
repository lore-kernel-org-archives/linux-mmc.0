Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3513D62B;
	Mon, 14 Oct 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885647; cv=fail; b=Yba/WTIVaQ5h7oGJm0qAjfqTxwrjOCM6BhWqgVF2pAOwuUY2ItsbSQFi1HkYpREu5spo3WypZlsoKtCGux/0kFWg/0ILYdZsq9Kij0E+a0+vfKdfFfJ1kAeEBPj/PhtKu0+Nv+KGDVayVlnLxRS1tA+ta9dcCFUy6GSderwnRqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885647; c=relaxed/simple;
	bh=t2bFtiuTbusH+vdzOAdjZ0c0c7pZPCiLqng8RmEPVAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GaUtc4n97cAL3Jax/+k2hQisb0mLfdJNjsNfN69FrFsEK1UoPGMRB0CNc0xs7muUvV0xgxDWJvl3eDJcLlhg3mwf7pn6le1U+KPkNrcaUOAZ6+ywMpGjOlCfjIot7XBDbeekiwZV3Mj8SY25PZ0wgjfwHDMzsi46R8YuHGCBdeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iMCurIfj; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMCurIfj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6mw7vlT58KA6/Ch/7fa+sJq7wkLHpWcFyt+j4oeiESy3KVCbM1hwW3G0/QAkDt9nm1pdvU7bGcOHHmKBS52cS8dTTtUw6zYFAD8goQyAMKOGE96YNo6xYGxkgQpQJIzSYoDxVubKovJVXzVZcGdzVxId7A6WqbCIOvDNx8dlpD8uGicSenbXkxYhQyh5I2QQC4JdTzFQqhfXgMNzm6VpvAIZHlcmcPQa+Uf6ASKMJm8QL4/57/32/CBizH/geaVdN27e58B8rPGSGHCS6XyAn8YW4DlLbF4nEBnjEG4jkvbYJkd5T8K1ZZQw148J5Tu/t6Pty6/vvDPf5l+v0t9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGxyknLbtIalQ3GMBGRDohcnpTs4FNczYpD4DizUtno=;
 b=YW2ZvfqZ+YfsmjoK5zcWTGwsZohjYZqNdoxmHJnT8vCtHaCPTEe2L4M8yl3d4Y+lQNbTO3iULcXnQ9Myctoe7QGzRg0GSa8T3jFffiuOFMGinmlI33jtvWwPIBKDWRqimEUFV86hP1dGIJIrQIDA8kZi41WBZXyYIHXrduTDBZ/FO25scDxrki9DyvsjgagRQ+3ZIuHwQNjKnCArAu5PiKXMdGPgYQDRP6WHGHYy8vUs0QarKgpaGKsdHb8+TasarRaVcm0P9GcHi649+34X8ZYRvYkXrtr5qM+gklxc2i7FgJXcdN/QCpY4quc/DC8xqlcS535i1yO4Z/XILCDHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGxyknLbtIalQ3GMBGRDohcnpTs4FNczYpD4DizUtno=;
 b=iMCurIfjTXoJ0DgX8ywU1WqjN1Ty2agy+Ufvw6kd1UNvt2//nH4GwG84AzeQ8oiO5y1J2nZ/uZ8BT+Woq3ew1WtzOVsCSZT5NkqKnj3FcgSZDN2nA/vVf0klAPci7RiruAj1JiDk3DT/155tJgDsPK7WJL+YlRIzKyclQmZeoJQ+PMts09zRBkMpAzEI5qhkKC23iwnD3yk/+j1qHqKwtoPu+UZFrmT6EE6LQkbq41I145OH74VM22eth2VqGJApjRd1XU+JaWPFLIDTuXwJMNX7evOptMSPDqfnEXnamOzydFU6xX54i0hCqSLZPx/w0XUz6zjmh4rh2huF16Idxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:00:35 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:00:35 +0000
From: haibo.chen@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev,
	haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the system PM logic
Date: Mon, 14 Oct 2024 14:01:28 +0800
Message-Id: <20241014060130.1162629-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014060130.1162629-1-haibo.chen@nxp.com>
References: <20241014060130.1162629-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2ba417-598e-48e8-230d-08dcec1583a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2PbW+4voim9758/eiejHVfiJtMpfAEVtgQESzbn8WQlnN5sILTFEZ36V9zfF?=
 =?us-ascii?Q?WoMOK+qpdxWB9J6RQbPukn+96XyiwEeWRhxrtcCEfvEuDHSV6B7arh1atnIt?=
 =?us-ascii?Q?MKm4DDxmQHRsp2NUSp2Him2lEwA/oKAuq8/WUAc4Rn1Wd9NM0VlIvkVXzixz?=
 =?us-ascii?Q?ejYrNCMTw+s5N4j0lWI5TLsYzKhTkuO+9N1OaCxNzH8SQ2mpYLyq5P2n1wRj?=
 =?us-ascii?Q?XjMZPrZD3vr3ySGN7lBABJygqFPvJI48OgeLdKM9OLl9bmgNwThYqrBew/7H?=
 =?us-ascii?Q?gNsoTCEOw3B9h1T9lJs0OjCwcVEthbn+XhjOEcrcQPyIVbupzY7pNtTxE433?=
 =?us-ascii?Q?02oeIuB6qXc+k8vyGhNH3VYvlWQxIeJgoSwuvNQhb0BhweFVyLLtBmo/SNSB?=
 =?us-ascii?Q?hFLcKOVRStV9aic8HLZKa5h1wO2TgIDjvxhY/jW8pWy/J2Ck0oU07XvfcRdb?=
 =?us-ascii?Q?Rj5MzPrRM2UXg8iRRDQRTt67h9zv35S8ztW7nOz/ZbS36q00bqyWgfEBTSpo?=
 =?us-ascii?Q?dm6R2NV6uYiOhhZMtAkKDPw98IjckSI2njzHXYcniNEMLODpXQEj+AXOSqhP?=
 =?us-ascii?Q?y8ER9eMb25dCj50A0MM0kVHYvn6qI2ebdME2eldSiuWaQZobPFsm9eYvHCBG?=
 =?us-ascii?Q?zfEbo1+lIrofcsq/gSqzuTiXBAiCS6XUVu5CvRqtpSDkZcKuZCVoQpMkETPS?=
 =?us-ascii?Q?cIh/H1sLOKDPBa4lkqbpIGW+r2V4HbwDiFFHLAsFGgaVLW3RIEpz5h3/VUgi?=
 =?us-ascii?Q?zHw+mrmdmLnSVP515qr0+EsrT20+VcX90gKLWVOUb/N6lIXHRtLzd3sTUTeR?=
 =?us-ascii?Q?xHS7hit1peCo2JPjumHLjfmMu30olIoUyiZzfT6QdT9VA5pfOevlcbfcnRIo?=
 =?us-ascii?Q?GJ+52muexyy3qdY4Y8WnChUW6k4bqVnOufLdF9mx3cN5lySKRnHxS3SwhjOl?=
 =?us-ascii?Q?oajkq1Vd8UETwV4gqXbrx5vGXQxv22ueHc5I5y9nUS8VPMZn8jPGkDJN0kJ4?=
 =?us-ascii?Q?bebEAF8pVfALmtaaU39Vcy8ZmsG8e/aI+gcuAtBi4yDi2aKkY8HEa5j2qBcE?=
 =?us-ascii?Q?CRKodAhouz6m7b6f64HVdmiBfGgBs1p8B/1UmgIhEnwXStlUNSqiFZNZ1p3i?=
 =?us-ascii?Q?9VkulNoT0I6hwpFkNmuvUa3pYqDo8WSuwkTUH7HWtCkisCNyD/UTx39Gi1uo?=
 =?us-ascii?Q?T60+2m/nlDdFKJ3zK2K5aruPtAdumExwlO3fhsZt80EKncvGIver01bYFypD?=
 =?us-ascii?Q?AiWoEkWrwNp1P4/Pc8tDsjbBI4XHFRdDKPE9nPO8iSgw2K+giV6waT3KsICb?=
 =?us-ascii?Q?hUvwy9/qwodMQVWdP9qQ655DVPFGyCa7mptkrQHZegAy5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63klnFseGE0ZYzOAKC+DzHQdxBCtv6ZLUoH2pZMaO1HNcO6sNDNSs/A47dlX?=
 =?us-ascii?Q?0HEauOhHnKdmhj4w9V87ZUitfzaIqqr/PyQ6KjJBSCUkWKE5Da4rxwmABj7N?=
 =?us-ascii?Q?aIKv9zhasC3zs1FVeDYlE2fpDBiNSYMpy3zNgwfigDi7TZD9xYnFwassrd/3?=
 =?us-ascii?Q?yenRoQEPGBq4GgpfA259tvCG6F353hAP1/DtPwuJNP48jug6O1Go/YpMc5Vk?=
 =?us-ascii?Q?v+/C5pkMgs8+YzDeD3IeXsefr8wtgDqPTGwHa8sxO8fYVuBRNZn6PK2l3mrN?=
 =?us-ascii?Q?LMaXrcUnZCLmrZSZgm6jBaQbHl+neyzhsCl8KVsmpTeXbfXKN31WeiMAOEV8?=
 =?us-ascii?Q?5U8KDT1tycIh7vgXu29MRMcVxcnIpEN/7SYGfbd9fv7k3syytKHWvWaoN+pB?=
 =?us-ascii?Q?4xdeJapd8hsSdyXWgZfXirF9yy6/DmaIqXwFAgXKPz6sOvUbKjZiFpg+JZfA?=
 =?us-ascii?Q?LuLadBMSO4AoPTR0Fl//eWvvTE/GUPDVPn7Jm296y+dVaZeA6sdvTYYHu+TR?=
 =?us-ascii?Q?7RNh/KY7obV5JR7Wc7INZssf1bNixdxbLJd70OpVT9b8n3EhWA1C+L/Rznw8?=
 =?us-ascii?Q?HdL4M7zw+DuYA+UmjO0cYoZxQuD6wS5uVOhqWgxk69VHsjeY4kUFLv7CU031?=
 =?us-ascii?Q?NmrO9ARzfmPFBnL2k1DrBGvemoCSbmoLZ/eD7hhkcyjUdNq9vVCceSWK/148?=
 =?us-ascii?Q?2ZsxngVu1/npJGGK75t2Yvlu8Dvtnn85V1q1iy4mJ6DsrAcARRojMb/yr/+s?=
 =?us-ascii?Q?b69Em9PFnS/Zhm+Y+Ez5gYKT4sI7EWEzHM1ktZwi/5Di9OUtOmyGgs0Is4KY?=
 =?us-ascii?Q?xt0db06izdlWBTaHxRKgSDBgLGmPSS6F6QiaXj+YESylUCIiYpx/ViLC6zGp?=
 =?us-ascii?Q?C85/avw5G3KEXMpurFRYDYzeBUcSizCH3j6hoZRV0hADGvSHFVXbAF/GZ+An?=
 =?us-ascii?Q?4z4hgDbmuEpoUVrAWPuvXOZowRT7nQDlSKPQRwGWCbq4arJfdSnpuHJmkYb9?=
 =?us-ascii?Q?LXLTqWIctdj5pjwQwSO5SFMgevRxSBugNfx0GfUfuJXrqWJUAZ6T2wqvsyR0?=
 =?us-ascii?Q?BraKMxeplHzoAM4xkU0suegEhQgqx6J+34rC4sUNqWeDh2fZDaomPyz1jyDO?=
 =?us-ascii?Q?npfU4+GLXrLx3lMhdHeBqyD4bhCAJSSDTE0Z08ijm4vxWI8/cX33PXwknWyW?=
 =?us-ascii?Q?P9VGvmxGO+QkiLvfWukjxvuQ+9LW1Bc7vmVmT4QMWH14meirxXVENO2udEI6?=
 =?us-ascii?Q?l0o9nG2VDCQWWUraqYo1YMbo0u8iihLP1VaYhXD2/uhPg9EpuNClIO15+E7v?=
 =?us-ascii?Q?IcOF8a65rZ3mWCn0p+UoN0BplyBEHQaDVdko+ThPv5L8KdypPjwVzfX+yMAg?=
 =?us-ascii?Q?Guo7CYMdTClfLzlapiMcosUJh0mehE5HonEm9AVic4ekSpihxsnKSbYNhDUW?=
 =?us-ascii?Q?5WHLJbdikX4q91u2wp9AKkifpR6qlgR9zEkV5yI8RYd/RcpyXHZJPGr2v+RK?=
 =?us-ascii?Q?LNjBF8vXwKaB0S4bsGb07s5YPMfzXrfdqOIxUJTDFlOxcm+JNvz5948Hqh6d?=
 =?us-ascii?Q?hjXo0JZ8BB8DmVWSiRbfxmcrGBVEwiXn1qg6p2v/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2ba417-598e-48e8-230d-08dcec1583a4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 06:00:32.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhZF0yz3ZfqKGOAFUNK/RcQ/Px78vLU3J+gxy0pipC7WnoKgaRp/UzmsHq1g9C66b7nRoWC9HiVMVorN3DmEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459

From: Haibo Chen <haibo.chen@nxp.com>

Current suspend/resume logic has one issue. in suspend, will config
register when call sdhci_suspend_host(), but at this time, can't
guarantee host in runtime resume state. if not, the per clock is gate
off, access register will hung.

Now use pm_runtime_force_suspend/resume() in NOIRQ_SYSTEM_SLEEP_PM,
add in NOIRQ stage can cover SDIO wakeup feature, because in interrupt
handler, there is register access, need the per clock on.

In sdhci_esdhc_suspend/sdhci_esdhc_resume, remove sdhci_suspend_host()
and sdhci_resume_host(), all are handled in runtime PM callbacks except
the wakeup irq setting.

Remove pinctrl_pm_select_default_state() in sdhci_esdhc_resume, because
pm_runtime_force_resume() already config the pinctrl state according to
ios timing, and here config the default pinctrl state again is wrong for
SDIO3.0 device if it keep power in suspend.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c7582ad45123..18febfeb60cf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1871,11 +1871,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	if (host->mmc->caps2 & MMC_CAP2_CQE) {
-		ret = cqhci_suspend(host->mmc);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Switch to runtime resume for two reasons:
+	 * 1, there is register access, so need to make sure gate on ipg clock.
+	 * 2, make sure the pm_runtime_force_suspend() in NOIRQ stage really
+	 *    invoke its ->runtime_suspend callback.
+	 */
+	pm_runtime_get_sync(dev);
 
 	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
 		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
@@ -1883,12 +1885,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 	}
 
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
-
-	ret = sdhci_suspend_host(host);
-	if (ret)
-		return ret;
+	if (device_may_wakeup(dev)) {
+		ret = sdhci_enable_irq_wakeups(host);
+		if (!ret)
+			dev_warn(dev, "Failed to enable irq wakeup\n");
+	}
 
 	ret = pinctrl_pm_select_sleep_state(dev);
 	if (ret)
@@ -1904,22 +1905,18 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = pinctrl_pm_select_default_state(dev);
+	ret = mmc_gpio_set_cd_wake(host->mmc, false);
 	if (ret)
 		return ret;
 
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	ret = sdhci_resume_host(host);
-	if (ret)
-		return ret;
-
-	if (host->mmc->caps2 & MMC_CAP2_CQE)
-		ret = cqhci_resume(host->mmc);
+	if (host->irq_wake_enabled)
+		sdhci_disable_irq_wakeups(host);
 
-	if (!ret)
-		ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -2011,6 +2008,8 @@ static const struct dev_pm_ops sdhci_esdhc_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
 	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
 				sdhci_esdhc_runtime_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+					pm_runtime_force_resume)
 };
 
 static struct platform_driver sdhci_esdhc_imx_driver = {
-- 
2.34.1

