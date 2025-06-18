Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013065.outbound.protection.outlook.com [40.107.44.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F928A1F5;
	Wed, 18 Jun 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248018; cv=fail; b=WQ4LjMLY2q9pakTjyOZ/uf3sebOTVC84e0e53yxss2YZuu7oJv2NHVu5Sx+uX2NUKXlFAm7u4lsuj6XyNKQwudJW0Wdw3nCiWGPhBmj/jIG8/Y7GQLj/wS46bYeH16/0AEpiSmFIh9O+huLwSsMsMxwpjFdlwYlZh6HypDwDuwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248018; c=relaxed/simple;
	bh=0UcwidRhs4HM0s6FirYpPtre4ABkJACLibiY6K/U0oc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cyq9tNtAM/MUkTH46KyhgoxqCfBZa5adYfR6D6S5jCbGxIe/ypffJWdR+Ba64ndxgL8gRP0P6sj/RaFqGc26pr242liaDhnzD7swbOnt3tsVugvUbnqK5P6IOibHov3Q449DM6P4mq0lKBqJpow2K2ysBzZDVgpu1te/v27PwXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qBRwmI7B; arc=fail smtp.client-ip=40.107.44.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qBRwmI7B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfcAg7qCGT/C+PejE69RZni3fHD5Wg4QrcBAk8upBJ3W6vwC/INTGIkFER3+XsK/pqRiSWvPBz4v0DyodlzcGjcuPdy54zLiohx/q1ZpkLTtWZlAVQYFFulUSxRX18aQp+ErgWbBvVOAcMgzCCkn+AXASe9en+Ke6XOIiy79Bbfvf5HS4ktGoTvM2xgwhlifnZFofgohSuM4ziqHn3Ld6OepmfkHp5Wdg7qu+GWnr2CceGcWxk6eM5R3+BpmkEdyf6CpNo946n+gFiJBZ/fAjFAHYfHYb8lzAm462gLEuO+BZ+vdvunKpIWBRv5LTlXbHFFYz1n0k1/r5w64+/o11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksC+2Pgba7wFQGH8xSn4kJCnrrZPxInTr/u+m3VrGRs=;
 b=FyH69aEzlUnWRcnx385VU0/yILFLa7nozx+IdFModXhFPM3qP8lk7hgfH6GJOz9Tk6iO+GXfUIVMz3dRegap95a4eYM9sbpAQj4b2zK3qaC/KcTFHuhkPlUc3Rh4wf1/mOVxVdjFgiLCs6pad7DRpwCtrjBaNIDIhzTbj5kquaFG7qif0vm1gVoRqZ5i6HVIJi3ZLYYmmU2LHrcg70e9cW0NS1O+ivnBGpnUdDt/0gKc59J3Xxr7Irgy9ffuPmHjftu3nn9rGN28N0zNZjCCVNc66BstUFuLaBl3rJ0NhpFPLbOEcvtakb7BLXmKM2Fqn6190Xtexqlu1Jsnh0Kuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksC+2Pgba7wFQGH8xSn4kJCnrrZPxInTr/u+m3VrGRs=;
 b=qBRwmI7BClIT+4szKgT37qHwtHzI3SS1rxZ42K2t/J03ENOSH5r3yiGos9oCACXx67srIGnWX2BsX7tJ+EqPoS1xjfKDfYIZkTY61ZMET/r0W7EGmz6ufMjn8BBS75RveYND/foD89oASCRB/mFGSNN0XtrpNjOaCQ5xV9Nqnnxp9HFudJlcLL9kk19eKPYyaLNXMTwRIbuftlUjeRzY/TOJ/MPqoaWS2AMrLn7dYm+ZUzLzgruo/QVXM2rNPM/YxwyD+5ijZGV2yKhPMtpARYSL8spf1aWlde2TSPLo3j5teUIiYAaTbUBOjHboxoOqTQe+z99v843RRSBYCP5wug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by TYZPR06MB7283.apcprd06.prod.outlook.com (2603:1096:405:a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 12:00:07 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::710a:6dd4:e9a6:59a7]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::710a:6dd4:e9a6:59a7%4]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:00:07 +0000
