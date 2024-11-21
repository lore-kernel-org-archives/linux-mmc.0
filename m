Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4971D4324
	for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732195432; cv=fail; b=aVKv67RFD3ELUrmQeKLE/6YWurV8KebXoR9yoCE4Zass1CqemqzHE6Z9evde30sphlkIWEytcagkd6vF9/WPtWAaKNgaGiqPGzkk2vNDBzFJdadB0Gvkx2fjYU5xaNjcQVyyw9IE9vOODahUPGGMwdeJqBn4NQJWP9f8c3vfx0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732195432; c=relaxed/simple;
	bh=wDAdNuAtc5lJonxSzH9yovs5ykt+hRARxdSS4gcm19c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1AUuPCSFLWaPDifuVSZVMF1DWu7yxZp0XKWbxbKLPqnm9Urd+PQo7CMSsMk1QRTY0G2zYG1fbmkQ9+NdUkj0/LaFoNYLr3kjzpjWD0gMKGGtTiSMuRsjVRGaJ01oy9ojwRUnmUrYEaTlqZyif3evYjES+HVAvg1fAqv/xu3pT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=oj63BdYQ; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="oj63BdYQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAF7+DpU44SsPxZHflyv/0jwZrWBKIcTuLTorBWF1dS1IrNXF0M1qLcWaSvoMjON+A162jPBY3Ntkfwc6balJcv4V9mqc9hZyKuZLCZz6/ulA4xGX50RNCj4MDRY/L/nGqnuDTuUxenoYc/ZmUFpT3ZVXMbNA4YKTqBTDNdcz6pSflcibcJIvMKSHWEs/czHUNn9z8+A5mj+8VwCefgb82kK4cSpuGoqvRw/o4CnpoMreIfRSeTAsd1F0HpkHuz0n89VF1zg5JpVwbcJ8y0EySiTYxEoRooEB01HXmyzTUe5WkPfpDyuq6i8Z9b2QgGOxTTru+qLDFKB+WaB+weBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihc5OHMvNTS5BbLA0auzCaJCg3jVtUqttWcHwsupR0g=;
 b=oEcYqFldmCnXBZ7hvVKYZS7I+rTcn/f4p9TZJSqOCpieXujKQGOuDNZzgZkhrKlY09eqAV5Yr2uWhbO8iyXEN3+ntEksXdYNEI2yazd5yB8Hsbhx6k3D6ep2xcbD7UelRjTXmTh/JFmDgv54gGbT32+6s1s4Tyg64H+i7UqUiBLkvAJKDmjrT0f3sGr2mCsizIY7zacFZQ76YuBLKV6Qc2PdQTMzIghl6wB0XtLu7adtAZNklXr+cJB7aZG7jFE9gVZ3NkoAIcFNWQBJjmmfZKiP7KuL6r0xbgY43+9QlyLmTQcL5rPD/thmrRXBJwBb7EDFEtZ1FaxNwx53qml7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihc5OHMvNTS5BbLA0auzCaJCg3jVtUqttWcHwsupR0g=;
 b=oj63BdYQo/25OAkVPTE78WjWmSBPfDVS2yVdxMiID/1LP3UgGz6mvNE2d0K2esK0NulGM89/rOpaTisljSL1u+A2d1oGdnm6HBsgnQMMkUuXuyRfPUyDtZY7KwFaz4xEbUmrL+V6W6Jh7D97UtFApbPGMUsEewjDXPa/wLqDkL3egn7GHQisn7qA/NVVgykJ7W6UxQx0xWS1N0SKNjbGD/NoUppzDdCh0fvbiYgbHyDbUd+uje1CSH5v3LVtm1Au4gmFDR+47cP0Ar52JVwvG+23I1st1Lp7BSI0jZ/TgUQolfPwfMF5XfYd/DDi+rCSknEv/6ak9Pyz4i/TNov/6Q==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by PH0PR08MB7082.namprd08.prod.outlook.com (2603:10b6:510:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 13:23:46 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%3]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 13:23:46 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: MMC card detection may trip watchdog if card powered off
Thread-Topic: MMC card detection may trip watchdog if card powered off
Thread-Index: Ads7Zw4syJtxBkzjQFCdin/8++ZdRQAnUT6AAATlKMA=
Date: Thu, 21 Nov 2024 13:23:46 +0000
Message-ID:
 <BN0PR08MB695151B49A2CBFF1D293775883222@BN0PR08MB6951.namprd08.prod.outlook.com>
References:
 <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|PH0PR08MB7082:EE_
