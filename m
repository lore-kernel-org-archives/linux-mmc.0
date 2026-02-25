Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0633B8BB5;
	Wed, 25 Feb 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032878; cv=fail; b=CxOd9N4CYXSzSP0OIXVY2KHTFZk/no6Vdt/jfGNcEV7Ie5nIK6MjIRmHnRU+aSjmHmjctblXvHws31BgBE29X9VtZ7NAZ/H3nwdcyitUouJvtF5k6ij3xtIkVuTTAdz9dIjkjzCh1m2IXLkuFMFjiCaV1y3HFji3Bw+Oxn5etGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032878; c=relaxed/simple;
	bh=gx1I/zYX1xQRHZyW5Vx2XegRblPGHIEHzHw/NjWaac4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bv2/FR1aUQCZjWKz6uPSLOCaDtBXQZtIxlpzsPTwoquiCJdCyBVUB/pYnXoEw4YGOsTdRkL2eT0A5Hq73r+MZ1Sbh8j8S3obKLcGmkmx6pGeqjI6m4glvd49CBJTTjoJyIIxm5TEjTwtGFr8bMI54apmytP0Tl+42BZzF4JpEJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PFTQ6bi7; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PFTQ6bi7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNDOwmKFf5MSX88TI2BvRJuGUUjLcYxk+ghn6GIljk7Erf3sxTqpvzUxPbVx+ZjbFCSELX5u+d+hJ7Xj36PlP9wnZ/IwaG1901nKH4r/MsRb5K6AvjgQYo3cQURYP+xpN5ABHhpvplaKRsmIeY9nOyWWA7iN7YgFMk8/nFuRYQmxd50LL3zK/JnTDMuAMTv1eAxSxmaIhzZFZlVi+0cpShSRI5EJQOoyewaNCXHEeukEtpbvCtlghFVIRP9iCho4uaixIMry9tn1gSDDWLH8iFdP4ly+4c6FYiamjBi23UBiDViQub41mu0kfSVmhUVKnPLQ91dyrdVsw/Xaq47P8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot9QZDiDtfS9uA5359HXWVx6oEjSDCciEbNGCC+PtOI=;
 b=IkRIUhs5ELH1S+xocbOBkZqwbjBxE5h6n5JD2XhmXpWlXlOelHpkZ8NXYqTuYHxkr+UvgJ1lCm2/F0f8frX8X0UOt7ubsn23i3YB61tPmeJ/rtzXzkaSJnNpmX2JqKiV6ZMZ2/0DvKJXu3CviJcNfEZ4cmPmwMfHot1RQuGMHLFnjf9DjVzXB2Drwt3FLCnsMQLFkIInTUVVv3A2gNdCrp0ztkoxN16HzKqxcIIQE48qOCjRFLU9jetbJ3zwfaTDu++CPLvc0/RFwaE86T3t/KqCnfWHphu1eBFcdVn4PiyEdXZUbMrNJnf1UbmhfULCDp/a9rSHGHWbXl2CB+Avdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot9QZDiDtfS9uA5359HXWVx6oEjSDCciEbNGCC+PtOI=;
 b=PFTQ6bi7t8wxl87DrryOBT+XlT3uIR3zECknEHf7iK+DMBECXii/VuCoRJ+Kpb97PBPMg9w0alPPXJpkqNmh41+3bXzTHgDHkyrNfzJcQ3x0f8wZ+ej2FGvniCfwkrB1IVHGcdkA/DpK9pJOhPfsWZeD3ugjXxKRCGlvVgsoD9fTzu85sYNyhQJ6YTiyIq75gs2pkEkoUWDLrlnxGZ3gB5Vc3brCluJy+RIePY9z1FUp0jOH2apKqJI//fdQ9GizAGst1623ea/IfknICOv/HIn/EjUi5Eh0w500kA1GjKGMn3Zeq1xy1EiEBR4/OvYV8mEcGqD/aaOnU2C1amTXvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10509.eurprd04.prod.outlook.com (2603:10a6:800:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 15:21:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:21:11 +0000
Date: Wed, 25 Feb 2026 10:21:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB
 board