From: Li Dong <lidong@vivo.com>
To: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	lidong@vivo.com
Subject: [PATCH v1] mmc: Convert ternary operator to str_plural() helper
Date: Wed, 18 Jun 2025 19:59:54 +0800
Message-Id: <20250618115954.10260-1-lidong@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|TYZPR06MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7adb77-d69f-4517-502e-08ddae5faaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8nXSBzF9oESdcadVy0eWplsnffJKrrzJtD8aHn2CC/b/ugVBbX8/WUBoWmjz?=
 =?us-ascii?Q?LmSgvjrYcuRWtJJN7bxy2/IyzXpk2J83NvqqONyhvZR34DQ1WhHU22xcmhS1?=
 =?us-ascii?Q?WU0K0KaYE867cHVuNRx8NDEkTgmoktDGnuMwYq/TLTVA9M+CGm1YUDTLhxT4?=
 =?us-ascii?Q?YFK9kW6MTpogtYui7fy1oHzMJlm3V4AjCVLEEg1nRFL9kKk7umBhAuKz5JdY?=
 =?us-ascii?Q?Zfum/Y1bhp5IEHGDX4OdLVCOMCsgcNqxB/4vjk3fbeAlUYPz5UliR6O3LrBg?=
 =?us-ascii?Q?iywkqS8YIyoWZGECKaTIp6pHZAgVrbIA1BQGGT0y0ZRVDJNlGbecBn/NUuIg?=
 =?us-ascii?Q?rXYCFqX6SKVyD6j4d0lCpp7ZYbO055e4aOuURD7QVvjszrM61dohVaX7RDU5?=
 =?us-ascii?Q?eUtybCEQzSO0Z6OWrdyGab2F6O09XW4/ZvpHkVX5Dn0sJQ/S6dfaZ13LqvJC?=
 =?us-ascii?Q?AlOSrwewh57stbCkFpu6waVtvvsKb+8SKCZYCqkoH7dzYJrFmVVg+eAxZHdq?=
 =?us-ascii?Q?5z49QwWoBDPu9zhP1vaLcd6wqwRT3JV0QmXXie+P390B1GmH67NCQHrI9kae?=
 =?us-ascii?Q?CYNe0zhrDzgUXrG6I2/2/dIayW0HbDx2IVveObrxN0A/2d/uEtp3kDR5T+it?=
 =?us-ascii?Q?fZnSFIcqBCNdSIVjb+/qMqO9exPSa3La/Lm1NqwmUPOy5KwKDCN/nsiCLSLM?=
 =?us-ascii?Q?6J5rPZJlsIa2rsEz+DVFo085832jaUlISxESF4DTn0+zeQq5UE/1FO+N4bDc?=
 =?us-ascii?Q?MGv96k7IKnBJfGKMCD0len3lRk9RYvn4Zms0d8OhSFr9y2djq5t+0bA1smED?=
 =?us-ascii?Q?fAUSf+SbvDvztDVzC2zsqP3ksGv035JoHtd4tCSTog57+SG+J1ZF7meYdQOc?=
 =?us-ascii?Q?mACbn8XCLelFXHrFyMhgdoOajGyMKyQC1CAOW7JqWWiRgF0dtCx8YOVNrupD?=
 =?us-ascii?Q?kIRhNgZu8MOGdlR6Ge5SVR0HHPTwV8sHFqG5QYPMTgCQZCda4fxn7YRuDa4E?=
 =?us-ascii?Q?JJKJ1WcY3zIaYZEQaNqib7nf59i4gTxyqquGkDezm3cpgKUnmUDEEe5khVie?=
 =?us-ascii?Q?21UZLxPWdsg90FDFVVExvODcQw/eRvc64qPswjZ0S5pC/AtNEjFw0qKv5UA0?=
 =?us-ascii?Q?WRWF40I9wvB+/y5R8UvRArs1P1LYIvApDwo7wI46ffyikrJloupvHLRTrhFg?=
 =?us-ascii?Q?JuVPaBlaNMYq3SNmFT88ZuJC+JSXWmE6yVxqMPX9VqeeBVln6gLwdCVNMZPL?=
 =?us-ascii?Q?am/CAl9/xsmmVMdHBsO/DFvGYVF2WebYRd0Sn3Pke7hEa31XQdkrlKKtu0jh?=
 =?us-ascii?Q?kHOfrLIU1XTf4eu0LdAmefHbSy5iCAleTxDe7lh2DoMAz5zaTXD+1cbDDVLB?=
 =?us-ascii?Q?i3eLFB7wrXUBl/hsYBnaIMwrQmhQv/6HuaD9tezkpEIPs2s7RQVzZHv2OmK8?=
 =?us-ascii?Q?gZ7gSifIzKQbMetd+9mmwRiQTH2Quf114Act6uBgbCZefGybKy23bA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WfKFxQbx1iM/n5JXGeD0fjCLCxu9HtnBZWYdiZXQhwcKCQhb+CiVO+h2gIc5?=
 =?us-ascii?Q?VXexpN5/KGRYr0nAFc7+44iKQurcBK9/Hw4SBq7CerbNMHBZY0TC1RAFSDVA?=
 =?us-ascii?Q?j1YMd+50H99XEQ7Trg9BxQ9tZyWliwQ0vZG0IVYYWJDETA9pvnYPymNimG2q?=
 =?us-ascii?Q?jjRJH692X12yd90pdkO88aREo0NWQdUGhTvD/nozV3ahnVw/Zm2G4GbMkmVv?=
 =?us-ascii?Q?yy4UBP3vibNvIUcswoapULd9LgqG+fZ6etkZO4vmPCjjphE2+IA1oC9cQQP2?=
 =?us-ascii?Q?aNO+iDNUogpkG/mMVTGcLV9rDAJ2rGTnaScpuTdkXWLJ1YOaaGsxFrNRknao?=
 =?us-ascii?Q?bIzCecYe/1QGI3ciPSnFkNrkiWT8Dm+M+L4NPo9C9Fz8+ENOLOZjpG0rVS3M?=
 =?us-ascii?Q?hfBI6q/36W0Rx9xTGD0OCnRWsZ52V+HYRL1jFoC1e29GB/TidIJOuy3luBU6?=
 =?us-ascii?Q?+LtUtbwQn5jb3tNr43D5aE+CjAOvHdNoZQ0km7RBN7fMkDJxlDMvoiHS9Ur/?=
 =?us-ascii?Q?sMjWEkYjd04+vQE5dIr7dBEITOIs3dn60nFwLc9nazwDoahpxW5uWBx8IrBR?=
 =?us-ascii?Q?PuSHaa7qDpQYhLB0wHlu34+55zfcXmrzJf2l4ELKhCkG3H5iwOS7eEYc329c?=
 =?us-ascii?Q?vCV9by3o2UmjUB9HWp6Yig9TAp9crjzl499A4KPs2dn3D6Ln1o1+umAhdZ4l?=
 =?us-ascii?Q?LsnSbhemrWtV7TmYMiu+nNiSdU3ZL438/l8irdE+6p0NGXI3SS5VE9FrZA37?=
 =?us-ascii?Q?80t3T5ZhOvmG8vvicKfcEGPBSoDvd/J1MCatGPE2OwQo/vbIiGdPpZGI/3oq?=
 =?us-ascii?Q?TbJk90tWNQSK0Wlydz61VMEfcAiMv7c5Fc6ErIfJCqd+pNS1pDowbjLvjpqg?=
 =?us-ascii?Q?h7X/cSOgWMFPzcbH0DOh2dV+d3PuShq7CalW0Ysc/n/hbmpmTAcz4CgeZ/tb?=
 =?us-ascii?Q?blZrp/npZHcxVrfvonp3oWfCny/qFx1t8sSrBN77BkB2uwOEyJGpzsZchW74?=
 =?us-ascii?Q?1Xsv/KuxNfWSC2ReM5OYQnuJSJIVpMhsVDgRdQbsz1A9LHOcWmkLLUu6J8nA?=
 =?us-ascii?Q?EiVv0i28uratfumszu/siZLmnGFLieJeD5l/wpDNoIrjaiZpj/A6/YHp65f1?=
 =?us-ascii?Q?bsiezjXaRsnGeMnrlrHnd4S9wOpTZRCUHkzxSkcrUT9x45QtE0ipOyUy5wxN?=
 =?us-ascii?Q?RUeyO2xxYpcJ3MKT266jbN1ymUJBZKiVqYard1rtMcAak/NIY+A7JgTpKHjF?=
 =?us-ascii?Q?AfNa4HlUvwym6xHFZkcA2rL1UF8hf1MIlpT5vFwkQ1uOiCmRfooG1Lq00Swo?=
 =?us-ascii?Q?vzK3tF5lnsFF6Di9zcIJUetZnLfTWrknoTrzNMb1U6xd4aJCGwua7rADtbr3?=
 =?us-ascii?Q?0jhJGWSFM6H6xid+jMPcIVU5YO8pHwDuFF2eWErqwpicTG+y5BeNZw7Q5f4g?=
 =?us-ascii?Q?qSOpw8HIvPRi/j8VseO1r6KMyeeAV8DfKrTmR9JSOfFREwyM4NH1QAKR5T67?=
 =?us-ascii?Q?OSj18T2ohtu9AFga1liQWtuI0zkgy3dbQPxF803hOs74uXXJNXxe0oOfZGcr?=
 =?us-ascii?Q?9aAkIcG4ND1uTBN0deOX232vYEnacZ/pCTwmmW9b?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7adb77-d69f-4517-502e-08ddae5faaaa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 12:00:06.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DvOjDKloOBMTZZdvTTAPwjuz5dvrnmk1Vo8qxnXA4PzksN9jXCTax68PtRJs5pXYHYZmEEnAiWU72zm9S1nDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7283

Replace direct ternary condition check with existing helper function
str_plural() to improve code readability and maintain consistency.

Signed-off-by: Li Dong <lidong@vivo.com>
---
 drivers/mmc/host/cb710-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index d741c1f9cf87..52f9cf7dbc7f 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/string_choices.h>
 #include "cb710-mmc.h"
 
 #define CB710_MMC_REQ_TIMEOUT_MS	2000
@@ -215,7 +216,7 @@ static void cb710_mmc_set_transfer_size(struct cb710_slot *slot,
 		((count - 1) << 16)|(blocksize - 1));
 
 	dev_vdbg(cb710_slot_dev(slot), "set up for %zu block%s of %zu bytes\n",
-		count, count == 1 ? "" : "s", blocksize);
+		count, str_plural(count), blocksize);
 }
 
 static void cb710_mmc_fifo_hack(struct cb710_slot *slot)
-- 
2.39.0

