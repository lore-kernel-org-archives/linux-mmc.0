Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012014.outbound.protection.outlook.com [52.101.126.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173C27A460;
	Mon, 18 Aug 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502724; cv=fail; b=BCQkIA+S5d5FsmRDKIcUu3RFXTxlcR4AAlmSQrICSbSE97uml8miD4Pirc3I1Hzn9p8sYok3x8cFLFnz3IFYEaZePGi21IE8K8ClQ8JDqRlNhGvlR4y9qv1AZ/7cbWqqkykfwWdu3dNwuKiHFfkY5vQ/UiE7g4nE3DUorxh44QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502724; c=relaxed/simple;
	bh=qUMUPd/6uIRoJNTVN/ZqzC0+K9RfMT7FBWmvFl9isTg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fzBdjetXSP5Zse0cjXsrWPcxIUDVv9cT5jBO5VuEzaa92AW4iDXomaGUwtbP8Ui+PIhBh0RAeuq8X0+5GoksQMsF8aPDqcJjkWR8Jnr8JOiEnCI6Pjvq81w2SmvmubQnv1KiCpDd5CNg8CnToHV4PAzc9fGRXT7KFvsBXkfHXks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FhJXlgq0; arc=fail smtp.client-ip=52.101.126.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FhJXlgq0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIcZ6MWQY7eOxO2BUIgbfq1ZckdZ958i3LOcL7vFrY8oVxge7VuKU8fi4eoG1U5vP3TUinZN6GBe1y/jcoaHlxPaAQX5AILnZ+8kTWlLAONLOrJ+tYPPEO5p7fwOIMGzJXiSrT2F8BBwIrxgdT2HW1co/mEegqmnc06+yohFZmM5G7ZIcqLQsIrqnpZAI8QjxHQ6cY6ueKtdu/nVX/Q0cYs31KhIJwE1e4HmdQDDdi2IJW5LFShqnt1ebQPRW2aHpsYglPDcV3faYIPMXDTF3LW1KAZhbUg28WoaYzpgnRdXMaWeMjg7eJirwcekthOsTIts8zqd64C3Wk3gNnvEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxqtGFSMgImcfO388PcybkBaQ0PlpoaBjTiqEfe654A=;
 b=wMFRHBUNwtFLG/ano//sqW90pD2UHvUWq9L/Yy5cHEipViXbXsw1lBto6NVHQk+4LASZBranyvVm/kd3KtuqBwJLhJENkYMT0Cl/4q11+IJfF5Q3XKRjNdVJOR6LxT6HWmSmANIWhxh8W4ha50ejFM5M9hXieOA3oIGFKWy5JPEgS1GMbYol/M7qBIyXd1k5l1U9grxCu301rq26v/6f+n7lXEK7d3+MG5B8lWMcXAHJkhyx3JvCN5KbTqYL/o4NHTYjW+XxQRKBEOwkdTKTvEH2Ps6qfzCBZE0vtxBjTocWSnVdOMTez/wJuokRMWtL3sdIkZk7ZD+2yUPj1K2QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxqtGFSMgImcfO388PcybkBaQ0PlpoaBjTiqEfe654A=;
 b=FhJXlgq0Yq83cr8VfnoCBufMzKPwmvVBr48slNIyQNiQbK6u95fufd7WUPSeIJWrMAtegYIEYlA5AH+Oy4JDW/PEqR8Xo4mGEA6Kkw0UaM5alyeuGlLcYnwVe5IfgKhLrwtscCWVECLmUm9L1tAFXHk5mBMHDZDxj38rb0X3f2GhotT6ZNrIjElOXf5EfrS4JL34PTsXgGYrBfboQcGuyfFzabB5YWokV/wQ1ILrXeWtYggDeqqD1W3jtZ2UsDcbCHiQGWYcJo8yrTaUVdzzGCO9KxLuxUGkLH7l3zdqniBGNVnfWH1qeXo/FLHJ42zygnjLbrj/4x79fQ+T2rsQ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SE3PR06MB7983.apcprd06.prod.outlook.com (2603:1096:101:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 07:38:36 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:38:36 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mmc: core: replace min/max nesting with clamp()
Date: Mon, 18 Aug 2025 15:38:27 +0800
Message-Id: <20250818073827.474226-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SE3PR06MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 87108996-a6c1-4fa9-a03c-08ddde2a3d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PwqjI/X6QREC5Vmc3LZ+woceyZuED59ucQEkgXpr3orLBhhnio66+eRuPkKL?=
 =?us-ascii?Q?siYVDY0dtEKH0Um799JrRG8+Q5JVPAv7PRfmgHRTD/GW4e7jH38/25Hzuggn?=
 =?us-ascii?Q?u9yuPCKbsSFH3V7/8J9yfmrfgSO/9n4nCBhI3AJyiKwO/KZnJGIZ2zdLE2vr?=
 =?us-ascii?Q?QkJT3ci+AFj7HXaf4c80sMDGYY/D7rO5NdOIDJDMBOcziMF2K7W465Kw0fZJ?=
 =?us-ascii?Q?siHeXym5Pv0OatjD7zCUav1WQLmhl59Zix2666/izsNWBDeO3cOm+skiYnnj?=
 =?us-ascii?Q?Ujvx1uPRPB7uITrk8RBDMRhqzuHyMXimQiZfjyc8voSnaf7UnvlBeKl4TvEE?=
 =?us-ascii?Q?cpu1Eue0GJ8honMFqOZuNk84DT6tI3JtJCVHWM+14jocu/2n5fBc2ic0nebS?=
 =?us-ascii?Q?8JjQAU3QzCanojGXK5fEzIwKUx7YWaGtO1dmnwqY2sfLV42ekDnVHVwnexx8?=
 =?us-ascii?Q?mW1J8iSI7xQPqWblKgGRn70rklzITaP2iDfw3/CtU49qmjP1C52c53KVP3/B?=
 =?us-ascii?Q?2e9vG68tL11KUy9ed/XaHxGxXw49yV8QLsw2i6ofyQMhJG2Nw9dXdx1bMQMl?=
 =?us-ascii?Q?ZmmiocA8a5XInwmKv0BcamIvMsZUgm86V/P4wShkre0OkbV7DBgaA4N+000U?=
 =?us-ascii?Q?PPzb8fNiV/j7qi21lQxqfmO6epE7+zuNiGwCRtn8nF4lL1SqBUOM4K/RmouC?=
 =?us-ascii?Q?aLfT/b7kmxW7cmfKCFA5S+n7F+m+0x4a8iYxFvrXKuLkpkrp3AqFdTjFEQUy?=
 =?us-ascii?Q?GDboxiAKAFzKTOuwnUlk1PZPy0lCGeFqnzRdG9xRIMO7Q3/nTh8e0InSM7+J?=
 =?us-ascii?Q?ZYSAnOadCatZvzefMaMUUA62+zRS6FwVKVYxC8eBFXgRJRxTOmZqVSKwXQnA?=
 =?us-ascii?Q?dM6+uo1XJqEdk4PSrqypYHvbLDe5zWLag4EzOZkca2tkfahEhhaQoRVC1/wO?=
 =?us-ascii?Q?owGBzwtW7WnDaO57Ua/J6hFSi8oTsX3NE/h8QMQKkCJeJXG5gtoAH1QwnAJS?=
 =?us-ascii?Q?qe2wgK8KBSJ11qQt3ngp8Scd6jyH8KKyf+Bh0fxnqRidBGZYclG0ofSUpRwe?=
 =?us-ascii?Q?FoetyG1yDG/RGldF1693LvMW/VGaWrL+YLa+8vRlmmn3kq0RIk5oN9PPtdhC?=
 =?us-ascii?Q?DTLzJ5I3uIkqh0vRXhQI+tPcAfdgVeiDgzY5p/QXM0UBxV1uMgCL4WeWQIjd?=
 =?us-ascii?Q?y+YPLG5pl40bh5cLW5Eikp3LJjQbaVScCQSOad53Vp0RhwVvhygu7PP2zex7?=
 =?us-ascii?Q?nlM1o+gm8Gz222SvlD+fdi0fBlQT0m6H/xuy4RRZ2tYQANIi+bNYsZa+ivjB?=
 =?us-ascii?Q?8rVcVkE1n6AbS49neneQsJ5Io5ejvysL8gtxf4ELLgQPaLAZBG2uSQDqUSZp?=
 =?us-ascii?Q?puCfZv55wQprIFsaRKiRLfCXmhQPWknjHE/j6EO+TbexF6XlU7yBbC0Ux2kc?=
 =?us-ascii?Q?lrTG5yF0DmgqFdS5w/dTW4oRYxh21KVuL4TKUWuVT/5bUtd9Spw+bECLOTaH?=
 =?us-ascii?Q?JqLQR3OAP1vVFpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ap55zXvvM7qcfrOKCSSmIPYWuDkSk5A04MfR4JC+elaz9dtQ6K0LX9bmqOwr?=
 =?us-ascii?Q?SrCkzbQZV2ZM4LXYqM0gGJaYII9apt3od5NMEjEVG1Ei/3gh6wymz+vbHSHH?=
 =?us-ascii?Q?hyLzJbUAI8soyovALmEyga+dZQK/OP4UYUJ5dw9noedzOjwZnsg1vG0RRCKj?=
 =?us-ascii?Q?/HA3fdhC111VtjoW7SZy7yqgWHPwloOkRv5n+BHJ9UF1vv0I+NvUURIagD4B?=
 =?us-ascii?Q?jyeilxE0NQz2KLGyotmznxuMCXuXIWH+h9Phw27ecEGnOWijt90Xpa8WZJve?=
 =?us-ascii?Q?L7atLkmPzLVwhrR9wZd97tnURRFIWF6bxywTMUJ/2RGM9ZNlWVPrme6iJgQ4?=
 =?us-ascii?Q?fHnLJWzD1JOM790l6cpAhr0L80+RwEhql+2piTG7K5gEed+uK3vvMXvAComO?=
 =?us-ascii?Q?NYUFGNCElfsFA1qCVjGA8RPhlGTAHq8OS2kP4ZJh2tVekX+57YjX67Ii6On3?=
 =?us-ascii?Q?kCn+P6ga6trz7zRouuNPFzbiNcYlZPIXRh9GTnUJUqss5F8ONh9UlWJaYE0F?=
 =?us-ascii?Q?MIjEZJNbvqfj7YrIDLGOYpDTUOj/1y3Qr/LQSyE8uIc86cgn/DOkwk7mShBX?=
 =?us-ascii?Q?PKv/vPFdL+yPBj7yiab8MsOT1NwxqNzjfDMgnRdU1gFQ3kt/f5Qvg1jKohQ+?=
 =?us-ascii?Q?DOuy2V5Fl+zvkK7qs5iAmoznpO35hgw2bBMERhE2sJCxsAt7T88I8ssDNJV/?=
 =?us-ascii?Q?N0bdBrZRa+L2cqanbdvJPi99futjkJihvi3RlhjqcwJYba8fXOzDC/GlyLUt?=
 =?us-ascii?Q?0q0XwWjBpHDlWI9eYnvDVhk1m4gb8oeEQIWZMJM384eSVKaM24iuqFDaLnjT?=
 =?us-ascii?Q?T98i6ANTpnm6fQ4kmBDiumX7fX6rPL77x6ZRcSQOjb8dpUwmlJBHNkSOEpY8?=
 =?us-ascii?Q?atrCd9fGYaW7OXXjnXqagDCY6iln+ofkZt7aTCDlGZvftpAnLA92+2ABqY5P?=
 =?us-ascii?Q?qzNUp8vzYEyi97cQ+7wPLqBOBA040xy255J5XCKxYwqwciV68gCs9qc63vug?=
 =?us-ascii?Q?YwEYTx46TDih3ly5VSUkQg1pdRcxT4qvOtEur3pYZfnlE8/kGnFdLq7q48Bg?=
 =?us-ascii?Q?LVYHaDNirz3AXOHazTnZe4e6cVA8nU5PMbakEKpOPcR5q1nbKfuK2P8RkH03?=
 =?us-ascii?Q?Lt4jpa9uUuxIDetqqdHTPcgxE/IgdENNpuL7T51g59BsfKgiZgXMeCjejFks?=
 =?us-ascii?Q?SbXOTviNK1V3vyFyMe69vtSwKjg95NIsZxLLbpqlBEJBUSjf+PzzwTKe24MP?=
 =?us-ascii?Q?HvsCDKnf3zyjS/iHJv390d/Rhn7OZTU29T3rU0jeLMB0T8necELdgZut7GKs?=
 =?us-ascii?Q?G2ofwPWtpB/S8vJT7Jd5oMdDjsdi/ZnMqJGJ0r1tH0wgGsA/Urt9bxpXTYf6?=
 =?us-ascii?Q?St1Vl6WDd7u+mNUMtr7PIW884JyNXgh9F9Um7/b7xJEhI8CQldFFogpv5Uq9?=
 =?us-ascii?Q?i+5nsuUpwX1FgF94dhr/dKCAJtXmOAv06eoEHWH63087ofWpDQZUa1s1pVPu?=
 =?us-ascii?Q?AzpPPFzjB19s58zMlnItO/URvIsMG5gEtY6p7wPDhWhHuCFO+sAO/WidRPaY?=
 =?us-ascii?Q?yNCc3kLXfypdKDWBD4zclEtcI2x3jn9kcScAGQRd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87108996-a6c1-4fa9-a03c-08ddde2a3d44
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:38:35.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FignOD9thGnm1CgseEM2/rh1phEupd7AH+Qr/z6XSQ4QqkxG+XJGtM9gzkUNP06ZNDod5ABm5SyVyUzSiK/Swg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB7983

The clamp() macro explicitly expresses the intent of constraining a value
within bounds. Therefore, replacing max(min(a,b),c) with clamp(val, lo, hi)
can improve code readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 874c6fe92855..31691ba5abe6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2308,7 +2308,7 @@ void mmc_start_host(struct mmc_host *host)
 	bool power_up = !(host->caps2 &
 			 (MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_SD_UHS2));
 
-	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
+	host->f_init = clamp(freqs[0], host->f_min, host->f_max);
 	host->rescan_disable = 0;
 
 	if (power_up) {
-- 
2.34.1

