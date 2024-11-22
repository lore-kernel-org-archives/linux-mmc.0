Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173113B58C
	for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297671; cv=fail; b=p0VEoX0Xl5BtDTUGIg1GB2MdQhCBD4x5T4fKg/0qgBMXimgBNN5fPdCF32CNC6vT7hdhYsXKuDJia67RyAByrck+tBqc6FJhLB7NnbVPjL0NNyOiXUpVhrwkrMgVCGmD6c7Mvi2maxaoVY75VyDm7rqxyk/miS9cxFzmC71gs5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297671; c=relaxed/simple;
	bh=49BmNLMoUERL9w3FckgkEBvZ4+f9QOczd/dP00YOCB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUELe0BuDKexzvXT4x+9dDXrSjtNOogrDKCA7UmL0nb4f/NcGtnHapYPQERsjSWXr6THucVIjrwtcu6avka3T6E8FbtHmALsSjDoHvwtUduMopBn7Gf+ojxFn6Or2ZzSKP8OFAAAmet2Z+tBFjwaq9p31ecJyJoql6PpGrwVfn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=hIauWjQf; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="hIauWjQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQONPN1PdTjM7VDlcU7Q1ypVvxYq39WBh92Pnk16hMKqAq0TzpnUGssvhuppphFz5/EtP3uVfk7FgyaBNa+aj4Ra3eDboEwvntz9VJeWCZtVmgVErA2NxJ76+HIPDLv2neKh+/oQ2QjcEPR4KGTjXdQ6Mfh3/XtlOGa8iQge8LAHh1orGnJcgr+Zy/qn2WY38Q0UnZEQ5GQmfMY9qvnB8MrhhOYGcMAMSGP5m/Nu3eH2/XwnMAYHfB2G2bVYwDNVJ095K5QIWER5q1ztpKeLyb5ex2QYuDNsyVlYP0UVoZvYbqruddp9jFuj5xdfpMTrfJscqD3Dqt2IT8o+alGpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnvAiP1Xa4h/XBQS/W7XxVTQnaBheYlBL7bBL4lP6Rk=;
 b=n+yXs1V20Ljq8Lvz2UznNfxodwPtANgRZUaoIA+OSbUB2KNqdphmM9EOjmqHkYjkXPJoRfzoeJWg+Q7Q+sE7uL6dwe869Dtlp0aYJqCUznKRyHVlzpYNbuaQujmKo/XogFkEPVoL7oqFh7ndJVdBRq02rgdVVJzp/3CEHrZqlWeiUjnWRigakq0MPb6HopwEflXU9aF0SPttOmAJ6QRo7erFtl7fLLoLjqzmdJpL7+SHceC52YD+OTn1ZGHYnjKoKPPiodZfykXIoRie6tKE2IhqtfmzPwowi+yAKej5R4d283n40/eMsO5CepqHnKuvpkt6CfZErluvt+Wk4ggmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnvAiP1Xa4h/XBQS/W7XxVTQnaBheYlBL7bBL4lP6Rk=;
 b=hIauWjQfPa/RhfKQ3i6LV3o7L7vcpw50WOuRUMalT4jbUWOFBwzLOUr0jIaXKP5YoFXXsg7fIhmoxKRdc3R9j5dT9FH5pm5YXTiwYMdDT0BhMeUIIokc+NX8HJb7z0vQ3Mc1tiMFjUPZRycxeBSNa74/OmaNhQ5PfdQYBLoHIB4nyUy9k8tdZOwvzWQIQIk+vz9aktYz60tMiBLOHIGaRp+24UAZTJ6G4GRXTlSGa3p7qcuhW5TsS/rVa5SaO2ETE91z9bJVEERKkj51Ha9i6B3PEsml1L3Re+aGiEFKqar8uN5B2Wd8WcAEaKOs3IXhxJAsXfkExYFC0qEs144Ddg==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by BL3PR08MB7515.namprd08.prod.outlook.com (2603:10b6:208:346::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 17:47:44 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%3]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 17:47:42 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: MMC card detection may trip watchdog if card powered off
