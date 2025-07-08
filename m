Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD312E0405
	for <linux-mmc@vger.kernel.org>; Tue,  8 Jul 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988534; cv=fail; b=XRwSrCd0CnTT5p43nb3YeTkIJdmRrnnqMZWRv86Fi6uYNqk7jcsowkcJ9WJ1cPs28ZLwDUabfCsbL4yVqWWB/76OhngL5zp0DIekI+QGYpHnqqp+TFXX4FpSkrG3RgRMKbJu/lUkWvRlhe8Nnvqq39v0ixUG0x5Po1UeASRoZ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988534; c=relaxed/simple;
	bh=GwYgPM1IA+toPY3z22SMpS9/prnxSbcRxUD6lAWyi24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qgsmt8WpS7+TeSwRa2WyvFZN1lzXeuyTfWjl7jbmtCcwyKFdAUHa992NbFD3mAcs25OcckgmNnZFLi0+xYisA6V+RDghdbbKgOk4mDjEP/W5Coth5W56iviRsnsA3tc1wtBkVoI8u1D1RF9zCHY0wUVzHLrH9B6nwmkenKjqeS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=pBHyyE3L; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="pBHyyE3L"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1751988532; x=1783524532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwYgPM1IA+toPY3z22SMpS9/prnxSbcRxUD6lAWyi24=;
  b=pBHyyE3LAyCoZDUyaKYjLW34LPDnXp60pvlYWc2XpyyE/yONYFynPIWT
   EoOszjuAqKSpvehnHVAj1yg6/rqhEVlwfuvJf0gD2zw3erJ86FT3nPB2+
   K3szi5vu0VKl9sUG3tGViKeCNZ8up7phjSWj4QpBuox3+53gYZicYtaOb
   B9PyMcRtC4lapz5qbl5vRMJGSAuacaLRPpD/JyWxAY8BZAQu0J1UdWigY
   ZG8K/pUgwZ8Hjr15grMqvB8ADY3fwRLzwdyu19YsNmDOWPz6H0+Jus393
   iLiwR0vii6ppIaRuBobySV7cju01At6pY8v8MWmcNdjMETfYmXWjENmnx
   Q==;
X-CSE-ConnectionGUID: J6hNnpnvTge+h5QieNXbBA==
X-CSE-MsgGUID: k0q6teNySpeCKKnMI0MZrg==
Received: from mail-mw2nam10on2116.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.116])
  by ob1.hc6817-7.iphmx.com with ESMTP; 08 Jul 2025 08:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovlS+loo/5R4Px37+c4J2PhNMXjdt75rip1HYG4+gzlqsRd2P1KwiywkFdW7Yth5RceF39YWA/wrhK/6sgExSFlquvcNL+ndx/GiUrcxwIkwZLXxBCbolsOS8LtihekYks5QG3vb/5KISTE6Fg0QpN7rJduXo2tm/K++TrYVEEamy6+et7U/f6mbObXh1W44eBlYmfVr8yFQeplh2L7xixnCFOyEeVBYN44PLw75VzNPWtbP30DzW84y2lA/Q1mtSoHxCsnPhF3SoH2It+mpGiMyKMci/wNtSdj2iuWISis70IHgIZuIp8cW9Dp/rYl9uzsPGaQidVuQnaPjpA3FNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzZn7f3m6JdYg96r0OBBVn2BxsSqYe1FG5ABTaj5dvk=;
 b=qYi3NtM8ayTvESADHtS1ntTNkEe+D7iBKQ6bBRztZ82l6U7vhjvuR0IWgc32KzE+uwB3FzHL60oazoERdhQ1AW5KLPWOTu4dRRlh2arx2BEDAckmD4TcIV4+XuAkem0zYLJKhH7TZYQQG0Gc7mkAhLWWW/Fuy4SsdKr4YdXO0NmyiotZZYOV02+HgjFBHYTZOxp3EFTAuLp+MpAoxiKx6BTJ64zQEDeeI0sp0JPvihgNCGUXcL8Qap17EWWAwXaoxJgl69KtUIPtGelx5NFcfaF9bO0z28NojOCSHdKmBe+VesGcveXJKvvjitXIoXpOxrGGZBW0X6L3uQBeR8L0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MN0PR16MB6510.namprd16.prod.outlook.com (2603:10b6:208:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 15:28:43 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::3f03:3b5d:6737:8231%7]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 15:28:43 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Michele Dionisio <michele.dionisio@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "avri.altman@wdc.com" <avri.altman@wdc.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>
