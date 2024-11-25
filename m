Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC59EED6
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558031; cv=fail; b=FXzXXUXRo2TB2Tpq16CYiWycsw03W7MaV/9rFDOm38eAhGNAv4ajDNCQoDUdTb/gyt7DvHrU7yUFMB58NWdAtvnd+aDhiw8pt0WmX4oMEZn3rtQfJcxX/cV+/7bRATHKrYaegKAVgEplJXLWyz1Jy9YyEKWJ5zupEYv7cSwPfYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558031; c=relaxed/simple;
	bh=svk4LajtJwK0JT0qc2UhePagR5fIjMgAdP14ajybNeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmzHvvhTBwV0ms67AKRrag76LlRF9HgpuQLvJRoNQYdc88h/AM9mHo3Fhvb07asC8ZX5SR64jF7GP37J3G7C84bB5YT2qGCqfmO2E9gb0mbap9Sl1bJqROcKgaZpKTofay7HBAeoAhPWkrKU8QC+A3o1XxBcFIhV3Dysu4VLjNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=STlTf5gS; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="STlTf5gS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNUqm9sg+FGcCHtv9fR3UoBzYUn9aejm98D3r6xLzEAFCJ/7XykgIRkya9oaKVkZyoWlSe8Y5u8Xj+T0Z+OTKczUs77WBwcOKFzvhfR+WAiIBpNBJoQFh4qsfHT5dhX+bp7DGyrZrNR4fBd6E3mzlyeiDj1yZfkpIj2uAzEe2+5qvt3WFMW+4IV9uNijWq4Fwi1VOpZXrVkDIC2a0/8j2sTYnYwGIbGN2pAenosVXwdUHSVgg7B6GJCPWM/ZiwEy8JMNwp1i1uCPVwv+WprNGMfCFpgigCpycDPwXSvdIgeOYTdjpQn19WCiS3OcOOT3Cxm+NnNKfT+alKFM8qEJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx04ZEbZ8qZulRmdFyh5TLnFyg5QjORjRgHjF7l7qxc=;
 b=CgnoUqIu8/cDw07Mn2eOtuKU1nScfsVjpQial25FingWtxQ5l6qCwp4PYdlGAzBM2gq2G4yj906XeKWAhMtuS6CBplHsglATuLG1B9iKtqTQsAnz/RcmTsRGoWbex0/ew3YhUhzUzsik5rwOQrBe6wA6kWCKCGVfqYfdfPBED6MsMXYvMrYcYuQIfDobW9mLqyn751/44qNWdi11V9xXMwmRn8Lw5VLZi1mqg8WUg0oV4I68tucMpLRkxRqQMS/0NnPiSFQhlVy9hJvqli/257ImOQaqOGqol3Li/z84u8QCWmUaJIsPFiaDk4a0myygfFTl0ckG2Cpj5WBdlFOsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx04ZEbZ8qZulRmdFyh5TLnFyg5QjORjRgHjF7l7qxc=;
 b=STlTf5gS5aWBc07HyyJmwDyJg0lzilhE3G5hY4r52K00t7cXX78DJ/wJoO5Ki6HF6eMb0Mj7/muYvqtBbODy93zW+Cfw7V4jbL7AagFJ64dXVX50Q9bskT91i67gTkrFigKRHmtOh12rcjKgzqRsRZN9sReILgssRSspGner38dLubFoMDfMQutUvuNhlnpiT2dxcCKeAyhv7I4JNUA+YQ8/gWJFc6vL7NjsNzG9YSscRhVRAjnk5xG5pRyt2IUKH7uNqGuA2syuYd/itXWCu9NrQldkhoENB/sTuLectpeFTeFbRO2a46pzzioPiQ17nKx3To/6SzsVXhkqHKX3DA==
