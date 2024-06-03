Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463EF391;
	Mon,  3 Jun 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426841; cv=fail; b=SzJFBmbq3Yb4Sv+oXHcMQOpkk147M4oZkl6TqYmFkrZwkXEI973CQOGRarcKvMDwoZ/n89TYo4q95VLX+uLu+mMacNX23W+lyGwkTSoVPzC5wBLAVBOHFiBNsoSGPvBl8TTYYAvBjAjuU3RQUNadVbgGc0HzYs7evIjvUfPmbYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426841; c=relaxed/simple;
	bh=EesVeiUONRoIYjV/LS6LC8wpkAlHfqxPSVngGw2QupA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Emp/49Eovj1E45nHACWXV6vrYN46kxmX/RiZ85gKQsxo9oYI1k3xjVHLmqP0l4SkCEzDNNlP15nFNxfbjirfoRXh/T83TEElXXfwHEJaK+esZY+DeTmhzEfIPxjlXSgIkq8nI19WcylAABL9FOgFEsfr/Q+L36z54BOwwagxbVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KzpRmN2R; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KzpRmN2R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOSE3OmOBRW9hImw+bdUML37vhnoT5XQdW+dXxRYYiF0hMXBZuy5MPN9tPCz+864h9V+hPjMxlKNG5miN4JtCX8eBO70bYnJHjaxZR7hMdLiK73Cl2Ft+YDKBI75HuavLXLEg3z47uEPr/AcfxTok25VVQGiF+ssJmq9y83L6gjdVu0es/taliXfTEpZMtsR3eS28AYvBCrSyJT29QOucwlvksGNCYMdosYGH2FST7HafioExH+ojVYtrBFhamN4qNMJnZQvzYn1S0NmUohkw0i5o+G3juIlXV7UNGekYEdT2cCA48luxi3t20nHRuzdW65pNZpDjHQ6FLGtbE+Rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eiXHN0j4hAbw9JzOWJtZkz4jKhLYpgFdhcefE5feQg=;
 b=ijb7kaXEAqAEYYn/k1m23c+J1sAb9c0BHgE/Hj5O4Z9MBtQDkgDy9tZt0/QoOK/675N7wu0aQi11vIzoG6PKYx//7QLEVlGeuwi5LRaGRVidaKLVXScNzGhvrSfO1FBcNFAaBDd9/NpNrqulMBwWdM9m6FZ567YSmpUpjbiuwxbEXmnGaOP4OpXMpA/CAtEgo0YY9gMlqaSwD/xhTT1jKZWyUosJcsAj6imOu7LKkkdfx+Is0ap+ciIRIRsPuGQMo/1vVSGZZLZHA+o1CtLPp02OhRUcFvfQHW+AkN6iK70kuCHrneRboKry6BM/e5wWYt7MUqDBkUt5uqr0Xbc+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eiXHN0j4hAbw9JzOWJtZkz4jKhLYpgFdhcefE5feQg=;
 b=KzpRmN2RatqL/Z46ydWhBpPiCPGyWLi3X6Sj5gUtRvVg/TPzcBWI15z8f4lQsIxkrbX3GMY8s0bz2r7NQFoguTQrPzZ3WmHjKbDPEIJO5Bca60ptEHQEk1fyf5agTt8s3NJ4aVt4+pL7y6wJ8KNIftLsfgRZfbaWaQr10vVs5Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 15:00:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:00:36 +0000
