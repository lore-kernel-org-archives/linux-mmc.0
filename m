Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E335DA78
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842365; cv=fail; b=r1yQBNqKRyKeIocR7S+u/ZyfSlUU4FqP5+giGnGa6zke++m9sso1NSQxEzCvO06a8XyPxw94OWXKCSemRaCa4e4GIVGAL/uEJNJODhj2t4L3uIdW+6SLrc3Un9Nnf8ulyHk5FpSWs0t3oahVYcpCctcvHDRFov6JbM+hQqjfzOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842365; c=relaxed/simple;
	bh=TBnboIVXyRDCaA08B2f52JoIRETKO10TUcpNJezxhos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HTsyKJN9om0690rVYlBQ5Bbcq4RNiUfoD/fZ5bzWWKbjb4pf5awlrw6X3Y+QDOLdy3s6FPHcrMRdH3MQCQmJIljb0mQpUkg1ToUe38bEnx2va5ar8Fok6QZlzVSG6aKqKhabSKdMZ3eBS2BxxdusyhKRTMVPiGtk4xp0RSZra/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=TQIXyr7x; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="TQIXyr7x"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1788842364; x=1820378364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TBnboIVXyRDCaA08B2f52JoIRETKO10TUcpNJezxhos=;
  b=TQIXyr7xyCfIfFa90+taWqeM8WhnTmgQuMZRztZg/rqpoUBpb2I0L6N8
   meD9jeWlh2JO6tXyQIIqoqzdNW3jFiHWD/IawhdWlrSD01TaI8iys4TmQ
   Z9f4jUACLL3Cf2LjNIzzhGIhFoX9x7iot25+JFKyGH4plClUJqvNs+4WT
   tMx5yjaReOUtFqY3NHbLZXRZtzJdHBslclnSu3kissBpl2y7GbA1rVTWI
   ua+Pe8fa9N8dPHC9nBA2Mxm57O5cK5zgiLX7+Vppcnht7W2FIzaDiA8j6
   5Uysx0N94/GduT9+qZQOSprf8mlnwGMp7udatdPjTyOsWXZ/N5z2v4XgO
   Q==;
