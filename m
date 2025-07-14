Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D872F43
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486447; cv=fail; b=IHMopBRN4Kt0mH+Ye0VAOpg5mWHQs81INnE5SutLSZZJosV68KOiRmGsHG10NR0krvAKcDY19eqmGrzyygJTDIvpLHYWqPDtAPSvIQnb5IUTWV+gqct3WXogf/oKu0f94loLQPTHvKmecqKBRRLAO6ivdsyvzSSxagFfMZEzAfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486447; c=relaxed/simple;
	bh=Mx3Uohqb0qbcRQzCX7jFcsklY3n4BJ7bJzyVAb7oYn8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCm49E6o4IsSnBdfVoKSe+ZNHHyMOBROCJDefh1783OcqIguJ094vvQ8MdUgpK10SWK9ROLt2GBpiGmJnd+97G7x2Drh79qw01rVVibd7405v2P2udyB62qCi65F4TQrkvWxD4uzGO0zV8jiSkPxhujxn230wwmbPXPBKxfZA5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=NnmYRmFn; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="NnmYRmFn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1752486445; x=1784022445;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Mx3Uohqb0qbcRQzCX7jFcsklY3n4BJ7bJzyVAb7oYn8=;
  b=NnmYRmFnhpri5pPHaGLUiM/cKcEIJZ6IbSF9XzcSwF8iWn4y3SFHWKPB
   jA9eU68CvN82SwQby/sQS8nB9j2vuIVYGcIF2bzwBtJxXw2+mNLwQU5Y1
   LsQy3nsqx1ki8+ax16DBFpYVilVFfnvEmS3tlqefdi5HWTdmTQVaV0aZG
   dIM4pdLqa8rK1UdZZwE5cPNrcASLgKA52cnCcgjurQ5tCSqVO/U7XQZXM
   a9vb2lpItQeZ53aNOhqDDCZbGSx3nUqm5tuJ+k5ML5k91D7YCXQz8uGo+
   udvfZNFYGEm+K+DISg38w4BzvPSwdyaiKGv6QA01X5xClycRfNT/7PqZo
   g==;
