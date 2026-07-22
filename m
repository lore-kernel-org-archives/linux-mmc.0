Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19468426EBB;
	Wed, 22 Jul 2026 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753842; cv=fail; b=KxsND65gx6+l/XWM8+ZgyXrppLHdnJ/GO8tXwP69iZOWli1TW63LrTFm5Mi2h2SaiX6E50RJzpunsjlwNooByd+KbReMyELdTCgrMbQuL9MtjPjqiSPynhpSEU2sK4adv1Q3j6ZHaWHv9Fv98Cz/MUu8uibfHSYlRuFCwAhDjA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753842; c=relaxed/simple;
	bh=pamsqlJPpuVRizfLp1hbsBE/Dgy1Ra6vQX8Iy0loa4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=am9QVinXszN+deiQq4AGn2E+h5Ww8I4Bhz3fY0iU/i/zecnmea5D7DJDJob1cCBa4ZfvYS3p2it3kxHjhtl7MA4qilqILGszbXKpiqGgaNdU+tqIc3lHkL1R1rA0FSYNeKklz1cLkzCrlKLUufucp9TqHeXpcODE30lxffAbOSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BkDq0ryT; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KI0NND+q; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BkDq0ryT";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KI0NND+q"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MHnP0Y156637;
	Wed, 22 Jul 2026 15:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=S5C6BKeg60NwPk4QnQ+WI6u4NDreop7YaIIRlNSTv
	HU=; b=BkDq0ryTvCCjiWjs2kZ1vc8dUuT7+SoZP7tavryh6lFkfPSTEC5k9w55b
	hV6bgK0FcBGz+XeBQJq6xdKs5RNaAZylFXBbK1C1hjE7BJ/GLEzSyKR2LnuClxo1
	KG3X9xtu16SDwuhP7tavklOOnD5/ubfZzb+0BKWRCJlanYc5mXtXff09Z4lzUR9a
	bLorjh4iA2idIOb9dVcoit+b13P8HNyeAoZ9/+PcQvWIZabBJTzSqlwGJSPRokYj
	rinrJ9DqDyDqxPFsQYqv7VZQ0aGORb7riW3PbNid5zkIH4qgP1ZqbvStj0YSrpRL
	Z9GLbbClS4p+z0SJSbCb7WFLB5hXQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fjwjv35d5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:57:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjLUiAdwhyFQfgdRQ7vS9X6S0DlIke1HrkZNdEaPU9k+pTq7C/AurBxOd4mj5hvT+Os79exUrvOSwnseUfyuiKQnZzdU70RUMIxWQUuXphVFcQ34+H1z2UB4Kxd6GocKgV3VXAGYPFCgWwuNsK56oroMUv4LUqhJ4vyoCKBV9Xe5LOLCYMAqhdkS8489FV4rY/wD8CiKoVU3s4jdk41ApDrFLbP72FzysQPds67USTAv+B+xHa5xMpTohQmc3cKNsjJv4YyKp/zXmLn4UJcZpgmxFmBOsfTFb3C5PWApDMG7pmkkkkBOA5gZhT5TolUturJgHGzkTTk0JNlm4MEnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5C6BKeg60NwPk4QnQ+WI6u4NDreop7YaIIRlNSTvHU=;
 b=Fz/oZWs+Uh+WIHl1UIKABOMjk9zV0rtTFYE3Q5WBeWNeZlhrM3bkAuh0+D0nME5Zldf45m3Sqy//SK3DPank3nlz0JpjxRR5pFobqPkBomq0kFFxkfY1zxe0O8XzB8GLkp6j5BlFWp0oyGdHB894Xdcg6IsEfkDME3VljTrlUPIWeVJI7RmioUTNYg2mvm2mXTn+FYRY+XFrFQQ4TMIgvhUDci4NRc2sl7Ha9JWbBeuB8JWlNaV+Ot9hNQH8qiXGIiXOoCKj6TGm4yjt6n69fWXwgR60gJLlAgkn92tDPDYdMsVO+dtSQUArqAc9+61RC5WZsvRilOnsyuKlc7wo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5C6BKeg60NwPk4QnQ+WI6u4NDreop7YaIIRlNSTvHU=;
 b=KI0NND+qer5HNdgfzftYu4cZRz59vcawKiJiwiiGXGgO0Gy6OUb2VenvNY6JfOGI8nwxGFKaeWUsoq1eEoddn9G9j8cU6KggcfBL9IGPElGKC5dIfwu2eVit8dp033UWhQ+AzmNIpeL5nhf5dSdSBMz5w28cEHitbLs3/mmXrB4=
