Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC8202F70;
	Thu,  6 Aug 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033372; cv=fail; b=kHghWHt9JifxsLdiuOSDdfzoXM3WDcFH0JyXADS7j/Laq3GU0VnNMYfGs+gNuQ+vFze7H1H3iACkO430ZflqKJZyaNOYrvBS4Mitaq8gVxRg0RHX5JXSpDfxTpJrJub3UN4LVaOeGwLGTWqZCXrOONWNdLGRKW6H/Y/S/Vb3UQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033372; c=relaxed/simple;
	bh=L86gMYfTNt3b/16KeFPu1yWye5D2Trnnv29d2tUJlUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoZ0qB950vgWmVjS8caNu/Qz+xtJS1IL+PvA0RItQrOfr3FsW5CG6Te84lPrah9F7j3mZN5l3aerYcGBEzP44g2fAtp3Z5jP9PjfFlxgM4zSR+TBVf5NGiPVaJSSZtTDgKjeuNdof3xyJoj/f7N+M1Eg8PAcAqEf8tXCTfQwqKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GOXXol/2; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PEyIKai1; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GOXXol/2";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PEyIKai1"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EoXat529860;
	Thu, 6 Aug 2026 11:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=G2G74MyCvbu3tCWT27YhnmQTXF3E37fqpLF9vIlkR
	Bo=; b=GOXXol/2n1aKCn6ED0/BX8SVH4tJyDM872tA1VOY56QtZIAgsZ2hIVdpy
	JLc3TiDXIvxJKoNbyp1jH31n7eIACwmmKNQ16pL3KxsW08F6pLngI+ztR1u9b27H
	tRXudDitt/UQqrweRpZveNpdnbInGWEhxzcS4KAlIoxFoXnzHqmolxmYOtNqdima
	qsWobM2Cwv/HgZqRwlD8kPa0QyABB1S7gQr1CCtBJPntsqeicCr0llKy1tDY9uB2
	d+gEE+xOw8MK+9/AzanyIb8XuZzOFLoCwQosNtgm3AtU38c5PZbbNGCHN+GM8wrn
	19Ntn+rEwbzw4x4UaXpQJ7AKMkaZQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fvsrf2bqp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:22:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfBcwdiIAHqLguKkgDGNZZO3QaWY3FcF6kpiakeiCERTHXAYhCBMNYXl77kkeVjgPyL/PthQOzntdIT9ils/UaA+ucFclsNOo2yHyyfRop05fxygRT7vXCtefixB5AdOrd9lEMG/utpmhm845lLNz++ei0UCdtjitYSVm8goWjqXI8o1UVBsK3s6PWq/+H8qbWOalSHiE693fNFB5zNybBDdcM5cTj9ykihry2pC/PMcEfI6ugTdV5g0BIEWVVTBGQCerY3qlTaQnJIW2bXO+0X7Oz1HHAOE4KnCJ8rHF2Z/EELuDV1AOidBbiiRQ45Ebl/jLtlOJIBdg3rALOStag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2G74MyCvbu3tCWT27YhnmQTXF3E37fqpLF9vIlkRBo=;
 b=ZwhC1Bzt/XsyjhFuxwac64JiNDM5DLvuml/U+RT62LzIacpqmHZa+9+WsDs2HDhWiifl/jIersfgKDOp3Bci00sZaoh/UQ6Ogt0/mCyVCvySsunsTs61eOdLqAc4Xd2HEZZcK+w73lLH8OkFylFre8iXH9p2OO2MG7RuHG1YqgCB09ekRuiHRzjfVuZ7/3pQqTV9xvJSkgNjGXnOyZIMuXGLgZuCGEkp+etwuRUMIdSFhLB/2ysMf0k34j5N1+t9xG/3sSU2MYjZ9HHAt2PjsdyUVJgumHivXb4h6vdTDtvnV9VhB3N8VW/R4r+dTfZwnrnZDvllnqouQQ4FbAmgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=collabora.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2G74MyCvbu3tCWT27YhnmQTXF3E37fqpLF9vIlkRBo=;
 b=PEyIKai1UV7tMgd9lpDoKUDKr1nLAnU4GJxa8tJq5oudXfMYKSWO78eIQEt3xp1SGmIaS5D+kF8ffbbpwiRVdWKdPQ1APT7s3erKBngpMuhasEJm3O6jVCeoyBzdp8QlFWzQEixwvibBgxtBYsKIAyEms21YDKDg6TAG3AmBpz4=
