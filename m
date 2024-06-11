Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC21CD3D;
	Tue, 11 Jun 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117914; cv=fail; b=tmZmNCZAPt+gRIuuUqmHElodTKmOWqkYDkcBMfXFhXgSjK1IIAFuDE9afxoEiYmU7+hY83aybojU8UvNta1/+tBvXLYdKFfr5MQgufZWLViK+gSuUW+5LE+EeAqpLcJ1Qi6sLqOWNfUH/HPI2IxoIDe2lJ8kpv58XnFe0BoVLl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117914; c=relaxed/simple;
	bh=+d19gZzoZ6cIufA8b0wcNIU9GqIizvEWrjXduRHoly4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=esD+eqHJtSW/0b0+AXXcu4TT+UCKzWCzXH5mLChE/1hoq6EaZEseNyXIPpTy6ejb5J59lTNdPYFLwz4pX41pY9DN3DFHLpMNqX05oZ/Pf81R3YFF0uEUAwCC6eeTaolqaVF1cv1yvRTcANxfsVulH/fCkv5rssn5ZVYyscq/uTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P0Bo7jkd; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P0Bo7jkd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS5EL9lr17yflaN6Og1JaaOElNSwMgDl6N/6arpHRvWaDLLyY9nAHg/GG08iCJ3X0cZ6GioT+r47nl0dQv6qzRE2FvacMWu8xaT3octlIJlA/ohXAzX9FNRj7xjDmA/i0NnWmSb8/LYW1VHbnbnU5k8AgGmF2yUXscL7EVAuFftX7x73GSKYBy0K0sxOLhBukuacFqvQvR95L6MRO5ygy0enRU//OJE9pmX5Dvyq1ywB5+WV0go4SSkOmeKpB2Q1qUqMRRQvGkBt5QE8oDBTGDpv0ViYf+I1NOKc0dmc27VeAX3c1yp2/HQFngQ0YgzMZsyXXuqcqVQXigQWjW4G0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwdN24HSSNI21SbpG+ZEe4+IXF6SviNae2+3XTYJ/9A=;
 b=IYkESyWmDPUhG4PeXFuHtSOtK7GGl48ZdTVfGRA6SIhktwA1u9dcM9+j7YglCIzPrgCzG8Uj2bc/TCBXHNoO8/Rul1EJIodtD7icaXUerkdoAsemOoeuFlUK3U0TR/3drDLUXS9Ojj/UiB5z8HBkF1L/uD2kJVsJVpfrhL9n8LwDhpylLDHqpH48ta0bov+CWzr84diVVtSictQS05VTxsKUkAIrQC4QxhqXPMmy5OyRbG4vk/tiuKiWDA0lusvJl/TLMv7i5/y9pr2lH58nyKDh3BvAV2doCLIAte4R0TlDOknsFPt3WMhBI7QczoB89Buy4FQ+kS8PkY/Odwytvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwdN24HSSNI21SbpG+ZEe4+IXF6SviNae2+3XTYJ/9A=;
 b=P0Bo7jkdmavvJKrrTssQQpgoYDu+dptxHw7L6vdOIaqr/dTt57PVfpbbrIJwHPEkrBw1cNoBCkv8c7D3fCeF//BbiAVJlpvirgoalne+iGEZVTJeui34s+HPcEzdEUDX6p9e1Xlbkq0tbvIDIuGVxZ79DHlGxXRmCPFdJOMAU3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10010.eurprd04.prod.outlook.com (2603:10a6:10:4ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 14:58:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:58:30 +0000