Received: from PH8PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:2d0::8)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:57:09 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::6f) by PH8PR02CA0018.outlook.office365.com
 (2603:10b6:510:2d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 20:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 22 Jul 2026 20:57:05 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 15:57:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 22 Jul 2026 15:57:01 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66MKv1vu331261;
	Wed, 22 Jul 2026 15:57:01 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] mmc: core: Add power-off-delay-us support
Date: Wed, 22 Jul 2026 15:57:01 -0500
Message-ID: <20260722205701.372789-4-jm@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722205701.372789-1-jm@ti.com>
References: <20260722205701.372789-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|BN0PR10MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: eaef9012-da2f-4e66-6123-08dee833c978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KwKGK84kBRwx+pUCy4XpDFiku0ZjNdsszo28c+Ucqauq74bMndHF4iEIcjd85Bnqr3GEsssqg5AiMXBQ5+b2fyMoWu8fWRHnLVPCSM+adNQQ9RNJ00Nrujyi8YSPrd/XqLZ7/1o8JFHCfunVbXonyxaZuoSoJ3DkqBghvxRHyAlkTjhIWPX9ShSOX/H8FvLOGEqaJpkk50x2qSipKQw//8nIrLcd4/bNfYWJ3c7UVJ+MKoEqjFgTCX5BKSltQE8/qNN2sMZwGtiT2WNRyalP68q8y2oFwlgsz8sCaX+eXbUyhTSAtDu56GKby9LuR424iwAYFYerH5r/4LFtmHvvgRN05iMA5HcWN8OOqn43xGr6IwRlJg6ZeHZzwQrKX0WGHcAeyh4T1TFnUmSac9H9SfPbda+IdT4KsCcgwyul/8NzOmGeda3GeXAfyzzrm7qaruMsfXNzUJhQ5oWcRcN+JbelOMIhbVtm3pZn9LVAosUIEYrhB+GxLEEmzXg5B+MeoYF30Fg0l46rucPLl/kiVhYNj19ncFDjxQTKnKHbvg5NTC9eAz3Bki4JVrtr6Kvks5sVCNPfX+0D9pk9okl+I786W2e4koSwj6j76rabRgug9sK9MhY7uW84lGBGuP1K3EqlJFPEdx9CzN9Flgd2cO+F/+nJdlPc5R9vtTRFh+o6piDHxPIiR1/JMQKWZ9sYHJlZ9NDN1FRj4NummrR7zA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+5y25WocIoGqFgmXYg1na2Ayn/KvpG1k8ymc/j+N3w+/8xjf22+p6IEIlFOOxUUza1QRY/qNq/L2FjKja2F/k3TW4RyGvDVyU1V9Y9Lbn2uNu2oUS/pD5A+4ZfMjMQ901IAzbQW24Uv1cLbjfdw1N7RUP0bhiMqIumkzDMas3atN6EUN4n1fuSWLmUT7z9KyOODeAuOUltiDrmGVHIU67QjyWCOsjXz8t7LLec0DJWld6qrfkcG+AI7a0eSflAveo82bqLpZZ6cD1Sv8F9EadKVe4SDkJnjTxx9+yljGur12LW0gFKCGL1kWHKu8jBfxrVu48elXDMa9LUziaT+2GaarAZ3K0v7eKTheoEgNFZ9LphPhUgph/5o0qGFhfDCCbePSEPfk5druL/Gd2zaIwfAuVaN33YKDsyRwA9aSZrR64QmTB2RqtBRVlewRqYzT
X-Exchange-RoutingPolicyChecked:
	WGjLkLO6ZQ0xzwkfwww0CiZFcRB7ifvlNwvoRnAVoLwexE275cTJEFNedTch9JlleQm/Egpsw1U1x8JNcfjRHNFaZH5GDu65/tMcknKl81psmTYqudGI9/rjs3bEEDrDsRgvwGEuttznWpPAvsZjY+bW/vaIYMvYHD5Nt/apLWLIDe8ttmpd5KoaKpkTGut7nO2l5EkqqTiLhEXRpi8GrpgMcattTU+0YQTizuQTZKZdlZKCcAl3AWsaoRdpeNeefhuIX5vjr5m9HWlc1m5iC1DVkNrdA64qKXh9wpNVuo0ObylPZxIk/1VKC00ksVTz0r+myX2Ma7sZlz1ra3MePA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 20:57:05.3582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaef9012-da2f-4e66-6123-08dee833c978
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfXyptJmwMotJvl
 Zxaaw+aJF+c9E+hHyTvpSH6OdcBEDghHRoMy1uJFxHCKuVnUtS5E9vW3CDe+qESge4IZ3s7CfaG
 yMn399rQRE8AFAKrwSyakYM0Qe5oB1E=
