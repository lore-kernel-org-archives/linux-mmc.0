Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BD27D764;
	Fri, 11 Apr 2025 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350385; cv=fail; b=O3WUvV2IC/LPIlmEWDVxITkG3IFwJ7xgFbBAtKR79EBRX0hSJ0VGVoFK917zkhy70ET7xRpIrBgxlDP2ZQzcVa6MdBkmkowgpY7Ic5/q95LL3P9w4We/58d7aYaSmirIgyNRPBAvsiE48XBoifsitZZy0kHy0ddy3KBWWyTpCkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350385; c=relaxed/simple;
	bh=XAa0xOj+0YaaC0gznEIsvwz6/RjY1l1GapJWEYsvKRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMojH8u92qZroGiVxj9QiTu5t9d0bUFSQWf/+ve2lKz+jnQJi2ty8ActEUAWHn4DbhrVxkr+os2lZ3MwxsmAEuME3SOG2fzxmAmuA3g0kLRXKvnyz3mbBgrLKK0Hsm0nQQxgijVJzVkkCWsiOFhM9Hsfx7LT+iU4HD1pFUaSRh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g/zwVEFL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pMNcVJeC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g/zwVEFL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pMNcVJeC"
X-UUID: 48d9e91c169811f08eb9c36241bbb6fb-20250411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XAa0xOj+0YaaC0gznEIsvwz6/RjY1l1GapJWEYsvKRY=;
	b=g/zwVEFLYR3Ei62mx5rncXaZgZUA4exVK8p4S5V/r404veOIA05iY46wRDlpGe5W613PyDhTLuTM+DypElp74zU6HvsmxwYtTl+ENoYiE3ip9ft03ie+EyC5hrLea1FXrFbUTzZyekqk61hpTnJstmtlttD2v2Vvyn8WgRbUra0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6acd132c-9b44-4b26-ab77-63ee026fd27b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:ba7bf3a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 48d9e91c169811f08eb9c36241bbb6fb-20250411
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 656433964; Fri, 11 Apr 2025 13:46:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 11 Apr 2025 13:46:14 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 11 Apr 2025 13:46:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/mcyqxt5IhtALLGYLNgZjyDBHiHsb+3vwJsQvB+sc01BF0aO9HZ5Bc8kCwjZJZCGDdyV+6jXmAYYDDkw64OnyWyQlQ7NfqcofOQcxLNz/CfB1l7TB9hBAyyD9t47v1nEcIIAW2NhJw4eTGM3pYlK/tuB+gRURtoITBcDgukx06D9ADYsTByLksEOLe9cz9m0Ic70/B63jU7jmi+e+j3nrjdnfXAvqQFPhP9L7nhoHerYQJyAKfid7ILx2y7wHdw4siRnv2YgC4cOdHVVs/Alf/OApDgtOfwMzSF5l648HW1ELM3Ba4VnZ/PypptaY9Yw5PNOJPDEZVZibJPCQcDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAa0xOj+0YaaC0gznEIsvwz6/RjY1l1GapJWEYsvKRY=;
 b=b5uk77DiZ93H4cLnjmyAqpxvqizUm0eUJYz+lD0Om5szc7xdwOHQyjPeucnW4vB9eSAhsbQov2uJqnARHBiaJ6eODwe/y1NFxi54rl3FQs/5SUHTESmJJjxkI+O+TAc+DBq+5wrNu2zG38dVIG0Xk2/J4Kf7HqiovSiJqbdeqjiSlgqkpRAMXTzQ0fEPqnIwBZL41OusmIPKStaCnnKRkwRvqYB9lYAxXEQatz0PUwFQNAirCF5Rtrj4bKU+ClbvhPA8h+B5gmihkJLgQeFFoICSxTBGF2CH6Hmzmli3eCUR2BNaQbJcjjA3aPxa0p8HoWdEDMVWt4/9NFlWEF0ScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAa0xOj+0YaaC0gznEIsvwz6/RjY1l1GapJWEYsvKRY=;
 b=pMNcVJeCYNhfBvqfqTA3XAACfCgqKWE8ROmSGF2agrlzH5HwY+PsIgidbikSz6SVRtVi/tUVTl7ihArUns5H4W6dVx6WnmP2CbzzF2myuoHTYb6ub7VjfbFlnconu+a/oCfLEpl/kyiN1pztjYYdh4gQRS+pLvABEz0+u7RTDLo=
