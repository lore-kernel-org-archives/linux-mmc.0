Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6D3DBD6F;
	Fri, 26 Jun 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457417; cv=fail; b=VpuPGPR8s04VS9TEXeD6kN0hHBIykPkciP1BkK0HtDW630EvjGaZ7n3EAfAgMlZJjdSjRlJU8W64TPfg7r7aRh6SbF9CtiaWAMBd4QRBxgtMke4Y8bSHTMfHgOZP9YqAU/ZOqTSpQ9xw3rrEKZc5caIxsOfUVzor6Tq5eGBYGlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457417; c=relaxed/simple;
	bh=+TlF4RXUaLkk3+RB/d4X7CXTSThTzm+pZ/e8eyPFnhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXyjLsh+l738vk4GmRHiUTcYqL5wGHavHAUEHMqb0VMl8IeV/gY9LKGHc9MeT0+YPCKa+/HCgg587a37+xXDTmvg3z73V4voiV6mKBhcXfWMDk700YNDBNux4n/3wu4Wdb6cyvf5YnbHCjAWr9qhpxGdW8usTbY+6yQUp351Hl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jDZb0K0S; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jDZb0K0S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPUmFTDO/yRVkObGWFiVFT+JksMq8Y86UJNMviCwX7/2qYjIHNTEi+yd6yajbuxoUFyTG7ATop1DiQRagy01lnfRc6FtD9zsMkM6R+YH5GkCFvD8xwqAa7XnOZPn9vG86XPj52LekVS6NTOZsejDHa1CwWQ8V19qdJ8fpPIU8UyKi2aqYe4NpLM11pB0/ocF+iBCgOjjcf+6+HByyBBQI8x5TZYaBDsp0gvD0Obq9+nnBlOoj/01Uz8HvfhU1/l4vwyguaUaBleGYYboIgDfSdOFzREj3k4ZH5qa7QkiDFE/h0QQyLj1vWeXdOTwh1U8MV481scfEGC5RrKJVEp7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmhFwZLkCtDPFl5C0+cauMBg+mpy6oltd+Pb5ragczk=;
 b=V1vawzdUf1sdQItepwKhutS1r6MmAgNYXNeJZmAeMxufe5/ic/XUM4uPxoIqoBSqySE3RYTsQb/kszzx9K+JZqopM3eUhy4FAhOqZwgX3NyLrsp7xatjAQclB+hPpLePqlV8vMzSY5jBWFCb+9DdpZM6XZ9K7b/PIE5+bhCx/iUGrMb2DQTDWayNp5a+W+Xe8NEjb2NVANbdnVzcSCC5VAKWk27K3BzNWCu3ANBnT4/lGvjoFBzQ8WnBiYw0ma15vYnegIcTactzaHe1oHAwGD8atdWpA6NlZojkVGTwd8rsGheJjnSiy93WbUceW/niaZtLGVocsZ1hz+toumqHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmhFwZLkCtDPFl5C0+cauMBg+mpy6oltd+Pb5ragczk=;
 b=jDZb0K0SOHqs5sxxaPNe2QtxWALN5OZggV0+Pk2qB2+4O0zQtKfdzHjJuvOuB03JJp6Bv3YCMcg9ep768CTIp9ejba2Y4GrW/mq6XWUH9Tz+lJUQGtf3rUy5sPsh3kemscF+1Gj/k3LAlnteavmNMIjn/ot0lv0JQ3n5bFc0qKtAGFegf6lI8vUQcaOSQ0/Lsxmk7Ev+GxWKO3DQQpOde+nAKDOGYKG0vtv18sUrCZToqhdL9FCce09aHJteso9M4Osh902q6ELk918S9Do5RWR9PEgZo9vgj8ZVu7GLGdw0D7c2ufRyv/j049XK9fHzs/G/tkVJ4FwvKb7dFFBcBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by FRZPR04MB12430.eurprd04.prod.outlook.com
 (2603:10a6:d10:1cc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 26 Jun
 2026 07:03:32 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 07:03:32 +0000
Date: Fri, 26 Jun 2026 14:58:14 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: "Luke Wang (OSS)" <ziniu.wang_1@oss.nxp.com>
Cc: "Frank Li (OSS)" <frank.li@oss.nxp.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"ulfh@kernel.org" <ulfh@kernel.org>,
	Bough Chen <haibo.chen@nxp.com>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	dl-S32 <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
Message-ID: <20260626065814.gzj4onei6bx3ptle@nxp.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
 <20260625105934.2890635-4-ziniu.wang_1@oss.nxp.com>
 <aj1Y1zLgZMzEihZw@SMW015318>
 <AM7PR04MB68708D2075BE3EF4BC35204BEDEB2@AM7PR04MB6870.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR04MB68708D2075BE3EF4BC35204BEDEB2@AM7PR04MB6870.eurprd04.prod.outlook.com>
X-ClientProxiedBy: MA5PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::10) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|FRZPR04MB12430:EE_
X-MS-Office365-Filtering-Correlation-Id: dab718c5-2142-40a9-0c19-08ded351082f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|4143699003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fAWtp4Xy5DoEcFkWN3C4ToWcI5+Q4DNkDLQ3DuTd8SAB6nQ7R8ZZEfr37YYIeIgM+8i9Ub6x3AkIrc6l33eVB8RgPF5pWPORQQW+15KEMgYpLlilInkfd7/GnBIai+Lp2AVdwOoFmcrh5Cza4VJOF59s71I3NVLvkC85YhA2cTIAuWYMTnJXA19rw0YB9FKroCJAm+5IbKMrDD7eLcD0zyaDKVLgihNW9tShpR3AwQk/++to0JEbCepKHgX6MDS3D23fbSoKfoq1MeEXenvJI05Emo/ruiu8OdiCEdfM5gYWYI3HiKOLRqZRr9js2a/dyXEwc8CCEZljGdsUe/m9323NlvmZHsKfpYgLkwzi/ngfR+VrrktqJPGdti2Q/hAMilGJwouWYn5gVJ4DZ3NtlC5HfFheE5XoNxiPWFt/NL7yYwJxpZbROW9qIJiAHZWNDaj6SEEo1JRgbgIKJJmruElqwyt8mfVE4SavXMP9D1YhfnygTGhnE1Vnvu6NpUns2IUL33N3dOuZ2wa6Qndb7HMBqvVv0n/ZYJCVSEOPYS+IP0xWtSDYLrYjqBvyMwBRzx0BZjigafn5kfEwHuSvyZS0kxGVKLBEhO3tP91MTmXegI6ROOOeYhB6bLl/UYPNlpJp2r2ZWd0ee9oBcYjSz1q6jZF95/TVIWwzk7m9Tmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(4143699003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7p4nww2QhhfgN5l5rzSDXWmRiT9dbuDdkK0iVAJdjB3PqgJHnbHoGcZ4TS4?=
 =?us-ascii?Q?AC3PmENro8W5naIBFI5L1sXtU0/p4r47aUwWgl2EnrM4VSbkydTMnpRP5D06?=
 =?us-ascii?Q?kDT3iumhk6kYARqfjm8y5/0ma2M/lEdCg9PB0awfYOO+nfhjFRu9hjONtIHu?=
 =?us-ascii?Q?0jDsfS0v2+Z8GPEwFcQjhuxCWAhUeteMtmOYZ4Pmx6eeMAM5XVBJz/dA8Cyq?=
 =?us-ascii?Q?9M0vVOaACvN/K1AFOGKaWM+X7hsCW0LlF0bt7blO8qilCYqHNTe8lqUene00?=
 =?us-ascii?Q?w+Wii5YUcFsdpxUwn32UTKXczpI7kqX/XP5CKr+2dy0r+Q311rzSYEzk1dVZ?=
 =?us-ascii?Q?C8RHIVoViNxISzbMKR+SKhDUMt6ioipCPWzpUaQC1/mylMXO6acVfV/8JiwH?=
 =?us-ascii?Q?mLhnZpoduAxxKjphTfb2/WWqsOVU5vQXOVTrFWUR8jJNyfT+Z/CKPsnq03MC?=
 =?us-ascii?Q?fvJ8jyIC0Ic+1FZV+DuJjrQAxgivsEs/4EdYG9ThTdIHrDclw4D5VL6UWkrd?=
 =?us-ascii?Q?SEnh3QhmfyrcC1EOwx22J8dgO8ncFp2U9u7uy1C/AAECWNh5zFoM/22EejU9?=
 =?us-ascii?Q?IL/7sKQn4zQf6xO7JBaenmsn6G70dIRunUdylaCi/JTtU68tTTJD2nWGY9ko?=
 =?us-ascii?Q?CIz7D3X1N9tnO6MOBKjsX35xc+yOLVffMq1fy8IleWgJ8Dplb5XidQN3dMIl?=
 =?us-ascii?Q?sJDJ254YhHRJ9RuCydvAtXiBPl/H+2wXVIMVu4CKix05X6o85SgpM358dR3c?=
 =?us-ascii?Q?dBwQFEzVuAKM+Bo/4qS/1Itbs+bMhY769n+fhIy4wrXSiJz/hjnonxu9fDbr?=
 =?us-ascii?Q?tB3fIrR4cI9Gp0hfj3kQ4efgQ3dkIeQZzO0DgnTNLa4s0QeG9cJ+C3S6XCeH?=
 =?us-ascii?Q?ggX7KKDWEBqXE8tE9Y4jnP+qFBpGkKe5ns/nfFYRaSa9ZH05w//sC74pDKGz?=
 =?us-ascii?Q?35GJvZB2F9Ly3vEKZo029EBBh5kKyPNinCW5oeII2c/GgZ35cn/9Nodj6rwv?=
 =?us-ascii?Q?WVPAOUPztFZh5Bj1Jjw5A5nqRukr2iyNwWxWA4ZpA2Na43NaoqJkbUD3Xs71?=
 =?us-ascii?Q?ZwVCbfbPCUgLc95DOY4SSxUQ927v5+BO64wssME00ikAx2UJU8dv8UqUgy1p?=
 =?us-ascii?Q?iJFSGiw8ozJ7VuWxDpCe1sJctvfEAdj+JahaBMC5dQvApe4xLfYeAkIMJegt?=
 =?us-ascii?Q?Mu56/vmEpWVHuB/K/DuKRnrQrH7dkofr53etcH6ZGWV2V4g/sxphp1TXvvHa?=
 =?us-ascii?Q?x8E9cLt13H/OBarhqECW6QffCdC4WE9FV6Dkms7/Ffc8HKvxcx+dOYh6yszv?=
 =?us-ascii?Q?QwMYug8bk2d1Za/YhdbMXWkvtuKZIln1QkuSNwcMf/yx/q46nBpoViLZG+la?=
 =?us-ascii?Q?7K1vygwwoeUkvqE9O4is4Q7ZKkhQHOkBqAU5tRs8+euFSWJSaAgu9j7eopVX?=
 =?us-ascii?Q?grqhcuqOWXfGXLIe11YglQWNXfdpQhS7tleghgnEpUmt39+Oyg6oWi0NvCt7?=
 =?us-ascii?Q?bSclBjf9DioW9w7xZaRfEJX/H3f/hO4xUaLvvdxkylojhbbpsyjaPgLDJArF?=
 =?us-ascii?Q?gBXHy6sqLJ9kK7UDReCTAPSlqGpMVHCcZm3fBwBe1HOlBp+RBoYjRbb9MYHB?=
 =?us-ascii?Q?20sj3sO1m4S5Q4bQX2ic9pxe9jpkJ9ID5G62rfBZElqs6mBCzMSEXLNAK9n2?=
 =?us-ascii?Q?SzNgJT7KG70Z7+MFaF2mi6XwG5efu05LgCBmlLRJzOZGSYsBsFW9wV1nUSUV?=
 =?us-ascii?Q?iL9PsGrpKl/9fnmBlIvAMVS/elgwlJHweuVyma4V9tzlOTbJ2zb7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab718c5-2142-40a9-0c19-08ded351082f
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:03:32.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPvkq0pWrEUk1CcKvC/7DxbD9qfb3V5nBVIJjDDl4xzyQAZmDqRceW46c3oPrJXOS+Gmumqa8zcKzXEm/+u29C43LfE9Srmbd1NqG9weHS4a0PzGZ1WEFnrsZB666Vj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12430

On Fri, Jun 26, 2026 at 06:03:05AM +0000, Luke Wang (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Frank Li (OSS) <frank.li@oss.nxp.com>
> > Sent: Friday, June 26, 2026 12:36 AM
> > To: Luke Wang (OSS) <ziniu.wang_1@oss.nxp.com>
> > Cc: adrian.hunter@intel.com; ulfh@kernel.org; Bough Chen
> > <haibo.chen@nxp.com>; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > imx@lists.linux.dev; linux-mmc@vger.kernel.org; dl-S32 <S32@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 3/5] mmc: sdhci-esdhc-imx: restore pinctrl before
> > restoring ios timing on resume
> > 
> > On Thu, Jun 25, 2026 at 06:59:32PM +0800, ziniu.wang_1@oss.nxp.com
> > wrote:
> > > From: Luke Wang <ziniu.wang_1@nxp.com>
> > >
> > > SDIO devices such as WiFi may keep power during suspend, so the MMC
> > > core skips full card re-initialization on resume and directly restores
> > > the host controller's ios timing to match the card. For DDR mode,
> > > pm_runtime_force_resume() sets DDR_EN before the pin configuration is
> > > restored from sleep state. When DDR_EN is set while the pinctrl is still
> > > muxed to GPIO or other non-uSDHC function, the loopback clock from the
> > > external pad is not valid, resulting in an incorrect internal sampling
> > > point being selected. This causes persistent read CRC errors on subsequent
> > > data transfers, even after the pinctrl is later configured correctly.
> > >
> > > SD/eMMC running in DDR mode are unaffected as they are fully re-
> > initialized
> > > from legacy timing after resume.
> > >
> > > Fix this by restoring the pinctrl state based on current timing mode
> > > using esdhc_change_pinstate() before pm_runtime_force_resume(). This
> > > ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
> > > is applied. Only restore for non-wakeup devices since wakeup devices
> > > kept their active pin state during suspend to avoid glitching the SD
> > > bus pins for powered SDIO cards.
> > 
> > pin state change should only impact driver strength, why cause glitch ?
> 
> You're right that switching driver strength alone won't cause a glitch. 
> The issue is more specific to the sleep pinctrl state: the uSDHC clock pin is
> low when the clock is stopped, but the sleep pinctrl enables a pull-up on that
> pin, driving it high during suspend. When we switch back to the uSDHC function
> pinctrl on resume, the pin transitions from high back to low, generating 
> a falling edge glitch.
> 
> I'll update the commit message in v3 to clarify this.

The glitch should be related to the SoC IP intergration, switch pinctrl setting
(change alt from GPIO to USDHC) impact the internal loopback path. If pinctrl
config the pad to GPIO function, once DDR_EN configed, the dll delay will fix
based on the GPIO function loopback path, but then change the pinctrl to function
USDHC, the internal loopback path change, the original fixed sample point maybe
not suitable for current loopback path.

Luke, please add this in the commit log.

Regards
Haibo Chen
> 
> Thanks, 
> Luke
> 
> > 
> > Frank
> > >
> > > Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM
> > logic")
> > > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> > esdhc-imx.c
> > > index a944351dbcdf..7fcaecdd4ec6 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -2114,6 +2114,12 @@ static int sdhci_esdhc_resume(struct device
> > *dev)
> > >  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> > >  	int ret;
> > >
> > > +	if (!device_may_wakeup(dev)) {
> > > +		ret = esdhc_change_pinstate(host, host->timing);
> > > +		if (ret)
> > > +			dev_warn(dev, "Failed to restore pinctrl state\n");
> > > +	}
> > >  	pm_runtime_force_resume(dev);
> > >
> > >  	ret = mmc_gpio_set_cd_wake(host->mmc, false);
> > > --
> > > 2.34.1
> > >
> > >