Date: Tue, 11 Jun 2024 10:58:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, robh@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Message-ID: <ZmhmDTOE3GJ7jN2G@lizhi-Precision-Tower-5810>
References: <20240605185046.1057877-1-Frank.Li@nxp.com>
 <b1c51acc-441d-4484-adef-1da368571097@kernel.org>
 <8901d498-d30a-43db-bda2-25d3d1d58e8d@kernel.org>
 <ZmcOyVmI5GhRUuVc@lizhi-Precision-Tower-5810>
 <1a5144e3-aad6-4a1e-ab9f-4c879b050d45@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5144e3-aad6-4a1e-ab9f-4c879b050d45@kernel.org>
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10010:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bd3e0b-0cdb-40e3-b2c0-08dc8a26f4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|366008|376006|52116006|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flluQf9EWJkZdyvYx+rZ6kX+NrqPDOSVsfywjIYcO6MZRC6IsVE0V2iBd3PA?=
 =?us-ascii?Q?5dj+cz3qg4EmUKPu4jKNacRKJFxhuIVYBlLTyvojfWTohESOWKtNrcXugb1x?=
 =?us-ascii?Q?Ig05jYeevRDLo0K2L4vCW5HLUbffmphNG5Jeu+zYaJdvsjp8hE/ceFz679AJ?=
 =?us-ascii?Q?CxHcVnp0jpcVy7BU826pn8rkPep4HCm5wrLAZvGm2yKsQwHCq3iJBRjsZxiw?=
 =?us-ascii?Q?/ut5GOPduvXX2yeBMLpflRLuQwvnwVljQa3AcHHV2VHfVsg8ZrT45WZsRGY4?=
 =?us-ascii?Q?HmZkM+i95NO8y8mGMHa3YxPTiN313ITQSunniWSaOF3u/sbGyg/PUNVOhInk?=
 =?us-ascii?Q?UwtYCi+XQIDmQVLN3ZJWObFyBThjmR5pZRKIh1sF09+tpeXnUr5cCk7tnnng?=
 =?us-ascii?Q?I/mPJwkLD0nxLyMroPuvwIulGB2YhMGNHlEetilKDT4/6EFcQ1g0zjOgZSUj?=
 =?us-ascii?Q?HvCe6kanGMaU9tRlUxtt4TSWPmj+8wVzn1Et1p0xUbrrmyv/+C9ZRjmzZ7b5?=
 =?us-ascii?Q?nsRFGoeAnI1Mmin4gbZ+9fnwfol5iXs4KdkdmSOayC4Hns6VT6q7QISh1OqA?=
 =?us-ascii?Q?w+7NSuoetDNAX7tJ4k55/etNI0LiMq/YXjc1/BFAuxxO0JU4kMZLr7iAQl/I?=
 =?us-ascii?Q?fB6iJ5OTVpy4BCTArm8F+gbFP00xD3DPA4E4ubHI1D4/uMC+o4P6PQWajuXL?=
 =?us-ascii?Q?y4rdIlAkpwV3PIX9nJoH9G5GBzZQ3chkc8vElVBbmvY6OWtNCla25yGgKbRl?=
 =?us-ascii?Q?47vrGMdLAfQExwiOoWnWbheeCiFU/AgYJZ493KgzwCPaRaFDKQ7FDrdmiz2n?=
 =?us-ascii?Q?4L+N0zW9oObX9jvxGeUoSCyQGROfLMjHFIyIcS+dp5g2b0KoDqmOOO/Zoa5W?=
 =?us-ascii?Q?zwlLX9iwJdweUVzbz4n501c4StAuQboIKF2CQUlDGSOJ/vpnq2b1R/b+ruCw?=
 =?us-ascii?Q?CRHcbDvz3Ku/nZ4zTQx8Fd7ZvV7Ixk2k+ZQm0vyI8/G8/mL1mJwPUpoztTH+?=
 =?us-ascii?Q?g/BYF7p3Nq9ulhbCvnJlpiip0KROxxUrHJIzEfFSqK6G3TgzTKvVYQGzsB5a?=
 =?us-ascii?Q?wBcVNGQGOMCqvZKw4jouonda7FAcCZECkC4tfuNUyJw2pG3SiyW4BBljK1pp?=
 =?us-ascii?Q?wWH9m0NbS5kCOInGKyirN8jxp+tafzTe6IeGAC51MJtOqpKIyN0o7xU0qYnF?=
 =?us-ascii?Q?83s3vZ/NbtqxcXczCSj+oT/FLVSg7tIBqwweCXvsF+XF2VDi1AnufeaY154G?=
 =?us-ascii?Q?cL0QdOd3SmomSQ5xnsPh9uqrETcxqHuOUxQLj7s55NlQ3h3Jh4InMuh2/IOJ?=
 =?us-ascii?Q?dYpp2neOEv3yoHzzGKGy1GYQfZlMbUPIKI169DExVRAzWcO17jQUShcBYS+K?=
 =?us-ascii?Q?zIaAydE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(52116006)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40OeXGetQGO06/UehospDsDzDiciWtJRDc2ACFM+jifLBQbHId0SoIe8K/+7?=
 =?us-ascii?Q?eAncSQmZWOXQUCgX2ymUnpv/7y7HhMLZ9xLmgeDV0788+nIhWUZYrl+U9Enu?=
 =?us-ascii?Q?HaizScGc3iftA7Zx2P1B8EOXvkNtmq9YkPc9JS4J7Jdc+6reW5T8ryP6TD2n?=
 =?us-ascii?Q?KuYMiP0moQhCXxWkmKy+3NjN9VxCWiFxbPAPy29WW3ijbj1jlcZbhhhSRAY4?=
 =?us-ascii?Q?dpPXmc4TWVMIItXLZIEIl55gpJEceRgQsc6jnb9wQIp2S0RpXxQ3U6KfYHE0?=
 =?us-ascii?Q?OCaR+VV4k6uHRFHpdE17lfmu6ukCReP/h8BLz56tpEmOvYc/EQMskLPuSBnz?=
 =?us-ascii?Q?w2AzexoC0mGuahPm5Y0Xf4JimGAvbNws5Y4PjYzzJP25lamIv1CGSTfwrIk1?=
 =?us-ascii?Q?TNezi5c7dyl9ZwGdqW3bCkuRQTcDrsHj9wzZXrvmSLKeOxPZ7LyYQgd+RA+U?=
 =?us-ascii?Q?WzKy6KjviAZt9UjKOTszQ4Wtij9bu2DyvylvwnwtkjXYIZSCsud7PilvVwCF?=
 =?us-ascii?Q?cTcY9FtMrLg8lIGsRCj4ff+MZuyW23QLZ88sjA2Xc5ywV1hpi829X8mtG9MQ?=
 =?us-ascii?Q?sINa1dARjRiLx3tMlGkFtdzwiA2jTcoo3r1vwSHizoMX/FNZ+0RVp1btqZK9?=
 =?us-ascii?Q?+lcN/wELa7iprciZNOUqFQdmIr92OlwrrZuAdQCYD2f4PTBWhW2pnDJN+cR+?=
 =?us-ascii?Q?IOy6SurAzpSBFHmL76CW9ErBLFt1h8LMmF5rakWyIQI2WktoooGN4UCaroRn?=
 =?us-ascii?Q?A+kKX5MlnrYvu8+/ka7GOuV1YIAp1LSnfVuKy58S2LOD0qC0rex3bhQHl8ex?=
 =?us-ascii?Q?mJs4dAp9alSgFfnXYDc0oVEsQBMFoLNBKoU17Vpc4AjxP6JkQfuojxx7Hw5V?=
 =?us-ascii?Q?VDEMgFCvFsuip9t/GnPVCBsP9iapUvi3JgETU8MfdKsfrweRqu1Kk7ykUbal?=
 =?us-ascii?Q?6h58mqPT0t51YgUDNm7EFguf+7GgRpZre+VQJMDA2aDRAp2OHN7rCyReYXvg?=
 =?us-ascii?Q?Bkt1ala+1568vSK8Eg1PZAyEM+PyE2dCDMB+ZF59QOJ2i8aHGWNNQkhgA6Lc?=
 =?us-ascii?Q?flCSNoib3lniaO5KBXxSeUCnaiyEgRS0nNn6HzdY5+JSAsSsEdbVZLDHHLu/?=
 =?us-ascii?Q?+zDCvZ5MKnu55+DMiiKwfYM5+MU2mOh5LTPyfgNPTccrNZ5bOP6T1l94ITQ+?=
 =?us-ascii?Q?uUEkWJQuc9R9baOY94Lg/opvZY2aAReJv4q7+DkNITamo/AC8+HxCZ/FKM+8?=
 =?us-ascii?Q?j+8LNVy9vRIMYfrzZ3EC0Zh/+gVphKqLKUxM0A5JOW+m0Dz6I8xnmYAk4vg7?=
 =?us-ascii?Q?iKYCbRuPryWg/AHa+L2sDqBPAas8Da5GNrIsKAH+MBEPBKqrzX7vA/vRgTao?=
 =?us-ascii?Q?GttmDmwgyaUWuIPRNzeIhL6YUmsk2vzO9YxhuaSwe3kxDrKaw6xLYHP7Imiz?=
 =?us-ascii?Q?D2scaToS8SCELeOKd7EW9nyVxLfwT0JEGsJsYn3cEnpPDjxcjqQGylFKSBNO?=
 =?us-ascii?Q?ZxYQxNJcqdZNG74LoMcf7xgYBOJf5spQlWO0KQY/8izp/sQtR627gj+UVt0w?=
 =?us-ascii?Q?DPgR4pRZemH7rZMGS3M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bd3e0b-0cdb-40e3-b2c0-08dc8a26f4a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:58:29.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfP67R8q/u5LzbKgxLfKkVuMg/oyyNopt5R04RI+CWlUO0vljQQTcCDRYgENWbtXIBpasdsUdr30xMUNCooxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10010