Received: from TYSPR03MB8428.apcprd03.prod.outlook.com (2603:1096:405:56::8)
 by SEYPR03MB6961.apcprd03.prod.outlook.com (2603:1096:101:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 05:46:11 +0000
Received: from TYSPR03MB8428.apcprd03.prod.outlook.com
 ([fe80::8dd3:7bb2:cbc5:e054]) by TYSPR03MB8428.apcprd03.prod.outlook.com
 ([fe80::8dd3:7bb2:cbc5:e054%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 05:46:11 +0000
From: =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	=?utf-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] mmc: mtk-sd: Add condition to enable 'single' burst
 type
Thread-Topic: [PATCH v2] mmc: mtk-sd: Add condition to enable 'single' burst
 type
Thread-Index: AQHbqe2i96BC8MjbZEe+frFPTsb5xbOc+HUAgAD9vQA=
Date: Fri, 11 Apr 2025 05:46:10 +0000
Message-ID: <5312b72fb5f5575877b4ccccf38dd81f62a5fa66.camel@mediatek.com>
References: <20250410075314.6439-1-axe.yang@mediatek.com>
	 <d725bafb-8cd9-4f40-b708-2760776bda72@collabora.com>
In-Reply-To: <d725bafb-8cd9-4f40-b708-2760776bda72@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB8428:EE_|SEYPR03MB6961:EE_
x-ms-office365-filtering-correlation-id: b468401a-17a6-48ec-a0dc-08dd78bc2a1d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MHJJTHM3ZHpwaWFaVHQvUGo3REZJRGp0NU8vM2kzUHRTV29UT1NLaGRIL05Z?=
 =?utf-8?B?MDI1bStMbHlhbHIzb1hJSUdRVUg0azk0K1g1M0RhZzlDN0hZOXd5S0tDbUZx?=
 =?utf-8?B?YzNBeS8xVE5tazd1UGRVcWhNOW9YcnJyY29hbmJWd040SkNPVGhudEU1d0Rh?=
 =?utf-8?B?QzdEa25VYWhkUWNjdU02ZjhXTTdIRHFjdkJMRGdaTDJCQ2hsY2l3bVNzOG1K?=
 =?utf-8?B?c3E1dlJvSmoyQlpkSXNpaDMvVjd6WmwxL3lJQUpvYXkxYk4yeFhkbmFqQm1p?=
 =?utf-8?B?bEVJS0pIeUhTZUMrV3FFUFJBaUpJSUxJcW90WTZ4OGxFMlV5RlBLcnAycU5X?=
 =?utf-8?B?ck1KamtJSkZHdm5acWNBL29zcnpWUko1R1JrVmhpdjhYNkNyUEdpUUdtVzRw?=
 =?utf-8?B?YzBoR0ZWVVFwYUhsRHJaQ3BFcmgrL2hVeVZWSWJObkJsZU80b3NnaE1PWHBE?=
 =?utf-8?B?bEd1QkkzNk9ISzZiNlgwYWFSMnJ4Y1UxUkVrMDRCeFkvUVM4bDJDV1BlOStr?=
 =?utf-8?B?QmZxNy9NT1d6eVZMMFpGekN6ZGJIUFcyS216UDcwY2sxL3gyWjZObTRwSHlF?=
 =?utf-8?B?enZWVXRPMUhQMHltaUZETHRZVzVXSVBvcGdNZ1EyamVPS0xDSUQ1ODVvTWJt?=
 =?utf-8?B?U0gzM3Q5VHhjRE1KQ1Q5clp2eTgydDNrQ3FPT21DNEVubDBld3c5a01qaTNu?=
 =?utf-8?B?VzAxQ0ZEODl0czhJRlNPb1VaR05TNUZLS3l5dUQyY2VWMjY1Snk2SUdYYmti?=
 =?utf-8?B?ejBJdzNsU1NtWkpNT0dBQUVTV2NQSldOK3gyMGQ4QlhSWlFPTHFMRkcyYjdk?=
 =?utf-8?B?SWoray9wVG1xdENnMVdHY1RYdVppdFZCenppcmpkUUJxbDhHWkx5TUZENUxM?=
 =?utf-8?B?QmdxK1NjTW83K2RXNFFQQmMwV3Q5NnlWT3IwQzEyc3NYbVdOcjV1N3I5Skpu?=
 =?utf-8?B?cDFMKzlZVWE4V1UzcVpmcWV6Tk00bStVaUdPNEFuaW4ydmFDZFU1WkRmbEMz?=
 =?utf-8?B?OStHeXExTG9oWXNLY0NpQ1QraDB5RGhtby92dC9KUG1xaUJmQWY1c1gvR1hF?=
 =?utf-8?B?MjB2WkpyY2E4bkNhOWFXeVNPcW1CVTZROHNuT09ZSGRmRG1MZlpCWlFaM0NH?=
 =?utf-8?B?OEsyZE1pekhjVDlKa3ZKVVNSYWlsOVU3YWxpZmpBL3FYRCtJM1Vndjc3S1pn?=
 =?utf-8?B?UGJudzFNajQ3TFpvUDlZakJkVWVwQWZRMElnM082YjM3M0RxSS9ycitqT2FT?=
 =?utf-8?B?cU9XOUFtYWNGMndqZm9NMk93aXhHeC9nZTl4Zk5OQ1crTkE2KzFWWTUwMHpx?=
 =?utf-8?B?dDNtbWN6YUJGMFRtcDg4MkxUSFI5bVkrZytiUkVkcUx6Vld5eTZpdFNKZ01s?=
 =?utf-8?B?akFNWlpVc2lZK3JMOTUvbFBvMHhQVFR1ZkwvMCt1bFhQazNoenR5VUxoQVNu?=
 =?utf-8?B?QjhGSjY1c3NPL2JzTFIwdWg3TktSTkREeUlPVDk0VmlXbHdnNUlhbS9QTG9q?=
 =?utf-8?B?d2s3VEJ4cFRMZGNxYzF0MmxjLzhyb0tjV0pkSlJJNk5MakFDZzEzWnBOTzlW?=
 =?utf-8?B?VnByVllwQlJvRnZ5SUcvL2U5REcrM0psVHFhU1lOQ05uVnhnZVQ3NzRRbTFU?=
 =?utf-8?B?d3lZOXFmeEJBcGVvR2FZeldWS2FzWlJGamFDaUJKZXpseWQwTDJQN0RPL1pj?=
 =?utf-8?B?L3lmOCtjUDlDdnFYQ0ZnOXg2Q2ZMNjNRUlZPZGE3UzhNeVkxZXhPVjZINmVj?=
 =?utf-8?B?MDBHMUgzMWl6NDYzdEFRK0xPMDJuSFhiaHFDak9kY0grc1ZjdytzVjVjNklV?=
 =?utf-8?B?L29XdS9hTDBaQmhueU50eG5xa0ZaSzV3NUt6NXIzMUwzNVJhVE93MEhMMWR4?=
 =?utf-8?B?UUYxMUYveGt4TUZqU2c1dWdhaVo3M1RUdW8wNEdwNG1sWDNzL2NVTGduUHNn?=
 =?utf-8?B?RmZXb2Qzd216OEd0OFlwMmNVMVBYcXF1b0N2R2wxSGc3eVI2SloxNFVyc2di?=
 =?utf-8?Q?80vadqOEYmGF1Ajv1sEpPRQCOWCHbg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8428.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUFQNWZkbjZKalMxVTAxNGMwVklqUXhBVWVCVVlwbnloNnBKNGpybnBDV256?=
 =?utf-8?B?d3cxZ2tJZHYwcWY3RG9EeVNuSyt4REpYMllkZ1EzWStweDhKb0JXRDJSZ0tW?=
 =?utf-8?B?OG5GTG5XMmZrOEtUUExGRmMvTlp6RGlKYyswM09BRWFRdis5RUgyTkZmQ1Rm?=
 =?utf-8?B?WThZSXlGdStZNXBFOVJPYi9haXJzTmNYQTRwd1VJS1NhMkp3L01sN0g1R2VL?=
 =?utf-8?B?S1FjZmpBSTVkZHJuTlZNanQ5RnVHSmQzZFk2T20zYVJwL3FGYjdTVXpIL2tK?=
 =?utf-8?B?RnM4L3pPQWxReUxEalhKd1ZKVDNncHdsYTRUUzVnWFVCQXhYYXU4SmVxZzcz?=
 =?utf-8?B?SmorTXdOVk0vVUN5V0VxSHlMUHg0aUdMQkQvbkpRdHhFQS9peWh5Mk1sYncx?=
 =?utf-8?B?b0xmNFB5MGRyZTExeGdsUitHUFNMV2EyaDBBSC93MlJvbUhyWUtrd0Q2d0Zh?=
 =?utf-8?B?b2w1REV0VEJTMkY2YWtBVkFJVkVWL1M3b2Ezc1VBc0M1Z3dYYjl0dVJJS3NO?=
 =?utf-8?B?b3FXM2FrSDdxNUsyV0NpUGpWeVlhQWMzOGJRTnNxYTlVN01xUnkrS2gvU3Zk?=
 =?utf-8?B?Vyt1c1cxejRnRWRETlpNSHhkWk9vbE9jZ0V6OTJ5cE1nTVVKVGV5N0Q0QXhl?=
 =?utf-8?B?VkI5NnlmSldDK1BMVFd2M0NpUGlscFVZZS8rNXV5QXgrS3ZqajcrcE43WHpz?=
 =?utf-8?B?cThZNlBBd1U5VW16dXEwWWp0Z0laYnVXQlg1RUNQK1kveVAya3ZsbmgzUEhK?=
 =?utf-8?B?ZzErYWY4bUhqaTJjU2pibmt4elk1dEhvN1RxZllUNisyRUdrUXZxSXlSMUo3?=
 =?utf-8?B?SVJ3bEFmWVp1dG1PenRzT1JOV1ZBYU95ZUFtY3VxTmNOeU5CVzNpZFgxU0xP?=
 =?utf-8?B?bGE4WFNvZ0tFNlNQYUs5bTEybEMwVWlQSGEzRHhFd2xWU2l4d2JDK0xzNjFL?=
 =?utf-8?B?bTlLNWpYLzNHeHVpZno3dGR1TDczOVl6OEsyRTRxYk1tN2ZpTExSNTJJMisr?=
 =?utf-8?B?WWliUnBucEdESmVvRDkzWURrU3JqSDhvck5JMlBJYzFyZkdZU004b1htczdW?=
 =?utf-8?B?TzFxbCtBa2taWFJFWHlOREFyOWhDZHBvY1kzWUlDN2N5U3l6MW5GeU9oc0pj?=
 =?utf-8?B?TmFVaUNNTFZIVDRSTGF3NHRSRTZTTURWSnYwZFllTG1iOHJTaGdncnBVTWpJ?=
 =?utf-8?B?VVU4RDlZU2krRmtQU0NmWDFYMFFBT0VtU1JQcGc5azRNUFdCM21BLzY2RjRO?=
 =?utf-8?B?MU1CUFlCUGZuUFFJSDBxNVAwdCs2TWZ3UkVGN3pydElpQzlYYWZZb1hiRXR5?=
 =?utf-8?B?cUNXbkdSWTJNKzBielRBdlhXTzlGcGU4OFJWSnhNOFRXMmVHNUhKdlNXNG1N?=
 =?utf-8?B?WUlsSGQ2UmRnc2xQNEsrZHdNRldtWE1zUENvalFBaXNlWGxzMWM3THBIWVpw?=
 =?utf-8?B?Z2VIa3M5cjBsbG5YbHJBZDVpK01hYW92M3dHVStONTZ4aFNnOE84WmFnYUhr?=
 =?utf-8?B?R0prMks2M3hRbHU4YzdnenFWaVZUMkRTbXFUc3crN1JRR0VJbW45TWtQNHpp?=
 =?utf-8?B?Mk1mbXl2TjZ5Z1UyM1M5NG4raVRzS2FSRjYzVFFSYVNlczA1N0JXZHZ5eEpn?=
 =?utf-8?B?Vm9zRVRkMkVjRUh1akIyOVZGWDF4VzRDcHpEMkxMR3cvTFNjSE1DMGxHTE1m?=
 =?utf-8?B?VFphWTViZ1RDSG5TKy9qWFBxUUkwZzFtNjJVMG1oeWVPUlBFSkJyMFBtRGlx?=
 =?utf-8?B?M1NVY2wrV2xIU2ppaTZFYnVWTWh3WUc2c2hRQkhNRWtJb0o1c0dIYU1Qd0t0?=
 =?utf-8?B?cUgrVEI4aW9mbG1id01yWkFSbWV4ZUlUajR1Y3lTOGdQSzNIK2crUENZYUtG?=
 =?utf-8?B?ZmRxTGdEcnlkSXRDTkVRSnJLL0NrMkxZK1Raa1VyU0hUVWpyU2ZYR0RneWlC?=
 =?utf-8?B?ZDVsSlZmWEpIdTJjLzFua3N1REpvSzZlL2JUUzRWaVhZNUF4TVNEdysxMDFJ?=
 =?utf-8?B?THVENGRSNVFta01LTXVxeWdxOHlxQ2lncHlOQmdNd3hld2VTRE9abkgzbEJN?=
 =?utf-8?B?ckYybUxHU3B0dVRHelZMRWFaUy9GZjJYVkpXVDlHV0U0V1BPbDRoa2JNcjZM?=
 =?utf-8?Q?cJvnZBfy4XyZqodtuWqbDKD5L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <897EBEC428DD1A44B3B4D501E7673DDE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8428.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b468401a-17a6-48ec-a0dc-08dd78bc2a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 05:46:11.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/zanW29CpJ+yfhh5Bys3YPhN/1zN07H/ZkyAO6X9HuVVJHER4CVrDEXwFJYUSy6brs2awgZ3g6biJ5UbMz3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6961
X-MTK: N

T24gVGh1LCAyMDI1LTA0LTEwIGF0IDE2OjM4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxMC8wNC8yNSAwOTo1MiwgQXhlIFlhbmcg
aGEgc2NyaXR0bzoNCj4gPiBUaGlzIGNoYW5nZSBhZGQgYSBjb25kaXRpb24gZm9yICdzaW5nbGUn
IGJ1cnN0IHR5cGUgc2VsZWN0aW9uLg0KPiA+IA0KPiA+IFJlYWQgQVhJX0xFTiBmaWVsZCBmcm9t
IEVNTUM1MF9DRkcyKEFIQjJBWEkgd3JhcHBlcikgcmVnaXN0ZXIsIGlmDQo+ID4gdGhlDQo+ID4g
dmFsdWUgaXMgbm90IDAsIGl0IG1lYW5zIHRoZSBIV0lQIGlzIHVzaW5nIEFYSSBhcyBBTUJBIGJ1
cywgd2hpY2gNCj4gPiBkbw0KPiA+IG5vdCBzdXBwb3J0ICdzaW5nbGUnIGJ1cnN0IHR5cGUuDQo+
ID4gDQo+IA0KPiBZb3UncmUgbWlzc2luZyBhIFN1Z2dlc3RlZC1ieSB0YWcgOi0pDQo+IA0KPiBB
ZnRlciBhZGRpbmcgaXQsDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gDQoNClll
YWgsIGFscmVhZHkgcmVzZW5kIHYyIHdpdGggJ1N1Z2dlc3RlZC1ieScgYW5kICdSZXZpZXdlZC1i
eScgVEFHLg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQoNClJlZ2FyZHMsDQpB
eGUNCg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF4ZSBZYW5nIDxheGUueWFuZ0BtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gVGhpcyBjaGFuZ2UgZGVwZW5kZW50cyBvbiAnbW1jOiBtdGstc2Q6IENs
ZWFudXBzIGZvciByZWdpc3RlciBSL1cnOg0KPiA+IA0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRp
YXRlay9jb3Zlci8yMDI1MDMyNTExMDcwMS41MjYyMy0xLWFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyFuUVVvdHRyZkdGc0hpSnZGUmVi
UzRaN01SZmJmTGxOSm1zVHFCcGdDWk04eVJ5dTBDRUdsRGYwOWNVcFNSWGVma2E5OGs4ODRsV19u
YjBidEo1WnZzbzE4VGt6UmFNZyQNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbW1jL2hvc3QvbXRr
LXNkLmMgfCAxNiArKysrKysrKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBpbmRl
eCBjZWVhZTFhZWFjOTQuLjJlNGJkNTE2NmMxNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+
IEBAIC04NCw2ICs4NCw3IEBADQo+ID4gICAjZGVmaW5lIEVNTUM1MV9DRkcwICAweDIwNA0KPiA+
ICAgI2RlZmluZSBFTU1DNTBfQ0ZHMCAgICAgIDB4MjA4DQo+ID4gICAjZGVmaW5lIEVNTUM1MF9D
RkcxICAgICAgMHgyMGMNCj4gPiArI2RlZmluZSBFTU1DNTBfQ0ZHMiAgICAgIDB4MjFjDQo+ID4g
ICAjZGVmaW5lIEVNTUM1MF9DRkczICAgICAgMHgyMjANCj4gPiAgICNkZWZpbmUgU0RDX0ZJRk9f
Q0ZHICAgICAweDIyOA0KPiA+ICAgI2RlZmluZSBDUUhDSV9TRVRUSU5HICAgICAgICAweDdmYw0K
PiA+IEBAIC0zMDYsNyArMzA3LDEwIEBADQo+ID4gICAvKiBFTU1DNTBfQ0ZHMSBtYXNrICovDQo+
ID4gICAjZGVmaW5lIEVNTUM1MF9DRkcxX0RTX0NGRyAgICAgICAgQklUKDI4KSAgLyogUlcgKi8N
Cj4gPiANCj4gPiAtI2RlZmluZSBFTU1DNTBfQ0ZHM19PVVRTX1dSICAgICAgIEdFTk1BU0soNCwg
MCkgIC8qIFJXICovDQo+ID4gKy8qIEVNTUM1MF9DRkcyIG1hc2sgKi8NCj4gPiArI2RlZmluZSBF
TU1DNTBfQ0ZHMl9BWElfU0VUX0xFTiAgIEdFTk1BU0soMjcsIDI0KSAvKiBSVyAqLw0KPiA+ICsN
Cj4gPiArI2RlZmluZSBFTU1DNTBfQ0ZHM19PVVRTX1dSICAgICAgIEdFTk1BU0soNCwgMCkgICAv
KiBSVyAqLw0KPiA+IA0KPiA+ICAgI2RlZmluZSBTRENfRklGT19DRkdfV1JWQUxJRFNFTCAgIEJJ
VCgyNCkgIC8qIFJXICovDQo+ID4gICAjZGVmaW5lIFNEQ19GSUZPX0NGR19SRFZBTElEU0VMICAg
QklUKDI1KSAgLyogUlcgKi8NCj4gPiBAQCAtMTkxNyw5ICsxOTIxLDEzIEBAIHN0YXRpYyB2b2lk
IG1zZGNfaW5pdF9odyhzdHJ1Y3QgbXNkY19ob3N0DQo+ID4gKmhvc3QpDQo+ID4gICAgICAgcGIx
X3ZhbCB8PSBGSUVMRF9QUkVQKE1TRENfUEFUQ0hfQklUMV9DTURUQSwgMSk7DQo+ID4gICAgICAg
cGIxX3ZhbCB8PSBNU0RDX1BCMV9ERFJfQ01EX0ZJWF9TRUw7DQo+ID4gDQo+ID4gLSAgICAgLyog
U2V0IHNpbmdsZSBidXJzdCBtb2RlLCBhdXRvIHN5bmMgc3RhdGUgY2xlYXIsIGJsb2NrIGdhcA0K
PiA+IHN0b3AgY2xrICovDQo+ID4gLSAgICAgcGIxX3ZhbCB8PSBNU0RDX1BCMV9TSU5HTEVfQlVS
U1QgfCBNU0RDX1BCMV9SU1ZEMjAgfA0KPiA+IC0gICAgICAgICAgICAgICAgTVNEQ19QQjFfQVVU
T19TWU5DU1RfQ0xSIHwNCj4gPiBNU0RDX1BCMV9NQVJLX1BPUF9XQVRFUjsNCj4gPiArICAgICAv
KiBTdXBwb3J0ICdzaW5nbGUnIGJ1cnN0IHR5cGUgb25seSB3aGVuIEFYSV9MRU4gaXMgMCAqLw0K
PiA+ICsgICAgIHNkcl9nZXRfZmllbGQoaG9zdC0+YmFzZSArIEVNTUM1MF9DRkcyLA0KPiA+IEVN
TUM1MF9DRkcyX0FYSV9TRVRfTEVOLCAmdmFsKTsNCj4gPiArICAgICBpZiAoIXZhbCkNCj4gPiAr
ICAgICAgICAgICAgIHBiMV92YWwgfD0gTVNEQ19QQjFfU0lOR0xFX0JVUlNUOw0KPiA+ICsNCj4g
PiArICAgICAvKiBTZXQgYXV0byBzeW5jIHN0YXRlIGNsZWFyLCBibG9jayBnYXAgc3RvcCBjbGsg
Ki8NCj4gPiArICAgICBwYjFfdmFsIHw9IE1TRENfUEIxX1JTVkQyMCB8IE1TRENfUEIxX0FVVE9f
U1lOQ1NUX0NMUiB8DQo+ID4gTVNEQ19QQjFfTUFSS19QT1BfV0FURVI7DQo+ID4gDQo+ID4gICAg
ICAgLyogU2V0IGxvdyBwb3dlciBEQ00sIHVzZSBIQ0xLIGZvciBHRE1BLCB1c2UgTVNEQyBDTEsg
Zm9yDQo+ID4gZXZlcnl0aGluZyBlbHNlICovDQo+ID4gICAgICAgcGIxX3ZhbCB8PSBNU0RDX1BC
MV9MUF9EQ01fRU4gfCBNU0RDX1BCMV9SU1ZEMyB8DQo+IA0KPiANCg==