x-ms-office365-filtering-correlation-id: 455fd97a-407c-44a0-b2bb-08dd0a2fba43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Lkp2gifuz1huJKtkkWsfgT9YXwnk9hXuVj2kvFkdXfpHjt6aLym+d+pN90t1?=
 =?us-ascii?Q?XcZUWhZITsBPq6xL08PLZ3hoAgeoajHNc8SV+qlEFOUEa3jzA6EdhGlhzRQl?=
 =?us-ascii?Q?OGmAYJAZ7Pf4h4U7rzPDqLvqrAfqNQ0DTdnkItI1k2P6WRHtQZTjp+vp/3vz?=
 =?us-ascii?Q?GBAomA7bI+lGu8cPLd4JK6/6qGcyWK7GVo2Yf7wpjN08aFUQUUSEph15p/B9?=
 =?us-ascii?Q?aaGZOs++QmwCCSt8dhwfz88dWR6VpaU6rJCe/YBD1MGPFF0Q8cUuKfyJeyAh?=
 =?us-ascii?Q?frfW69iupeXu0h+YL1+FenpIPfSzxz4qsS3/pTfgyH18WqhbJ3NPw5wKw2Of?=
 =?us-ascii?Q?wrgTdYcjavJ7CkAQIdTNxCeEvMCEUDo4f7th6iiqfo9tAxRFz5774j2ji6R1?=
 =?us-ascii?Q?cqTpLEUFjgEexAsA8hwW/E/60EyE7VRYVA3F9HJeY5zobOljThKfa7lPLOK3?=
 =?us-ascii?Q?UiitwksEqiMZiMheycYj1Gx55Q23OwHliEDo9Uwpa3WSCC9vkOjpw2eitinn?=
 =?us-ascii?Q?fD/N87ZdmBAv537zcmYUk16/afW2LSj9HJ0jLvoSEIP/ESp7paz9OMacCtid?=
 =?us-ascii?Q?6v9jFXLW6YhBPdg4P6Kk7+kGH9yqG4pc8x88ErQUOc+ADb8nLdrze6vRreyD?=
 =?us-ascii?Q?z+V3rvdUx5+7RwysZ+YXcob8xPsJD0s39T/yZvK/0Yb3dGuZme695AAPX718?=
 =?us-ascii?Q?mkkRKY0K9gNxcupElEk6nz6bI8B/m3HPfNUpfTpK3menvNzeQW1vt6mLUyNG?=
 =?us-ascii?Q?zNQc/PsKBqNs5Ft/QncYTQMRvpRXzZ1a8ydmoHOZn+1WkJRLJAgp+X+ZEgjn?=
 =?us-ascii?Q?/TnU9nJx6B6w7UAD1Y6kQt31Cne37Pn+1SsOq8RITjr9OcbdD/CjnvwzyuSk?=
 =?us-ascii?Q?EEtBiqiIyx41l1JhezzlPvs4EBbIY9qIlvx5PlXPN9hrKeI3+jShCdKBn6HO?=
 =?us-ascii?Q?VcH00vgeWji1n/OSqNssBvN4EOnyKBrmIskHyNz6IaNibCBUYJK20bW4xHDJ?=
 =?us-ascii?Q?3X6w8P4eCcJyeXLZ6ejOlvNCLmb+E5rWW3LSLhLCZfoZB1HgIFd32WB71QGU?=
 =?us-ascii?Q?2hoZ5gT+AHh8B+zWBGTcn8AQkhW6Bn6+b1wcWTqsiBZTnyv1k620BKfhGUoO?=
 =?us-ascii?Q?rNVc0CDTr4VQyd93moUB9L8Jw04/8qMQ/u5LZTajPqHBiGFqDgUy//ukUzlH?=
 =?us-ascii?Q?DQf6eI99Ti/gVn+J5GFQjr9UUTEhXB/zY0dh8FMw8fXHeryuZG9LC1R5jbSy?=
 =?us-ascii?Q?VNHjymLTAtpGZJjETNICzOAo88tbYeW9z1/bCaHyoLMiXWBvdvw3mvI+0uBF?=
 =?us-ascii?Q?CmwSS1wAxUPW3rVOMeVcgbw1z/0nwuzrkY17UiEDqFkKZ28w+pYDA9yqJd96?=
 =?us-ascii?Q?HtorL6c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?936WUB6sV+qDjkn8sBgEDd1OrCX6VTDYV6F5bATEr+bbtDm0iizNdWfSj/Bd?=
 =?us-ascii?Q?a13yhqqsE1+DRUZMoAQ72EXySNNXOhiVl/U5jLSZozap6vPA1RpHdf2WN4Sq?=
 =?us-ascii?Q?ORhxQyu7kj3gfo4EfliaCrpmVIgVHBjQnK0CsQ12IOyY0m4+oI+ZpotZgclx?=
 =?us-ascii?Q?2D30SvvEq+DLOhMzNNlVOB981tsa+C5EKL91kLsFLesVjnVyoF3w6VR5SHK9?=
 =?us-ascii?Q?eLD1d7b+O9USo9APD3j0RlPFDnxXvx2Pzo6hpzvMFioaWVOwnDkKyu0mlipg?=
 =?us-ascii?Q?Jc6jd4L9oe1wKahWPK3+Dn+LLzduOxUOTNj2XgD4GAT979VClM+p1a+7YiEN?=
 =?us-ascii?Q?UeG8OMCtXSYgiPRaBX2WiX+fgcKO0HR4HdwWfErbU0siaDnrPZtC5TZZlJGC?=
 =?us-ascii?Q?SEHQQ98ufo9wsZxcOl1OCBP+NEZwsDljoWpHpgz70pE9EaZsoIvhXE9twfVY?=
 =?us-ascii?Q?oZ39X0Nhkkkpj+I+QH7sjtEQWlPPh75sFtA8gm8J4guWOiUchklqqwdbQ3zj?=
 =?us-ascii?Q?kQJvmlShRU6Uh4qAl2g7nSGZ2CQE+svF/wyoW/PsMqH3s5P9HoCT/6e+qWoL?=
 =?us-ascii?Q?8QP/BVFK5LdpJQp5i1xWRZIs3pq6LjCL7h3cGopbA9l9SfkghxXERu2sVcJ2?=
 =?us-ascii?Q?gmDAi5joy0JZd7hYEBV8kSyS2Yn27oxqTu8CLz3eg8MH8Xhx9fIELVVweYau?=
 =?us-ascii?Q?mk+cEftbkglRlFKMo4piYv6tpgMtUmzDQ/jI0KtE9VDMpQ8ng9MHXqwmMNsp?=
 =?us-ascii?Q?tuGjghi2mp0BVEMO+qLALvHLGQ7F916bc36m1F62m1sMzz1gfeKUqy4XVbfW?=
 =?us-ascii?Q?dceQo8Z0IJo77kt2L4xZYvZB/1KeHx+VaxFbzDPvN5sa2uHvOgouznXAYXfa?=
 =?us-ascii?Q?UkwHvs+ELl+CuVEuisgBRZB0Zag5XWv/zpc1gLXsl5jQdEYaQOI4ltG6wqhl?=
 =?us-ascii?Q?cGe1i1lWOr6vwxcjPqSHNxlovdVDBG3OX6Nw89GF4KmJLqEtJUf11p3t+u7v?=
 =?us-ascii?Q?lMitU23OMdQM0ZkueZpbGFpUEiBcoWHN5FcLBpJuVkQ64JcLdpOCJAlm+CKS?=
 =?us-ascii?Q?WO6MasgyLDr/xF4duyCXnYHKQWJ8C/VNNYgLd5lOMTn5NNt3gsnKn8FVawG/?=
 =?us-ascii?Q?EfD3mzXsYq94ArnPQWz+NbF49FBS90Sk+K/vtmYHBLeHrx+ji7nVaQaKzFVJ?=
 =?us-ascii?Q?dDKrSUqTFQazSTUJnC/8ei+yeE/azVnhKtIIknC8IJFJNh9BSOxrAcHZdQ82?=
 =?us-ascii?Q?Q/nWYxdQKUHnq2VAM9d/eI+CA7EJsG2yBRIlXKv0q7FfJgBP8GDyVbIeKIQk?=
 =?us-ascii?Q?XQlQQ3lLFoYWW5tVvpj7J6bMzsWRLhBzarA8BMEtg9XAwq3fqjldEt3sSnE6?=
 =?us-ascii?Q?er1r7X3h4GS4qChvpm9o4yaWuAx0khfIaZwOoe19aAtMrremv8RMPzzM/v7c?=
 =?us-ascii?Q?KKifBUHXf0cE56zk9e+/wSuTKcQPw0zXw6QjW+C6vk0IqDkWZS6dP7DQyVKT?=
 =?us-ascii?Q?p+Y3k1HdzQxuNzVWYvxpgtbQnP80oqm6g9l7d7Cl1Jpenb2GrG9SsL6FrZbP?=
 =?us-ascii?Q?HXqWjcBEQAl9omnAOxn6JbrEK+FNr/3QcdU97OR1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455fd97a-407c-44a0-b2bb-08dd0a2fba43
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 13:23:46.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bi5Lwm0ThuswpNbhwJuWNafWDH62byIYjXTyOuRwH8TDnupDYL61LOyVCgBO7JBdYtr4RTB8wEbsN3FFj/Y8jAI3pTY1gf+RP/jN347ImGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7082

