Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EC34F24A;
	Thu,  6 Aug 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033384; cv=fail; b=p9N1oq86kUkV3IrhIBJUGtFJSzrQSJMQyfKXxaZlMcYStWu8m5vE7DLMDNldE1Bpg7boKPkNudP7OQ3zk6TaQyqvQnG+ypnBbf7FCORboAgXHXp6zxa63vpBJ7Ek4ptv2Jn4u0TCUySs72xgJAw9nVHIYcx6KFMenNMb4sN8llo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033384; c=relaxed/simple;
	bh=IyxULBJyG12JaKYfaQXXve0QOfi8AKcKnVoAv3GP+vI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SyT9DWlfAQw/tzIqawO/2hKFDW65cn72edbJU+Pl1t02dXkOxETMW0RgBRnBYIlUt4kZZtAFDIyVGeZqSLzzuvEVzMwAxdpqND6WeTdsNHhH1avYbudNM3pzDy82JPR/lVwrCUMEvdqGcQrKHSHZfLkKWRKjoss0FEWNKD7A75w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=K+zTIYZp; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i+sZhaxv; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="K+zTIYZp";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+sZhaxv"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EoAOo177122;
	Thu, 6 Aug 2026 11:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=3eDNtATNh0iYD
	HCBkEFT9dF6mMoygak66Tn+Od9wfkA=; b=K+zTIYZpbydcvSr+M079PiTHmT7cA
	odguZlyHK+M32L4lDKb/8wSkpSnsposP8o/C9A4qccsriEmof3F/f9mE7MVlehoJ
	MigYSE152xqO5WQbnhCp4H5gqnas5eXEo7cedmY7QOr8AZm69Nka9D1JkuwnVEwj
	KClR+cwGdy6w64OMW55zIuJLb3HYzh8XILYc5c5jUlDeCHc4/kvfw9TGzDcnbDEX
	gH+GK7IXPvaXFmEckcfzxFyjhs3FKXyKFobkRD99OGW6WjxgZK3z9WdMEvfLsAEV
	dieGrKoTyGWxYa4Hz5fu+SbsLIXdCqywQzfqBOcOlMM6epMdtdIR0ebww==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fvs73ahkf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:22:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCEvY74aIlkAOSlm30Q1tK92ION/eTPo51uhfQQhuZaOVRdNZyMVIdlx5YFpb9CDuH+EifhsOK3H3vjVSJ67U/95OVhSxOXNVVeCtZSNAg4joUppMcJlqPwuKv50vyXmPdWSkooGfjSP6i8LlsM37OZ6Gx+o1+XKQoPurKmujsDhuLCQICY6tI/9bh0HCF9Y//Tor8/uxi/nGP1CrcW1eY2IGSOhsaSqlUQYxEjCDoNqur7XnYvZbPJ5R9JDs732Ud5LSFbtYq8AH3j6hvyoDU/ME0zxRAcHTcnroC3U2blrEl+paAEiAnOJzjBsAAftCGjE2pzEuZOvnn8xfNJcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eDNtATNh0iYDHCBkEFT9dF6mMoygak66Tn+Od9wfkA=;
 b=cWyqp6eVaQQziwPZwbeMk1TsJpecjejsNN7n1jPs8EyN91ZUjshpBXnhRa4tCazPU91CjzXVhPcngVO1IkNGP4qVZBjwTYO79boCwLMJBHlmRojWTtZHJsdos7VC0IrFCp5uaAsawUueIIaYhKw4zw4f5kPvDRvPNniY8QBKh0KL5LY0TaCB8iEkJYnCuQ/lhkjCDs6wl9fhoBxlxBfnrRzuOpmfYXWJNDNGQWsW1WsU4AnIII2EnYNNKdERf4D3uoREQoVlfx934omIoHvdqgZb2+tIn9JGEVaGQCv3+ykb+IRjNohbU63SALfepJokGnAs6CaPGsHK1zK1eycOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=collabora.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eDNtATNh0iYDHCBkEFT9dF6mMoygak66Tn+Od9wfkA=;
 b=i+sZhaxvDOjEm0T2jXFQ/pOtCRKJmOu34QUtfoGgubSk+nQKOozkivW2Da6nXRK85KBMg6XZjO6I1oEpy01blFhusvbC9mphU4d1NOaV9RNpK2SF4pKKNnwLtmwEsYyNmYSRY3lEd4EMZhNHl07rXFGgxSpZHGVhEDDHihlIFKA=