X-CSE-ConnectionGUID: 8Ykph/5HTASIzUaWgkc2Hw==
X-CSE-MsgGUID: HevOG3WJRJySk7XpHUbZLA==
Received: from mail-dm6nam12on2094.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.94])
  by ob1.hc6817-7.iphmx.com with ESMTP; 14 Jul 2025 02:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgiwT8sklWs8ww11158Yc6nZGOl/c2aR9q6SPcQhbhtWXU3brlxzGzybJmGC/KW+JiqxG6Kh7ra2xwa9E6rTzJY2Vh58ANEBb/jNkIJV5Mqyp+rs3CKurGRIvuIkN1/lBxJBjggOcwGk2rcC5DGuGMGMtJdXTDRrHwBNN4DG03k8Sg2ha0/QIBNh1kidn7bpeel9/Wei2OlW5b5P56lCsFhbegHi2PZbtjUSQwdxYPz19C8J/UZV9N+hmWiuXcay6VgOhFOfy1dC3jxxUync2aryCs4iQWzqTHGj8Y4lzMkz8ms7vKRPZEauvz089Jn9Fr7eCGdLvQlAOS9MMtdhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx3Uohqb0qbcRQzCX7jFcsklY3n4BJ7bJzyVAb7oYn8=;
 b=tP81yBh3NlrH2Ur476YSE+Aj8klGF7nAFy7dFiRYlhPgxFkgXAOyYNJnpdawpYiIAkNyusHhRhmoZYMfngrM+9DTuUk393Woe18WcCfqBMCCGHElXZ4NQ3oK9p+NRGd/SzPLkG8ZkC2EzXEivwneZ4C6ciFNr7bqEuXc5N2JR3fqD8DL59NAz2lVbQ3wIQj7YOYUmyUuMsnTUAGWsIgLQCr2yDNTm6jwSYsXTeRVwbECqtizyq5s1Tp+a559lf5AFSpS0os3/ZkURYRmoMxRakVcJ670h0zYHnBwMKkUTvTK+SUpKOgcwbjH34nEptwLqwimhmgkeDJBY6HNPJNqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MN0PR16MB6405.namprd16.prod.outlook.com (2603:10b6:208:4c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 14 Jul
 2025 09:47:17 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 09:47:17 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Michele Dionisio <michele.dionisio@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: add ability to flush optional eMMC cache
Thread-Topic: [PATCH v2] mmc-utils: add ability to flush optional eMMC cache
Thread-Index: AQHb9ItIjKPLYpr6/UetohvsHf8FRrQxXJJw
Date: Mon, 14 Jul 2025 09:47:17 +0000
Message-ID:
 <PH7PR16MB619606223ADA80AD15014EC8E554A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250714064807.1915470-1-michele.dionisio@gmail.com>
In-Reply-To: <20250714064807.1915470-1-michele.dionisio@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MN0PR16MB6405:EE_
x-ms-office365-filtering-correlation-id: cfc23a45-ad07-4eaa-c46b-08ddc2bb6b77
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y3jTatPfi7x7x+qw2C19bndmL+nroSp3T47LxfBLNDGyryKf/X2xekMUnCWU?=
 =?us-ascii?Q?T+gZRtTqgQHwdsiowt5LUdW3FH5eklZ6D/uYRlC4YFXf6phs8hRD8js9/HtE?=
 =?us-ascii?Q?vIK9AAwr34QbBDHmvPNvjMQgOnhLwHDgGy5yOPdB+hyr/tFjQn1QJzc+PvxV?=
 =?us-ascii?Q?H+cTZIJRUrZj6idkTmZHFVTU1S1nGvTfQP02Vq/twqJQWpDDsz8qoQLu7PI+?=
 =?us-ascii?Q?eVejsdNb790LosKRy0Xf2jsHbH424vfLNH40Zgb/CdNrpeP5PJx5wm1Q34m9?=
 =?us-ascii?Q?2PVL3fIJD7lX7DF86H2UJ+HvcGWRS5zdQigKIT+Ie/jPDeCQiPlGcWpIKWt1?=
 =?us-ascii?Q?viw1NQTKAQligTVQgtuylo2Eh6vp3PezNbvr7pTRl+Q6ClMXp+n45jm+nM8I?=
 =?us-ascii?Q?eSnL9MiHDpIkxPsAEbwPu0Jjq8eI8YdsWPc0Zb8xapxatNKlR2pH7LloWAX+?=
 =?us-ascii?Q?yA63nr8Wd3WLY9XqNvV2U+zz3pUA8Hdv+uP7rj3OICgdgTXLhRhyZ2ziFBcW?=
 =?us-ascii?Q?CDgnbLGJXa+kD47f6YZ1sr3gsSrHRhvwrW2g3hBiafhvk75DZvkMyiOk0G86?=
 =?us-ascii?Q?eIhyNxUKgUpmAxtvNk4kqCxKgtlbUV1+Kp9C/W4DeMk6m3FqoufWX0bmLF/Z?=
 =?us-ascii?Q?PLUljPp6Dl0CjpqFIxwmhSfjDaJrWqqyiHbZNgIDxJ7oQP0d9/K5wCPd7S80?=
 =?us-ascii?Q?ef3WtBdwab37kGFnPiTDo6c7hsgbfHFxtmdhhgbQ+4IUhZVOu/26fNleDqzo?=
 =?us-ascii?Q?0HgnoTMGf/EndbWVcgaSezSdXPdXW73aG1MrTZooyrNTUbTscmiV6AzKHOfE?=
 =?us-ascii?Q?LdzKWy5RdaeRujyOtWYOU/3VTbp4lnY+wi53AA+116jci0+3MJM1otyyu4Mn?=
 =?us-ascii?Q?ctUypFkdxTWjVYK6WrbmNXugK+HOJSPcdfEIm2YxuTwvl0IcdM9b6/iPFIKl?=
 =?us-ascii?Q?/O/E3EEmWkoA56CWBcHRH6MQja7EM5VeSc05pAyisVqailwjcAiRWS4Qarrp?=
 =?us-ascii?Q?2GAEHqjFvWsurqaz5QdWc9kdJviUYgAskX/CRxh8fybStIwikgaGS8Q9f6rG?=
 =?us-ascii?Q?HhnfnXu8HZA/m3/uqQM+eTD0SFnNOcBeKleXem+h2fvnTqNvVQ6mVo88qiQM?=
 =?us-ascii?Q?zlX3czy6X4SWtAPuAkF62OVjBB4io3V8VIOvdm9ImLvcbmJKrSMJApucPuuu?=
 =?us-ascii?Q?UuFY/eNM3idJhnU4bAjQDcGvJF+heuZ1D3uKIJ8Ar0PtJpHOZZzlhtz6eA8R?=
 =?us-ascii?Q?zZCVgrOUqICIfO0vCkZUz9+LV2cYcyrDlbrp+fS6pGlkzz1X/L+WIyCV214b?=
 =?us-ascii?Q?9+HLBqL3cSwYkAtfadT2D3iAY8G6LbMefRRjy5qjktAP2QO1gngqe7qbNILX?=
 =?us-ascii?Q?PY/VBvZFGcjpoPTwAacAXd8qw898vOO1Gh3hCQUfuO16waMb8+he+HuaB/I6?=
 =?us-ascii?Q?wYsBmsszx8ZuD62FXwMRkHDEYPsZiFN7sNJujVaIssi4gqKZzINw3Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8fcX16SJ0vOv/ES1Kn5SlVCnV+Ymchd6akedrUdwIEf6mIytVOrm0Sbp5WH4?=
 =?us-ascii?Q?jcyZx3GD3Xb6xwPMF+HgooTZOj1uphmz+D8DGmvHyuJ89pyJfUiU1wdShu3k?=
 =?us-ascii?Q?r97B5vq/OFBTBJMKen+47clg9xNYkGMFa33AVUQKM/mFYa8lgowaj0sGmNN4?=
 =?us-ascii?Q?nK2OlgZVfXHn4fpvMaeKQioertoxFsW39vEm3OGSRNlRc+rz/s2yH8Wb+U/x?=
 =?us-ascii?Q?AtBz0ptG9jhQN/stkfmtqc9L7e9g3RP6WRRkNupc8Gk2hR40hTo1oNnOipzX?=
 =?us-ascii?Q?hhAEzV0KOURVY/rCdKOQhGbR49uzlLzA0VxCjvKdpe/ZdJMp5HHqIv1ymTi+?=
 =?us-ascii?Q?POJ/cMojRKtUhtrhjE1WSSZ2+meBRb7HiHBE7BZuWslU1405rPOKYzKt5+oH?=
 =?us-ascii?Q?6ShnvHfUictOPx2pUzz+GctB3JsI4OKPpTvYGrJQPvwt1wttpvhlFD5BmiIH?=
 =?us-ascii?Q?nD49xGQ9GaLqSDPKH68+jywxUL9mYYjaWLBC/ElWxwMNcgRUwKecdVnEw6OO?=
 =?us-ascii?Q?HBZLxbK8N2ym2srtqjbF3d0I1Cq4wHWLtrsnIYA9mIoIP9wka0OH3/DObJ3Q?=
 =?us-ascii?Q?ZXa0XrAQAJAvbmcoaUsk1F6D1YAx+jrN2XFx5qR6PG8bnadqWVwk0cgCxKsm?=
 =?us-ascii?Q?9BztZIXx2ZCEZ5WVcsIJQjpI34F2hbP04yKoLuJ7NvN8oT2a3O8KDvOUYJsI?=
 =?us-ascii?Q?CuwKGJPl07v6dqDSRJ+XpWgtRXGB69N0YOhDMvNfhiEfA17Q+1cfXamVLvpH?=
 =?us-ascii?Q?F1G+wmOvVce3Dj60/qV83h/vX0ad6/zLrSTwkAj5q20QWKv7CJAT+5D7N0hq?=
 =?us-ascii?Q?qAtlmVtVmilCRCE1iLTpEk0pwPeQYALKJ0hGxo6X3YfuiqOtAvm5ZZby6xTF?=
 =?us-ascii?Q?hOOS79XEXKoZYe7TDT/khXWhIjIRMqrVOrM6hlWlzl9at3MKg5D880Ha4W7Q?=
 =?us-ascii?Q?32CWe1eG6cuNfm27u7PGokTGK3GEx0U71k/D4nmM+H0wSLDoEuQzLfEk6mI6?=
 =?us-ascii?Q?0+yGA7MFcfeQC668siCegAuvlKyjFM8kqMOdsRwd0tB3cPN9BR6EsEKIORM6?=
 =?us-ascii?Q?mRl3X4vBBVlyZzw3FVyEC7HW7VuKxu4plLNh7sUrDTO7fNqRpTSVPzeiKeWt?=
 =?us-ascii?Q?Oavk+ulK0owQ5p/hPnOUkowt2oOY3GonysJA/FbcdAPPtDwT8snZF8tWzdD3?=
 =?us-ascii?Q?p/Bz3KRfkUqttFiscTaCf2ws7hEVGvMaELc2VsdAIND/pfpIOaz4LcCBePQ/?=
 =?us-ascii?Q?Gv6eydZ/ySIxMEnSv3kYPYVssD+0KzhEsXXDe0S2A0kpCekEozHq5PWzx5cJ?=
 =?us-ascii?Q?b2+g4N2FKU1fOR7sIP0BBGy6caue7AB2m2yFtLM2sH6JVvOoJk7o0JuiUMrR?=
 =?us-ascii?Q?Jzc5oXQcpUNQLBjaQJgLjnprBHpJe2XUeoKk6KVGu9JLZT4V12qwy6nafibS?=
 =?us-ascii?Q?siaAOW9uoV0W+oXpZmupZKhVbdfqS3hWjr6jYCPVnEDHBbFoNb9tFXiiIufJ?=
 =?us-ascii?Q?gt+GVmwlwAqTfG3E+DUG7Ak5GH37jfdw4tutC08GflQvF7v5RpeDxj/RuAuq?=
 =?us-ascii?Q?TlDmXjG7eXBSLQtBaKzzP2Qb3WRGoSQrUjQnbiNd?=
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
	n6r6mpg0amzfKOBdWYjEVzf5CPcd6RvaL8ByI8OC3o80vaguTqo6Vduj0dDEML4qJIG4dWOxL/uyxWHNzuO5F/DEFiQQ9dyIXXM9VnYQJLt1XtRJ84/wNCcPrETsd8+tznnZsPlBTQNJYbtroZrx0SOHWoM7/pApzZsCtwjzVka++8V6LfO0YQJZvGfbes62j3sZo5SkVFbxxhJW+6aZUgg0yal7jtWTSH12k1Sb6JFGXi6Oybv0DgwZ9crz5F9vwQ7GqVaRpjRxVXKDbKpwJ/JTrK34+pwrMxCtPYq2v39sJNlZVhcnP5gLoXG7Iou2oln9JXshaiS+m3BgxURayHLmgNCw/UWA1mcpZRU6Y/YBSKzovFiH7jqJxkX1Ov11bfSShNWUl13tKkCC8lkUjo//4apKd4ua9stRlge9tgUeNaOM4PuImBgr/Mo8S1rJjjYch0aRtjkkROM0rFvu69s2ri5SG4/NLOpUzD0564WRJUP6xr5Vho5hEjcrAYii6hUwtIUKnBfF+Tjyt871vJXZn6IdM5TF9f6nqW8ZfDWIcuUa/ULUnX5kVbwVXJcsAxf4NFUk41dyuCx4HZ12p3PbP/jir4aWEZluM98y0afxGAFHjIn8mgOkuCNWARCTxUzk1/6B/qoxZZ0l3cb0JQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc23a45-ad07-4eaa-c46b-08ddc2bb6b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 09:47:17.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFudlMUO1xGriQ1C9EjDdMT2gzxVia6MNwYNv3P/i64+slM1Y+MvkaQJhWAQyzXgzDolFf/MIm+nr/LQkVgGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR16MB6405

> The MMC 5.0 instroduce command to flush cache. This feature can be use on
> embedded device there power is not stable.
>=20
>=20
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