Date: Mon, 3 Jun 2024 11:00:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Message-ID: <Zl3ajFd05VKULEyO@lizhi-Precision-Tower-5810>
References: <20240531193745.1714046-1-Frank.Li@nxp.com>
 <b78b14c7-e71c-4403-a606-80564a31e107@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78b14c7-e71c-4403-a606-80564a31e107@kernel.org>
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fbf25a-4c36-4b5d-d85e-08dc83ddec85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0CPtFdnRfBfi7lJOCQd5emtloxAqwFnhh4A7smFZNjCVpS0yK+98v8fSvDM+?=
 =?us-ascii?Q?DrNXZgtj7KOkVOpOsGUgMgw/R6jKGzISMEo4uG0G1TEjqOmHWYO2SLt48vkU?=
 =?us-ascii?Q?M6kqAjEPoVFhBy3X69MnZ8sz2dMKdyVZ6xQj9G/O8pvNs8oi9cyYSBKpNsvo?=
 =?us-ascii?Q?OAyL/q0iNK8+WqXsEp72fhEivB74+41SgtjhFbuvEiP+Ynmdb+v3mR+fzpu9?=
 =?us-ascii?Q?XAEpfAOxjjuVoo5ltrKnip+g1IcNYCdKoRNvTimEf7aPEjQRT5ZZiwcR7dPf?=
 =?us-ascii?Q?nl7kZ6KuLlX/eZyheJC+Lv8mZHwnmjVwninXO5UGRK3itqc++y/+Uh8ui5o6?=
 =?us-ascii?Q?e8WgTSJUTCikvzFrDyEGq3ZPh+iJ73mgESzy1noScGsii97g+/uJVtcvsHox?=
 =?us-ascii?Q?VDzJ+Vz8sRmk+rxtx837aR7Pyr//TjCkin+2tYSucmXlVNZvw9DREjFk8Cze?=
 =?us-ascii?Q?S30bCxNr58ieHsmbssgniyiHH4Y86xo9e81r1A6hrUzuTAxsoonftzJHu8l6?=
 =?us-ascii?Q?HbW2X4n7YxGOSsvl4uECs2eRRYySYnDNXmCyT46vQP3v/+tGYrjIh1olnODZ?=
 =?us-ascii?Q?tIUs6fhfzVl+wbLnHEIzMNQEyF4rQ7sKVSws1NW8ZGEh7zQSy3ss3i0+mmAi?=
 =?us-ascii?Q?KCbAkkGY3HS3vb3s/TUoX/QTD85RQO3hYacc7sRX895UT6CRt2rjMz6iNOUH?=
 =?us-ascii?Q?JTiOmq0vbmUaAMs7RCzgtkLgOPcSKyA1IJ/0ENRP1GLRuJSubsaLfmOjgODh?=
 =?us-ascii?Q?xyLYr6n9ebRhkbLU6RJHb5Q6V3lY+NWQ1iuQtD7Yp1pOORgEYj3B3o8RHD5u?=
 =?us-ascii?Q?9t6o+5xJsRwdrRc2FmJ/kn8Y2UupvGqGauKGXgbm9Voa/pAM+ghug+Ii3Dva?=
 =?us-ascii?Q?G1Av7FzQJW2xPU/80uiJyVoMNTVTVa4oCbM/71Us/JlqQ9qxHwOxYNPhH4Zx?=
 =?us-ascii?Q?PxWLzT1zuY2biHZZpnST+uHXrS+yPMpOY4Vq/hP0HduAbPHt5ORe1oHJvjiC?=
 =?us-ascii?Q?MO8Cs9Y0+YaGFGfCMjgB5rPdU9Dobd7ollQsqtVlGRBg++d3sQ4Fj4mvcUk0?=
 =?us-ascii?Q?UEB1+MiTG5hLGq5GSkiSItdpqNwBemloHT298SX9Ax3u0SICJ8KHdMd7uqqL?=
 =?us-ascii?Q?R9C2mOBUyQMSuz6q5jz5ySJoRtkSAb2HSjm7X8tEinhXRfT/Vxyh5jhY5w1F?=
 =?us-ascii?Q?0O9YnRu0Zqr6icNWZqC0B/IjfMJwTiADlmz07iNyflxPZVeafNWjgDYMHJ21?=
 =?us-ascii?Q?etckAeHwvTDSfEGWQcRalZijJo+wtYLT+NeDCHbV/knLGcBLqwAtos61PGxS?=
 =?us-ascii?Q?UOYbtfrcx73o6JoK+9PRKrj8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vypXhQdWk0ZAfBtgjGiPFcArEzwOSNN8u+l8axGF8oeZ/s2rL1Z008gkxxu9?=
 =?us-ascii?Q?khgF7++jiASO4+XEIGEXTMwUdsZIO/CzYhAtxFRgC8iN1rMjAhCISDeAi7pm?=
 =?us-ascii?Q?KrU36CcRbI6U9nRT5CDGvz3qQWdREMvbI0AdUvJNLGI7QIml01VL5uwVp81s?=
 =?us-ascii?Q?EKOvKORvMyaW4HV/uKFgz1w/FOAemMCXARnM/xpFrktROdCI7x9ABV8asBl0?=
 =?us-ascii?Q?BH+CyBlbDrxCK+Az11qTMy/jESV8SY9gJWd8bON+ei9pUdDE3csFDIKEfkTB?=
 =?us-ascii?Q?pyjGTuwHPOrSptNQ+DVze/3E5ezsoJ2TRG0/dcxCbYEfQdx38aIfPh/b+mOM?=
 =?us-ascii?Q?RAn3Gfr9mlilM0tkVyXqcNneZEBL0QnwAx56XVkDh3Dr1r+AT+nQ78H7+0mU?=
 =?us-ascii?Q?TEk7gl+iLSamGzCSwt0ogxBcgt16DyBM+DftjokLosRgdPG6BNzIou6MJaVI?=
 =?us-ascii?Q?+jh6KL7kK+50fZbSzmyXfnagBd6ILlv/Pgl1AQCwxM/d2Xt0q0GQX501UwSF?=
 =?us-ascii?Q?tCw36SpmuAhh+XdsIu0SREVIJMUbBKmzdNWpnUhKl9T8TWSO9hmPIo1LSfqf?=
 =?us-ascii?Q?JvW42vLqUzYyjGhuEQNE7WmYwdDwrk5DOCy59afnLJf1ZSK4dt8FRiBSfJSb?=
 =?us-ascii?Q?QC4DBLlyJuFtteClOBfMyVACOM2DU9FCyUVUtGLq0xSgVVGYajAxSeCOapaW?=
 =?us-ascii?Q?Jxjvz4TH3nhQZPzxGn5d/R61UVTs305i/JAdKSBAW9VJZh8/6WRz9/ghnSOZ?=
 =?us-ascii?Q?HWOdRVNFyZQuVO+dPB2h1bjw95UlUQmu3B1ye8nQ1xFguKuzQt1KyWn196CW?=
 =?us-ascii?Q?KaUnzEtw9aBYDyXPQ+D3TYmcrenGdTWuIcjVFtYi9iR9/mLTi7OA8P11DFLH?=
 =?us-ascii?Q?O0bs3Uf/l93NImvCcFs+I/OVf4FUCaWAHUSM3zI7mxiy5O4ZF6hJmBY74y9G?=
 =?us-ascii?Q?Qv/P4CH8VwdNggKUZCMnpoDzNb57M8KQ7wRjkM1hSXSHxY+nqtiHX6c8cXs5?=
 =?us-ascii?Q?OOHPVw8pShM8uX42sbHgGhdTMdl1V79+9TgYOdycboBRxc9Nu7h/WTB/TM2e?=
 =?us-ascii?Q?MxozLYxsrv/zi09jlllrqfEWtRjqcGjZlVnc58v3RIfmcgbhFXusZz3M6w00?=
 =?us-ascii?Q?/AgvT+iErolUDLr6xa2A84X/J4bytYvm30MhOdN657yRdemE8B2Kk135vBWG?=
 =?us-ascii?Q?rCsgaks/s4652vE9E1klnlBB2ddP4kjrhsn157oay5503T0GWjYGO/OZl3iX?=
 =?us-ascii?Q?bDHuTV5MpldMaD5GLvURQFj2NNBxKdoYbZDtJA4+zCJEOkDdYkCm1Es35hvy?=
 =?us-ascii?Q?TBavFbnd2wgLtJ6JGOK9BvwsHMr9OHlhc8ie23PGacFbsZp1ksJmBEchIhpS?=
 =?us-ascii?Q?SaK/aKLSCUr5dN9kVYMLk/HvqOnohAm0buFuRQkptFVAoLg36b4usLLK2s7z?=
 =?us-ascii?Q?yPRbCPKmgHKj4cH5p8dMOo/OQHFW6O6W0GN9ZkplseM0E6JeiTtUuUI5S9/r?=
 =?us-ascii?Q?ft5dG1vUSd3KZxSaFvDQ04Omuwi+PabKCAlDze4p5mB1ddJvnmUT/6axH/oq?=
 =?us-ascii?Q?RR03HPLYjmdtyd8hcGiBY9ifHoVuQkGUuatUUvOj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fbf25a-4c36-4b5d-d85e-08dc83ddec85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:00:35.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFFGSzyCRO8VOpwDU3LdgaO1ik3prMVr9kZ1braOsEgP732Thf6/0g2CqppGmJRhSSM40pOW8A/9cIEXMzXsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050

