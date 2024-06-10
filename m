Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF238FB0;
	Mon, 10 Jun 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030039; cv=fail; b=IXlUVXDYbOCVi0+ejEi47eeW8h0UPI92ioUKjx7uPo9QaAE+3R/+8VZtse/yfefkYiJiIFgV3I9k/l+e4CJNpkaxJB/cxfZH3aBYvBVbB2e4kZ/cMyYyxLkTrpIZhapFwvQP7dRqOWhNa3BJXeQayav5VSKVSNH1JJNeoATcVLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030039; c=relaxed/simple;
	bh=+cGySQQ2Q+OI3EqfU7ubE09BsyRFjxSCIbS+4+lvN7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T6NCYmjA24vUedCbKTO2aC7kya6x5pb/f3x08wT5RWjlVtsObqr05HVSNH3fH3n4Y1i7xmskzYGNLES+kA0X7oHuAY+oNazNKNHKRsGFcrkrQelN4O6Y328Ji3b7VRMa7zj4oEQCGnvWL+AVwr38kKZByl3vgVQZ0c8PaPr56Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T4IYJ+m+; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T4IYJ+m+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEd+mYDp69Lucv6XZJCa4zRKxdKBpvnmyLDJvduryfdnuhztJS7W3UL37FZooHCPfdMePi0S2GiIiquzzBqALJ9adwep40YqMJMod2r0KevuSI5LqNwCv3obAfDARV0azXhstldDlncebPkqFoUVjonEHNY3K4AXOtIPiqtvGqNI9uxEPBCSC4SlzT8uyHJvtpBz/ZMjZMlFAQEPKTuMy+uane94GKxv7Y+dCdqn6/5yajDdJAKx5JduQBjqtQYdZczV3/QXFHkZstEeTgGYoD9YTv/DirgtbopMI7Sr2n4lc7GUYnjHPYkloSu5u3LXOPsfJ1wLclvyuE9LSgn76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O29E0kVUDR60WoCAuW6ifVFz+S/MfQqrxlUaVobcHbw=;
 b=J+LgCxvAHH3gA2+5CfuAV9G+VIDiHBfPWcwQPyswKf6upTa5R3UGXSZWn8pEcLkGRO42jaxBiq29+Bb/ZtZbeNynKWecj0AfSEwXRIOQojnhKX6k4QaZUFGCd4GG0x5t/zDrzC2WKP9yVNmZEuJdh88bezKreD7zJyEGbaNnuWZ9F06BfNSzeusvGuN6aGvxWX4t3ydTkyetLzocHDENobU4dn3WhYc+5PwpSF5b8IAVY9E4oknGe2JolqsssLs7e74TAB9EvLs0WXFaBifPQXiU82eFqlLrAE+w8OVW43ZXv+Bv7BJIFD03+MBCZU20fhKSJfFrUpa+GbdC+cv7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O29E0kVUDR60WoCAuW6ifVFz+S/MfQqrxlUaVobcHbw=;
 b=T4IYJ+m+eO0PBawKlX/m0gR1PqIDUNHA5ndtdw8l/iY1GHG0bC2GOkR8tMVPIMqIcDEyLKJvYguzKBfFckBUNvvPt3Zvjin7VehOV/PVr93RqjQN3giK12S7iXgKhQMNEt6svHm+koIdgK8PBwa1JgS0Pn1qxE/XArCeo8EPmz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 14:33:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 14:33:53 +0000
