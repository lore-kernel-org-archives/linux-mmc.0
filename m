Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CCE3A4532;
	Fri,  6 Mar 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809921; cv=fail; b=AFfCY4Sw1unxe2O7JO0bK2vq63NPHBDGH0X7x6UjhjvFZURdohUSWS6G4I2UQlMs+yBPV0fxF9rmnIwTaNldfFzLfSEpU0TRWoljihn4ECPsaq9bl8s3sZJaDFU/ionnVlqAkobNOFQiYzhv6ftIxiiBGOr1FGQgwi9RCxTAdA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809921; c=relaxed/simple;
	bh=QiHb4JIcMzBgqtOKXT8cpt2Sz9PNgNu2kirDG0ni5gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7lro22wmr+hHc12FiPVd6F7t2U4CvIr/kZw6oNPOUaC9kNU1hTJqvASKaCXLzQSxXyIFxQxsVZsVlKan+MmYmwXYkhH7ZMTs3hh07vzsCRDkrb6e8W7OZsD5m61AkaF1VrYTDNGMl+GTKU9FczW8oqmN/fD1OBSJ12oLRApmzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MVx3fvV5; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MVx3fvV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4cTupkN+21cWjOxrwDwdKsO4oHeKfVTJo5RNI0O9hWEwsIeYqiMfr9oRM+FNfsNjXwf79FpQAN/LH8N5tWmdLRW1RQZ7/0VJriCxNVYnEUYTgINQel87JCYYvgHJhodyBLVeP+K/xGCOSzwv5HfIapjnABihSyrFXZ5tifHzAnDnSwfyqKZXcccO7oD/3m2rHWxiPdu+P7wKgKoennvAtFWNuVaybz9dZ5dY95UfWwebuPM6wdFgWJbjHuypqyBQOKVt2KPi3Fg4W6joww/fjpTPj782hQEncdMI3Xna+fgSEwGQZREg56QvLGYMx1JxcTFeqgD+Nmv8JQRUmfQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5SIS7GokQUC8ftlCPPmg4XbQf+sFIKPTSrqHAUeYX0=;
 b=w85QcYIgmQ7+avan9Ax3r3q7C7tje1zfeRgCqN3WXx+Q/kHvvEfjRmUKDJDMLwyqpzVUCdsdtx1+1/ompyh1Tr9LNdKfS8h7SvBg7tWL1/HYqh36UVjHD9g6VDpacFnTrM3dK+IoGzZsmJMuHrW/+YLhpPjhR2tegbk/VyPIXaD3fWHsUr2FqIvPcEl0IK/ZXtilo5NqmpeO1+wpFR0ah66gjbfOJJ75QnScGkE3ZtwbAPZ4I0/KdvX/DAGqx4Fs0wAnNRY3HloY+6QiSyR5VouToQwWlKpYzCEXvTmb0YyR9lfVdsePf0ZmhjbYGV094kUyN4X7yDtz0aMIC0cOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5SIS7GokQUC8ftlCPPmg4XbQf+sFIKPTSrqHAUeYX0=;
 b=MVx3fvV5CTN8l3B5pGZW39rPGREOdbDfjRYEuplul7Lgw6hEz0eGPkGJAMeMiJTAYFmT+saU1+DILAlyZ0naYL4PAj0ePHFuLgafh/y+qXwsnL8GCNA3Rt52dB2wlqNLrrWRX2VIlDq2P7texVT0opX15FZAfveqbGI1iwuNmowVoWluQ3zTy/gIGZyHXGnZlXp7hatMwQdu7W+79Bph07DBLd7QpmDiSvbbNNvUksu8nG49vOlhVu+dcUQN6MPeGG8E6inwR3uBdQrO1pmd5IkoYkA3H0WhG/w+fk5fvZb4k0KWFoUOsV1wuCN3ZBa6cM5plXJ5PxeOKlCKsQKJ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 6 Mar
 2026 15:11:53 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:11:53 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v3 2/8] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
