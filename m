Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5620C028;
	Thu, 20 Feb 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070038; cv=fail; b=BOF0ExjP+fTXRROHVn73iB93Mc0EujFblV10zApimdnmeUIWdHUchvfB5YLQ2x74S3VdjNgx+i9VKhPhea40+1zZBQzWo0LO/KBEN05WPvUbFVRSBemg7GeZkugWP6ZfmUfWPaVCU2v5r47jPHxqmCDJKAaKkbpgKahFAwPh0XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070038; c=relaxed/simple;
	bh=L7V46hc5aPY6Ey2CCXt5zPEjHKfxE2wgWWBPiQZh2z8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kROgS2rLbIBrOpxeZc4wTSyqdE3LB88NUOyOPFP9eE9BfWM9t6jZCK17NbYvwZRoeH2y61GQ0mRHcOiY5OFdji0XPfOj2T6pgZDy4tvzizaFvaBS1NfUarQht9DmrZzoLd7uJvuXTIdsGz/evzzov3ncz1ZOnFMUKtWY0vnU1mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gX9Uet9i; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gX9Uet9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb3t1cotP8sGhciHM5lVPbbnZkpDX4IIo6eywtB8ibb32azk+zPQEtfmHKFb2Z8u3HLrLREb/pZueDiST3d5ZBGmxOT1O2aQWaJHZ3ajQ3TfE7B4JpgrO+Aul/++TbvFfmS/MZhjJliiSgyRNlIixq0d1LAt/o8m05v7E1HhkZfc9oMJa50nua1UcdmXRBulfaNu2gQ38S+eFxWCspOvdXiy2k8o4PSPY5+X9uiX2xrLuw8mTcG1gqiGdnHh5DA3OZx9fZMk0Vm3IrTmxdGkvNy/iBToYPJTs/2XWRBqMGQyKVLsIU693k+HrxsKdB85RV9ziYPZyV8y3jU+LQsp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pbGfVcrEvHKDQIu7RNYlSGQcRYSHe+ZBsoHxGLmzko=;
 b=AIpP/OCU5kACaMz46w/hddWnUhK6MVN62hp3LSRxQPCVPJapi9iHoFhwM3znV8aEgSYCiQI5K6PJ639VIjh0J6q89iDn/pl9HIbaGx/WE7Sm5n6lH0SoyQTwikOtmXE9CdCFC26YrLRbhe24hXbA8K8CTAbMh28KigLI1H1tDu9Epki3W+s2cARaFHM59TG7DYdS4nWNPGyWAIvFjH7VBCuL7bL4sJgaZ+TX1MGqFGO64UMb7I3/xx1Q/87J4cdHeYBswdPqmveev8A4Vg4V7k+/arqp92IE+NZURF+jOYf9ou9HUGQNeNVoM5fwgKubSk6KG9rsayWfQCKIoXx/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pbGfVcrEvHKDQIu7RNYlSGQcRYSHe+ZBsoHxGLmzko=;
 b=gX9Uet9iPKuG/gNcHZMkWEEZG2WB+t/+wdA4Cfz0gDFTh1gdoaOvF3PP0+EWQaCQKu3cndPEziWkSwTeggTkQt7OzSdAXKVxtkPcZVXNpYukleM9VH7pPRBBorSO0CP/SpHYThRdVj7/JbcT17J2y+8kHKbB4a6xw/rglIekdahmVskWd6Ub3zlyPjTH2pc8Gq3xTIxPEXpF4ic9rdOCOYunqSm33b65HPcy+OCG0PyyZ6UVonfcZjLC0Glciod/VbSWTp5p+ipxUqQmhx15ce4Dx1N65S/yBcoNuVSmE57dMDuCHB8dJkoWUwt74trTQjEdU+tG5UbjYkZ+HV0adg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9119.eurprd04.prod.outlook.com (2603:10a6:150:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:47:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:47:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	shawnguo@kernel.org
Subject: [PATCH 1/1] dt-bindings: mmc: Change to additionalProperties to fix fail detect Unevaluated property
Date: Thu, 20 Feb 2025 11:46:54 -0500
Message-Id: <20250220164655.2081224-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: e12875d3-544c-447b-369f-08dd51ce385d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4X1VXl1Dvqy9RmLN5FtctywS1r1pQqBeIcSlHzTLB4RoxAnx9vXopbD4sD7B?=
 =?us-ascii?Q?Y/L+9t9X9/7j1BOEf1Nf+6jnv/An83VUi/bDfUBeIQsvA7j+3PTpWup0c7qA?=
 =?us-ascii?Q?WOb0ZEl13NnNFRUvbQLVPl3BNbucZx8v995Xrwf27zV9vrT38GKtVMRMUnAE?=
 =?us-ascii?Q?cVgcIGeLCwmzCl7Y8yKdoDgo3/I7IF99K5barTxtoCLT3w+Eypa9rmRoyG+t?=
 =?us-ascii?Q?X4O0jxvRYVSU5Ndh4iAX5b/hwTGJ3TeHHO9Jfho0/CWa9wUJnOrOxbvlu0Fd?=
 =?us-ascii?Q?zYvMz+uNObNNTKWOM4lcbfISHRaIRaARj+20V+lSm3BUXmogKJRDp3y1povT?=
 =?us-ascii?Q?O9b+m52XY5fMkRQVyf4mASxQes4MKtRcX3Zla0iX5iHe/eooU9PM0etw7ni0?=
 =?us-ascii?Q?s7Jxh6BcXZ3cMb47nWDfkwpi5jXvF2dogJXqL2uJmrcQ1ExCz/mDQ+0vxJ8b?=
 =?us-ascii?Q?V3Eru4pebnXZYfi0OmYTAJ3mteZML+ef5dZgJde9fJvKx7903VNbozzulvv2?=
 =?us-ascii?Q?m8kIMztfSCoAzePS5KLKWzdQOMU8G0pY95xWCaia4U4JGPt3S53FGV8IJ7H2?=
 =?us-ascii?Q?dGJXkQ3/539XwcTugvDA7YQSJxlxGTuVCLOM3i2maAPkGDgDC+uWntP/mGBk?=
 =?us-ascii?Q?HHH7RcER/cjkTA9HwHdpRyEehuzwALgtAEcVrnGYslpjArVUlgNZU3t4LQ+1?=
 =?us-ascii?Q?fzr0qpxWNPdmkxGR/C1KhILcQtksescOSocSS0c50OVNw82P+dwoQJx6zKyO?=
 =?us-ascii?Q?9q6n2Jc+H93XusTR4CALoQ8JZAsPwdKUOBIWKMcR9RxyElLYZb/V7QYp4Dq4?=
 =?us-ascii?Q?YElkYivWNBsatuADHBWZ3db8eSaBbVXNXTLm5xxKzTI+MnBqYu9oFEGH9+42?=
 =?us-ascii?Q?j8484Rg8sZqJV0hbRH4xdAetQ0nItz9YqXo7QvQR5L6aUL61qh2NMKrt+Tdd?=
 =?us-ascii?Q?Lim0gGy2zYsOBRvXFG2dMOyzhg2dBsl7pAmq8Ixr7R+GSc5lmWhoTEaYGp+F?=
 =?us-ascii?Q?9/XUsfCahMJs479LK07iFqRrKUFrte890iSee8ySHVeleXtWB/Q1ZUyaLXmE?=
 =?us-ascii?Q?mOdqnGtX9QX+OBesp0u+ddeEfKWmH3rmOYkK1T0w6bMhekCo9+2nPzQ6Mrzy?=
 =?us-ascii?Q?I6bBdGJ50Pd6jNiof4ZkeI5tXZrLt84Kg07nmfN5iUBPrvHd6KMFv2lpIQ5y?=
 =?us-ascii?Q?7ggr/6PaLaJzGjjnfae4h8et/X7A9D22IJgPx7Jqs3fpBhRNxv/TC4QOAwwL?=
 =?us-ascii?Q?N0EKmQJaF84OcbWcdVBF9mh/TcoKPFfy1jjdyjc37V1+s7u5SN1RXQ2FB3qi?=
 =?us-ascii?Q?IOAFuxwSyiOS7jpXGp47sbJ0yIrUsd3kCzJJ4nzjp3XqDmsuyz+sGCpspymf?=
 =?us-ascii?Q?LTrFqrV55JMVKO90gpracz127avzZzJYmS65YW4avdRik75F/HPwqKf5OYqL?=
 =?us-ascii?Q?JhDaz2bJzacTO3IC9/Y5uZb0XKCCazOo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HsTcyheI/fxtXYoMtH3Xc8hCtmLMTjUvzNie2D4C8vspa/EfFNV69xpXu1pq?=
 =?us-ascii?Q?aJ/ayDpP6tPyinuvqdZJ0vxoe4X+W4GIm0nMIay2Y28A0fTL6v0vidYkG47a?=
 =?us-ascii?Q?3B2Odflpmu7McqQYTjQrhO11cTynW1zwNGs4IuJtpPxQ1myt4tDsZ6NoS9ZJ?=
 =?us-ascii?Q?pgwymZvkbZbDn/m7SZVj9NIl6pCApSbxiJCH67Chn2jh6wOvEnBobPTztMAh?=
 =?us-ascii?Q?Rc2+3HNdJq7Wa9OlgWY36q0mlt0PftXMMcDtb1Imdc4Y3nDkfu9wfvMCNZXC?=
 =?us-ascii?Q?h65Ds3RYt/q3O9zELgO0n2rJWHVWjsaMD7sfwWS28JnPKugEvUrBXHIlh2pi?=
 =?us-ascii?Q?mJGyvtuUZ6HAkVlx/cPiqn4YKLmKoIt1EtjFZYA/6fDBhs9rvsyxSXVsBtUI?=
 =?us-ascii?Q?lC3TN1IK5PtEDvwpqACkMyT59DROfyCu50KEVxGBkQUySvCr1AihWHtduHao?=
 =?us-ascii?Q?/BhgiUHE2gQlQWXYSdgHN48qDFOgd+NNaCvcNp0uUJLbgG5baSyXchr6t+8D?=
 =?us-ascii?Q?GpIh5dv0ko/EQE1CDIL7XtJvxO+zMoZBtAmuWMkrq2CBUnTfU/47y0og0ERt?=
 =?us-ascii?Q?XZyMipH9FWTPXCJ4NT/PrCAQDtRrH5he/tJNbL7kgkMhmnJrWlKm6bnMCwEw?=
 =?us-ascii?Q?OYmcMd1P0HlMeNuVPPP381l6b2+/K16D0pgY2ED2AdT9MgZ6IDDuHAvg2IuY?=
 =?us-ascii?Q?DKCbh0ubjgqq/0Ce9Ebb0EltGzcO6IsgbEUs89LVU6MLw4hkaY+ZzhWLR8oF?=
 =?us-ascii?Q?uZd3SWtGtERZpL3Gut0z3lErwIpkzsLWHsuvWk3N43+7ZbJz5VZVcB3RLlrY?=
 =?us-ascii?Q?1u0YeXWuLaDXZ2sno68ecBy60wPZNQ4aQyicKns1r2OlAg1P6Vgmq2Bq0C77?=
 =?us-ascii?Q?jMYCW+WQkggZop9lF7+as6ZWfECezBI0tyrM3WwhUIbH/TyduOkEOWdqPQf6?=
 =?us-ascii?Q?TmQ3dt2+0GAii8iaEvRRR+LvJmkzyV6l7eAOKqgCkA4y/RjRExAkh2HRNjOT?=
 =?us-ascii?Q?1ZQxdB7CsQZcaHa0S7pVpNSmKq4Iyc5qaQZ+4i8HnFLb1Ijg6o3xmLdWK3NW?=
 =?us-ascii?Q?VeaqK8XvQ596lTrxVugqOEz9eT14Xok6eNXyi0qKSCkKYLDx6TKb9nU8DzEV?=
 =?us-ascii?Q?DTWqwiPkuK6xd/V8d5Y5ROW4JKJwj/OyVR9JWoollQANjhPIdn7DwpFFM0zs?=
 =?us-ascii?Q?V/Kc5uG+ycs/cpZQJ0s156dlbkvQoB1/evGIvCGIeQlaIUJXaTkPZJWiMO8z?=
 =?us-ascii?Q?U1oOB56MmrTLPaYL6l4CwQkEH/gMH45Ww5SeJcPk/S5a8Xt1J108/Ua/FhC8?=
 =?us-ascii?Q?LBSHKmGobxNWvffGGQX++PKvpLZHeldNfuLbBthbaa7KnDZArhJte2oLcqk/?=
 =?us-ascii?Q?7aHMZ4Vel92zIdWeSeWLz7kJcvzneoHIK/T5M/w9CO1NyJoY/BmgBRAP9w2L?=
 =?us-ascii?Q?jL9OGgf0+v4XcLlx5F7u/uCC3KCpePL0vVfQPvB1NTyqzdFmzH7vnGgvzFag?=
 =?us-ascii?Q?cUGDAD2ip6zf/VuwONnSFaOUOtcwAC5I4rdi/EiccxRm5M0Crja3iaXhUdIz?=
 =?us-ascii?Q?2c3FDSlrOwy2iW8BVH3aXThwNxiTwGt2qSdUyjMP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12875d3-544c-447b-369f-08dd51ce385d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:47:11.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOrZQwfvvOnDQFzUALnJbYHW25aRYmS0d5fr0mpJWtP/TyU1iHT++kXgLITJm65Qw2ct92ZJjS8g1zw8tvpYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9119

mmc-controller.yaml is common schema file. According to writing-schema.rst,

* additionalProperties: true
   Rare case, used for schemas implementing common set of properties. Such
   schemas are supposed to be referenced by other schemas, which then use
   'unevaluatedProperties: false'.  Typically bus or common-part schemas.

Reproduce steps:
1. Add unevaluated property 'abc' at example of fsl-imx-esdhc.yaml
2. Run make dt_binding_check DT_SCHEMA_FILES=fsl-imx-esdhc.yaml

No any warning report. But suppose report below warning:
mmc@70004000: Unevaluated properties are not allowed ('abc' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 9d7a1298c4554..26e4f0f8dc1ce 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -24,7 +24,7 @@ properties:
   $nodename:
     pattern: "^mmc(@.*)?$"
 
-unevaluatedProperties: true
+additionalProperties: true
 
 examples:
   - |
-- 
2.34.1