> >
> > If card detection is done via polling, due to broken-cd (Freescale LX21=
60,
> etc.), or for other reasons, then the card will be polled asynchronously =
and
> periodically.
> >
> > If that polling happens after the card has been put in powered off stat=
e (i.e.
> during system shutdown/reboot), then the polling times out. That timeout =
is
> of a long duration (10s). And it is repeated multiple times (x3). And tha=
t is all
> done after the watchdogd has been disabled, meaning that system watchdogs
> are not being kicked.
> >
> > If the MMC polling exceeds the watchdog trip time, then the system will=
 be
> ungraciously reset. Or in the case of a pretimeout capable watchdog, the
> pretimeout will trip unnecessarily.
> >
> >     [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> 03220301 flags 0000049d
> >     [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000001
> >     [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000002
> >     [   46.891906] mmc_request_done:187: mmc1: req done (CMD6): 0:
> 00000800 00000000 00000000 00000000
> >     [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2
> powermode 0 cs 0 Vdd 0 width 1 timing 0
> >     [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> 00010000 flags 00000195
> >     [   57.433351] mmc1: Timeout waiting for hardware cmd interrupt.
>=20
> Hmm. How is the polling being done? By using MMC_CAP_NEEDS_POLL?
>=20

Correct. (At least in my understanding.) 'broken-cd' in the device tree wil=
l trigger
MMC_CAP_NEEDS_POLL to be set.

> The above certainly looks weird. The mmc_rescan work should not be
> allowed to run at this point, as the work is getting punted to the
> system_freezable_wq via mmc_schedule_delayed_work().
>=20

This is the backtrace I get when the timeout occurs:

[   46.154348] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flag=
s 00000195
[   46.161917] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
[   46.167743] mmc_request_done:187: mmc1: req done (CMD13): 0: 00000900 00=
000000 00000000 00000000
[   46.176526] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03220301 flags=
 0000049d
[   46.184016] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
[   46.189840] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
[   46.195665] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800 000=
00000 00000000 00000000
[   46.204362] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0 cs 0 =
Vdd 0 width 1 timing 0
[   46.219307] CPU: 6 PID: 153 Comm: kworker/6:1 Tainted: G           O    =
   6.6.59 #1
[   46.231988] Hardware name: [Redacted]
[   46.238678] Workqueue: events_freezable mmc_rescan
[   46.243466] Call trace:
[   46.245901]  dump_backtrace+0x9c/0x128
[   46.249643]  show_stack+0x20/0x38
[   46.252948]  dump_stack_lvl+0x48/0x60
[   46.256603]  dump_stack+0x18/0x28
[   46.259909]  mmc_alive+0x74/0x88
[   46.263128]  _mmc_detect_card_removed+0x3c/0x158
[   46.267735]  mmc_detect+0x30/0x98
[   46.271040]  mmc_rescan+0x94/0x238
[   46.274432]  process_one_work+0x178/0x3d8
[   46.278432]  worker_thread+0x2bc/0x3e0
[   46.282171]  kthread+0xf8/0x110
[   46.285303]  ret_from_fork+0x10/0x20
[   46.288878] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flag=
s 00000195
[   56.793379] mmc1: Timeout waiting for hardware cmd interrupt.
[   56.799116] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   56.805545] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
...

> >     ...
> >     [   71.031911] [Redacted] 2030000.i2c:[Redacted]@41:watchdog:
> Watchdog interrupt received!
> >     [   71.039737] Kernel panic - not syncing: watchdog pretimeout even=
t
> >     [   71.045820] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O
> 6.6.59 #1
> >     [   71.053207] Hardware name: [Redacted]
> >     [   71.059897] Call trace:
> >     [   71.062332]  dump_backtrace+0x9c/0x128
> >     ...
> >
> > CMD6 is SWITCH_FUNC and arg 03220301 is POWER_OFF_NOTIFICATION
> (bits 16:23 =3D 0x22 =3D 34).
> > CMD13 is SEND_STATUS, and when it occurs after the
> POWER_OFF_NOTIFICATION (as above) bad things happen.
> >
> > I have made the following change to attempt to work around the issue, a=
nd
> it seems to hold up, but is also quite brute force:
> >
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -2046,6 +2046,11 @@ static void mmc_remove(struct mmc_host *host)
> >   */
> >  static int mmc_alive(struct mmc_host *host)  {
> > +       if (host->card && mmc_card_suspended(host->card)) {
> > +               pr_err("%s: Skip card detection: Card suspended\n",
> > +                      mmc_hostname(host));
> > +               return -ENOMEDIUM;
> > +       }
> >         return mmc_send_status(host->card, NULL);  }
>=20
> Yeah, the above isn't really the correct solution in my opinion.
>=20
> We need to prevent the mmc_rescan work from running, which I thought we
> already did...
>=20
> >
> > Anthony
> >
> >
>=20
> Kind regards
> Uffe
