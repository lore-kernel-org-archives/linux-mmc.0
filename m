Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170B394470;
	Thu,  6 Aug 2026 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033334; cv=fail; b=oRTernOO3InAVJ8hv2GfO57Aeoj1sdOb0tZBGC9K/d0OYKKGO3nSRxI6ToyAdQ0f6GWzFwP1kQeibBmQvpICkO/4lUje5S+i24yTmr4atim7q9e6jOui/WZ96p1z+5+Vqy/hI1yujo+zrp4CHIAYiEdzxEJ1JsYByq3Iz+pE3pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033334; c=relaxed/simple;
	bh=MEw5khqOhvn0uqv0Es4q/kUVJ7RNs6CARJHFNVS7qq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCt3/+5TkX4KY4utpHpWtU87e4aWmBbMyxtC1gyTfQ7/n3S+6AIVgAOryLMPuW9LPufV6t+B045XWDQAGT45dJaRzRR5JjQ4uHtZE8Xm9HP6qSGQo81rYFdL8+pdvcd0UJ3ZJDxClQfztqIYfc6fmIDfZysRIIFdMC2lpMsKfzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=KDCL+4lx; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xhLPHUig; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="KDCL+4lx";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xhLPHUig"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EoXgE529857;
	Thu, 6 Aug 2026 11:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=pLeV1e+MgX++LhrbBP9xXdphugJelb7f27vdJInmM
	tI=; b=KDCL+4lxq1xkjHbTo01ipD5E0X0cj+/izqHzx2I3RsSAuEwwiF07LUaRz
	TyPx+TdS88P/U6MN9qiTV28Wgh1W0TUElYeiooOkTZQCJQ36o2FvTldF+XQzNa/j
	2CDorjLIU4M6aJ2aFf8gLOIeHZ9IpB2hYarbCVyZy0+gAEfTr15EM5DmHn9RNHmN
	q7RM65NZD/inLO6ig3T3RT7nZ00eCjDsvykFpdCo3wxM4snmO2tRRfnBU9Tj28R5
	VffU2odtmd8RHd/Z05pMoyzawP/kCxS/7SdbgyUYUZtXEko5HsG+FQm46oQcEbzB
	PBI6sLq6uDHDlY/faypbio/NRmrjQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fvsrf2bgv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:22:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn5hSjxVtGJljvVtKIoBOMAlRKCddsGhsOAE/X9MukRvDYCv8DzL9TGKwHqyOZDqclGtoBdoiwY6wbDZdczV0OBsaZWG77Iuzi9Be+jWGTVbBG9y4MZkzn04UjcWzgzOp2PxSwzxwAgR/+4TAzKGo44R59KA8vuo9bXJqfqhElvCRQyapNOQ1DDAYOBmK/1ve3KLNuxK1abVFU+J/Zf/Wsz6GM0hWMGvl6KVVwJeTXIas9Ja1/w3G3esUNQAiINeehaMmim6nUBLeGaPizuiZ/wdcX4CC6nJyg8+lBzJhgdgYS19jQl9V26mHDZZ6kGgaJSEc5K4XWDyzuTzKcmt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLeV1e+MgX++LhrbBP9xXdphugJelb7f27vdJInmMtI=;
 b=lBzyIyqM9Xv8ISATJLPwoKNwbglpyJ84nHNT15deG2ZYqpHsNtndOP1p6Eu3a4EgBc7qthMekJr2QUGa3SI1hWNJnYGaS7rR9eFzL3w3eVWgQvjo7iKPC4sIVLcwP2OEVtEw9FRCWf8vVZKA2l7lVXQKRT69kmawnNUU9mmURt5iACXzAuYus5V9VnkdVN411VDR00CFzonB8chZ6wyjW1hXN4OmxOpOdHvn+9iX2wAWmNEXMH+/Xch2yM8cJerKwLPE4+9gxsUcP9N09JUu7sJpxb/7En7JDxBWAS8XguOF+pm6VRfHHEEMS+LyniSV2Jv6UL0nd2tkYMQeUwPQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=collabora.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLeV1e+MgX++LhrbBP9xXdphugJelb7f27vdJInmMtI=;
 b=xhLPHUig/gp1uJ92HwiaJv8nw+8ms1Bmf7Vvdki+0/w36ErCH6Jeka0wDlk0MXbJp8JKCBYYWnbVn97UTwBa5o7Z7/tRWRgoqBwKe5535WgacUYda4FnpMJvBueyg/Fm9PYs8S9huK+PsitmHNi5dQDKfkJBYhDyzQ+IC2x1Oto=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 16:22:04 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::5c) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 16:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 16:22:03 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 11:22:03 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 11:22:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:22:03 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 676GM3XI3627950;
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
Subject: [PATCH v3 1/2] dt-bindings: mmc: Add power-off-delay-us property
Date: Thu, 6 Aug 2026 11:22:01 -0500
Message-ID: <20260806162202.657512-2-jm@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa17714-e6a2-4234-09bc-08def3d6da15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Z607OVi9ELglClZHdehBWdfhqGq4MrMwU59vgJh0fa2Aj0o9HynxpmNmzO/qS6TMhkMVcpjZ7eLZhDZl/rqehWjWMppQyj7CnVpb6Df8j+bWX0HQQvvD0VYP0brwxE5KUzCXsw162QCRRwczwJexhav9193tKx9MKkQWGmsG+b68XDfneMuvGRXNNKYhedXo1j1q1nlm6uqaAIMQuQ8wu+Q4LgHH/eB28UggHOygs4rAeAtcuwieh7OYw+8gl6cT1lQdE24EdEoWyQh7u9l9TG+Q9gjcub59moSZqSrgeN9m/VCISTBgYPNkHMO+O2bDofsUKpfTTxu8SlN1YKcbulDWw/bwobwUjLmMJvaRHtpSyxuZECC2mGwiHeo/QeP2XQhf1nlm0Z8wiZLlM2rh149pdGVXPlN7cPuFgzl6eA3mK00Qer+t/ZzQgb9hR9GUO5G5n0mtvU2ZmjO+AiKE0RyyZ3vB3mjDiAb/i0APVEPpw03UngkDkjabMU2S1prMV/kYEWd4YEXAXOwaa7mXnHb02elPr7780MhkMAoeYQvk67qrCCwoTzHSmDjHSmlJBe9wj6rlLaeBEoGzI+fYQGKR1bsPAflE2sVODqYiyFWD4bgII/kf+y4Vw9Yjj5snGB84NPHySktyzbRpU02reQ+vIWmwINc7rQvtfmpB1Q4q+6UT+AWYLIoY8Of1+FT2O4mFUfj/0GzWwpekMObN+Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X0qirOXCQpLW8mKu41wCau2ImUZAb/z5ah9I66DkWc7aOzVAMKPsfO45M/8QDXrjpUJauFphziimgh33LFSHDAPut1Yj1ADzu8epoQKvCLA47JkUOuSleMJxjcrvxmrUBq67V5bcDRdRwF5HX1te96kGQTZjNv4H6qKw39D0SqMdpz8uLruCrZqp2RxSxNCwBMOfUDkO0sr2qFgWJUX6fbDaQrT4aBnbL82jJ0vsuJwjukkSeI6bCheqsOZgYkLfNM8bQPR1BBycs+Au9QpEyvfGgR/xVuUPzlEf8+Quac14dWAerQ2KPKuO+QhXJSQkvwclaPkmL93ONMoIvpnmXsYmWfMvX3lAY8CfOBalgRUD3CtEKzBy1k5Ttjp4YpUAU22r/gAG6ypMeHBm+R0k7KR8dqOLeDEWgd2KY3rbdr+gvbZoC/yzHFIsDe1X+r4H
X-Exchange-RoutingPolicyChecked:
	gnJFMA8K4ODJSI2mN70U/IeBDKC4ccuWnv64r6yWg6OC+00XR+MknNbS2u3h8+xtePVPDxhE6vyUHDKqeCLcEsCrs8KrhrEIn0iIf3xs/A4WYexebWpVUqNsD2yu8q4wX2KKWeKJl3uRU9FT+DEjmnr7qJZZM46+N6godjdjMGPXX7959VvmQ3anlSvUnFsrcRGDD9xf4n0jHXb9eyftDnZfY4zJy8mhaJK+oY1wTgzwi64PSnDem7MrWdvIMPEIRaZAepNmJ7tthJsiwxGOUeR+EmmS5qHQiwLrVjDEaaIRpDQH9Fu1aUn+YVpZmq2PG3VVAwYwcZy2xW9bObuLtw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:22:03.9435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa17714-e6a2-4234-09bc-08def3d6da15
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX5WKYkAZJtavj
 b8/4L/Y7LxHatchz9o+q3LEaEZNVQBVdSmOKuxp4wNmJdhSjZNPnvOvLB4LC+eqhjrafcr3MxBN
 9UtEztachX6sALfNHGU7X4v9lFCvYJrdtDcBLs07IGFsC+IigG0Qdzvq31SOU6M8rBkYv8DtNzr
 a8ZZZEzO9XdF9Ol8Y58tRYy5eFpCYEsrHDqNyjCGgxMhAMS4aib88LUNH3A4K1GwJ+0BRfHFX1T
 issxeqb7HqmPmGUrDgyt8fgTDGfkSi+44cbCylRbFLzJxad5CZ/wjK9S3nci7a/3JUOw0kuZajY
 Ki2/QzKAb8COqbB8w2bnmgzU8GRBNkm1PWbEVL+CMvmLivDl6jKjLsgdmoV1m7oHQO8i+baeY13
 c+cq0Zg5Ml5lqMYFRcJ7M/+hOW7QrlI4cy1qPO0HUXOV00W1e2fl13sdVEUGsMiYi2qZZEW4NWQ
 ud1upsx3JIVEfXJoZ/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfXyzMzBRZBjaA1
 PfHhU2ieTqu/NvRaKChJUSJZTeQkTn4J+cY9T0K4wdkuc4COmRcdf6MbjD0SLY0B3x1ZW457Ul+
 JOcySFYZ8SumUZFQ5IotFefKumWR2zM=