Received: from CH0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:610:e5::7)
 by SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 16:22:53 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::9b) by CH0PR03CA0242.outlook.office365.com
 (2603:10b6:610:e5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 16:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 16:22:52 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 11:22:03 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 11:22:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:22:03 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 676GM3XH3627950;
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
Subject: [PATCH v3 0/2] mmc: Add power_off_delay_us support
Date: Thu, 6 Aug 2026 11:22:00 -0500
Message-ID: <20260806162202.657512-1-jm@ti.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3878537c-526e-4cfd-9882-08def3d6f743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	N1pptNkVeV2/NN86pGORLRkaDVN4RNb3FDOHkv/TbehKkzRRlMaUPddcWG2gjUXTmE1TzDvQnXOzNGkL7paoCp7vhXG1tkMyy2gfVAoHP48BFaDDBCQE7A5sf5ex9Hg0GlyjDyqRVm+MiZH7Q8qkrfcngRIUdCTUo8EjL83de15ztodjXGcGBSf/EkDwf1WXonpkUE6Yo8emENDqu55+cV0PziwnYfGxbDmfnVwxZZgdxTk65rKaNGzhjxxXkFUpWJfs7JxIpW3UUwITcSSbIw/2OGy8Ast5NYBWnQZ3jLDQBZ4M+5UlhW4mtZSRlw7NQqG6GSt922xY5KY8qdE7DtNmXPsloIHCrJDB4mcId4Z4xEOamu/pc3c0uCb6ftg1oa5ulIH5NrwQoo7IjbNO3Z0OlwQg19S8EIg1XbRlI17V6W2YICglYBJ8kXzBFHPNpgIe9wWOYXp5DHJOgbPYo3JZZzE7KyUjdwDL+X2vfg8A72D4FRHlaOLf4zOtJheOqwsI6m2+K5YM19J4jQUs1qM1D5+tFAtsoFKIIa7xgdHikl47jH77kGJNp7C6mlNBXaRgp4jxrMYwjSgmK7z5VCLHnC5r0yQi/EOHBIhR2tb0ycDugI2OYnWRBAa9wGmlYFsNmEMxaUZ+5ojaMYgk5N48PiaOouMl9BmyhHzG3M+QL4o8ZgqpP+FSVu/hGN5bjrZLHDNJ2Aji8D+iRTINIQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vB36VBeud1wJqgbH6M9y44t65T09DyZ+fSKPJjHl7oFCRIuP50cQuU9zqzyKcnk/eA1invlfLXgKy13PVLX3LqDvMXzqoX+Tcm53VQ+NmeoHmk06BLXfCq2G5eawTEYkYYIfkcjC3AdIQPn70iZaWGKM4CpI56ZF8Ug2Z5DkKw8X8N0DtyHGvXAqaBk5vUI9a/nakvtZGUAKOHcJirycPPTgFihgHLKBIRxUntFMfY9g4ooBOW/d2bWeebpVhJUQARgDA16oU+v0iTwT0d58FpdPW2WUNbVtN+EzktGLIzGsgnEdtHsgbwOY0lVsV2+cOq0vJTE7nbADLYIkuvBtIxQ9Hb++c/hWBEJKdyoDwqtGEvne0oej6TggMOHx0idoq7QCvIAG5KCqmPEF1HvBu9CREg3QMSfiYaqJg2ZlfCjJDrtPl8T+QhtDxBAjg7NP
X-Exchange-RoutingPolicyChecked:
	pdzyr7sLMFRsFgOq1xwjrL2QVu52qwvaIm8RkxxA8RWqJ7lFsOpcMBvc2FuPq+Ou8SBR7C8PeJ/CcHZY45di8LZdC6MA5w95asms4roRaLTA3t8t9OL5SUH+7PpQBMQUREOsDyLEKLwKicPbBPTJhxx3BRm+L7B1eathvuzImAgJKu+YQDug5uAk0mlmcxP0YWRuQ+rHRt/zPrKryTPzOEOSkFp5CdqtYwE6prjScj9BlnHa4wx4OlMpQko6YLpRT7f9ayt1Ri5/O5LpfNp6/0C5bqKVGO07awcsCLt7QLXPbh951bTaaQ2dusTNX82hULtrmPiQI/nxgJ2bi4Dr+g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:22:52.9128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3878537c-526e-4cfd-9882-08def3d6f743
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfXye4D8QQwu1Un
 5qTQT17rRcYBcoFIDXKSYLXRll/SQmZVPCTqxcyGLdQuY8Lkbe6gyNLdj/48bZbhBHWAWYOp2hQ
 Np6Aj55Ekn91XPE3i2GHtDlW1kcikgTaqCUf3Z15WmZzCN1OKdiUL82PcgCUefB8QRkeNLntXGa
 DwrDFWn6Tvumw2eOz4VOfOqvTqGLEHw+GjX8N/fRnzF6L9p2qMVwW25jBBUPcHhJuODE8H++6j2
 kLQS9OYjxHChfxo/dL1uuwolpOJOdmCmpSZJk59baIY14snezqJ7SVvVpr43ydOpy2dINgR283x
 4Cu9YXAe2Wge/win1IQeFQGllppLP0eKoUKj7lUhPFUOKVdAh0PHN6TndJs0r6QT/Vl8vqFw/71
 xr/kplv1Q0DxZt3NfpxeRHmTjMiNOXf8iyU0bu3EwekI2399dkyGpu9kB+tErKRwELSSDfD8fXu
 mlqCvv2lVOKQf0UKhpw==
X-Proofpoint-ORIG-GUID: KWeQ9cy4gVF_vc5T4xMppRC6xlEsMhit
X-Proofpoint-GUID: KWeQ9cy4gVF_vc5T4xMppRC6xlEsMhit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a74b4e2 cx=c_pps
 a=SqiBG769zjf53VTvhFyIdA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=E8uqfyfJU7Q-EQTp0kIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX4ttWt3masLDe
 a3LqhSJ8YvqnWNDv/KoUdJNKBZSbjjQBSmeicDHugAM5S8QgJUBSm9B9JRWvSVZQVpn1CRclAqE
 KsZ3XL7mquASb7LLkv4wdiilkQ1W0HQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060127

This series adds power_off_delay_us support for MMC controllers,
enabling boards to specify custom delays after MMC power off to work around
hardware issues such as slow RC circuites on MMC VDD rails.

Rather than adding host driver-specific workarounds, we abstract the
implementation into the MMC core and pickup the delay value with a device
tree property (power-off-delay-us). This allows any board with slow
power off requirements to configure the necessary delay without code
changes.

The solution is minimal and follows existing patterns as with
power_delay_ms. The allowed minimum value = 0 ms (early return).
The default value is 1000us to not deviate from the
original 1ms delay set in mmc_power_off().

Link to v1:
https://lore.kernel.org/all/20260716232641.2659710-1-jm@ti.com/
Link to v2:
https://lore.kernel.org/all/20260722205701.372789-1-jm@ti.com/

Changes since v2:
- allow 0us as lowest possible value (early return)
- Change custom logic in mmc_delay_us() to use fsleep()
- drop dt parsing checkers

Judith Mendez (2):
  dt-bindings: mmc: Add power-off-delay-us property
  mmc: core: Add power-off-delay-us support

 .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
 drivers/mmc/core/core.c                                |  2 +-
 drivers/mmc/core/core.h                                |  8 ++++++++
 drivers/mmc/core/host.c                                |  4 ++++
 include/linux/mmc/host.h                               |  1 +
 5 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.54.0