Message-ID: <aZ8TXTzYOVaezpCz@lizhi-Precision-Tower-5810>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
 <20260225133858.8026-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225133858.8026-4-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: PH2PEPF00003851.namprd17.prod.outlook.com
 (2603:10b6:518:1::76) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10509:EE_
X-MS-Office365-Filtering-Correlation-Id: a0461d00-4cd7-421f-10a0-08de74818198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	IW7oj3gM0LD+LoRUtud0lx9rMwY8C2kSuU18MZjBLWXjy88GLyuFq8+0nxn7hgbfxWHej67e5XYXA/tOjsNLealj6QRHn2W8x9ZBqmOTlMU7MjgHamgrjUIshK22epiHMQPsRmfVHrkR6j4YeT/QDfUrLOIbcQ00wEUx47lpOtl0BzP2eDdUseyd3PRDediP542449pX9may/EXP/mZZXevenMk1yPWuR3RL6V5pICPGhvvikuJjnCipVmFmiMfTh5BAGcMKLh8rKaELj4kMa/xTIdZJ5Nshakw/XCKYQb9COzRx+zr8avPknWN+zCjsA9BgW7wj79oWgE+QHnV+FLj1djqkRWyBSMHzsNyXjWO6uZ86UeXsCQNlGcgEsia+5w0WEc7qzVum0zgEml3KyMKMIrGC1uEQ3COfsIy1eyqA+J/jzWL/+QBI7EZSydhTLmlp8nDW1a2uEECXr7mAmwIK4XndlDIg+ud8o7z18RJQ57payilf8qNoXn1Xq4oqWthR+Dw8JwIR0ZkV9pfzTbOUWCs7tUwOsLxoC6HzC6XCqu+swip6GoJTMPhPOrnpIwgNGk1GxlJYVm+BPSiwaGIW+R+FfvxoxXBxVqh16HOGv97KJo+Z0WYx8RUkG4zcAhlRQWJvwE9xMFiltUL+RmTMHpYE2a9Xm+ulvoNzkT1+TUz8mbokDV7tEIFYvRT9YcDMgt5OQstzEkCmdo9nks8APoCOY7V1COywMVDWi/IKSkwcKB3zOsuiep4IjIqi9NUz4n17jYubZ9aYhTM/xVkKo0lEs4KNyd2sAJ7P+58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wd2tXeJQVvq0f/EEu6GFtxH6nYXX3tv0N2dJPE+nT4b4+HfRkvcKGAkIPGT6?=
 =?us-ascii?Q?ZUE78H/QCdzdT4byQXNuLEw8+o6ZckYt/nGznbh8VguJqDmgxohXAYv5mUiL?=
 =?us-ascii?Q?hDwQBxWjwnmwzgi7mW+OSOoMBJNVMABpyQr8do/wX5HxY3xulnI908JmgPY3?=
 =?us-ascii?Q?HyUeCdApBZZdH7Ds071Rj2D27BvjD30CD72i+q8v4J6Wq5lGoLhqhDUhY63e?=
 =?us-ascii?Q?JsG6vI8n5rAKo8fHEBF7W24IU7d6pwq+MgaHWFZK+EtXO+whzzUCsTWy7Gfs?=
 =?us-ascii?Q?IbHnJNT6TEbTcKjHawCjP5A56VeK5dzeErw80glLLDUNd5nbkqEF6saKZ/e4?=
 =?us-ascii?Q?vtUM7/GwNjtNmktsXjlrVI5wEYk0kbsS4qcSn7s1qo9T6w4lXId7cJgWclbW?=
 =?us-ascii?Q?czXmrBUCopXfks69dIcQA9GtdGywjq0cVLdwh8Wjp1VsKA757J5vyTtR1YpC?=
 =?us-ascii?Q?chFZYeXeaRv5Li0nKT2IX0OUcuJyEvfyf39TEqXd/wwX1jduRioNUpuCpNnF?=
 =?us-ascii?Q?Q+TUi7/Koedv89V8hgosWQNCdg224gZBnoHDHFpOi9xdt/ySLV6AA4lH2d/K?=
 =?us-ascii?Q?dstDPSNkqdJqy0MV5Xs5P030ZB/fpONnksqmZUJ5cF7kTn1G1+L6Q4nRoY+f?=
 =?us-ascii?Q?eaHlfTW8hJqwTfJdoZr+mJEwmrnvI7Y2+nHNqtA3+h260qeF4TuaLbuAUUWY?=
 =?us-ascii?Q?4jA3AEFUMfWckmuCP0qEb3V3FWqLFWfaRI/zuWjoGExxe7BOmOpLU7VM2MEy?=
 =?us-ascii?Q?sXsA2+kxvzRLsZaEhNW0YYLmXSc9ku4QKD757iCLWqXh1dtrfWPH4gGPPXsw?=
 =?us-ascii?Q?rTNKFJLhnbU3Y7/WLotz/Gl9S1HlKAgMMnvULAS169GtuoBwYukU/yQ163a0?=
 =?us-ascii?Q?VUrminTZ/MAcD9izV3eBhOGid7QNC/tFX2cpDdXuk5sCvS9i23hZCIizYDdA?=
 =?us-ascii?Q?3g85C9sR02N8iaSXBft09aaKeyYp4JXVtqCb2oBbm8YOHEsPP6BcyPGwEc49?=
 =?us-ascii?Q?F9TeWXWcGSkTAC+8L+LLR1n7juYD/h3ON/EfA1rGFGX5EZFBg8WKETRx88Oh?=
 =?us-ascii?Q?DGwHCmXLuO+IpYq6p2PKfe3Omsj4C61lNmEGWLUD55IqJ+Pwh2x0BTBHc+gY?=
 =?us-ascii?Q?TRBXWDGk+LCVfM0n0MZ1dEd4WqqZDbNRjvizbjCNPqwop/k3cHQon2TQooPE?=
 =?us-ascii?Q?x0OogwzqroJCcdUHL+U0m1/3DsfdpwVgBeSC5vnQXTccoiSIZoNdWm4mANAu?=
 =?us-ascii?Q?qIP0h//bDZDBAMwjsvmGTIxT54qmo/SKmBhjbhvE0ErnkEMXK2HrJZHL/dtF?=
 =?us-ascii?Q?nGOamr0LnyInR0Mf4Pbyi0nGCxE7Q0aNoUl1OsGkA9Jd8+LAUZEH7PnrO4/g?=
 =?us-ascii?Q?8fuskntcjFOeeSAUgh2gM6G1b5IuC6ztJQ77ElLggYK1Obryx92pfbJepre4?=
 =?us-ascii?Q?YVRhkatOExV0gwHT8XQTJ3KbaKowSiGwYt3Vh22Eq8r8QLpigv6rF6hiNBw0?=
 =?us-ascii?Q?wy3B1YTT7cq0GU93pBBM7p6bkevu8g/wZ7EYAvsERqwniCWsxIe4NdP71UEf?=
 =?us-ascii?Q?2bFRKIdeL1TGEtO2d57i11hLDlskgKRePA1thhsgEg/LHFie1An1EUmtyX3K?=
 =?us-ascii?Q?zxnXh2Uek7WOO6niGCM2U0Fz8NqEibryEDdJqFHuYItnhwbDKNttrcBMcW3p?=
 =?us-ascii?Q?u6Kt6su59kitCWoUIVvxTiJYeFWg+J51Kw8H6F+tbsMwaC6U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0461d00-4cd7-421f-10a0-08de74818198
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:21:10.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yK6kjiZdqXcJH5HNduMgQQMVzFs/5wTwW1mHOv8/YD6EeNixxOT3mX7c7wFXhEUt75NTGov894Oegw9xW8tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10509

On Wed, Feb 25, 2026 at 02:38:54PM +0100, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add device tree binding documentation for the NXP S32N79 automotive SoC
> and the S32N79 Reference Design Board (S32N79-RDB).
>
> The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
> cores organized for high-performance networking and gateway applications
> in vehicles.
>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 5716d701292c..415081423a30 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1827,6 +1827,12 @@ properties:
>                - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>            - const: fsl,s32v234
>
> +      - description: S32N79 based Boards
> +        items:
> +          - enum:
> +              - nxp,s32n79-rdb
> +          - const: nxp,s32n79
> +

can you put after S32G3 based Boards

Frank

>        - description: Traverse LS1088A based Boards
>          items:
>            - enum:
> --
> 2.43.0
>