X-Proofpoint-GUID: 1gIf-Qi7wOACdJrhJS53ghEa-DdCzVx2
X-Proofpoint-ORIG-GUID: 1gIf-Qi7wOACdJrhJS53ghEa-DdCzVx2
X-Authority-Analysis: v=2.4 cv=C+rZDwP+ c=1 sm=1 tr=0 ts=6a74b4b0 cx=c_pps
 a=NzAOMTrFL2nmaFUJOsdohw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=C4jtwWyuzctMWfqfuQ4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060127

Add power-off-delay-us property to MMC controller common.

This property shall be used to specify value of delay after
deasserting power during MMC power cycles. Default for delay
is 1000us but custom delay can be passed in to work around
hardware issues such as slow RC discharge on MMC VDD rails.

Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes since v2:
- Make minimum 0 instead of 1 (for no delay, early return)
- Add Rob's review tag
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c3..8b9b3b0361296 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -275,6 +275,16 @@ properties:
       not available.
     default: 10
 
+  power-off-delay-us:
+    description:
+      Delay in microseconds after card power is deasserted during a power
+      cycle to allow time for proper power discharge. Larger values can be
+      configured to work around hardware issues such as slow RC discharge
+      on MMC VDD rails.
+    minimum: 0
+    maximum: 10000000
+    default: 1000
+
   supports-cqe:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.54.0

