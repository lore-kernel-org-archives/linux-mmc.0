Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6039A05C;
	Thu, 20 Aug 2026 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252266; cv=fail; b=mIQKSV81v1spIQ7SqOqLLfNrEfZe4QBHaaXjFAiJVafHAIYejONN0GCdMYTeEIbUGcgDmi0uCyOTkE6QCkr/tfkwf8XnNOGwc9j0ZfsUfifV7ZTtukuJc60GZ1wZdN+UBba6KfnVrNcnr7N2MAy9bjP2uxgdBgDxv7mIKjuNcyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252266; c=relaxed/simple;
	bh=tCMXUeaBrrg4qOo98h3Nt/kqcy52escRntH597ghNvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhG5xy/Y2LT1RsbqavXZg+iRhVnTaZAY2G3J/bQ5NNarM55Ejq+jFsAAEEv0X+SLy29bbDHwSx3E+jjOxU5TCbBpBcoDKKlljU7dgJgDLX4ColrmHHAfFLXBUuvHe4/V+MMYQbwuktvrC6Oum5c/h1MF1e42EM4BFlEBX1WZH90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Hiki3lV4; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Hiki3lV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mhwid/u60xWfNSIFOajCUuuJKcQP8UtDGrnjNKCAHo3tQ083h8FaIvFiATOgZAA0eJ96jG36dVkvolpIuWeFk7MNbt5K579vnjlTzz8mzz2eH84gC+C8C+2W3eBCSJXJH+gl8Q6FEra4v1AkX/E6Bt1ALSEPESW7dPLBNXu0JFistsSZS5FAzrtA9nEZVVmlJomVbheNhQxyYEBF25M6V0Dq44vLK2w1jJd0TAtIcbTQGXKRD6odiFAJpR/HJWvC5+rXx5Y8xyM5/afYcanpVh97moeEdf/OBjh96H4vE0MtEq8h+H4v1sIHNFNICFVOEMGmNxfiRlc9jQAiEkOzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=aSFx820oyz+sm3BJ+mD02bOIOdEHSd9pJW108okZlkoxuxUWnM1VYM9LNAkF5gQ1wVcPtr+Ck6KF0kAq+wMBuT49LYC+NXuLLra/Kcfov84NOV+vdMco1lmIwREx5q/z67RWhRrovbdFypLHDmhB6b/LUcLYCQfYBi8rrZYohd7GrO7cPEGtCAG9zp2zgr9HE9PDGBfm2tdqGH8jNCJyhxJJfralJhB8uurONUNri1RdDTW8TID4LVQWy138xY4c/j2kuKV/LVOmNaTLDfxWGN6ADgv1ucYxVjQeSzWFAneiX7ycEgZUZLfE3Ui0xiuwO6Gp7AD7fznc6SLu4zJPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=Hiki3lV4s7Vx8Zbjgmu57oai9szV3aznuwvd+Sy3OgAwZTqXMGCuntOKjh44pPqci0deYVjtRkhRhyFWPX2KKqhrHg4O6UcbgMSgGeUMulD4YWxszpFGU7si0T0La3aCEgPLYfXcqyNnSFfBEhwo1MQTz6dTM7KRHsI1CJh4fDZ8/+gsM6nKcN6e3icWMaW/XeJVr9qOaQfXx3S2GwZXKaHyHFKwBD+gTtH+ruLJI+sJixhnYbeKIp58doIPaQg4nkr9yHD5d6rVxYFQSVuwSTbsyeMXQDhXic37AxuN7Qj8Ylef1hLARboQGUn3YLrKxpjk7w2XFv4YiYQDqessgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5636.namprd03.prod.outlook.com (2603:10b6:208:297::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 18:57:38 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:37 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
Date: Thu, 20 Aug 2026 11:57:09 -0700
Message-Id: <20260820185721.22823-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
References: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be62cd1-e31c-47d0-ebf7-08defeece727
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	p7UmjcvUzfYrQIhwTr2PI3+YFJbthbqisr7mJE0m3Mefgoy+hWnMOQ4UxArahvbpNcytZgmREH6wVlJvjYuWiZOx0lBfmemm4RJEnvMGTtueMzGQQ175O1KHWdikC8KNUUVAizzeN1kd4wjeDwi4uh1JjfOduiEU5pzgvBUqERt93q2uvRHkYnb/MSVuGf+XkBEZh55882IuiOMnAby0RtoOb4qIbtrzY/0TO+Lf6qoYLVbAcxXgZxN/BehITD8KtdyBgKQNibbe69DdMFe5ZXxGDb5zHlsLQVv/3KUYOVl1sfQ1udTp2zIvV4ZP8Ab4bnY7bMtP1PhrAmAqi1Dr0hURId8RXQl1jnLpwahCfBI3d4bkvRvCyJA+ldepzejpDBDnF+TzL0hHa261s2s+Q6xYPfwPpFPRHDuQa0p/WSDsiJiv/S5JryO/08se1TxqYkIN9O2muZNFPMirVq34EhyTYOOyH7q0kyNH5TzgAYYoiBMsv3wwVvgHyaC5t6YvAg3CgIAPrF9bS6KkutAwpfZ15BwRQpJNi0D8PUHCL2p+97y0XgyC4dHouzkikRMdP5Dnh+5EXeGjFEm86ayu34edsi7tHMeHza/mfrSRqqJ3f6hrd+iNH6Mh8FQ1ZxUa6IilShG+YMDR630SuX5kXwmlF0LfV2N8Lxp/+Qd+Nns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?edMVyL3TcoTLJqBI1VcMoh0/kfP4qqGcUon+b0O8MoPJloPbxWBcHIU0hCE5?=
 =?us-ascii?Q?Lz++3naXiu4eqU/bAwYzDjvCeNwzGMM4ZW7f2yNn8e4oBqkkkfe9ZGwBEPza?=
 =?us-ascii?Q?0klwZwcQOuqOzKN7WXRSm37TKN/kKOJggtyrsnEkv9DLWzLcuFZHvvqFCcIx?=
 =?us-ascii?Q?Xv/HFFAp8RvjOZ0ZuPI5Pl/zowvEHmWtkmBtUllYoyN1nIw+W4UZXCM+n9Co?=
 =?us-ascii?Q?b711G6JGzgBM+vSQ3k3OFeu1CgFmgea5sKuAsSD22iIEl4mvlG9MX3UBkbC6?=
 =?us-ascii?Q?ntAcdJYSwd90w+ISTitkZr/qh5XoF4IqPzplnD3NaeHH6kmyTQkGYhnYSCED?=
 =?us-ascii?Q?BA6/27tjxgHT3JSis9sGZp852t/x8fhr/LVx3HL4KCpihaIc2kopguipmS7W?=
 =?us-ascii?Q?XyjlOIHhPHFGtOs53vM3ZNogKm7qMyzxc+SHPgXOQMvb2jFz3GBWv4pZ5uMo?=
 =?us-ascii?Q?Qkqm/vLMTOxuOjTHmiEuI6E7NyJhK/8Z+97H4O78TTRhH107wmmNp9lz2WiY?=
 =?us-ascii?Q?Xwgmawc6vhTuR+MxIv/B9kLPBqJoAnvFJbYh9OWR+Gkz1HuBCHoDyXYax8/B?=
 =?us-ascii?Q?mqqce2uSh8iQsMPoh2QmjOBvGnQFEy52oumBYn+4xsKmPE1plqXB+0Pigt34?=
 =?us-ascii?Q?VvyKDPmZADlQaCKdixAzkTJYb4cYK2yVuYZTszuZpMQjHQgwCHRIDG2XmlL5?=
 =?us-ascii?Q?8mQeFZvyggaTK3C8MLPkUO7beHQcs7kbRpIdFcil1gvlSD9fCyZ5zHmMK5JE?=
 =?us-ascii?Q?m0e6WJO3xWCNCUfZH/gKR0FyiJ1h6VRChE4s4Qckr9x411pErA/+kL7czT7Q?=
 =?us-ascii?Q?t6cTyB4UFVSWWmyOtEUNiLxNrpGTx6mdbxAgVFlIdzggUPElljT3DXMVksxz?=
 =?us-ascii?Q?QK39sdi4d20M0cZnpntqEHbGck6PN1MmAlLIEJP2wDU1bnF6yUq2GjuZuXTX?=
 =?us-ascii?Q?OpE7pWTI0cyDt6aK5nNzgp6HSv7WpUMcKulB6cv4O+TMARltBk+R6d+kAe8d?=
 =?us-ascii?Q?UX74zYAOPSy+FuX4DnTuEozGom1pF+BvF+fq0FUZlsPYMnCA4l8xcGH2c83Y?=
 =?us-ascii?Q?dh7+W5oSDg23MzW7C2wCJwvYw7u5e1temOXtWCBhvulufk8hNOSs3091Ydez?=
 =?us-ascii?Q?h8KfedVM8sZt0v+XxKnnC+lRZ9XTBNfycEM6J3QvMB1m7CtU/vCseiixlrTD?=
 =?us-ascii?Q?nfJ5WNCFraQP3YRJu8qsQPspUdgSSXTMsHM09b6zIcqlCrC6jJ7BzSc0BC6B?=
 =?us-ascii?Q?dBIdmHoYnOWUhu5JHc4jlNilJ/tYhBAHydozvFwcsSetoIe8Ti78my92YKOH?=
 =?us-ascii?Q?FzhXHM0Tfhn+uvgMMTQ+BeuPqhFr0aaISRHZUAbqrZPy9MT7Bzcvnlct1Pm+?=
 =?us-ascii?Q?vJIJo0y5CtzcKsubocVTyTiqLQHZMPByKdvG4sKFRz9/O1azSbCw2v6i4VLO?=
 =?us-ascii?Q?IyiRHNMaazKwsMCe4lsHWAmJiB05SItOqU4lTB3WlFGP/SWb9biEF/VuQY0M?=
 =?us-ascii?Q?aoiFSPQivbGSNTnrd3OQHrumekEtxvLYStYZ8yEHRUt9h19L/msvMtcE/yGk?=
 =?us-ascii?Q?1pEGEtTno+gLhh9kUzLfu8H4kS4R70bIoZi6BtCdrVOdJCGh3peT9UYfzUeP?=
 =?us-ascii?Q?lCvKAq2ywZEnLNmdYvUHaZ9h7ndy4cZVRrvQMaHE7JatMlxTq0VpH168WSTT?=
 =?us-ascii?Q?ZHrTmPB6r9Z0sYV9ObLlWWM38OwL/Ba+bz5KDlBwbqXFKnRjkNSYaxSRoTxg?=
 =?us-ascii?Q?4S/ZdwTUYVIOTPF6uROlP9Wn43OI5mk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be62cd1-e31c-47d0-ebf7-08defeece727
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:37.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5dQbU/SyA8oqMv5w3O21Bn6aAK75NYpgqCt4EmZiZ3DvEvNJO+Ss76YQOw+StnmAmUSnG0SsVTMaapDS6x5P2I8W935CAqqWUHYR+3jIS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5636

Document the Agilex5 SoCDK with the eMMC daughter card, which uses the
shared HPS SD/eMMC host for onboard eMMC instead of an SD slot.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 0b418d9d60db..ce3a8c1679e5 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -112,6 +112,7 @@ properties:
               - intel,socfpga-agilex5-socdk
               - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-debug
+              - intel,socfpga-agilex5-socdk-emmc
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
           - const: intel,socfpga-agilex5
-- 
2.43.7