Received: from PH0PR07CA0092.namprd07.prod.outlook.com (2603:10b6:510:4::7) by
 IA4PR10MB8349.namprd10.prod.outlook.com (2603:10b6:208:567::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.19; Thu, 6 Aug 2026 16:22:40 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::75) by PH0PR07CA0092.outlook.office365.com
 (2603:10b6:510:4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 16:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 16:22:38 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 11:22:03 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 11:22:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:22:03 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 676GM3XJ3627950;
	Thu, 6 Aug 2026 11:22:03 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: [PATCH v3 2/2] mmc: core: Add power-off-delay-us support
Date: Thu, 6 Aug 2026 11:22:02 -0500
Message-ID: <20260806162202.657512-3-jm@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806162202.657512-1-jm@ti.com>
References: <20260806162202.657512-1-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA4PR10MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d3b6df-31f9-4f68-8d19-08def3d6ee8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OL6KgN06cMDqbbeLBFOhlHtKsluPiMx4CsINFGT7ZTTjFZZCdP7Zod6osl3HjGUL7QsJZmkWoB5+eAKFmdNi/Piymzw7Is6mJeCzm49TVZr6qEXEFN8WuwfUrMFImpkMkaHsqRu3hwjvZfOmNo/5HGbw08PmoTJnPHQ7QRjlNhd/vBr1cZ7V0ziXDkGs3+MwSTLRJtDZPzkmZklTqK86IMQ9WEgIc5+z/4RtUD0mD5/wR/Z5ygTacxrVRvqxM2jfWnkxuP17rKubmvxyegmIQ8x8bGUNfsczftG8LdSE7TCAFvZzQMM2dTWNeFa4aPHqKGVcKNWNngH03ZU7phvgTOTKGvhKBX3VQSQaoHeDB3E7CQ1ThOD2P74SBaDBV2AFIdjiSQmSEGNcYm7cZF6RWNyit8sfKfazSnb4ylFGcYf06fv6161AjixLKnineYJlUqkfAllZcNvSG9kTCyNKCku9xjbLEKDE4NRvM3gkidKPe0aJ2CcnAO1IgaAN6V/5rvP2Ks5j41soru0xnyJ6RAyyXAgMYFz+Qp4zc/WuhyWMwK+DQ8tkrnEwqwZqfUtvP2AwApQvHEQL8FZBmrJRa7f9eS8ynb5QQIzO8U/juR0xzvgcBnt6heBxFjhKvvY7T3xFaP2KCyEBqLs3izWWTvJpiMZ767lgi+kIkmIt54cANa96LRn5fziTMQ2gWWsDLNUe0r5DSHPzk7MWT4twSA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h9Z/qgiHsu/Hq31vxT0Q/MvocMegmLl6TZysyPAxQipStiHmtQOPNn5WcNwr1n4ag9Z5VdL809XL4IsBuaOBKl3RjAwpddFYV+pPgMFnknpwV0jrLW0cfz7OmjAUZCqFKHOS4JgKwatOKCrWaMP54VKJ1NWsDv2MRVbRBbE2YAFj/NSWfm2JzRSfHBjVrI4Y10uUqSzVydo8PSG2CMc/m8Aa9xZMsCWHMrBrfgyRHUdzxU8mFO9kvG407JdUV8pa691ZL4fYOdws3+WDDkN5kY4BwO38Q/mAG4MyjcnHO0JAclnz1ZMT2jiS8nY3wiQXusxoDnJrFxdHD0r7N7X2To61TxYsgetiZcc69SRIfcqSt8jHCUcjmGf7dTAz2E8GVjJgYaTKhfaWOiPNVzop4044rUajD6RVGK0r0HaRBdVl2OurFCWqc/Bd4MyjNy9i
X-Exchange-RoutingPolicyChecked:
	J9LWiWbOPhzqt2RldgKFbq9c/23qW2mJ0Mag2K99FONuIvcWn4H9mGbzAuya4UoXpEXx0rOQrrn1OMWb8OKyC13tsZb9VA6Ne0mm5lJyQ0j1SbOK4orVMeWaFDOAY3NdIXPKgUT0HRclvbLbhA1cqXZjCVwiStTWbgad9MBD08ye4Sq5FF4XoUhxkaXB6ZWQIU7uaxpQA8oCmOEA814o8iYA1/mUkh7LpsSyzMND/xZ/sH3CK/ubBNG492SvV/7Ws3FY2n4BOw5XIAFPN/uGwZ5F9ilD6+f8EL+FRRBy3ZhFXRp5/EPtWluH7dL5abMtEDQwMu+bVze0MySgSOqyoA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:22:38.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d3b6df-31f9-4f68-8d19-08def3d6ee8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8349
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX8MckqpdLlQEk
 hz/lLUx+VzLYO2+gtVpf0BFDBeL3qxMT4G+LH9krphhNgeW1gers9OXHYKrNxrlNR2NToj6z2aA
 yaIcPyLzdswbQ8H4BS4EzB6UOPq6TyVIWlEi2kj8jEOrAvSbx6cPUH5jyAx29n3EE1b3lxC5WRz
 C0dqOr5OGRp0Tmm2N1iTA0KHGSXVFPJI92nGUTh4L4Fg1s32VTWmNItXs4GIahLK6IS41/g3xkt
 mW7ab8zM4KFzIYpf535ZUhSZj+OaL+wXIdwAZiOCB6YcbzLK+YNJa0UIf16MNDCJTPV+/P/F2Ru
 kNS5f6oXHq1p9q7jX6+tkNEZjRamfxXAmqAOwy0ISZX6Gw4HSCHy1O6Vv38fdhv6tQVbE64IuEr
 GMSjeq6hXkZQar11a7K7F7EwHyR6PRbq6MrdBpxyDLJuVu2yhK0BHHgQV2KxtokI7P8n7kyN4Q7
 E1f6za54ubsVriDOaFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfXwFmYLavKI+0I
 o7ADhHgGs+zCBlUoEWIrJLMTg0CpBMlcoUmFwyysnZrahGJoWg9nzgWis2Mf8Vq0k2yu/179Wjq
 le72JLByxtdnTBY8GddE0lz9F+B7Gsc=
X-Proofpoint-GUID: 3GmZjojg25AOg67Pb6s1klxPja7j0kXO
X-Proofpoint-ORIG-GUID: 3GmZjojg25AOg67Pb6s1klxPja7j0kXO
X-Authority-Analysis: v=2.4 cv=C+rZDwP+ c=1 sm=1 tr=0 ts=6a74b4d7 cx=c_pps
 a=puQxxl069aAozDPRWZ8vNg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=4-rhPllB9GzNMvTH0ekA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060127

Add support for power-off-delay-us which shall be used to specify
value of delay after deasserting power during MMC power cycles.
Default for delay is 1000us but custom delay can be passed in to work
around hardware issues such as slow RC discharge on MMC VDD rails.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- Drop < 0 check when parsing DT property, device_property_read_u32
  should allow only positive values. Change also per Ulf's review
- Remove upper limit check, also per Ulf's review
- Use fsleep() instead of custom logic in mmc_delay_us(), per
  Sebastian's review
- Return immediately if 0 in mmc_delay_us(), since no delay should
   now be valid as per Ulf's review
---
 drivers/mmc/core/core.c  | 2 +-
 drivers/mmc/core/core.h  | 8 ++++++++
 drivers/mmc/core/host.c  | 4 ++++
 include/linux/mmc/host.h | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

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
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index a028b48be1644..601c73761e886 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -73,6 +73,14 @@ static inline void mmc_delay(unsigned int ms)
 		msleep(ms);
 }
 
+static inline void mmc_delay_us(unsigned int us)
+{
+	if (us == 0)
+		return;
+
+	fsleep(us);
+}
+
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void __mmc_stop_host(struct mmc_host *host);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d4529..ac1846e0e7fbd 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -421,6 +421,9 @@ int mmc_of_parse(struct mmc_host *host)
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &host->ios.power_delay_ms);
 
+	device_property_read_u32(dev, "power-off-delay-us",
+				 &host->ios.power_off_delay_us);
+
 	return mmc_pwrseq_alloc(host);
 }
 
@@ -574,6 +577,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
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

