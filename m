Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2042.outbound.protection.outlook.com [40.92.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C171C0DCA;
	Tue, 18 Jun 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702016; cv=fail; b=DUfOD5Xls2dZeh+7/SHtDshoRcHLn7ID1PHlqKrj52rS8fk4a1wDzx1Yndgz6iu1dIS6r0xHx8XgEs+0XPdnq+SkmQa1IBhNckS7IQriUYjsyHbrpxzfnfwNOk3TVUdn++hQY0fEtSB6D5+zTeEvm3r8SXstwG/djCaIBUKDNe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702016; c=relaxed/simple;
	bh=TWLNgfZUZURetCZ2suMVo0RyVd+BZx4upR+vPimkY18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K74BLOX+cZwjsrMu3WEjU+WrXWvELdGn5NuPqsrdKo8A5midKFflY+Uybqfi0RVzHdinqvRWGszWFrf/Wn42YTHm3EYz2zmclH6H8xLfOfHnD2elpu8qkhAG7Y6rX9WOfylXZBqIGfsSwsOsHkdMVRtn1fvx0Ryl4oQWJ1Nvlhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cskm53nT; arc=fail smtp.client-ip=40.92.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cskm53nT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIVa0Z2tNplPVqIgJWCCol0npMeSkhquBHRlWCmIKG+Xyvx9UUSwldELvw+WJvUGuSGc3SBMT0XDO3jBFkAGSfEsz2ld1N0SVb4L771MWGivH1kDHjXQZIRAJKyjjBKVNwi9zXuDiYzZaGjS8I3rpZiN0fyYgf0OgTvTM8ybWXOId7OQ0+iYOqesF+2HRHkiQLdM9ZsUqndIpP0uruY+616liuzxc7D2MwJIMPGGJ/CKAAHgT8f3IXntz+EI/waIr+nDS5i88s4W2j85vXB1m16g7E5Rikft+maeJKUEqEU6fzwK/uhnIohtLEEVPUqksEoAjhpRgbr/ajnSWoWozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3q/xC8quHmijQsE2iVF3t0ohwpu0uSfV91YVOmdtM4=;
 b=NYlf7MdH+agcJkaKYq+oQcQOeJ4hoxQ227sPoBN4qzMU4KpuSESoJchlsxAzsOs8MVi02/a5PNAfQCneFPhhMAYonSVy7RzOKVodSenxCKgoBV1NUfZ5fmozM61jIhrWaC/0PXMi9mA/fa40daB1PPuiLgOOrg90joTWi2eWfgOX861svt7To8IkW7wgfWqSRz/lCNcRvbv/z1RyKHu9mScJeTfhhaf2NfJ1UWkyJcXr4ZR0J5YcOz46IM8H6RFHVXoXf2u7Z7tx4kR9zG5itR0i8w2TGOBRkYE/21y/GxlD79YkOCCI4mi6pRBpT63u56CNBhQKMAhszw+36QFWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3q/xC8quHmijQsE2iVF3t0ohwpu0uSfV91YVOmdtM4=;
 b=cskm53nT0oF8jICL6KKZDNzttmba/hIHaWVzlHzPjpyj6lCYfD4Bgnu4r3bKVn0EM6rXZq5cUZqxs+O0YqJK+ZxqhD90+yuyC7AOv7OeGolksOmQUgFI9oLNWWvCMKXlsJee0Jw9JaTy/mb2RC6agkcJiUsVa9B3ddpABiT9U7ReJJPCvlHNxgHAgNUERVKjkon2jCvdLNdEjbo4StYZiSXyDvz32KOkMt8G88dzOjnvB5SD2fxfu0zEZdqZ+eqBbo9RKQjzp9Ggr0/QX4dWZjKThfE0jO0fBEyILCoUPqtSn2HWtkE7oqJROPEn/jHrrmtiTOuPOuvjUEyWMEPgMg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEYPR01MB4976.apcprd01.prod.exchangelabs.com
 (2603:1096:101:b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 09:13:31 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:13:31 +0000
Date: Tue, 18 Jun 2024 09:13:17 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use inverted-wp quirk for CV18xx
 and SG200x SoCs
Message-ID:
 <TYZPR01MB4211B26AEA487D9FB4D0731ED7CE2@TYZPR01MB4211.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <Zmrt-dcPR_ZXlYH-@xhacker>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmrt-dcPR_ZXlYH-@xhacker>
X-TMN: [eevGCR/Bd4NaFashmkaLanuDecTAj2Ee]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To TYZPR01MB4211.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::13)
X-Microsoft-Original-Message-ID: <ZnFPrWJ-K7T5UCMC@ketchup>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEYPR01MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a687f-b064-4c39-3671-08dc8f76ea82
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	XQrAp1hoZPt/ozPkB0w5/em+TZ4LZaT3ev4jDhwK/AL3n1NZq1MHWneJDgfDwPEHsk86vAT9pRolE0rCKF3JxD7sQFYmMHTVMxHJ5PzZxMpAWVyEShwrivio0uloiq4xqzuCL6qg2/B78N9/v1tS2+rNv9hSSx7tRAT3Fh/WOWb+8v629dZDKfsaFr5gaUEX+OUeYV4zmaaxDjdgjMKN5FrcVuA8TUvvazYyjSVOA5c26cu3LBXQLAaDrz4YLxNvThskUR9XtgQehKZmwwlBTlsfkbqzq3Tee46/m8K263IEvcb9VQgFux9tiuLp/BLfrSH+sq5r8j4SEnNAannvr63KuQIQC7CydPU7QxyCd8vqOCWRbEkoa8Y2XMBUGOLqqj44f+MSFlOp43Tmr9BA9SsEq8VzPIqS+rUohCoLHrqV0J+uylaN+L9qiSSJMwjkla4jGhkov/9ZPqLgSxYzO3JxVOvbZ6Q4RwRHirVZGbrvvhS1nB8T0R5D2AKHgT0mabsI41nFyTOlLojjkycjEQ9JzMM4VbER6n5xwHtH4ilf/AfUYIMR0Lddd2+g8svZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81x+KtTHBWVONZNmcpdamWiQ5iSJxG4JXGwrBeZpRvlekmBNx6sUTaNF9YmZ?=
 =?us-ascii?Q?RUtXQ/1TBu43UbkKxRo47MlpFEUk+nJhaKd6wi31sHDAgD6KxSfLyDtDqS/h?=
 =?us-ascii?Q?jUu16pZthgepg1NyCOniN95w5ObZhgfZX8CWC0GOMDC7b/+hLNfigSoTJuz2?=
 =?us-ascii?Q?9xyZmRWb/dxgfPI06ap10rI24VcKExTDrIf3t1/A3pEJsMucLXQ3KzUBzX4q?=
 =?us-ascii?Q?gm0XwOMIS9nmlbh5oSyXNk4An3s0Fs+mWnEHqF8au40CtZbwGGS4Hkk3wmfQ?=
 =?us-ascii?Q?K7F+E7THLmDUk9ml24QTD2djRAP/WCp1U1J/9zjimo7QBNynfH2DPdW63PQk?=
 =?us-ascii?Q?hQmaPBwWOxkjy0fNaobZa1ABnhN/0i/dW2DcyHElYcyJbCF56qM/U7t+HERx?=
 =?us-ascii?Q?PjlKjiFKFoO9u7hET8c2DZi9jxhlT1LbU0RDaCIOpTbwsU7i1Za5l+qP1D9q?=
 =?us-ascii?Q?tZhYgfUm/9B6kCJaUJReszHTWMQCHTkVktwPQprmsoWy9sMnmYneityGiH8O?=
 =?us-ascii?Q?8drbNhCE6BLj8Iry6scGwoVWEZdiNgH76BrzZ+kvuU1Mv8w7OO1QmgIwX3Q7?=
 =?us-ascii?Q?F0t4nv2iSTG4zqda9MoiVtiMScR1l3EdxdW4Q4ytWPGY0dwwfUmpdmmeCIyV?=
 =?us-ascii?Q?9Tu8avlTDXWD/ANX2IVXgehKQ44Opeg6V6S6ySpVsrC8gVsDZeUkMoT7XwnS?=
 =?us-ascii?Q?1bRoPs3KKYWD19RSIuXJDcRZqay8TDb63p4bVfk7ArleHF4Loo8nDtS/5GBf?=
 =?us-ascii?Q?T/uqOSUCODTBs0rQcXon2M6lR4WzpYpr8uT261TzHGPNEpSUIG1ZRXK7VaRP?=
 =?us-ascii?Q?VL0dB3IBbvGQQEfY2uOW5PxDdDB8Oi1qkbO8Pu9sDWafdPnGJtGX6A1Klg0O?=
 =?us-ascii?Q?3TFaSiIQuFUcS/yt0+l7LR4Vur/OFILicnlsL/L7eXEjszmsFlPDSCOGYf7c?=
 =?us-ascii?Q?uXzGVr4KZVvKsQDYUS1q2RpPz66fkep8y3wcCYtb4ZIKmUAZx0tyYLXIiKdP?=
 =?us-ascii?Q?eBIKgBn9nB2facxR8F/LjeipqkjrKdfFEyKT6CFTL3mDzKYNeH11PXbSfDhU?=
 =?us-ascii?Q?VrlwkWhQt7F2vty8PHSsAD866F0hVrdj9fIqHa/DB0lmZzMW5OBw+D512pMT?=
 =?us-ascii?Q?j8GGoy64BF7LB6tOrgUcoxvqXEDc7HVujsxLO4panGroi2As9vE6an8Lhl01?=
 =?us-ascii?Q?+3VpReAbdZZytxPhrYH6cU9tkmbxOEBX8HCtXRsuwbjG11Rj89Z2OYGIj10?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a687f-b064-4c39-3671-08dc8f76ea82
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4211.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:13:31.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4976

On Thu, Jun 13, 2024 at 09:03:20PM +0800, Jisheng Zhang wrote:
> On Fri, May 31, 2024 at 02:13:47PM +0000, Haylen Chu wrote:
> > MMC controller integrated in Sophgo CV18xx and SG200x SoCs has an
> > inverted write-protect flag, causing SDCards misdetected as read-only.
> > So set SDHCI_QURIK_INVERTED_WRITE_PROTECT to make write protection work
> > correctly.
> 
> No, I would rather set cd-inverted property in dts.

Okay, I will fix it it in dts instead.

Thanks,
Haylen Chu