Subject: RE: [PATCH 0/1] mmc-utils: add ability to flush optional eMMC cache
Thread-Topic: [PATCH 0/1] mmc-utils: add ability to flush optional eMMC cache
Thread-Index: AQHb7+FUNaCdv7F7J0ma4DIA6UtpIrQoWTWA
Date: Tue, 8 Jul 2025 15:28:43 +0000
Message-ID:
 <PH7PR16MB61969299B80FB299C1458152E54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250708082105.160653-1-michele.dionisio@gmail.com>
In-Reply-To: <20250708082105.160653-1-michele.dionisio@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MN0PR16MB6510:EE_
x-ms-office365-filtering-correlation-id: 1893d5c2-0592-4555-496b-08ddbe341f93
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FjcYVta7DDxINGIa11I8zpdFu98t/L12MSRHOcTfpyN2vSWvpXoit1Ntw+jI?=
 =?us-ascii?Q?AQoHnKBSbP0w04UpNZW+XvJXgnWYkU6x7rgPcBizAF2PqPx49BWu8vS/qMnt?=
 =?us-ascii?Q?gOs0/aCk/vCreZc0ExgpnBvKc4dhXws5984rXUQ3Kl6m/UJGLCQ+CotJs4Zt?=
 =?us-ascii?Q?f/sFHjx0uUBuzSRwUOcF1rU3yGunO1Yr2xfPlXrUt5YKWoSb6e4yMyVJbznp?=
 =?us-ascii?Q?U9E1kLiXdtLgGYVrpKTws99977H8seVJZeb+BIUcD+ZD4IXs5fyBX4HzAgiK?=
 =?us-ascii?Q?vz9pJyvcYbzuc/9pK/4xpeBGD3gVSngznIxXBnDJjNeMJEtKQAnxSkdjbSHd?=
 =?us-ascii?Q?SVa80uSVFpyfbc6RZ4dWREekYdCwE5QdFds1rwBtmrlz3/yKi0+dR+UQq2CA?=
 =?us-ascii?Q?0H903jD4oSvXlXNO3Ac5pcllhPte3JtlJl2L+S/O+t89uc4CJ03VQDsfJwqe?=
 =?us-ascii?Q?aUtGd7rvhTVX+MMfZo0nvtyu+mZbpXNGr/fZsSamy+bEkjMVKazNwyhXtc2S?=
 =?us-ascii?Q?JHPw/Z17NmWCaZZUX/0kc3WV1csW5e9tRDHwhYYhlXuS9tX6ZnFXYGyvggZK?=
 =?us-ascii?Q?1kWQjLP8nv4B7VN3g+M2a/5xGWHsKQ3QkF4EgwN47Yx7SBE2uAdANunmcWGA?=
 =?us-ascii?Q?tK1NBbH/A4yXhh3zlAxDLgehXCuKZUs3taZGY9N8WUNDl0dcJNb4yiL7vX5o?=
 =?us-ascii?Q?5kcmH+wN74AKNpHuh8NZxAnQUgSCjXi4ldFDZbr44Uuhn94zSWpx6q5enKmv?=
 =?us-ascii?Q?yPGd8tl4gihu9YKEjY4Salq346/5RhPL47pTwxkfswd6UvGuuLvpQMEPsafd?=
 =?us-ascii?Q?SoFUFo/JLysbN+M+JIyYuJBGclT6Qa0RiBnt+DysvA/bj+6THmQ/Ng2opBAB?=
 =?us-ascii?Q?JberupC4ZX18fEQCMJEV+9ksSDU74gT4XSIA/NZLicitRt2RWOFw5fm1kYke?=
 =?us-ascii?Q?hjmbLyOwv25TcOmG/DhQGNJJu7ZU9YzYT0L+esmYRCeF9xJZD4XAmKdDqVhj?=
 =?us-ascii?Q?/KBC/qSYDeb1g85krUdDYh6Al0EKKjR+08Y+PWXR/44tMX9IjOg6lC07BFjU?=
 =?us-ascii?Q?foU8G1eaXfGo+LaaMTEOvJNWh6ccO62L3QmbggcVPNuGmTj6QJmYwu3cKpfx?=
 =?us-ascii?Q?WYcjnF0ezm3ShMflxLs7YLTBQl5DxLU+s63xoTei6oMr1dSC1lsNk+vkPGu5?=
 =?us-ascii?Q?bb3QB7d1KfpuHyejvA90UtXksNOCkTdHSPCrZGrBUUTCn5CsCY+ujSr3IVAJ?=
 =?us-ascii?Q?FpFxJTqQ2nDVZ0qinOAmTjplpEm/WcNXY7RKqNBI2QhPQ6HJysKIalOT48YN?=
 =?us-ascii?Q?FoPtBSVzUiUzyhi59o8UT8XXCCK6lZYDyxr2aLfbNuQX/607cDnabxivrvny?=
 =?us-ascii?Q?t+ABvG82XRVxKEv2ZKmY0jmZLCPobEVtj4lcRjNWfSHUsjGXPv9cKejwiaO9?=
 =?us-ascii?Q?fbZrS5e3dJS81qEHAkiDqfokMt59f4Dukc3qUdKYX7M+boIH/7Rq7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F8YDld+oQ6tAsB8qKFrG0akc/k/AvsN2LU36xFyhjIoeEuhBu0Dyp71FNJ+a?=
 =?us-ascii?Q?N4d0f4cYa/HwIhXIN8brNLEtr4l+lKJ0Db46aG9J98880CrfmpvxJKphBFGD?=
 =?us-ascii?Q?IclwNMRS2Xh542k6UGLPa3oj/J6J0etmNvPTHorCjUKMY04Jj18F1oC2EWxD?=
 =?us-ascii?Q?5ICXXBO68wAaINN24EGvmSlDQI7S1hsYhSI/POFIB+Pce5HkKBRfiTe5/GQs?=
 =?us-ascii?Q?MqkORI+NmAd94aVyzVSOz8a/OSTCb700XzOn4kfFLBTHswDBpjgahnZl0Dn0?=
 =?us-ascii?Q?6qk0vfY+TeF0dmsxrQPZMhpobvhlx0adM9fMTVwdHjUvKyC1vJRxv2jpX8cR?=
 =?us-ascii?Q?g5DpX2r+48qDwrkmz/1m2GlF+MOibFrqFIVs4qa8Eakg+bAGh9niQAPtuN34?=
 =?us-ascii?Q?uKHw4Ghg2OBACqFZ5IeD/2fleUltO2yqQzPy6yUnzhRCYpcn9o2SMCu05sCx?=
 =?us-ascii?Q?F9t0smR3HVD57OAa/pkuUwwdPDPLg5B/q9x8ySbSpp/jSYp23GjiuLk1BDoQ?=
 =?us-ascii?Q?9cmQEeA6LpOCA3PQnRnxwdVa4nL6wJ71+wTRHtXAzYXZzUACvCA2NmXzUxqQ?=
 =?us-ascii?Q?h1zMXkcD69mf69DionoNcHgC3mrReoaAIsWNKRblwFQdkU+PnnLqtnVN0zMr?=
 =?us-ascii?Q?sCyPbYEL5fFvy2dgD6QPM1FRit9h0Yv/44foLPxg/RGxJgrxqu5j/lFCw6jt?=
 =?us-ascii?Q?V6ZJg/KOHlKiNDeuKp+NdHq+4yVMMXdqgUEF+rZnK70BhYYLqXlXThh9HPSz?=
 =?us-ascii?Q?9YJNFoJrtqv0XV4unuklyARGGYFcxfaaIZNoNS3IPqLaQLLKHk0fxwfKNsBu?=
 =?us-ascii?Q?7CULkXaO9NXSJo6QcEMmKM1hGXzq9/1PCiZH2Ftbo8E+ui9M5F1GVsAPHxsy?=
 =?us-ascii?Q?ThXPkacjnFqtdoXkTSHgAWwLWNAbRl54wPryGxP5pfMocnvIAfP4utAjCnEZ?=
 =?us-ascii?Q?GFOfK7waP0x3J48z/ztkEfPHTnxTd8r9TJ8gZuV2SiMx3Pu9RsIxt+A/E+YX?=
 =?us-ascii?Q?fq0m/PYUryF1Ml9J0Fr53BwkIzDNQ/02ffaDed+2R8fES2GSt8l/Zt545nNJ?=
 =?us-ascii?Q?8X40MKsRaD/7Aj+AjpCCvld32C7YyipGtg26zbjcCRf/kRWAm5sO1V8LiZFG?=
 =?us-ascii?Q?NK9HucmoWbORGERP98zD+3XkyHbkiEsFsB48RczvTqm95sRbO1nD16AD/ntw?=
 =?us-ascii?Q?CUBOtXoLU0O+cA/3aePKmSGwXL1XMsmP6CGItvsJ4UPmPSYo001AosoSZE0G?=
 =?us-ascii?Q?YiJoM9GaNJWqghS0GWg8GxgGhbxI4TNsjvwjtKRhNpRSYx7Em6h+FZtvzogf?=
 =?us-ascii?Q?xGZ+2j3aAvG3f3nRpwQ/DAs2ndRFDqMheyJakWut2QNKhrFkURL7161mnZyB?=
 =?us-ascii?Q?XFVxF0t+1zPpDHasDxVZHGj12UtOpa7k7b6K9CPzTQ2a+x0BOrOClhf+ZABL?=
 =?us-ascii?Q?OxRc6gIwUzrMAUQi1SM7QPINEI3K0DArzppiw6bxuoZsUTDwEyQSF+FsSnca?=
 =?us-ascii?Q?p8PP/d3N5yUUgLXgm0VZjmEQS5Rdct0MGycCgW0zItpTwFeZyCtYzrv2TMLN?=
 =?us-ascii?Q?Q4VVINQWXc7qhQ+22MSgh4iUst8P4zeH6sxQ3vdv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	63L8wWQyaINN2Goxm3P55/xMWkPioRmwHYbYzjgr5g7Qs47Cz1Nzj1ypfmxXWqTeH5JNfvxqCawT6rd6Q3ui6bxh6X/pHGE26b70W0W2uJr/+lM19MGqAC6nb237yXu81I0prEqoM7U/PKTWDTuY3zMlm1ICLyLurQSWk5jrxENO5mYZ3GWcX0K6+o0zBs2sAw2S3JEXV4QKGLaTmuK/dOI3AjpY133IEAHcAYH5OdT/Of3CGKzF45fxnuJphu055iDX19SweW4IzI7us+Yf0CmjiwxEo1F9/BrSJwj2WRr2kkBE9t09FuD/E5kXdHCreDwYOTonBTpKQqco1PqzpzdS7LfXQt5ktMpqC/5Ek1OmUyRCLtJY4U/DuhWULT/D9gCK4T6sJTr0m7wWdaVLComI/cLRNFhuBgbd9PCbuTkBsbGEXmB4ByX12N+MF6b5T204GGp5QXeEJmjNokOD0DjPzwFbXABgubo+9oK48txReM5+4nORoBDKbeGaynwmebhwkVL3dcQBpJXtLr32ksXah11vs9DGhBPofeP3Oj2I5MnE2LHmUAnODenIjzK+EVVR5e/4DJA8kmk0KxOjPYQqvG+EPVWIB0U3WFsUZ17Ia+zuFWhdJ/8haL5dRTxG+jp1SswY6hxfqtgpPrRu2w==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1893d5c2-0592-4555-496b-08ddbe341f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 15:28:43.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dek/bjZo6eX+tdoojI2NSbfs9CLavBYDbdeKFq6dX3AHsCb9IBpQ2cbf3nt/2oHxBDySSu67/yqqS4DmHVSOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR16MB6510

> eMMC 5.0 introduce command to flush cache. Linux Kernel support it, so it
> can be nice to have this feature also in mmc-utils.
Maybe you can drop the cover letter and elaborate the commit log of patch 1=
/1 with these lines.
Also maybe you can give some stringer line of reasoning beyond "nice" as th=
e cash is constantly flushed on every runtime suspend.

Thanks,
Avri

>=20
> I would appreciate any comments on the usefulness of the change and a
> review.
>=20
> Regards
> Michele
>=20
> Michele Dionisio (1):
>   mmc-utils: add ability to flush optional eMMC cache
>=20
>  man/mmc.1  |  4 ++++
>  mmc.c      |  5 +++++
>  mmc.h      |  1 +
>  mmc_cmds.c | 50
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  5 files changed, 61 insertions(+)
>=20
> --
> 2.43.0