Thread-Topic: MMC card detection may trip watchdog if card powered off
Thread-Index: Ads7Zw4syJtxBkzjQFCdin/8++ZdRQAnUT6AAATlKMAAN9t7gAADregw
Date: Fri, 22 Nov 2024 17:47:42 +0000
Message-ID:
 <BN0PR08MB69513344FCF13A3CD7780B1283232@BN0PR08MB6951.namprd08.prod.outlook.com>
References:
 <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com>
 <BN0PR08MB695151B49A2CBFF1D293775883222@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFo6BnHRg6G9vj6xiUncowUi59ExE3sCVLk8K+=6wqd1xQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFo6BnHRg6G9vj6xiUncowUi59ExE3sCVLk8K+=6wqd1xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|BL3PR08MB7515:EE_
x-ms-office365-filtering-correlation-id: fb835067-599d-473a-58f2-08dd0b1dc427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dS5ICzMSMLIWBnBYE8jhpniOo6M093ggRPqMmao13zDxo5lX9nSJYlo6M7NY?=
 =?us-ascii?Q?XyvovFjfUsHlgsOiSYpXNHyUXrggSbn4RAXLVnXQOCO/i5i8vb638FRE6rA2?=
 =?us-ascii?Q?uub+eZL6JJyQYfu/vmF36YyC2EJnhVT1xicsv5NUq/7Z2d6OKDmB1ECZ0+Y3?=
 =?us-ascii?Q?Pf+ayl/WOzgyEUACwnOXJx8EXGdcYSCoAizTpkhgizqmnHMRLw5ncB4mDlQk?=
 =?us-ascii?Q?Rw0RP2rn4BG3KdSxcCXVjr3c7/zHqRDtU6b0nyINnTbHfB+OUIGwDZ+AOgOR?=
 =?us-ascii?Q?t/y11+QSjNXWg9zv25Kt87ph6bgLns4AFnTh2P7QZTPCaPA/XI8KiBL03iIF?=
 =?us-ascii?Q?7Wgaa6geggsIHKO+/laDqcCfyI3U16FRgmgRebBMkLg9seUsIIthVozDI2RU?=
 =?us-ascii?Q?oa+ne6Yd1j9Wo1c2PyQN6IbXlGppY6YbvJwChdCsPCzHqzFKuLT7JpcOZrrD?=
 =?us-ascii?Q?UnW1Jqs3dR1oprw8DHlVyShnWDdhKn0StiW3s0KnTVPaOHx7IRw96uhXVSRL?=
 =?us-ascii?Q?sj6fqUlU15Qmh8CZrkqgRlnTQws62rEnQquyd0ekEudeivigKMbI77wdxzME?=
 =?us-ascii?Q?5ZubMxGOioZgBkORXamU6shj6HOu3KX68GlwQoOv8EqTDvGJtJIl1JXm6RVG?=
 =?us-ascii?Q?8sJJ0b9Qq0v9i78bzKwVgUlY35IuHZvibzXgLpoSHkDIiXOdv+z1nh6Ggm+i?=
 =?us-ascii?Q?nZ21WeAjhlRUY6tWW1PrKIMN4OW+m0GMnMPgVcL/n/WovFaPQgXaAVRfOxl2?=
 =?us-ascii?Q?1IL6SI2jgioXsD1WyIHDqt+Z+ZErKdRkPZfzpRJ7kJDrXK1+fnEmE472hJVj?=
 =?us-ascii?Q?XBbKT4Vz+cePBvAb+iM+kzPNhWGnLWaf4GhrQargN0G/hqKgO6hw+C2TyHjl?=
 =?us-ascii?Q?vbC24kdipcG2cnvn7APa4PP47SNIjt5F1I6SMI8cjXDcYhuj0nS5/a4ij1T8?=
 =?us-ascii?Q?iwfjqBh2ILF8TdmHSifo1yjd7w3f46SN20IUrY52KMC8owp+IU64MJkaMd/f?=
 =?us-ascii?Q?hIaJytYUVNBqwL4XUcO4xjl+qMiGZtio7dm5t2DdylcGyIxumdu9RlhGDTCv?=
 =?us-ascii?Q?8SUPIuM/Qy2FyhsBUrCG+Svn54t0H+KkDby0mhHZoOA39TDf4IG09ZKu0wrn?=
 =?us-ascii?Q?aaa0+/oH5tZTQuWj3CYgYOmV+EMzhD2e96upHFEyEm5GPQHrqtREoFuRM1ny?=
 =?us-ascii?Q?Jvd053khWkzZpg5ASDeH9SpgOLBgr5OKlrjfxOpEuCz1D35duDKCCJ5S3IhA?=
 =?us-ascii?Q?ok0WKuwo6ffqeWAmp2ZvRv4EICAiWNy2b9TraY+TE/gt+ELLE6T64FLv5QI6?=
 =?us-ascii?Q?Z7K9PwPMsTW39U84nC3IOrrcErR5A2Ekl2kqnJG5KcscottK177zkDaNj7Em?=
 =?us-ascii?Q?5W1BNmk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XyAQpInjunLH5Pqay47UtzYLxqfK8YVhzKp5Ni+d3KzX0uZsGKNMgo8MQ8/h?=
 =?us-ascii?Q?cBZeUCqAYbfZLQvdwZ4dU+oijlgc2DUwGwmVgaHgNC9OvO8Fuyxjr8FwykfH?=
 =?us-ascii?Q?h4un928tZ6ge8qayYEqyQAfbE3YfOZCJ6HJknyausB9SqNa6IrUSKdyd/w1N?=
 =?us-ascii?Q?WSyxANeRm8KSpm8lwaelgMBNkfx+5Kn77A696I7SF8/xckKKJCmCKgln3Fq9?=
 =?us-ascii?Q?qVbobMnb1O/JpACqidzpuhi3sqIAY5y1jxhcqPeMhP2Ojta2LhueccmxqJB/?=
 =?us-ascii?Q?iZMblNOxY0QrwORuHDY1XVhakH23w/B/+6wB9vSr/WCx57DmSBXEhMG6r1+M?=
 =?us-ascii?Q?v+On0fcakJo7jdT5Xv+aGoaw0Jql3+zB6wDGIDO8kKTDk5wAB6ohvJ7heQzZ?=
 =?us-ascii?Q?xj9+p9xULIRw6sgX02aMWqqyREc8hJJYQEpEihM0cgYUWX0MdaHGN7thUOiY?=
 =?us-ascii?Q?//lCYFJCy9WBaDqjjgWn89ABVwYOR6Itu/SWMKEAa1tqyHX7g8fBneVO8fa1?=
 =?us-ascii?Q?C2Iz/B/XaMgxo40Tx3xsT9PlXdyg8lex1Snb73XKj6oouW4qEiZSuDbWs384?=
 =?us-ascii?Q?2vltouYTksCZcwE+6QRyA0vESgwcgpLdG52E3NuSEAu9gfHvo1Q+1FkjzuL1?=
 =?us-ascii?Q?nZqKy/zyOcxhvcLKacdqY25A9+Ih/Z5ueUeeNIo32EmqPBMxp7NDwK6X+g2A?=
 =?us-ascii?Q?z42sP1bpgdTGKQJJw8p/uBGUHa0MjPj5D7/9hYVADDD37+PGCt6MLL0QDquX?=
 =?us-ascii?Q?E0p5tGqIdE9ejVtGSr66FU5/XR232A7kb+N7gMdeTtGUfNe2eC1aQVIlq/HL?=
 =?us-ascii?Q?003/6N6+3pXx9en9iETKXBzH0oGMQ21R+eaC32MvocrwzZj253h1n6I6ZlVD?=
 =?us-ascii?Q?CgpZUTYBEX1khtXeZlI69drWrksDL/ZKuhr5XqUjTd7WzG2NqNkiefWiTtoK?=
 =?us-ascii?Q?2Uoy59nwb6FmuqqypZaEd9lKuZbH6lsHJVNMCLtkka0NqyOz7ZnFNl454RD5?=
 =?us-ascii?Q?5K+8C9DfCPKvFVoMHKd63nPA/2jPn2Gydpl5pCGfUrk4sAL4pt/jjNjSUir4?=
 =?us-ascii?Q?zaqruMs5Qzt+JsrAs4BTsJOViyH8Jvy1JyJq8mwg6pNtQQ7EpCLcPJF5gFda?=
 =?us-ascii?Q?ZwD11AJUnJKnUtpv/5fR3PBx3TETmzisrNeXZyQHOTO2BxAfy51xaSh9LQZp?=
 =?us-ascii?Q?94UJz/UM+iKzGu1LywvdYn0sp4tBH1Fld264HA0d+drmEpUrP0y4IgORrXBc?=
 =?us-ascii?Q?1mvY52fmhcIYeu1exKEIZZ+YMchqn9e5x3YcpV34knhnvInfbPM6XLNKpNWq?=
 =?us-ascii?Q?mzRb3Gup5/0EiXj07wFSVeE+nog0VuGdYf3xfjzZe1euv0UFJ2tR2B93UPeA?=
 =?us-ascii?Q?cxVW6DHjaCT8A9YTwBfSIZVPZmWG55bXmXlhrVnBSQtiJRX2iL7RsivY4Y1+?=
 =?us-ascii?Q?LkueumG2TIy66XpbLMW2wk1GHNMS8OJxnnUs9hozU4z9Slgo345joz6YpQ/F?=
 =?us-ascii?Q?Bmvrro6g2mcbeSS127Bx9glNthKO354uRGj71bBn31NKBKqqDqfdiRmRSelH?=
 =?us-ascii?Q?dBGHCfRMhRXFoqy67Gsr74/0vb0E92qhBFJJlsoD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb835067-599d-473a-58f2-08dd0b1dc427
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 17:47:42.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLTunGQygQohk8JPzuoOgux9LR6iXPkDb3EtOAEBPIMfxDiNXeGqfUKWb4jorDf49xHRrJNjHYd8T1kMo5pgqSaBcXT2z8bE4x5HV3c/T9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7515