Date: Fri,  6 Mar 2026 16:11:41 +0100
Message-ID: <20260306151147.24446-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 793099ed-1b38-41a2-bec8-08de7b92b307
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	F4Jg51VcTChK4kc46bIDDAlNfDuSLjW1O6/J745UN07oROsK6qYJMBUR9Y3k3Q9LDWk3Sg1k/PMZa33oeGMNHNldQVCsp3bKvyFB+w+NZ6a3a/KaXD/wHfPFYTfUI4SqMH7L0t23o1jZTNWDTxVGkY5Op0TSwWWgo+wLXoF6ljfbmS6SMzTjpQRoI4TKYwOkkFj5FwYG+zsEIk3f3+t0JqKTIsxUv2uPvdVowKb6h9G3+TamWphceyreHGL06jsD0Z4kkjMv/mZ+HXa6ZYZNLSyfy5relkmBCuOQ6ZoR/rVUF+1Y5Z5qbkf7B5sTU+grZj5SpRxazEZ5V6K+Up+axNS1WAupLUrqbBcnIph98+lDQGQTkcNzDpWsx5rxuiXQICPOLjzbvan6NwJOGbu+Opp0ucjQ5z9VqrG4qIZkt6L99FKAmNE+H3/QXzNIG/sYh1q+ofc/6iufaitIORGVElIFyF1JLCUfo9Q4EAZTmK9v3k+/ZQ3b3CDuX+jG1bd5hqzMtYljznnWLgPJN75zDeik5U0+tgIRNYKsGpia2Xtvr3hW+h+2kzrEDijYyfviSVmjeGS5FuxkaTDRV3m8QdlMSKdYkzHtZnBjXMorf2XGXV9/E8V5x8ZNDjBBRdEtfyO0kGn0w2C88MevDoq2g58vieD7Od1Wbw8MbF52EzSKgrAwZgePP2sAuHx5VcxPpd1a4rboQxuycTygWNYFB+w4amcqut2htiW3hhHkpF1B/r4ATAdOP5Hmk1KlDTos0fM9UObsO9erQL/Mmf4k4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azg0K2VWdmdRQTBEY0hZWkltZmdYTlhZVmJWK2N1MzJNWkZuR3hvb2g1cE00?=
 =?utf-8?B?anlYTTRFV1N4WFVEUk1Ib3RQQU9mQVA2VnJCK3RYTzdxQ3hTakFBTldzODdh?=
 =?utf-8?B?WU1yemd2UjFyRkh2aXo4UnBmUHRLZkQ3T1Y2UGlKdUtKUWRUTDQ0a1hiOE13?=
 =?utf-8?B?b0lPMng1dE1Ga0R0a1VCdTNaUFJGSlJNU2hRMUdadDFCdDN6M1ZzR3p2VWxk?=
 =?utf-8?B?M1dycFAvRElKejFIcFduYXBLcmc1blVTZXo4a3pXV3UwVXd1RnJzTUNNbXU0?=
 =?utf-8?B?SWtKY3lXWldOYkQ1R3RDOVNMV3hVeXJxWHJTWE1DN011S2ZBanZLUEl3bUxQ?=
 =?utf-8?B?dDk0Y292dkVjY3pCQmVYRWJqR2QyMXVMeGlyUDRkU3pvRjc0eHdyNSs3M2NX?=
 =?utf-8?B?TlZJSmU2TGxCbnc1aGFValFPSDQ2TDh4eG5xL21pdFkxN2g3OUZTbEFQaXNY?=
 =?utf-8?B?bW9KMVRhNks1UGt6Q3JlK05IVUJJcnhPaVRtVXlPU2ZkcE9UWU5NcGlNYXFu?=
 =?utf-8?B?b0hkRWphQ3dnUTNyOVdBbXA5VjBhVWl6NHZqWktpSU5DK3hmdkFiN0F5ZFJL?=
 =?utf-8?B?N09OOEtRM003OFZ2VnhEdjlBNFNTdHo0U01mZ3kyL3NNY081MG9LV1RrN3Nm?=
 =?utf-8?B?ZzhWSkJUd1dxS0UvSmZuRWZiQkxZemdMczN4d3hnR3JDZFlXZGhlYnRRaFJp?=
 =?utf-8?B?d2F3M3hSRXVaczFabit1WXpyZ2piK244SmdNT25DQVNJMUNvTXR3WUlXY0xC?=
 =?utf-8?B?V3AwY3FhU1dJaWxBQ1BZc1dnbFN0UlhRVUVWbm9VbHRHaEhLdGRhV0xEQ21T?=
 =?utf-8?B?b1dCaTVJR2JWc2dDRi9YZzJpTkhEMXFHMXFYdlptSGtZVVdMRFhVTmQwNlNX?=
 =?utf-8?B?NURST0JJOGJ4cHY2VzZiS0NQOEtwY2plWmgxb3oySVk4UXkxNG5HWGVaeFdw?=
 =?utf-8?B?QWE1eitjdE4rcFJjR3RJSVMzeXBWenhnSjBKRXhYSy9haGREMUNuWHR0cWE2?=
 =?utf-8?B?SnZsU2UzQVlBem9LZkNnSWlOU3MvWjdIbDhVUHIvZ0NJWXF6RmpjRnVUd2c3?=
 =?utf-8?B?ZlYrVTBqTHRXUDB4RkhpTURGTG5jMGNuMkZXMkxJL2RGdi9jTUN0bFhySlZP?=
 =?utf-8?B?MWc1SDdzbTZNVm5IaDF5K3JIUjZWRE9sMk4wa0Rta3lVTlp0TlU0UEZEWGVY?=
 =?utf-8?B?QkptWHN0bE8yTTF0OWd4YUJzZ2RJdWF2NG9rTGoyNzNEQXF6T2FOL3p3RStj?=
 =?utf-8?B?cW5xNFVvd2lQWS8rREdSSTY3Y0lodHZoTGU2UWpUMHpxRExGR0hyOTVWVnQ3?=
 =?utf-8?B?SVBYQk9FaWtqOXZ1U3FsL29HUVZLdXVQU3JIY2hHT2ovSSs0NlpMOW05azN4?=
 =?utf-8?B?K2cxSFJJYlhnZGRqaWVvWksyNUg1TmROYTA3M1M3djExSUwwTWpYbktjN2lt?=
 =?utf-8?B?Q3NlTW1wckVKbFlFSWl5ejVtb2hVYjl2RUM5emo5M0xwN0djbHNQSFVLaDMx?=
 =?utf-8?B?WnZCTjE0dlArYkg1L01JMC9EZEhMdlVUNmlpVTNEV2RObjhXb0ZCRThCWHZW?=
 =?utf-8?B?eXZ0QVVqa2g5TTI4eUtNK0dURkljTFVIeDNYV0xGOGM0OFhNenFmaUhvbkly?=
 =?utf-8?B?VEtVd0xuT05MeFJndTVRU1N6Nk05S1huR0tTV2hncDFNRHZuWDUrKzllSW9q?=
 =?utf-8?B?MzQ3V2VZZ0hXRzh5dklwSFBWY2NzeHYwNWV4Z0YvV042TTJzdFpZYzN6MGln?=
 =?utf-8?B?d0txN2ZwK3ZjRjQ4Zit3Vks2bDM3ZjVsdVVWR3VseHFQaE1hZEdKVTdwT2l4?=
 =?utf-8?B?a0EvZS81ekZBRW1uYnAvOXJUL3JPMDUxRkhGUHRPek5hRlRvVlRXRDVCeTBh?=
 =?utf-8?B?R1d3d28yREpDU0dQYXViZ0NFQ2poblJHay9pY3lRN2NCa1Rjdko3SmU4L2tC?=
 =?utf-8?B?ZUs0WEJDUVJLYmZkaXdzRS9temxqM1pZQldSUVF6UGRtZlZURXJkVGsvYkpv?=
 =?utf-8?B?T0JheVgxTktrdmlYWFdlSGZ2b3Zsbmp2cU1oUHgzQ055RWNSY0tIbWNUVGZY?=
 =?utf-8?B?TE80anFTREZ5OTNNRWxPOHRueCtWNUpWc000ZFlWZmJKWE94UzZMY09DeEp6?=
 =?utf-8?B?Q2JUN0U4RXZsQWY1UUF6dExmaE90TGlIKzBlOU14RnE4Q3JDdzVUUFcya0RM?=
 =?utf-8?B?UHlpak95U0QxSUJjNjAwTmFqZ2VjV0FiSTBhTTlXZ0FMMXEzRXpqWHRKajRX?=
 =?utf-8?B?MnJqU1cyY2tIbXROaFFhVm9naXdxTGJUWFAyVjc2eU9nRzZ1NHMwQlZkS0pa?=
 =?utf-8?B?MkZVS0pxQTR6ejFyU2tBN3k4K3FzN3ZaU0NIOEV6MVY3YlNRaTkxdTljaWkz?=
 =?utf-8?Q?V0H3KhGGC28Gc8gY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793099ed-1b38-41a2-bec8-08de7b92b307
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:11:53.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ6SHAJtbXr7eu9UmnSfTZ8AdJ0y42PsCGV/FWVol2ygso3XKIi63G+orVEuZqTs75Nfa92w8AC9Rns8lkhA7wT+IJmW7kmYaAeOeR1knwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
NXP S32N79 series automotive SoCs.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index b98a84f93277..014b049baeb6 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -35,6 +35,7 @@ properties:
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+          - nxp,s32n79-usdhc
       - items:
           - const: fsl,imx50-esdhc
           - const: fsl,imx53-esdhc
-- 
2.43.0

