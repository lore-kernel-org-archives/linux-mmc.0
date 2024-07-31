Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2096.outbound.protection.outlook.com [40.92.21.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2316182C3;
	Wed, 31 Jul 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412849; cv=fail; b=aBYCoqhVb/KkhN4EgT+wAuOUPWfKO6ILK89VcLtarudvjAcIxc8qv1E7umrasjKZjwARMGujSoOf/DxGsOn7beW/o+B9DaEigntejDJ+7NG+9TwYi7LNavmu2SlQauMcNC9wCzj6F0aW1M9uUJbhCn6+nddIjuOnxkBt71uejd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412849; c=relaxed/simple;
	bh=fviT0ZjPvGOu0OwuHlmvK+M1Du0d//in8ouG3Zuy/jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asrTLjsNhIWQOsQSuBLm1jUCtlyz4j6fx3oabix85v7OI1Eu3UaOPIkBFJGQhSLOjPKb/iyvfa6d8UgliptndfiAdnRxK++/YaAxlwoJGSbNM1RwG2a8Ot/9rs6/DOwjD5HZVirYAkqttR6lHeWyGTDfXuAcGzkMaIwD2He0TN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kATbARDc; arc=fail smtp.client-ip=40.92.21.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kATbARDc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+CKEqNSSlgie8UV+Ddlz+5FVF6Ha4ufMuG2lPHxEDpKZPVKkebvwhAFBUQCeazGyZfG08W8uZ04SSeP78j4N0KTHfmAlbiNujQZsjIj9uy/dhl6fXxkruk/cUw43joT2+/tEGj9eRQVCqO0gTPZbiXryqPe+E/74D/jkABe9cyttK+zo2yq54LIxLAg6Ge7U0yuLBufgq+jP5D6Re6oUpm6oS6feqAFGRBKLMjj5cnDHPaPzaBUGI+LimuggHyr5ct6GzAdkCsPZqwiFVsaxipdvAcec3OYZCywMyxWdt4nRswrv8KkLi0MgVAbk29lRs5b0kWZYUhRHiagZwumsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14E4mJUMdh2edbqXXonlNXbiBxXgTYFvdR8YA3kr9a0=;
 b=UMmBk+3Dl8sZ1+UMUMTecf8AqCbbRj1AdxlLUMKiMa0Yj2vkTE2djLaW+esjepCQ1bCZOHi96QR+5uaIkf1BaEt1S0f8hKRYFNLCe2/xuaKslUTETykmfyu58OEK0jYrUuq20mAj3FihKwjj6zyxHdrLNFRmP8GsFKNvqGx1WV+CSxzgZdiE5NOQg7yMXTYTFL/z5bsyAja0TgSTNFt/704JEIsmbMvKNI0mKOhCRpFPXoTfU9c1M5vMSbq8ik8FORkiVlWNtKzDzZhRI9GDDDyvGQUgRQwQ0Wi8AG8SGsWxX8PFSS5fKg6dx0V8UhCklPVif5etJmmANUw4it8J3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14E4mJUMdh2edbqXXonlNXbiBxXgTYFvdR8YA3kr9a0=;
 b=kATbARDcqywFc6eeGvPAnwDbivfXXJxp6VgMl5Yfh1soUeqEPLYaGlSYkp6mc5IJOJwU26YNzk4YhLxFn6JT7h9Wbkv/wbSiBsjmmWhn7sl5qdzeVobEgh/hjOLfgHX3aPt51OkRFEvnzDrMFT/iMxXIfFsr9nYCSp1XJxM1eKw1i52/1yUU1sVkWdVzzhsIlnK8naWgWwnCiAvHkC9W/95J4a8VgCP4byTSRi3x0TOszAm3YG123tj76bd2YXBtExg4Fc+bnpk8lnwry2zGQ8AaXiDKTvXQNDFy7WokA1HlLq6RLYoSuo5eBWmdZMRPMgMd1iQdF07gFLc7NjrBZA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV3PR20MB7123.namprd20.prod.outlook.com (2603:10b6:408:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:00:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:00:44 +0000
Date: Wed, 31 Jul 2024 16:00:13 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, adrian.hunter@intel.com, 
	aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
	jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
Message-ID:
 <IA1PR20MB49539C30076AB6D14B20BD57BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
X-TMN: [mY44jRH/hZm8Zkl/DnPdqz2GV+ZOXfQ9u3x7dfA7G34=]
X-ClientProxiedBy: PS2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:300:41::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <d76gtjvcgqqk4v5lbjxappq5ii7c32vk5fxtgoplyy7qbwlike@z63fvzr2fdat>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV3PR20MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: ccae09bd-0fde-47e4-cc6f-08dcb136e0f6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|440099028|3412199025|4302099013|56899033|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	JC5moDJkMIbWkUFr72jmWtmbogk5B2FyCEwFGD62GvmGbR7COItp1YTtvdwSWsdqKNN1GptIUZ8kO0O9PKHuzDVBmJ8Rj+l4EB/937eb90T8zlxRgDPUsCHPfW/bYYqLYWmuKlF6CQuDQLrPhFeT8D5tD7/wv1AKhe7mV5r/feoYmvSkXQ+fDjauPU8OoS9dYkoo3vTMgyLm/HkHQ9D4RSDtscCcqe5ZHnXseCA9MSoWmSbOcHvlpJoUkL2zrjHpLjBkW0gQSLHSE06Pj9bS1eAi7h0NL4TLm/Dr9LHK4O+GvyQVUHGq/YC4u5d1ic8cwvwpsJmPNMS8I5yzjDpMiGsvniuwttOpknTl1K8QudvEexSCRdderHLueW6Wx4DKxpmD5f07aPXcTT44O7rqhCv0GW46adZUkL1kY09YwSr5BDjanQvH0kTnG8zPsMp7IpKmxAwdKi5KvsnbmUWUOfpeDSCVaAPClwmsD8GVxep4wxsTozHNIQCZG6maLrN7cAZPwBDuGlgJyDRxhzxWmeeC9VXaxuPR94K59WFgMdAaMHb2LI+/8T/xUtjDUZ1n/XlkWS4dbhLx9my+V88kNelGsMAj7SK2D0DI2jn6UJuOBYdokLDFg2JWJy54mMqPL9weEq+/UaW6kJyTE9LejKfXWycBVdMZCUX6ngZpPWntAtSoiFZ+GTnG7+48zLzXfsoV20JTA7vCkBdl0ONjtQZmKmlxCUo/fj7UfNrckttXddvc4NbUYQ99ro1EMMl4lMI8QotiHcVPtQUj1TdSaXWnvNGrRWUWevKyymALf0boVOTj78d9VklXLFZ66w4J
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAEeMTxE+okO+bsBWQZ/iFzSldY3jHDUTDnBc6scW5+S7GEpXnMvnXozmnr9?=
 =?us-ascii?Q?kK/ZsZ58nppUHvOdCdopqGxnLZeAKmQ23PWZa4lunU7yq1OaCbm8QrE3TynN?=
 =?us-ascii?Q?ZmwjnHhmir/9m1Xce8KJEw7iGfolJf2rbbeWEjPjLPTMwFUxoZb8hOesVZ1s?=
 =?us-ascii?Q?Hy6GXjS0C0Z54OGOwALR0zmWfYcPjGom1dX8Ow652KRYKYmGEij+7lQFKjmC?=
 =?us-ascii?Q?fvVliHAvlXHNsgFi3jw/XqZu9GZPW3ru3PP6PeTKxQszBRpieOgz3ntnIU8L?=
 =?us-ascii?Q?fjAZIfJ9Jo6v4wmztOt7OMxevwuet+lrrbwFygzGbzVh40oJCI+B61oIJAP8?=
 =?us-ascii?Q?BhclRCG6qu6MWiIQjdhQopG8KCurnM0NePkxCol2k4JRHZ3FYyr9YOP7Oyni?=
 =?us-ascii?Q?Ol25fACAo12XH26/AaUWUy1sKLHjLEe8FZqI/aDcmeGbpmIyBDFZ59I1RXhI?=
 =?us-ascii?Q?knb1wb85UBAdtk62hZBOQGSRxoPKKRHnHmxaCfLx44aXLTfWuRRLxwJ/yT32?=
 =?us-ascii?Q?5Vqvq9Utgs/YTMOwptzjzUcBlPCAeBszsDsVMsOjSZgHwbwd2HCPUXWgFqty?=
 =?us-ascii?Q?eVtqTsHV9ch+IteLE0sakYD1eybdKU1MOpAPEv0RWfUJgZYRAEk3ki7pHZSi?=
 =?us-ascii?Q?7n8LECNxEM0mvF6IjgaW7cvZapgwth9ddm8QsMX02i3qBJ6vFGmyq5QdDP3B?=
 =?us-ascii?Q?zr4YbhG7U3FuDW3ZQO42Zh1Un8tPYXJLpMFp0FMfL12TSlyuathyWbTrv4yk?=
 =?us-ascii?Q?MSzOXY+Th9TuovQ1/SfJ5cu2BzM3GP8lGxSee5T656dXUak8lQFw0Q0I0OMT?=
 =?us-ascii?Q?QsIFMe4jgWl8uK4tctv29lofqlLZIlwf34sWrxeArBngabs6MBZto0VsNFLU?=
 =?us-ascii?Q?cTREPPSHE+2fl/+FejMrrsGC/FODU4Lx+BTYRN3gEMDd9laHzT27S+fimCXT?=
 =?us-ascii?Q?RlUMON1lODFjG6SHhj3Uqzhbqusa+2c4cJPBH0Zo0TUolXhasxHV2RaPgX5K?=
 =?us-ascii?Q?5vvZlOOkAvaF/1g0wzmVxfuMIeKUNMsPq5quiYfqBYyWu4IYwaDzvJruSjeU?=
 =?us-ascii?Q?ryMnxyHJ8NyQSt4hDrn0mvLCxmjM+CIEg6OfusEWeYvRyY6ciSz+aeG1V5z1?=
 =?us-ascii?Q?VFuqDpFJDs1SniyZVkwwzlwf5+j4kgHSdKgpCQtdGW+SXh6qWqWcyZSd8US+?=
 =?us-ascii?Q?QHxn1stPcySF421T3s1JulhBKVGYLG3SazFpUudXpZ0O4OQjmkgNdUlT3l5t?=
 =?us-ascii?Q?/6TY5TVQy4lnFibN9go1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccae09bd-0fde-47e4-cc6f-08dcb136e0f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:00:44.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR20MB7123

On Fri, Jul 19, 2024 at 04:44:38PM GMT, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> This patchset is composed of two parts:
> - one is the improvement of the sdhci-of-dwcmshc framework,
> - the other is the support for sg2042 based on the improvement of the
>   framework.
> The reason for merging the two parts into one patchset is mainly to
> facilitate review, especially to facilitate viewing why we need to
> improve the framework and what benefits it will bring to us.
> 
> When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
> that the existing driver code could be optimized to facilitate expansion
> for the new soc. Patch 1 ~ Patch 5 is for this.
> 
> Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
> Adding corresponding new compatible strings, and implement
> custom callbacks for SG2042 based on new framework.
> 
> Patch 8 is the change for DTS.
> 
> By the way, although I believe this patch only optimizes the framework
> of the code and does not change the specific logic, simple verification
> is certainly better. Since I don't have rk35xx/th1520 related hardware,
> it would be greatly appreciated if someone could help verify it.
> Note, the DTS change has dependency on clock changes for SG2042, which
> has not been merged in master/upstream, so if you want to test this
> new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
> pick patch 8.
> 
> Clocks changes for SG2042 are expected to be in 6.11-rc1 soon, I will
> do catch up with that when it is relased and provide a new revision,
> but anyway please feel free review this version and welcome your comments.
> 
> ---
> 
> Changes in v5:
> 
>   The patch series is based on latest 'next' branch of [mmc-git].
> 
>   - Based on Adrian's suggestion, split the first part of the patch into 5.
>   - Updated bindings and DTS as per suggestion from Krzysztof, Jisheng and Conor.
> 
> Changes in v4:
> 
>   The patch series is based on latest 'next' branch of [mmc-git]. You can simply
>   review or test the patches at the link [4].
> 
>   Improved the dirvier code as per comments from Adrian Hunter, drop moving
>   position and renaming for some helper functions.
> 
>   Put the sg2042 support as part of this series, improve the bindings and code
>   as per comments from last review.
> 
> Changes in v3:
>   
>   The patch series is based on latest 'next' branch of [mmc-git]. You can simply
>   review or test the patches at the link [3].
> 
>   Improved the dirvier code as per comments from Adrian Hunter.
>   Define new structure for dwcmshc platform data/ops. In addition, I organized
>   the code and classified the helper functions.
> 
>   Since the file changes were relatively large (though the functional logic did
>   not change much), I split the original patch into four for the convenience of
>   review.
> 
> Changes in v2:
> 
>   Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
>   patches at the link [2].
> 
> Changes in v1:
> 
>   The patch series is based on v6.9-rc1. You can simply review or test the
>   patches at the link [1].
> 
> Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
> Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]
> Link: https://lore.kernel.org/linux-mmc/cover.1718241495.git.unicorn_wang@outlook.com/ [3]
> Link: https://lore.kernel.org/linux-mmc/cover.1718697954.git.unicorn_wang@outlook.com/ [4]
> 
> ---
> 
> Chen Wang (8):
>   mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
>   mmc: sdhci-of-dwcmshc: move two rk35xx functions
>   mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
>   mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
>   mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
>   dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
>   mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
>   riscv: sophgo: dts: add mmc controllers for SG2042 SoC
> 
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  60 ++-
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  17 +
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  28 ++
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 459 ++++++++++++------
>  4 files changed, 391 insertions(+), 173 deletions(-)
> 
> 
> base-commit: b85e021853976aaebd3788e7e721020570754199
> -- 
> 2.34.1
> 

Work on both Duo and Huashan Pi. Both sd and emmc are fine.

Tested-by: Inochi Amaoto <inochiama@outlook.com>