On Sat, Jun 01, 2024 at 05:25:46PM +0200, Krzysztof Kozlowski wrote:
> On 31/05/2024 21:37, Frank Li wrote:
> > Convert layerscape fsl-esdhc binding doc from txt to yaml format.
> > 
> > Addtional change during convert:
> > - deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
> > - Add "reg" and "interrupts" property.
> > - change example "sdhci@2e000" to "mmc@2e000".
> > - compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
> > most existed dts file.
> > 
> 
> 
> > -};
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml
> > new file mode 100644
> > index 0000000000000..cafc09c4f1234
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.yaml
> 
> Filename: fsl,esdhc.yaml

There is fsl-imx-esdhc.yaml for freescale imx esdhc. If use "fsl,esdhc.yam",
it may confuse user, which will cover imx chips also, actually it is only
used for layerscape chips.

Frank

> 
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> 
> ...
> 
> > +  clock-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: specifies eSDHC base clock frequency.
> > +
> > +  sdhci,wp-inverted:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    deprecated: true
> > +    description:
> > +      specifies that eSDHC controller reports
> > +      inverted write-protect state; New devices should use the generic
> > +      "wp-inverted" property.
> > +
> > +  sdhci,1-bit-only:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    deprecated: true
> > +    description:
> > +      specifies that a controller can only handle
> > +      1-bit data transfers. New devices should use the generic
> > +      "bus-width = <1>" property.
> > +
> > +  sdhci,auto-cmd12:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      specifies that a controller can only handle auto CMD12.
> > +
> > +  voltage-ranges:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    items:
> > +      items:
> > +        - description: specifies minimum slot voltage (mV).
> > +        - description: specifies maximum slot voltage (mV).
> > +
> > +  little-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If the host controller is little-endian mode, specify
> > +      this property. The default endian mode is big-endian.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> 
> clock-frequency was required. Isn't it required now?
> 
> > +
> > +allOf:
> > +  - $ref: sdhci-common.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    mmc@2e000 {
> > +        compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
> > +        reg = <0x2e000 0x1000>;
> > +        interrupts = <42 0x8>;
> > +        interrupt-parent = <&ipic>;
> > +        /* Filled in by U-Boot */
> > +        clock-frequency = <0>;
> 
> Please provide complete (final) example.
> 
> > +        voltage-ranges = <3300 3300>;
> > +    };
> 
> Best regards,
> Krzysztof
> 