Date: Mon, 10 Jun 2024 10:33:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, robh@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Message-ID: <ZmcOyVmI5GhRUuVc@lizhi-Precision-Tower-5810>
References: <20240605185046.1057877-1-Frank.Li@nxp.com>
 <b1c51acc-441d-4484-adef-1da368571097@kernel.org>
 <8901d498-d30a-43db-bda2-25d3d1d58e8d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8901d498-d30a-43db-bda2-25d3d1d58e8d@kernel.org>
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fa8d6c-0a33-4522-9297-08dc895a5a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?biVm8L/kKb93QqsbfZDI8k2sR2dYzRgi3ba3q3TUrjFX4lc5SNYfF5bK5l7w?=
 =?us-ascii?Q?CgWE3HnNNGcKf1TxqtznxoWfBKMddPkAzf90wQitQkyWIoYqo6PNLyzMg8PA?=
 =?us-ascii?Q?lyGGWnAnfmDIaxE7tB63UJkE5Klmhcp0qLFX5XULbUwZ1ZVrH8ltyu1X5PmF?=
 =?us-ascii?Q?BRPp7bA7IFg/4WPR8OHJsqANCupbNi8/5eAFKbHVT6t9R9VdDo3mdskH+BYU?=
 =?us-ascii?Q?iiO+noxX3OEEssQaLC5wHHW7bTKHQDipN6hGoPsa0RSN4c9iPVanuE88oStD?=
 =?us-ascii?Q?WpF8oKgpThLSKpWpiM7dcc/zoQsY0BPIUwnpw3INQ/4m2qInJyEfZ9fNS0py?=
 =?us-ascii?Q?hxsXH2+0Iqm1ABmxBju2HGzjvwq/2lfsGqHnfLl9kMsPcOlk2OjKqDIBzoPB?=
 =?us-ascii?Q?BgODK3bK9ald4kkc9rOz6HsERXI+lt2WU9blCfJ73pqcl4mUMrA2KJRzdDiP?=
 =?us-ascii?Q?fg8DBW15RaPw2gwtlSQNcLga2z42k4p7Ch2i8yjkr5ggt/RWKxHTVS9RGu94?=
 =?us-ascii?Q?+TtKJRerryb9RGb+A9G/VwGg6w3TiKgHpmQux/ZcF/u2zTOUcXfF1eFasBqd?=
 =?us-ascii?Q?Dr4UVYMFZW/1Mz5D6v94HlPgie4DcFj+fTdK6Wx0OJo/radPjO5XGvcLCheh?=
 =?us-ascii?Q?DFvn9UxA8NNyQZmSG6QTXon3kS4b2in3HnLFciJMnsAM0yJrgWXtBbGCLcJM?=
 =?us-ascii?Q?Lf34rcFzBohCXIBthkjYQk///kRC6joZPz8n2hmzbhZMNTFL9yuZ7gR1iYRG?=
 =?us-ascii?Q?br4IihJuJCWGlnwVIfOWvQO2qG5aLZtCLlD21ybY571shISPpUca/VZm+kWW?=
 =?us-ascii?Q?XOc8nYUPDbZIg7KHKKeC6IrZbMwaHvWGl8ssS4Ai8KhlcwI33VsQOp2YYOI2?=
 =?us-ascii?Q?ryzX01gzsL8A23YfagZORFMFXKtDkjbsyu4tj9O+N/4wP5wn8AjlGgfnXaBi?=
 =?us-ascii?Q?Fpbzow9Emx5QSfhj9N2PCYgHdFe28yZEAranfm8qEkeVAaZAyq83TW3RUnBP?=
 =?us-ascii?Q?8Nzx+kzvPVAl5wgkuwSBZTXoUtQvIBz/P6M334t6X/zeRC31c3AlmFBAXLPB?=
 =?us-ascii?Q?71OHfVQPnPLI3XGTD6jYD88rB8rmfJyjTYfrkljFShkr7Rqf3d7uCyutVjc8?=
 =?us-ascii?Q?vIEZCuyjlPUQSBN+1v67s3As2JJuoIoNLa5J8D6ZnzwfYIJDGks5IEwJlCFW?=
 =?us-ascii?Q?zjP8bkqOTuUug41fJ5Y8vyRy1HHbARXWW0TiCUiADLpasDGGzJZpOUwmdaxp?=
 =?us-ascii?Q?pQ2Hy1J0wKH7EsKUZG6VjbRENTQcv+AeEvD9i3JkB+1pWojeVTUbYMxSYgU9?=
 =?us-ascii?Q?5YrAhgPB147+NfAckCsASDo9mIQmlB2RhmAvml89TbevXcp5fXskO1n1IcN5?=
 =?us-ascii?Q?7wXkodU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uf4ceSuATDKaV89V3Ys0aY2jsUAFAbEFuH6rdfLSHHVpPjFW45337NdjaExJ?=
 =?us-ascii?Q?QAsjTXbRqoKHMdsCuzYbmrYkyCvAPxK8Yne2ykG5ikrgGiNk3fvZ/GWdF/vT?=
 =?us-ascii?Q?A8frDwpsTO2iYz82NIQffw9J90EP/r13R0SbOilnQiUsNpgUQIFBZercap7X?=
 =?us-ascii?Q?GNIouBeSCIzLDFIYQ3VykZEiHn3wzpjFRm8vFY83XF+sgmgew6sS5Ll91HYw?=
 =?us-ascii?Q?IZZnAaOWCf/Hjhbxx+NgF9XKPHctAanA7vvR8FWdmXGJEZxEvfMYpwWxvp9u?=
 =?us-ascii?Q?KW7arP7RlgvnLNoZBV8Wc8J5Cp87AoxXc2M/Sr1H3ugNuSaI03UXQK+bTbb/?=
 =?us-ascii?Q?eKfqG0STqdSCTvHE2nZA3D8xEBuuvE4cjdkBBMSmVstjU2Mq6oWe151ratjc?=
 =?us-ascii?Q?OaazxqGPOxh58mtYhygvg2oRVQ1WgVMvn8Gn60GewY3Fy85T+WQbMnTRPvYA?=
 =?us-ascii?Q?CEtgWhBvhYtixoKgyO+t46TAJ7HVD/aohJjL/z3zBORu95KiHA8iP/KzFgY3?=
 =?us-ascii?Q?9AL7GjjT4ES3VlkYoUCs1gxsSU2HJXqZwkckcrouQjxiFLr/1GGYHoXGN9mh?=
 =?us-ascii?Q?TRfI9kglP8mgYJipPWsxxVsUM8+6j+FzcK61TrgGUZfFhpIFRY7/CuiLdHVh?=
 =?us-ascii?Q?HZdNytIZ7T/YFrKpfNv2NZLCg9XgpN+gKID65Y14YJURsFbpI29b16sfaLQv?=
 =?us-ascii?Q?N0UGY35Un75EGO8sWQVZgyBIKKLkRjNpkR2ityqN+BE3TE4pkFJTaCmxj4iE?=
 =?us-ascii?Q?GvK21QqTlmoQixnqQOBkAPDWLFnNjeTIt8f3OH10x3WP0HiFmCibDeSnIYJY?=
 =?us-ascii?Q?sRBz9y0VzwW6/XVktJGwj6xyVRKdDG/7WOPbkP3+B4gWZJgDmgVTbsFnBR8M?=
 =?us-ascii?Q?j0wEMzdd+/R3xnPqSmNh7k4nrUjlMYrfM5tP2KAVyaR6Yu69+IyGevHTPfu3?=
 =?us-ascii?Q?SjVWob2K2DyozT727rmsOzfnZG40ERhIQnZhkjsNY1gJWI3DEvebMumfstU1?=
 =?us-ascii?Q?iWwXxgvn+m7zFXbg4n87/Q8OPjItgKnvc6ZrULnkNCf0wkz6dtWfhgLv87Cg?=
 =?us-ascii?Q?rRr6jRKtvXth17BBX/3FqYj1TppLpuzsmhwB/1y9/KvRWVZslxV/YOWptDwH?=
 =?us-ascii?Q?bJZSXzBLpziD1wtDYv3KXiNg+kXpVGR9KGSLq1CxCDQDLCFxQwiwiMYE4POd?=
 =?us-ascii?Q?jQ+WwnxU7QnySqkdEH8IC36LiomKbtfSpDtWW9mvd+3Ms/9iVxpuPtPTuzCm?=
 =?us-ascii?Q?C2hldmwZayD7mCRxR3nLXkAZO+P1ZY7EJGLm4EDwDnVqgCCYUMj57ctpEmui?=
 =?us-ascii?Q?Rn1flc97z3lIrXdgiJcG1koQnqjZIfEU/gPlk9hvvstISqbm/3iNEH7RHKTc?=
 =?us-ascii?Q?ApQVWhNpZfZ1zNJLkDIZVA//Wyb2k2zGhKRaYD+OkDFiz3drvZ059pJV4VIE?=
 =?us-ascii?Q?3IWmRmLRlEL4xmG3Sl8bng+QxWwi+kF3YtTlywZUASR676TXLBcH6tHE7hRz?=
 =?us-ascii?Q?JzLDJdnW2kjnyhV+RLDVloTbRerOY6CGZdg1xEwgrEPNYQFjQALtwWqu03F3?=
 =?us-ascii?Q?w8rmjbfFL5V0+k+tVZk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fa8d6c-0a33-4522-9297-08dc895a5a73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 14:33:53.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3ymrrRWKFU4Ejgpzv/0naAV2B2dYVFkV7+jXwKmvF/KzKq93TrRq7e71pyAhaFhfZ18lJCrGMruuU52ydKB5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847

On Mon, Jun 10, 2024 at 02:29:57PM +0200, Krzysztof Kozlowski wrote:
> On 06/06/2024 08:44, Krzysztof Kozlowski wrote:
> > On 05/06/2024 20:50, Frank Li wrote:
> >> Convert layerscape fsl-esdhc binding doc from txt to yaml format.
> >>
> >> Addtional change during convert:
> >> - Deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
> >> - Add "reg" and "interrupts" property.
> >> - Change example "sdhci@2e000" to "mmc@2e000".
> >> - Compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
> >> most existed dts file.
> >> - Set clock-frequency to 100mhz in example.
> >>
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Or not... are you sure that DTS validates? Did you test it? kbuild has a
> bit different opinion.

Need additional patch to fix this DTS warnings. It needs convert to yaml
firstly. If you like, I can create big patch set to fix all emmc related
warnings.

Frank

> 
> Best regards,
> Krzysztof
> 
