Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072.outbound.protection.outlook.com [40.107.103.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11D17E466;
	Wed, 12 Jun 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203020; cv=fail; b=Qs4sJP19rI5H9cj/skVG4oOl3NoytII7UD7zmEGZEL+dyf6jFj77/0GkQN/DPZmEEvByJ3d4CyHpHu9zwlgFY+46lZX0UI5asdGMmTOnqd5bllN6+xI0YLaA9FGJT1AvKZrQDnuhNlgjrD4tGnPDD5BdWtBrN+EJo9n/u4G57iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203020; c=relaxed/simple;
	bh=ZDWRmj2Ohpcn0g/j/x42JDtu48plH+FZvg8fT2rbZco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8p/iR52meD8q+GP0VhSRD+NhVB7tDW7IRU8XF54h3DMZD2v/27JxdXz3xyklwiG8Pv4xrqci7mqcAodCDEtftt/Pgm/0NqTtFrDUC2iCNLJif6HYkhUElFSGkYUwQgAkF8mLlMso3uOKwuiuiYnCAXAnDrYwcGC5FBKhWF+tDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PxuPfFmM; arc=fail smtp.client-ip=40.107.103.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PxuPfFmM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tljj/m6JSn9hqEUUzWnb9bTWUHhBoCsesg6M7Fxltdvrsu8hA0YPilUUbQx8zq6WXibdSqq4JyCdZrm1ny3Talv93ts5utOwCjmZbjqZWzHFRwTpRqBvt600aQrgR6G9/kxpr8uyA9TL23vk5BmqMTVFceyZoYMPEKQt+oWjK1K/+4rC8WemEFHRoA/cX3n8RYhrOhLUVgSmMljpQhkP+0d2JCr/nXYeM+oJhtbxNK8eP4yFdIK3JNK7ye0+pM792eHwF8OpFKDvfeloZ9FioihHeklaQTzL54G3LYd3NGj23afrV7yYims7Cn5PtwhEuutFiPXJYLoibpnWrHWXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPDA2sIE4yEDkMfPIxHFrhtZUV7nqEzh3+gMGZrP6tM=;
 b=Lq/fKgRMw3LOyUOUoP9mGhLReTcCXAwdpBD80BohPJkqXJvkPbYNQbmD8QRrkrlHFTwWFajsAcxkvkYeCOc+a62qvhjctqQ6YwLIQQ6YiTsXW+ARO0x+yVpvSHkiYfZEFyfwX7I5gou4JNxZ+TNNm6mdPzgzI8R3FZXBt+O1yw6fv5l9mg8//dHKFvC0SdQ6/WimtaxrcV7vqynQA6HEI0K1IB0oNWP+oYhX5BSU6iu1w0HHeBxcnEpizpVzhhpKrntSLlE1cFxx89+apSJmDGJBR86qLMz7IH0/E2zgANtAxKY9U24O78MJspbwFG0xUMW5wx7LYfoP/QOxb6Il0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPDA2sIE4yEDkMfPIxHFrhtZUV7nqEzh3+gMGZrP6tM=;
 b=PxuPfFmM3gvCyzQTzAibF81/cSvjofRsOpSjUyuZ+0jI7T2QfCw5lNzPP1/6KNh6yz3cRhXtmj44GWgiLWUzYQRTMM8qQ63iDPkmSWhiUbT4qDVfWrFuIa5NBvAOcPzifmOTTP9UzAcCpdWm1MwmYe+d1lRUsdsOG9/b19v/pwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 14:36:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 14:36:55 +0000
Date: Wed, 12 Jun 2024 10:36:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 2/8] dt-bindings: mmc: mmc-spi-slot: Change
 voltage-ranges to uint32-matrix