On Tue, Jun 11, 2024 at 08:44:51AM +0200, Krzysztof Kozlowski wrote:
> On 10/06/2024 16:33, Frank Li wrote:
> > On Mon, Jun 10, 2024 at 02:29:57PM +0200, Krzysztof Kozlowski wrote:
> >> On 06/06/2024 08:44, Krzysztof Kozlowski wrote:
> >>> On 05/06/2024 20:50, Frank Li wrote:
> >>>> Convert layerscape fsl-esdhc binding doc from txt to yaml format.
> >>>>
> >>>> Addtional change during convert:
> >>>> - Deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
> >>>> - Add "reg" and "interrupts" property.
> >>>> - Change example "sdhci@2e000" to "mmc@2e000".
> >>>> - Compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
> >>>> most existed dts file.
> >>>> - Set clock-frequency to 100mhz in example.
> >>>>
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Or not... are you sure that DTS validates? Did you test it? kbuild has a
> >> bit different opinion.
> > 
> > Need additional patch to fix this DTS warnings. It needs convert to yaml
> > firstly. If you like, I can create big patch set to fix all emmc related
> > warnings.
> 
> We kind of been here... I raise the problem and you answer with
> something unspecific requiring me to dig more to prove my point. I am
> not going to play more of that game.
> 
> Did you analyze the errors?

Yes, only strange thing is "voltages-ranges".  mmc-spi-slot.yaml impact the
result. I don't know why mmc-spi-slot.yaml apply to 'ls' platform dts. Any
way, below patch can fix this problem.

diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
index 36acc40c7d181..51cf2e4270252 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
@@ -27,7 +27,7 @@ properties:
     maxItems: 1
 
   voltage-ranges:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
     description: |
       Two cells are required, first cell specifies minimum slot voltage (mV),
       second cell specifies maximum slot voltage (mV).
@@ -38,6 +38,8 @@ properties:
       - description: |
           value for maximum slot voltage in mV
         default: 3400
+    minItems: 1
+    maxItems: 8


I will send out all patches soon.


> 
> Best regards,
> Krzysztof
> 