Received: from CH0PR08MB6954.namprd08.prod.outlook.com (2603:10b6:610:de::17)
 by DM4PR08MB8698.namprd08.prod.outlook.com (2603:10b6:8:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 18:07:05 +0000
Received: from CH0PR08MB6954.namprd08.prod.outlook.com
 ([fe80::5cd:ff94:d83c:4c5a]) by CH0PR08MB6954.namprd08.prod.outlook.com
 ([fe80::5cd:ff94:d83c:4c5a%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 18:07:03 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: MMC card detection may trip watchdog if card powered off
Thread-Topic: MMC card detection may trip watchdog if card powered off
Thread-Index:
 Ads7Zw4syJtxBkzjQFCdin/8++ZdRQAnUT6AAATlKMAAN9t7gAADregwAIvrHAAAC7r7wA==
Date: Mon, 25 Nov 2024 18:07:03 +0000
Message-ID:
 <CH0PR08MB6954D95FAD364D214693D56C832E2@CH0PR08MB6954.namprd08.prod.outlook.com>
References:
 <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com>
 <BN0PR08MB695151B49A2CBFF1D293775883222@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFo6BnHRg6G9vj6xiUncowUi59ExE3sCVLk8K+=6wqd1xQ@mail.gmail.com>
 <BN0PR08MB69513344FCF13A3CD7780B1283232@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFrqQUSiZRx0Hr6ZcmrFq4-CRcCHqE+k+YKjdQfu1xfGWQ@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrqQUSiZRx0Hr6ZcmrFq4-CRcCHqE+k+YKjdQfu1xfGWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR08MB6954:EE_|DM4PR08MB8698:EE_
x-ms-office365-filtering-correlation-id: 6946b073-65cb-43ad-6c00-08dd0d7bf74c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?agxlQ5MM1faBYtolN8dhtH36AyiKxjfd071luBl0Btm9f77XUCf/i2j5g+oT?=
 =?us-ascii?Q?Offgq/fUhueIyXAktP+ioplmU2Ch1Ut8+SJBqc13c33mC9IvOY4w2kclvWFa?=
 =?us-ascii?Q?hcKxGTwPttSe0OK5HhteXQid4fr3pu45/XakxB3abMtsTG2yQgaa0lwU72W6?=
 =?us-ascii?Q?+B2dlvQkWvpOTA/SrcdA23YO2gA1ANzoFRObTRkOUDJwje3CZpwRux3Hpif+?=
 =?us-ascii?Q?wTQfwvvliiNd9PcImX/gwoUC2/eqbMhXslkkCB7oVYWpmm14oJH+uScNUexI?=
 =?us-ascii?Q?6bKGQJcD5ibqb7zaHLJZE2j4rZMANILW3VAFAWZxPVlmXVwQuKgX25MLBvJQ?=
 =?us-ascii?Q?H93nyPuLD43LLc7a9AJZOO0tfNfMfWOA+4BlFR7gDWpAZ7yhwMfS0vZnIxcp?=
 =?us-ascii?Q?AUcUWN7ECu9XGKTttQxnc2uDU11JTNBMHPFfab6QYqHX8B/w9DionxGZ4r4f?=
 =?us-ascii?Q?xNIQwFHlizZChiIgqCtytDq82PIjob3Vy0Yqh2HDHXzdVo6QWIb6HbkwCD4M?=
 =?us-ascii?Q?X4W+RLP4tAHeWFgsx4WYU8QvQKEDV5H0pjRfF30BBF4nYiVIW7V67Iyv6Kxw?=
 =?us-ascii?Q?RxGNReAKXV8VNB9Q97JcKFzwZgOwIkbvttRuRioB+G5ko7Ohb32InIXzqYzd?=
 =?us-ascii?Q?k6hgDj4DGUVUZbqGoOgWsZJgQTfPn8mU9Ldhtj5ZmqEMsTed36yuJkyc4GIR?=
 =?us-ascii?Q?LSXR+/uB5zvzs9Ufa/nuchs9XQzkB6BLELRObC8hncnsfgw3OQEO9NpHXGjp?=
 =?us-ascii?Q?6IatOvyRHT1RkZ3sMGJEQKJv1HX3ZtIVZEqSqpHYb83jQ2OC/PDNFtbj+ahs?=
 =?us-ascii?Q?bwbAc0cE/LjNAW7nLkUC7zzVgo3JvQfVdwYHN2kPWQ0pOOopDrws3UIEe4SE?=
 =?us-ascii?Q?jbewSPKjuYwYl4SBtNMdUYAq3xqXIUxz66VgHHzV6VUVCidSonYkqebOrtd8?=
 =?us-ascii?Q?RyloJQn73MK1Q8vr6n1/yO0Ul9mDtJquKgJRvfB+MgiGyt5uJ5SgRyGx4eTb?=
 =?us-ascii?Q?RPfkqL9iTfvRKtAZrC+1EpCWKpdyoenI4ut14SVZgV13ZE7DmE3wPAndtCuq?=
 =?us-ascii?Q?XgmkZIAF7ImaQJ7uPvx8C3/05ApP9P2xHSHdkOv0gxs8yk99IycaT62NKdSH?=
 =?us-ascii?Q?yXaDqIkIeixANwZbnVu2RsbzylZTbKhJ7s3H1xMU/1Dm4HOuOtJoF2uw6ECZ?=
 =?us-ascii?Q?lWMvExNsVMGVpxQNDv7JDqwpBSQDKseFQALl5QMSruV1cR/vWd4DiKKIO1uT?=
 =?us-ascii?Q?u/UfYp6K8uqDS0JFkratzzbVGQWCzzC0N/54lgDjgOinj0C5j8Y1AX6qyQq/?=
 =?us-ascii?Q?/hrsUSt7JSbinrKRToXcL1tPjuzcTYMTGK2HrEuhywZlYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR08MB6954.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AgCbFTc8+kv8rIKt55j+lQAFqJBlQk+3uhVQPynkQWsRqtS5bl/m/4/UdTUH?=
 =?us-ascii?Q?x8aAbaOdvQk4QKVNK/TG5dfIIpbNuGX0cATcxY8eTv8G2ksxq1gD9B8LvHKf?=
 =?us-ascii?Q?/qIgoMS2x+KqZfVggzwDFoY3LbSIdMz/8RAc5pc2s935xQXUUYvhRYRCrcJc?=
 =?us-ascii?Q?LCRL24mQxAAwkfPM4D4w/b6yo6qoAaDbjRh2yIrfAC5TYLk1MPfhDSzaFFu5?=
 =?us-ascii?Q?4HlvzFH1TqUfGJao/7dQ4EJkoqTmuKtwosO0TYSutrORVX24U4NX6LNeCrTw?=
 =?us-ascii?Q?GpSyo3+1GyOcDF9Ak+Pk/dk/OZYCLKnf6Xu/TNTfKlPM0p+IwlyZMMJ21pBV?=
 =?us-ascii?Q?3fUXk+zk6Y9qJnyQQviFA//TKhQ8kA0FAPdZkNrpqxrErqaiclCCtaCYFc0a?=
 =?us-ascii?Q?kfbKGq3clTXIcLEKyGgNu4vVucrOAOaMuxySYyrpOzAOtERvrLK5qCq/BVFy?=
 =?us-ascii?Q?ad8L+I5RxXkhcVkyN5TsvM3tMtOoT3C5ddSHnEgJasEd4rdrNjXoqWHjZ8Rz?=
 =?us-ascii?Q?9oY8iNh4Cz4iEwB6O5i/cI6nKFISxnF2mhvJDKvSEEuz56GH0TXidSJltolC?=
 =?us-ascii?Q?JyX82YCdhR5DT1hOS9P/mNLQiZTtvCVJxuK2wQ3Iq0EGWl9lmO2hABpvW3kM?=
 =?us-ascii?Q?2GGg/w7ItIwrwx4sEf+hjAZfcOCTmOe+vn7+izdJks4jIgodsxcx0ygz1bTI?=
 =?us-ascii?Q?epOudwYSqgLMO+2FfMKL8YjNeD84GXE2fMR+QO0ItEpP1ls3mh+2UW24gr75?=
 =?us-ascii?Q?bVtwZwp7gVhTJXnEvjaShqF/C4sqagH1XzUTe3lHJqFThTM4CtX+BZ/Yvo9O?=
 =?us-ascii?Q?glcfNgJtmNzeoF2vrLi9JFlgC+xgsP2qZdpzS/UJCyaV/1dn5p/W86gJn67S?=
 =?us-ascii?Q?NExAny6dXuGJA6FCbXQ9IKCE1TVNd1aOyvsWomLELKwlBdSVsIUosxtWjtCO?=
 =?us-ascii?Q?9higBKUv/zxhJKXY33h8RFtF57yDVDCtz6EGCtDFM35cwWZMjvVXxXlGCxq3?=
 =?us-ascii?Q?JAAbUCYw9s2I8ZEWyBWHb4qW9E7A7yU5nZiDh5u+C/BvPXknWlzckyh5zCen?=
 =?us-ascii?Q?ANbCoUnPA5Slr3UEhTn3zPciKnYmin1+8D7Bu/pqAlgcrNwMbzsGyF8RIfqN?=
 =?us-ascii?Q?4SIKUPQ5Ut/mdPcUpbM3Qttz4uGznssOwR5+NKUyie5KnquZsZLSiVLGpFhw?=
 =?us-ascii?Q?XnAXpy5b5fFIphHXBQ4PEmQv37VgAYO9OX8Vq8TDZiz5+kKuazfZGQ4RxRXG?=
 =?us-ascii?Q?Aec7jHZtBR29L+OkN4heMnLnYGxj6clCpD88PheQ/MXGJ5AglZFhhWQr/iDU?=
 =?us-ascii?Q?Z6auYMekY6rrVxFkqN0TfzjaGLf8he0ia4dtoWNGQ+FBxNSEq5nUPNJKRXEE?=
 =?us-ascii?Q?AaQAjhiYusx1P9vA3C6ZsMgJIkpccWhF7orEAdBDxNFc8i+ap/YOLBcQF82c?=
 =?us-ascii?Q?2g8B53qeLrDQ1OZZqeAKAJPTyV6PEHTyJP5RcYFveg2PDtznG/1h9NdHrp5z?=
 =?us-ascii?Q?Otd3lZ6ZDMcE+x5shwos6Ovj4X1VC8gzR5f0dACRVn4djKGN5eg4GffjFsrA?=
 =?us-ascii?Q?kiZGUVDpq88doaGXebAVt8vn1o5soAYvNU2jRhc6?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR08MB6954.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6946b073-65cb-43ad-6c00-08dd0d7bf74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 18:07:03.7248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jN7Tbwq8dfLM+RXf54pMkov69wLQz42aPeoX2WGKuPB4VacFNppQUG7Hv42yipPKTr1U3S6A2HCmHT3RfuTeyEym4NE+g+7v+NSVoKH1eJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR08MB8698

> > > > > >
> > > > > > If card detection is done via polling, due to broken-cd
> > > > > > (Freescale LX2160,
> > > > > etc.), or for other reasons, then the card will be polled
> > > > > asynchronously and periodically.
> > > > > >
> > > > > > If that polling happens after the card has been put in powered
> > > > > > off state
> > > (i.e.
> > > > > during system shutdown/reboot), then the polling times out. That
> > > > > timeout is of a long duration (10s). And it is repeated multiple
> > > > > times (x3). And that is all done after the watchdogd has been
> > > > > disabled, meaning that system watchdogs are not being kicked.
> > > > > >
> > > > > > If the MMC polling exceeds the watchdog trip time, then the
> > > > > > system will be
> > > > > ungraciously reset. Or in the case of a pretimeout capable
> > > > > watchdog, the pretimeout will trip unnecessarily.
> > > > > >
> > > > > >     [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 ar=
g
> > > > > 03220301 flags 0000049d
> > > > > >     [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00=
000001
> > > > > >     [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00=
000002
> > > > > >     [   46.891906] mmc_request_done:187: mmc1: req done (CMD6):
> 0:
> > > > > 00000800 00000000 00000000 00000000
> > > > > >     [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2
> > > > > powermode 0 cs 0 Vdd 0 width 1 timing 0
> > > > > >     [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13
> arg
> > > > > 00010000 flags 00000195
> > > > > >     [   57.433351] mmc1: Timeout waiting for hardware cmd inter=
rupt.
> > > > >
> > > > > Hmm. How is the polling being done? By using
> MMC_CAP_NEEDS_POLL?
> > > > >
> > > >
> > > > Correct. (At least in my understanding.) 'broken-cd' in the device
> > > > tree will trigger MMC_CAP_NEEDS_POLL to be set.
> > > >
> > > > > The above certainly looks weird. The mmc_rescan work should not
> > > > > be allowed to run at this point, as the work is getting punted
> > > > > to the system_freezable_wq via mmc_schedule_delayed_work().
> > > > >
> > > >
> > > > This is the backtrace I get when the timeout occurs:
> > > >
> > > > [   46.154348] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > > 00010000 flags 00000195
> > > > [   46.161917] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > > > [   46.167743] mmc_request_done:187: mmc1: req done (CMD13): 0:
> > > 00000900 00000000 00000000 00000000
> > > > [   46.176526] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> > > 03220301 flags 0000049d
> > > > [   46.184016] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > > > [   46.189840] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
> > > > [   46.195665] mmc_request_done:187: mmc1: req done (CMD6): 0:
> > > 00000800 00000000 00000000 00000000
> > > > [   46.204362] mmc_set_ios:892: mmc1: clock 0Hz busmode 2
> powermode 0
> > > cs 0 Vdd 0 width 1 timing 0
> > > > [   46.219307] CPU: 6 PID: 153 Comm: kworker/6:1 Tainted: G        =
   O
> > > 6.6.59 #1
> > > > [   46.231988] Hardware name: [Redacted]
> > > > [   46.238678] Workqueue: events_freezable mmc_rescan
> > > > [   46.243466] Call trace:
> > > > [   46.245901]  dump_backtrace+0x9c/0x128
> > > > [   46.249643]  show_stack+0x20/0x38
> > > > [   46.252948]  dump_stack_lvl+0x48/0x60
> > > > [   46.256603]  dump_stack+0x18/0x28
> > > > [   46.259909]  mmc_alive+0x74/0x88
> > > > [   46.263128]  _mmc_detect_card_removed+0x3c/0x158
> > > > [   46.267735]  mmc_detect+0x30/0x98
> > > > [   46.271040]  mmc_rescan+0x94/0x238
> > > > [   46.274432]  process_one_work+0x178/0x3d8
> > > > [   46.278432]  worker_thread+0x2bc/0x3e0
> > > > [   46.282171]  kthread+0xf8/0x110
> > > > [   46.285303]  ret_from_fork+0x10/0x20
> > > > [   46.288878] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > > 00010000 flags 00000195
> > > > [   56.793379] mmc1: Timeout waiting for hardware cmd interrupt.
> > > > [   56.799116] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SD=
HCI REGISTER DUMP
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [   56.805545] mmc1: sdhci: Sys addr:  0x00000000 | Version:
> 0x00002202
> > > > ...
> > > >
> > >
> > > Okay. If this is system suspend, it looks like the workqueue didn't
> > > become frozen as exepcted. I don't know why, but this needs to be
> investigated.
> > >
> > > If this is a shutdown, mmc_host_classdev_shutdown() should be called
> > > to "disable" the mmc_rescan work from running the code causing the
> above.
> > >
> > > What am I missing?
> > >
> > > Kind regards
> > > Uffe
> > >
> >
> > This occurs in response to a 'reboot' command.
> >
> > Here is an instance of the failure, with initcall_debug set to 'Y':
> >
> > Rebooting...
> > [   44.500858] caam_jr 8030000.jr: shutdown
> > [   44.504805] caam_jr 8020000.jr: shutdown
> > [   44.508748] caam_jr 8010000.jr: shutdown
> > [   44.515349] tpm tpm0: shutdown_pre
> > [   44.523165] igb 0000:01:00.0: shutdown
> > [   44.558695] usb usb2-port1: shutdown
> > [   44.562268] usb usb1-port1: shutdown
> > [   44.565864] xhci-hcd xhci-hcd.0.auto: shutdown
> > [   44.570306] dwc3 3100000.usb: shutdown
> > [   44.574052] [Redacted] 2030000.i2c:cpld@41:watchdog: shutdown
> > [   44.580137] tpm_tis_spi spi2.0: shutdown
> > [   44.584054] spi-nor spi0.1: shutdown
> > [   44.588066] spi-nor spi0.0: shutdown
> > [   44.592112] mmcblk mmc0:0001: shutdown
> > [   44.595902] mmc_mrq_pr_debug:274: mmc0: starting CMD7 arg
> 00000000 flags 00000000
> > [   44.603413] sdhci_irq:3546: mmc0: sdhci: IRQ status 0x00000001
> > [   44.609240] mmc_request_done:187: mmc0: req done (CMD7): 0:
> 00000000 00000000 00000000 00000000
> > [   44.617939] mmc_set_ios:892: mmc0: clock 0Hz busmode 2 powermode 0
> cs 0 Vdd 0 width 1 timing 0
> > [   44.627877] mmcblk mmc1:0001: shutdown
> > [   44.631709] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> 03200101 flags 00000095
> > [   44.639200] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > [   44.645027] mmc_request_done:187: mmc1: req done (CMD6): 0:
> 00000800 00000000 00000000 00000000
> > [   44.653727] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> 00010000 flags 00000195
> > [   44.661296] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > [   44.667123] mmc_request_done:187: mmc1: req done (CMD13): 0:
> 00000900 00000000 00000000 00000000
> > [   44.675907] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> 03220301 flags 0000049d
> > [   44.683399] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > [   44.689223] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
> > [   44.695047] mmc_request_done:187: mmc1: req done (CMD6): 0:
> 00000800 00000000 00000000 00000000
> > [   44.703746] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0
> cs 0 Vdd 0 width 1 timing 0
> > [   44.713667] aer 0000:00:00.0:pcie002: shutdown
> > [   44.713673] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> 00010000 flags 00000195
> > [   44.718102] pcie_pme 0000:00:00.0:pcie001: shutdown
> > [   44.730534] pcieport 0000:00:00.0: shutdown
> > [   44.734898] fsl_mc_dprc dprc.1: shutdown
> > [   44.740863] fsl_mc_dprc dprc.1: DPRC device shutdown
> > [   44.745830] mmc_host mmc1: shutdown_pre
> > [   54.873286] mmc1: Timeout waiting for hardware cmd interrupt.
> > [   54.879023] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   54.885453] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x0000220=
2
> >
> > The trigger CMD13 is in-flight at time 44.713673.
> > The mmc_host mmc1: shutdown_pre is at time 44.745830.
>
> Thanks a lot for providing the details! Yes, this certainly points out th=
e
> problem during shutdown/reboot.
>
> I have sent a patch [1] that I think should address the problem. Can you
> please test and verify it?
>
> [...]
>
> Kind regards
> Uffe
>
> [1]
> https://lore.ke/
> rnel.org%2Fall%2F20241125122446.18684-1-
> ulf.hansson%40linaro.org%2F&data=3D05%7C02%7Canthony.pighin%40nokia.co
> m%7C2b25985f3d974df1d15e08dd0d4cf275%7C5d4717519675428d917b70f4
> 4f9630b0%7C0%7C0%7C638681346376209654%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DXQ%2B3SRi8%2B
> F9NZLEuhmekipj5YrjxVhTnlXIP2RUokmg%3D&reserved=3D0

I confirm that the patch corrects the behaviour.

Thank you!

Anthony