Message-ID: <Zmmyfna+DoAcYzHp@lizhi-Precision-Tower-5810>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
 <20240611-ls_waring_esdhc-v4-2-d0d8a5b3f3cb@nxp.com>
 <20240611202311.GB3003237-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611202311.GB3003237-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 124be509-f42e-45f9-bbb1-08dc8aed1b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|376006|366008|1800799016|7416006|52116006|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i3IhzMz9hxlKNoU9pftge9TELJSc2Y8qlSM3NwM+E1bblKhn1m2HY1/c86q4?=
 =?us-ascii?Q?iDJvo9imPyV8IV8/cwNvD9ewVduW18Xa7lHtEc5jKplIFQF2O0hUZmezNYJJ?=
 =?us-ascii?Q?H/kOf7mtYdSzSuxNoRs3ZLS/3SqhONK2Tg7Y4BPJ9rjCwdzuM+jkKyJXvkuI?=
 =?us-ascii?Q?MRdyELXBgFL0rBrCl1YXtCh3/kc7OENy9pNcEnIgy5PTKIGrbynJGlWDIGiG?=
 =?us-ascii?Q?zA7aZqcq2U0SzK3CRjUnVUL5Tjxj5UbLdGtRjrxAmsEjl2BujhaaYq2aOYZY?=
 =?us-ascii?Q?sNnu7UhsQ2SKhzmfFFivj2QCKjTd6Tv07/Qcp0G93P88J2bNkhLeIl3zRsIL?=
 =?us-ascii?Q?a5XD5xM6+LoH8nb+/i+0UcchelPMfTzV45fpIVKXUtGdrf4tk42wyIC7/fyA?=
 =?us-ascii?Q?5dgtk4C/oKEEiknF8RynHaTBr9s5oGsW5vo1n7ycJc10+PkS0y7/7POg513Q?=
 =?us-ascii?Q?7KSCX3qGVsfU9z8Xv+hyKez2iQ4hC0jfLbEgTM3ZwbzVkkeiV5Nf8buRGtLX?=
 =?us-ascii?Q?74RuGMycNw3EQZ5ddSL2aaNHRp6PrnWQGw7VhGkTWR2fMiHI0ax7957gIJ1j?=
 =?us-ascii?Q?8qALdqofcfxGIqjYK1Q3g9NSQyIhqJzkw/yCW/P+gVtLBetHlVJqlYmg5UEl?=
 =?us-ascii?Q?FW+yDUDKU/f4M5/Tx6HICGt0qUEiPlvUyZr4GfuyDReKbpnXhs8mRE2UNJpL?=
 =?us-ascii?Q?7dMcASWO0BypvpbVd39c6T4+dBNBbGi0u7/8xzL2VMq4TuZmxpTw6vwbt3i0?=
 =?us-ascii?Q?OJuOFzmiyBXUylsuJim+Hn5LsBrJ0gDrFAfzjd+XUB4arFspzzKgXuC7tGji?=
 =?us-ascii?Q?Kz10AY+UIihhHBl+o+z19cTwv8iZgaUJrGLCnPVDDtyNVO33Pd9i/W8MiajU?=
 =?us-ascii?Q?Xa5IG/jEE1SsS+uYoY5G5Mw4Ingv9NapjaNv1HTDd4WVwj2we0h0hf7/rwUV?=
 =?us-ascii?Q?lYtJISIl1lLrI1EibXrObP35yMS6Hc0YWKKpyR7BCTQFgMXOj/IeOSAilpb/?=
 =?us-ascii?Q?ZQ7lzJbyYjb7eAHyZRUeJiSxdIC9xnOWMG9Ch+8WIY+ooWaWYLxUfymsoaqc?=
 =?us-ascii?Q?e0kkaI/yYsNxWjsneoLzI/R15x9suPZ30IcNUEAAsM685okUQ+GTHn8zZznh?=
 =?us-ascii?Q?eWZ75kvaWRoUdPXwTkSdxmQDjkPI+t79Zf68udDGmyyqqdHsGtg+T2bGgVk9?=
 =?us-ascii?Q?pYy+D6z2vuMabBSdFZn/e2TC00gVNfnOfaZVYlt77YxtfJ5Fv6yXdScknmJt?=
 =?us-ascii?Q?Id077Bq8/ThnwNqUpJ8gKkJmMDAlfcbUppON/o6poltWa76pK3lGm3kj60md?=
 =?us-ascii?Q?a+ihwUfG0v4mtViV2Filct4qEvG+BT+6ZHQ0tICD0d88oGWRNfuzZvyGjZCE?=
 =?us-ascii?Q?sH3ULiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(7416006)(52116006)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWDPmcHdEWq6jqhndtWVkUA+5turB6L1K30P/TY2TrHtH7cKG3TrkH1GJE0S?=
 =?us-ascii?Q?53hfCUxZfxh6fEW4Mn6Tsw6dTlWS2LK33Mh/r7S3D3a/t59PjHD198pGlmyQ?=
 =?us-ascii?Q?H1bwBFAstMa46zNXLHqBaSyJ7fG9/Z3R2sG8vvcGDL/sPA6sAPfDjurgFVL0?=
 =?us-ascii?Q?lBnLpcbjEHf60I/qr8D/47PhkMCCw8DwpyGOJ+VeQ5cUrzNOhNojoQ3Rqgqo?=
 =?us-ascii?Q?DoT2WAdTEty+tl3FbsDwbqyRMyRzxNE5x9nPMdw7AzOi/6NJSbtpDzjnZ5k8?=
 =?us-ascii?Q?eUxzPTnpGPuQz9kDQ2kvj4HPsp0fegUn11nILJAiRrQpPi28nUm+GucZyCoD?=
 =?us-ascii?Q?whcA6j5lKQYmtLyy8NdONdkAoJjpCLDDUFEiMX/VmCiSyOKWMC0ZCJqj6UU2?=
 =?us-ascii?Q?Bk0nOtBUFGiJx1Bn1ZzXJEB602cdxVVqJauSQ+BLIDUu2xgPyDA0DZZoBQqj?=
 =?us-ascii?Q?bHUaQ7AN3lODNmVznAVTU/aEetn6UbpgnkmCVq9UOvI0pOGebFxloUr5bren?=
 =?us-ascii?Q?JTtpAsUYZ2EDfcEb1hPFqLlB03g49aVPIijPCIVM2lwQ4aInQ4VeYhEwHrgx?=
 =?us-ascii?Q?7nv+PO8doqYKBfGTT6L1Luk5wUTG542WsCRQ9pjQDFMhTNAejx38dp3VHJEh?=
 =?us-ascii?Q?65chaDhDN8CxlTzHVd7lqNRxpXihh/cKONdJTbra1dRKAehoBmBP6/+9Yn/x?=
 =?us-ascii?Q?INH0MPKwlR6Vq7JkwcqntoBjUxVdQNGq5T9lRAsxO8duYkmGGrAlheDEqOMd?=
 =?us-ascii?Q?gIuY1rTSN9oM1zxsak985uq3qshfg/+pJoupX3JyMKUSo4JeTJ0ncru4rZAM?=
 =?us-ascii?Q?4hucO3dcUCdJu84JVeqG1G/ERBC8Cya6EsGrwq3w3LdokoTZrvwiGAN356lg?=
 =?us-ascii?Q?GJ/1hCJog3R8wRMvGHpNtNDmLLGKwDDQWv6TPDTIOgN5M3/onl61+CI9t2oo?=
 =?us-ascii?Q?ZdSICAprBQfK06F0LbT26NuCZKGIlCnP5OKSH3Dz5k3ZlWmcRAyFN3Yw/R5d?=
 =?us-ascii?Q?t+OeE7RBzYolBm11NEjcyA5HdxY10Zw62ZSxDl/uG7olzys7apwOP+Uh6+hp?=
 =?us-ascii?Q?GLZ8c3tPLdcfXGAFWk9sIDbeC3C6xm6KOD70fHI3bugETq98q6LndmWKC99F?=
 =?us-ascii?Q?Vuk9aXg6nKvpfCOaGrpZ4QhAg1RzC0f8HhEkl+vPNrVw6qPBxxUpiEobIKij?=
 =?us-ascii?Q?TcHCm0kBIsPnbXPYa0LAt+lR5n16e3PBbFX5ImL9QoCYOZQrlRkxaneq71iF?=
 =?us-ascii?Q?ZbVl3tHQTlJG2qCJyHge6upq7zDHVMn/eFsQtlLdjJGXQO74fCeoj2Ri4bBS?=
 =?us-ascii?Q?tVBfEFdBCdPTLJ+TPTlGsha6ygeFzvh8ZoSjcqdTOLmcL70DqabQp5yqqeEt?=
 =?us-ascii?Q?pHHSasFJTLHY1CnBNy23FWgzTHLoYeiMVg13CTgg9oLxxmI5BskHMIKpuhp8?=
 =?us-ascii?Q?hOawCLyKMFTocSHyqntrSaTPZ5K74x1qqp+28fJCETm7kAB08u+Dtz0cheHx?=
 =?us-ascii?Q?MENeZc/KX3g24XVeVCDtXzAy5/evnb6ZZ/hg+l+fwYPz2c1dQy6qjBCiZ454?=
 =?us-ascii?Q?3lq463wpVbyfCT7PVCs9NjtVRdnigMukr5oRhVtq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124be509-f42e-45f9-bbb1-08dc8aed1b4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 14:36:55.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/a+0hQjyWrNjdI9Cf+fidvJM5UU8zorjLA+2gZ+vA8YzkSX5RYd/c3+ph8pQJKjm1dQ+Ya2Im08XSl0aIo26g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218