X-CSE-ConnectionGUID: o3dENyLcS06iP65708Ha+Q==
X-CSE-MsgGUID: Fj9mCf4yTxmqgEYH/eA0Rg==
X-IronPort-RemoteIP: 52.101.56.113
X-IronPort-MID: 29697095
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastus2azon11020113.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.113])
  by ob1.hc6817-7.iphmx.com with ESMTP; 07 Sep 2026 21:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijMenrBwsfu5mD7Ekv6I03KixSBFwEjLPG2ekbV7LyTyHrHjyVFgmij5OycaNDWqYHuCXs4AWmZyrP0zqSooe8AuzNe3JO4IvC0bGolqBthVwQ6L/hfqYeIt/kCdt4GIEoDKhnFiwS/vDVaYccAEU3pRxxbvL/WWo8mBLCnnr1JFtzx5RZ3ZxxLxVeUphuYFnlOZ1x7tnYjasf1M8IKy1T6P8Q3PplddPxwxofy5nycvxlH+WLse+tA3la3mFE9lc4W/U9kiIWWF+uFh2a+TQ8na1rIqIUive8B2DlmOmYCf6SaMtbXJnGP85qro+cH2b0fze7NyF3d450IWxJoAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6a/nYAiPMOp0r0XZUDw+WLbjkKrQo68RKoUo+UH+cI=;
 b=Be7HJJ4cgLWtzI9hy8CMNr07MdxiBe1c/OeYLR0PFpq7YfhtL1O1Ja3+jPKAlOI5KHmZB7Y/ZGZb6XSMTgwGsbEW8G0aVGr5SJ5rLWw/DNAj6oBhdOWckSs6aQQ6o+nRI0jdW6CVlAZNdzuIkB2R+3gR3Z0mzUaTqVuMcmW+u19iAGFjGotXZd7B8ise0U2R47cNQ5GlSNCwWwv/oPeQ9eiOOL18q3LY2L/XMEkT5ZtIWwUJoErw4tUsyKaQTkkAYEJREvr4l+6muAlw+rg2ksuPf9eM6tXFQYQnF/HQS0XWhNUUR9DWQEDKoOzEGt12SO90BhbPtedptNAN6Couiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 SJ2PR16MB5818.namprd16.prod.outlook.com (2603:10b6:a03:576::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 8 Sep
 2026 04:39:21 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 04:39:21 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>
Subject: RE: [PATCH v3 2/2] mmc-utils: Add health command for eMMC health
 reporting
Thread-Topic: [PATCH v3 2/2] mmc-utils: Add health command for eMMC health
 reporting
Thread-Index: AQHdPyf3RRPwmNYvhE+712aFcOu5srbEGYxQ
Date: Tue, 8 Sep 2026 04:39:21 +0000
Message-ID:
 <DS1PR16MB6753C2A5AC9D89C7BC284FCDE5B12@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
 <1788826860-153971-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788826860-153971-3-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|SJ2PR16MB5818:EE_
x-ms-office365-filtering-correlation-id: 2a426db8-e38e-4232-0ab0-08df0d6326c5
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info:
 32Nd4Kvf2Dcn0wkXfw3VrCU6tr8w4IF47gee0I2J5p6oOS+aZ1imiG2H00+ygDrPJBV7BJxM4BsZ3rW3MNrQ5atV89GLXPpxqZOb2dkD8AduX8mtIuXCf+v1vrw1OGR6gc0nqAPWWQWeUGLhIOIdmPDV3KJRX5h2jvJtgSEQApw0BRd1pkcjomM5GxFWkdato9sLO0ouI//RbcltJvdWQtjrXHB31tgyXu29K0iBbQIW3knrIU1o0H0N37JJF/cIl1sT9AoMspHtMWgpzFqOPWHOWKdgYp+8ZW6Amr6cjUn1xPZPU/WC6szooSJ7P1jRmCWTL/PzBOTZGgDXqIBi4sb9qAfLjE4KhE818XSbsM9KHdD2kXgwC33/CfGKFtxZpYet3wc+2g/Pr7+ALxahzBVzrHGXP+MDB1SrPFCVixp4y1OTQcRlnR33WWfkxIsW1of3j9As8jk24OpZW11p+fSoSeSt8nRfiG+tOTuHVeDmJMdlhWui8eYkc2+Guc3g1jhZwpcxie+hapdf4Z5NCvC3xB5C30Dd/G2beEeDCyFNek0wGPrXgORWmy4lUYI/Iu9KWFruxWXUHMIwroH3caYORX1ad5UaqlW6VctoiIgGCrmFu4DMXgVmGdj+aqdSI6BE2NjSN3lGjM+okwJJupOwt+0aOAAWPkD1QbMvaMYpBXkJV4qpV+ObO561jBxMVHFxAgOD7hwSZ5zES/6L9kYKGv9kC5nF7kU76Xno3xY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5VHfKuyVAHJia/LDQwU+VPSvuQmHoN0XHo3oLPSN28F0EZiV3sEQFwr6teuB?=
 =?us-ascii?Q?iW6P3EB59UGAYnpN27legIDMYNMjPyJp8xDhwyPxddFaGWUBpQKWsj/VeLoY?=
 =?us-ascii?Q?7RqT8CZ5sehRA2aKvu4Fa3sJ8wPEq8udVlvj6dpWPAjPA01ykeqS7HjUNULD?=
 =?us-ascii?Q?ZxGy73NgjNhhl1UYJQk7SChao28p0pu7/2y4pIydGXRGN6+Xl/PGl1PEPV5L?=
 =?us-ascii?Q?Xs91LFFOfhbzMNkWa+S9N379BzUC6y6ZRbDxuwxKaWz13sLg0ycN5eQlRDWi?=
 =?us-ascii?Q?/qcbwPaFUQ9Tibiqjzr9IBOqGdEeZrILd9sljWimUjVZQ/3wEA5nCwNTTrQx?=
 =?us-ascii?Q?midi6zavV1e0kXrg+JRFxNbDFJZNwbcup6riYA3djX82NT/IdeHHPZQinmS5?=
 =?us-ascii?Q?Sbol7HXy+uB1IvaV92byagYHv/HFNeRPqdByelBbIFsxjDa5NTdQiH/vsdTz?=
 =?us-ascii?Q?+2Y95dN5HKOx55KhpqAIrID5im2RzY9LyuIKSnilr3dfmAMcdxVhP4+Fa43B?=
 =?us-ascii?Q?c8XDCWLkzMo3w3PxXWskhm2yGaudKq4Ys/dJ1aeRoriUqihGS2W2zVJGhYWn?=
 =?us-ascii?Q?yqB+Jtg4txoNtZ8p6t65+pCWPABlWHhs0muVwFD6m+D0x1vYmIux9UThIBGl?=
 =?us-ascii?Q?wkk/6z3qiIa5WKMc+bZfEubst5inv9RZA9L/OjylrGAcW2K8MGJdrZn5qMKQ?=
 =?us-ascii?Q?DTGEo6V4UtZ7DMpWfbFIH+o77tuvj5LrmIDSjzEpQzRVnI1SsihN8fdWofpS?=
 =?us-ascii?Q?bNuut0dFheKdlU4GlA4W7zIwNavy5qi1LDZxlduSjpvVABYAp1zZnSdQUT8t?=
 =?us-ascii?Q?gLEohQR4OBYFs3BXZKypNamH6zQpL6nGg6EW+SunetUikPWsSlLIpfaKvjl9?=
 =?us-ascii?Q?SgP8RhpZOV32S/ipQjiXfA4T/wZoLY+Dt6QMiQ5yCYCwvp4A6ND57mOKN3ux?=
 =?us-ascii?Q?K7Hx/rUulQttwmZLvVhu0FRCEZ0wbFSWvyVoVzxkUpY1wXt2F1IEcCg26NjF?=
 =?us-ascii?Q?unOvZ3orU6c3We/3s2vSD0vKzG2DtRU+HkouQ9Cpv10uTcSEf6ARb7h3u/gP?=
 =?us-ascii?Q?Lf+qMPD880wNCB+ZWcMvQ0MOXh/q0QIl3c1CNemmqNyvjNY3vY6AL758cOon?=
 =?us-ascii?Q?S6s3FiKBp4lFYZ+iTjrFTGrZH63PNtE3BNqHw1GKOYljwSQG795s92whAMb1?=
 =?us-ascii?Q?VMcHWZZxPqe/s3mqaLqMApIwdFyJC8y2D9C2fUscR4rn9C5v1wANLNVgS8uv?=
 =?us-ascii?Q?2L9tG8BuRy1Uqam9sUWombWKt08kU0RLiBKrGA21oJiTWe/0IN64Er1tqCdd?=
 =?us-ascii?Q?m3RByNDw9qodJ+0xE+jmcIv6v6aiVAuai0OmTTath2dAqTxbMmnpJC/4FJnz?=
 =?us-ascii?Q?rP+Qs3pJgNCI1XnwJI1fGW2jI/FOfT6fliJmJ5E5P3y7f/NdafzCDliiNDfu?=
 =?us-ascii?Q?779BjrM6dEllq2HS7mT5Lb9alKat2d5XHfRfPN3g8C5YR4YkMzuxFwbnY7h9?=
 =?us-ascii?Q?e0Fz796T7lz6JixIbv6xo8NhumhDUJ++asZDhQC5z3LzFcggYQM5UX7XQpqc?=
 =?us-ascii?Q?kAgrJwyaE9aOZFBdlzq1GLJIoJcu3LZ3PSfU0Y+h+FJTEhRnb56cmRhWoYHo?=
 =?us-ascii?Q?l1Uf8oi8BtWkTl4UmTl/jux/ekdHn2w9aU5k5alFF/v10qwVPdoKktgElCMN?=
 =?us-ascii?Q?FEdK5EM+leauQXhRUx0JAxV6ErCTzqRCLh+XKwR22+KlHry/PhnMQ++mIdKh?=
 =?us-ascii?Q?DxN6T53MVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f3I8ytrFe/lJWMCE4uhD3CSOtX9zQpYmQFPUIw+T3n4xhmNR4Ogyqzyz1/rqbCe7HERdWBLjYD5QyD1jwgHq8n4mUOwkTN30CWUQLZgqfweOeTLsfMODYQfo8w1QNLdt1PUFb+pxLztvTO7jBu5Oea8anovCcIPc2Ms6jwG39d4jXc7bzfoJX0HGZ6j3aaADIlORL5lMA3hyupj+Z5ljZkcbGXO//iBfbTnUUmg4dO2p5wXvZHOxLYursdi1Nltf4hgLkKLH2/6n0SS3KkIjv0NsW6TkokK6kAq9cRrL5uKj+nrIPHEA44vD/JDnRPLITEYl8pwxmHzSht4b3LMguA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ukuxPoBgdcVaHtgbfsYM1Zy8whb99moLtI9KqlMkpgrcNMVX4Rvz4vLEsOYjTZUQDsjjx6215uQgvN17mMMhpNUnWVJqCg7CkjqMSgKpUvyOKLXoRu39HvlkTWy6O6w6tCKIeFZZFT6VxLwZhqdAO/GS5FhXxP9QvffXajiV+NXnX8Ykw3JPI30YqIs/4htxJu4aCqS7TyVfeV1ewKBu6BzwQdUQ72u4e5dHK7qV9IQwALhYNNPTjUPnKovWmy2smdHofSbAm2/r50Im2tijg751YPex07NF8KRnxeGysV24cbFA2NTOthYHsAXBkxwzO+aiUno9u6rmSfVjuck+wqR/tU657Wu4Y1JHOtpP+gTAHkvRYyEUilqjVF/RBsEAA/XuxU/7bPtnUUzbVEX64YJulaft63q4BIq7mk8l3635F2DPoGu6rEqGESGb+7SyYQvaqbse/XLIez9miSOH5xvrl5yW/Ux1kNXoA0/nSBfX9GJDPhB5FKHMEpEw2KQc5dgJX+TduHCEdFQckkzYi11Mfk6WGH5c9XBHKUel82Coy2dcnfTqQeObh7QjXNyVtGcrwpCSy9+UMiadzJbU2QTdecQhJ4xnJwRZFzU01Lo4QqO4f2tU6yZkYFP8iKuNmiMgo6igSw6j6qPF0LIdQg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a426db8-e38e-4232-0ab0-08df0d6326c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 04:39:21.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzNnNEO09/BibNfS9H3bdDm02A8ekW4gYdYo0zmYVnup0SAwxejjdH+Ir3bjTxDdMtFeoBXSpLU01MFfeaMfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5818

> From: Shawn Lin <shawn.lin@linux.dev>
>=20
> Add a "mmc health <device>" command that prints a health summary of an
> eMMC device: the background operations status (available since eMMC
> 4.41) and the Pre EOL info plus device life time estimates (available sin=
ce
> eMMC 5.0), each with a human readable decode of the field. eMMC only, as
> SD cards do not report any standardized health data.
>=20
> Note that devices may additionally expose a vendor proprietary health rep=
ort
> (EXT_CSD [301:270], read via CMD56), which is not covered by this
> command.
>=20
> Execution effect on an eMMC 5.1 device:
>=20
>   # mmc health /dev/block/mmcblk0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     eMMC Health Report: /dev/block/mmcblk0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Extended CSD rev: 1.8 (MMC 5.1)
>   BKOPS status:     0x00 [No background operation required]
>   Pre EOL info:     0x01 [Normal]
>   Life time type A: 0x01 [0%-10% of device life time used]
>   Life time type B: 0x01 [0%-10% of device life time used]
>=20
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