> > > >
> > > > If card detection is done via polling, due to broken-cd (Freescale
> > > > LX2160,
> > > etc.), or for other reasons, then the card will be polled
> > > asynchronously and periodically.
> > > >
> > > > If that polling happens after the card has been put in powered off =
state
> (i.e.
> > > during system shutdown/reboot), then the polling times out. That
> > > timeout is of a long duration (10s). And it is repeated multiple
> > > times (x3). And that is all done after the watchdogd has been
> > > disabled, meaning that system watchdogs are not being kicked.
> > > >
> > > > If the MMC polling exceeds the watchdog trip time, then the system
> > > > will be
> > > ungraciously reset. Or in the case of a pretimeout capable watchdog,
> > > the pretimeout will trip unnecessarily.
> > > >
> > > >     [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> > > 03220301 flags 0000049d
> > > >     [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x000000=
01
> > > >     [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x000000=
02
> > > >     [   46.891906] mmc_request_done:187: mmc1: req done (CMD6): 0:
> > > 00000800 00000000 00000000 00000000
> > > >     [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2
> > > powermode 0 cs 0 Vdd 0 width 1 timing 0
> > > >     [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > > 00010000 flags 00000195
> > > >     [   57.433351] mmc1: Timeout waiting for hardware cmd interrupt=
.
> > >
> > > Hmm. How is the polling being done? By using MMC_CAP_NEEDS_POLL?
> > >
> >
> > Correct. (At least in my understanding.) 'broken-cd' in the device
> > tree will trigger MMC_CAP_NEEDS_POLL to be set.
> >
> > > The above certainly looks weird. The mmc_rescan work should not be
> > > allowed to run at this point, as the work is getting punted to the
> > > system_freezable_wq via mmc_schedule_delayed_work().
> > >
> >
> > This is the backtrace I get when the timeout occurs:
> >
> > [   46.154348] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> 00010000 flags 00000195
> > [   46.161917] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > [   46.167743] mmc_request_done:187: mmc1: req done (CMD13): 0:
> 00000900 00000000 00000000 00000000
> > [   46.176526] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> 03220301 flags 0000049d
> > [   46.184016] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > [   46.189840] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
> > [   46.195665] mmc_request_done:187: mmc1: req done (CMD6): 0:
> 00000800 00000000 00000000 00000000
> > [   46.204362] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0
> cs 0 Vdd 0 width 1 timing 0
> > [   46.219307] CPU: 6 PID: 153 Comm: kworker/6:1 Tainted: G           O
> 6.6.59 #1
> > [   46.231988] Hardware name: [Redacted]
> > [   46.238678] Workqueue: events_freezable mmc_rescan
> > [   46.243466] Call trace:
> > [   46.245901]  dump_backtrace+0x9c/0x128
> > [   46.249643]  show_stack+0x20/0x38
> > [   46.252948]  dump_stack_lvl+0x48/0x60
> > [   46.256603]  dump_stack+0x18/0x28
> > [   46.259909]  mmc_alive+0x74/0x88
> > [   46.263128]  _mmc_detect_card_removed+0x3c/0x158
> > [   46.267735]  mmc_detect+0x30/0x98
> > [   46.271040]  mmc_rescan+0x94/0x238
> > [   46.274432]  process_one_work+0x178/0x3d8
> > [   46.278432]  worker_thread+0x2bc/0x3e0
> > [   46.282171]  kthread+0xf8/0x110
> > [   46.285303]  ret_from_fork+0x10/0x20
> > [   46.288878] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> 00010000 flags 00000195
> > [   56.793379] mmc1: Timeout waiting for hardware cmd interrupt.
> > [   56.799116] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   56.805545] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x0000220=
2
> > ...
> >
>=20
> Okay. If this is system suspend, it looks like the workqueue didn't becom=
e
> frozen as exepcted. I don't know why, but this needs to be investigated.
>=20
> If this is a shutdown, mmc_host_classdev_shutdown() should be called to
> "disable" the mmc_rescan work from running the code causing the above.
>=20
> What am I missing?
>=20
> Kind regards
> Uffe
>=20

This occurs in response to a 'reboot' command.

Here is an instance of the failure, with initcall_debug set to 'Y':

Rebooting...=20
[   44.500858] caam_jr 8030000.jr: shutdown
[   44.504805] caam_jr 8020000.jr: shutdown
[   44.508748] caam_jr 8010000.jr: shutdown
[   44.515349] tpm tpm0: shutdown_pre
[   44.523165] igb 0000:01:00.0: shutdown
[   44.558695] usb usb2-port1: shutdown
[   44.562268] usb usb1-port1: shutdown
[   44.565864] xhci-hcd xhci-hcd.0.auto: shutdown
[   44.570306] dwc3 3100000.usb: shutdown
[   44.574052] [Redacted] 2030000.i2c:cpld@41:watchdog: shutdown
[   44.580137] tpm_tis_spi spi2.0: shutdown
[   44.584054] spi-nor spi0.1: shutdown
[   44.588066] spi-nor spi0.0: shutdown
[   44.592112] mmcblk mmc0:0001: shutdown
[   44.595902] mmc_mrq_pr_debug:274: mmc0: starting CMD7 arg 00000000 flags=
 00000000
[   44.603413] sdhci_irq:3546: mmc0: sdhci: IRQ status 0x00000001
[   44.609240] mmc_request_done:187: mmc0: req done (CMD7): 0: 00000000 000=
00000 00000000 00000000
[   44.617939] mmc_set_ios:892: mmc0: clock 0Hz busmode 2 powermode 0 cs 0 =
Vdd 0 width 1 timing 0
[   44.627877] mmcblk mmc1:0001: shutdown
[   44.631709] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03200101 flags=
 00000095
[   44.639200] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
[   44.645027] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800 000=
00000 00000000 00000000
[   44.653727] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flag=
s 00000195
[   44.661296] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
[   44.667123] mmc_request_done:187: mmc1: req done (CMD13): 0: 00000900 00=
000000 00000000 00000000
[   44.675907] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03220301 flags=
 0000049d
[   44.683399] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
[   44.689223] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
[   44.695047] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800 000=
00000 00000000 00000000
[   44.703746] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0 cs 0 =
Vdd 0 width 1 timing 0
[   44.713667] aer 0000:00:00.0:pcie002: shutdown
[   44.713673] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flag=
s 00000195
[   44.718102] pcie_pme 0000:00:00.0:pcie001: shutdown
[   44.730534] pcieport 0000:00:00.0: shutdown
[   44.734898] fsl_mc_dprc dprc.1: shutdown
[   44.740863] fsl_mc_dprc dprc.1: DPRC device shutdown
[   44.745830] mmc_host mmc1: shutdown_pre
[   54.873286] mmc1: Timeout waiting for hardware cmd interrupt.
[   54.879023] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   54.885453] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002202

The trigger CMD13 is in-flight at time 44.713673.
The mmc_host mmc1: shutdown_pre is at time 44.745830.

> > > >     ...
> > > >     [   71.031911] [Redacted] 2030000.i2c:[Redacted]@41:watchdog:
> > > Watchdog interrupt received!
> > > >     [   71.039737] Kernel panic - not syncing: watchdog pretimeout =
event
> > > >     [   71.045820] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        =
   O
> > > 6.6.59 #1
> > > >     [   71.053207] Hardware name: [Redacted]
> > > >     [   71.059897] Call trace:
> > > >     [   71.062332]  dump_backtrace+0x9c/0x128
> > > >     ...
> > > >
> > > > CMD6 is SWITCH_FUNC and arg 03220301 is
> POWER_OFF_NOTIFICATION
> > > (bits 16:23 =3D 0x22 =3D 34).
> > > > CMD13 is SEND_STATUS, and when it occurs after the
> > > POWER_OFF_NOTIFICATION (as above) bad things happen.
> > > >
> > > > I have made the following change to attempt to work around the
> > > > issue, and
> > > it seems to hold up, but is also quite brute force:
> > > >
> > > > --- a/drivers/mmc/core/mmc.c
> > > > +++ b/drivers/mmc/core/mmc.c
> > > > @@ -2046,6 +2046,11 @@ static void mmc_remove(struct mmc_host
> *host)
> > > >   */
> > > >  static int mmc_alive(struct mmc_host *host)  {
> > > > +       if (host->card && mmc_card_suspended(host->card)) {
> > > > +               pr_err("%s: Skip card detection: Card suspended\n",
> > > > +                      mmc_hostname(host));
> > > > +               return -ENOMEDIUM;
> > > > +       }
> > > >         return mmc_send_status(host->card, NULL);  }
> > >
> > > Yeah, the above isn't really the correct solution in my opinion.
> > >
> > > We need to prevent the mmc_rescan work from running, which I thought
> > > we already did...
> > >
> > > >
> > > > Anthony
> > > >
> > > >
> > >
> > > Kind regards
> > > Uffe