On Tue, Jun 11, 2024 at 02:23:11PM -0600, Rob Herring wrote:
> On Tue, Jun 11, 2024 at 12:01:47PM -0400, Frank Li wrote:
> > According to common mmc core, voltages-ranges should be matrix.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > ---
> > Not sure why it impact other mmc yaml's voltage-ranges.
> 
> It's a quirk of the tools. When decoding properties, the tools only know 
> all possible types. Types are global, not per binding. Sometimes it can 
> be figured out, but cases like this cannot be.
> 
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> > index 36acc40c7d181..05815b837219d 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> > @@ -27,17 +27,20 @@ properties:
> >      maxItems: 1
> >  
> >    voltage-ranges:
> > -    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >      description: |
> >        Two cells are required, first cell specifies minimum slot voltage (mV),
> >        second cell specifies maximum slot voltage (mV).
> >      items:
> > -      - description: |
> > -          value for minimum slot voltage in mV
> > -        default: 3200
> > -      - description: |
> > -          value for maximum slot voltage in mV
> > -        default: 3400
> > +      items:
> > +        - description: |
> > +            value for minimum slot voltage in mV
> > +          default: 3200
> > +        - description: |
> > +            value for maximum slot voltage in mV
> > +          default: 3400
> > +    minItems: 1
> > +    maxItems: 8
> 
> From what I remember, SPI mode doesn't support voltage changes. 
> Switching to 1.8V came much later in the spec. So it should be 
> 'maxItems: 1'. Or better yet, make the outer 'items' a list (of 1 
> entry).

I don't understand "make the outer 'items' a list (of 1 entry)." Can guide
me how to write it?

Frank 

> 
> Rob