X-Proofpoint-ORIG-GUID: EpfY7Im5JOsvj-bnmg3DWmEccAl05aIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIwNyBTYWx0ZWRfX25I2ZjFBcjj0
 DfZEOsOQia08GO/s0/aMCeifv7lK2AntztpVYXL87BM1md1CdTtPg9buxO7qTG/yYh6y9wayuij
 ned0cfd7tBI79pew+RvAmh66ZBD/tWWfb+QFQtH+liTm43uXLSbdShlfIlMnMPoW96azAlOtpbg
 AJW+2vBJheqc9tJvkU4yZhv73uPKTRpx2mbs76Bh7X+AMthUvZ7aCR/0ni5lUbmzznHmcS0bNuw
 R2b/fU6hYzYgeqzFGGMkvdoB5PNiR0c59ui1X/SGlMm5UrYSkmY7QfKgKxMhgzsWz/cY5PwHsVD
 SCcv/T7f59pSMWWTbX7kIA0/vdJunJltKraWTFdrmRlMKCRnwU1pg4tYsOf9PjXxmFYeBIcSU0Z
 /rgMhLA/Y06hBd0uHIJveicimftHebOCjxQ0BwJzZi4b6CNdLfYsttwBiks5rjSZVxfpzuEdyzZ
 zhjmRsjoH3cbzFaVpvA==
X-Proofpoint-GUID: EpfY7Im5JOsvj-bnmg3DWmEccAl05aIH
X-Authority-Analysis: v=2.4 cv=PsyjqQM3 c=1 sm=1 tr=0 ts=6a612ea7 cx=c_pps
 a=OswsEo8IlqVTC7zrgcx7Gg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=hraeLPrrzT18JU5iE3IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220207

Add support for power-off-delay-us which shall be used to specify
value of delay after deasserting power during MMC power cycles.
Default for delay is 1000us but custom delay can be passed in to work
around hardware issues such as slow RC discharge on MMC VDD rails.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Move delay to mmc_power_off
- Fix dt checks and remove print
- Move from mmc_host struct to mmc_ios struct
- Rename post-power-off-delay-ms to power_off_delay_us
---
 drivers/mmc/core/core.c  | 2 +-
 drivers/mmc/core/host.c  | 8 ++++++++
 include/linux/mmc/host.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 29e80e5f928e9..9472041fe1c20 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
 	 * XO-1.5, require a short delay after poweroff before the card
 	 * can be successfully turned on again.
 	 */
-	mmc_delay(1);
+	mmc_delay_us(host->ios.power_off_delay_us);
 }
 
 void mmc_power_cycle(struct mmc_host *host, u32 ocr)
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d4529..fac50a2860211 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &host->ios.power_delay_ms);
 
+	device_property_read_u32(dev, "power-off-delay-us",
+				 &host->ios.power_off_delay_us);
+	if (host->ios.power_off_delay_us < 1)
+		host->ios.power_off_delay_us = 1000;
+	if (host->ios.power_off_delay_us > 10000000)
+		host->ios.power_off_delay_us = 10000000;
+
 	return mmc_pwrseq_alloc(host);
 }
 
@@ -574,6 +581,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	host->fixed_drv_type = -EINVAL;
 	host->ios.power_delay_ms = 10;
+	host->ios.power_off_delay_us = 1000;
 	host->ios.power_mode = MMC_POWER_UNDEFINED;
 
 	return host;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a101..714417466707c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -23,6 +23,7 @@ struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
 	unsigned short	vdd;
 	unsigned int	power_delay_ms;		/* waiting for stable power */
+	unsigned int	power_off_delay_us;	/* waiting for power discharge */
 
 /* vdd stores the bit number of the selected voltage range from below. */
 
-- 
2.54.0

