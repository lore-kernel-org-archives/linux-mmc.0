Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C644239F
	for <linux-mmc@vger.kernel.org>; Sat,  5 Sep 2026 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604830; cv=fail; b=syjPtD/FrVYzdfnpthTaigZahIKsXnYEQWyrRry2Cq7CZ6wM9Sub3DDom5XwIjGPgwdhoEiHoie9GeJdBheAXT1TdD0vqNm38jvPzxRjRMLwjAffxtJmTErj9ab7G3bMWeoMm04vS5dqOmn5q4TQwqW13G6K2a82mES9hpsewiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604830; c=relaxed/simple;
	bh=tOCaitSa0OhFqlR7H4SUNOkgRAccJ7hgrgw8dUzRaHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hGFnzea5Y0+ICGuaNriet3Ijdcxp9BFdd0Vgsh/gZayn8m46O/+cZKrfrN30CSBC7DqhLLRvqhehNRVZotLEh6j0Z1f9rnV5Pkl+NtB+g9jyw+lkjbaGWMKDANY1C8UEpYt4+708M973T9T5/BEL/o08WERvACg2d+pGEr0ox2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=f1xwjTF0; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="f1xwjTF0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1788604823; x=1820140823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tOCaitSa0OhFqlR7H4SUNOkgRAccJ7hgrgw8dUzRaHQ=;
  b=f1xwjTF0y2oT7A++qdKz8lRtWl813QLBjSn0C8FY0Lnmi+Ctc6LP4FiB
   qnYL4DcpCIU2lr6iABpLshsUe8ZSHnT9uAJwSZx6hi+S006gQMYyh73eb
   Vsgc0wbSmb0b7P52+Fxx9B+Z32q+OhGg3iVys49/0nI2z/wVI1eUoLBz6
   62WO0a9JiX8J4HS2cyTZwq8HA7ceOvvbELsBYGn0dzfyyVKU51/y0hCmB
   X1Q6ZFvhzbamGQ0eGg8aflF24PKljtVIemFMQB8S6FwvqPlpjN7WN+RCy
   +O5dHeVWAVaUV8hGwFA2UFbvGHlYzdN/itdNFttccc56o/vKw0F064hA3
   g==;
X-CSE-ConnectionGUID: b6zc37aOSE6ouhF9z7EHtg==
X-CSE-MsgGUID: 0uc714fyQC6NckUcssGmaQ==
X-IronPort-RemoteIP: 40.93.196.112
X-IronPort-MID: 29539723
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-southcentralusazon11023112.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.112])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Sep 2026 03:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1esZ/A3+kB4sihzAAoMrmNf9GlYWzzz/GiAi/9DhwZXUZs/6zUp/y4jE9iaubNIWHxBCfhhOGViA8hnaxNnHJ2+KCDUteyfyoui7cQGxgsDYf0lICC1z9kg4Y0jaNYdA0sAs1tWg/vSfMFQtxrWM/4VDKaqP0vs8qD/brpqA/ihgXUnX2vtWMrHptfwBxcVagFOuZoKG2+H/V7wWve5UlATryy+pOf0wue/ffINOY0gpp0UgpCuG+yT48oDu2TNFGKe1zdBdzVXcEDzaMgTE98A0FmZFsy7xGX4bTESHSdmzYWvUFydntOwFOYfn7CFERF4EcSVno9n3hk6dcxcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOCaitSa0OhFqlR7H4SUNOkgRAccJ7hgrgw8dUzRaHQ=;
 b=tmqjI71TjWO3t1/FDgT12DShYk1njREh+v3StAe+i7/V602KVSwI5Dvjh8h3kBRo5UvLkKjPgrG6KyKpuUZNp7iFwJNfGI8OLSwHzMBw7MdrQIcdFIa+tzkthMSYp+Xzm/g/4HuoVBTIR9HqmUMTDiJpoeZ8mu09/QRncHetry3UoMmW1y+rhfaZrGCaqezULLiNhRBVS7SQ4ILi3nI+pWPtO09jfQYrKvNZVzjhMlk07opH3xbt0404elmBKjxqnSYCpCw6FVzCOHdw24OzaSFwBkn0ZHIMlhvzSHoSjY6IwIGBbH0GYuCjMSdybwdz6lmDVtlWosagRdVaoQkbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 DSVPR16MB792437.namprd16.prod.outlook.com (2603:10b6:8:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sat, 5 Sep
 2026 10:39:08 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.21.0382.007; Sat, 5 Sep 2026
 10:39:08 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>
Subject: RE: [PATCH] mmc-utils: Close the device fd on the return paths
Thread-Topic: [PATCH] mmc-utils: Close the device fd on the return paths
Thread-Index: AQHdPGxahCsENKkt5Eau0Yc/JNLhFra/zIyQ
Date: Sat, 5 Sep 2026 10:39:08 +0000
Message-ID:
 <DS1PR16MB6753D7FB69395BB9260782E9E5B42@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <1788526382-45113-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788526382-45113-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|DSVPR16MB792437:EE_
x-ms-office365-filtering-correlation-id: 56163a0a-06ed-4f03-9857-08df0b39ea87
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|38070700021|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 Hi0zgJN2p9n78ufRiac6xqbSxVTWK9AQp8Hf3Gwcjsvsab/KPI/wPwzOzL67+s2Imfd5TD4zbEkzinp3AemTpT9oYqt2IE5irErI5TAIkrI+lo2eGeQMD5KjojBXrl7DBXbKu9NlQTi3cgkUJQeGipBwW2dhTok449m9rcxPs56RUMnD03ISqrmL6SrCqsPAFodegO8HNP5rpFLAD14AtKCPEqZSd50m5bOOm9kFzR6YYqLSPpI72Ofi+OyjDjri/jddk3pdptYplB4lcAvl4kYhga2sDeZoZuHNvDRW+XfWbY5FHoVBDzUZgjdc9CUAIzzcbWDIOA/n+LHfICZrhJF+WAzgqA3tmEl7v0+JQF4Q4gPdoutucAFWC0wG/knP5gCtoz7CfqpSYvTaL1IFlhmQ+YxXm78qKheK/K5UIDsld+BOt4SlITIL1qGKVKNHhJq9TBJDvvK8ivRQB6rK7mmEaPJrope/td5IEwQxf4FQcfhgudJI7a1VgsOXIWcgit+GlBBklI220pA49qtd+dTszpfzevps8i7Oru8e5iZPfNCfnASBak2F+BVfGJRzemS4ATI4sRxFmrw85UKziqXb9bKEgUdleSV1cWPsEyrvOYtFzEN4e4zxCUeTWTeraNlZfgw9kg8cdIrVRs72DKbqpTDBPKVPrlwtjaxhY51WMsYT7/7a9fan0BwmGPLR7ZeRUqdVvMb1KlfMCaqUSUIWhhR/El0RxqezfDIPfFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tNiCUiq+1bfVuZbuSkjuOBKiQFD2fjnIcMNikA4h7bQwRHSwk01aJKjXnNyo?=
 =?us-ascii?Q?q77fKsLZvsoAzfiVLSpvNqlJEe0XP/nhd3JJd5AP9eXKQl151nttozUVhpx6?=
 =?us-ascii?Q?eV9EMxc0ijybjS7bUnZZuQSS8GA+0LKU31RiD0NMMf0+uDOn3PnVrwzlxHpL?=
 =?us-ascii?Q?dj5hl5eplv4cEs8q6qB79B+o6DtHWEYwqHNobyEm2ZTbgVpsjQTpbwUGBD91?=
 =?us-ascii?Q?LaWFWeHO5YNum/Mv5K2nM/5l8W+gbFTZfmVpPQ5SX//JopyOuiO1EP7lhOYw?=
 =?us-ascii?Q?YFB1sFv7m+x3FSgZoYNn907ciUR6a5B/ZGqLNS+mDNVBoUpGedHYLCT4xhZR?=
 =?us-ascii?Q?FHCroryEZqB5yUY0PSJPv4CjSaecl9kqBS+qwHP342FpgoaIQL0/qiasO8oC?=
 =?us-ascii?Q?riUplpP6NS0EK0ZxL/C6pWYoLla8HWcxRb28npnKrjcDKIOmIGGQAjkxK9HE?=
 =?us-ascii?Q?85md7EDgpj3I7jmFcdAuWZh4rdHAqZfYF6fhTzRyGnqACysSjupqhY3bn8M7?=
 =?us-ascii?Q?REIJLgYLhoCAKvBGaImDfzkhNWV/ScqVWZonlJgHy8I+ForWwhpyezfglhyf?=
 =?us-ascii?Q?SGAVFXY+8gPpTxtANSKsF/+e53TvSDtngF369nDdD7nw6k1OND0+jHXwPYcq?=
 =?us-ascii?Q?YB5CWz14jATytLcHPHEykEHdrk07Qn8Zxg5KJ1q+WLfiR35rjoT9CIp5xNWs?=
 =?us-ascii?Q?0ucbJ2+SumHH5Ias5KjWzUkqICArAJrgBW4J2ehw1HXKRYKDSXkqe2NVfN44?=
 =?us-ascii?Q?1AJBC/JVuo80IOW1I7SnMd30zDu5FMmQyq0U9qjjzKQkilrVeGXqpR7mQ+ak?=
 =?us-ascii?Q?MMjK4gmkow/eNlEiZ8phLRyuxPNWI2oaopYR41fWTgWxz6OGmH98EDSDUk9q?=
 =?us-ascii?Q?L8d7mq7O7gvjLNqIlt7IwO7mi5w9qIkMpzgLqaWTrkl3A0UjewX4GRNqRgQL?=
 =?us-ascii?Q?2EFNaP+vPtrl2xBTHeuDXuFlRAHn0qabMD9LCp5+FoHaZ2kD5ccFfBJPynJG?=
 =?us-ascii?Q?LFp8FJQ7M88J5c1qGze9mPz25PBqIzparGsSIkH/0il/WyDCBQTBOP+qJ/5p?=
 =?us-ascii?Q?LYE0uNonrYq7HfRTdh4OdzEorAPYgUIIpVMw9X7Q+ta8hqSQKr0xT5wbHLfo?=
 =?us-ascii?Q?g39sdOoHbc64PGOGbMCJlMe2GWkEYhI2yRo6DmY0w8StxuUqHVDebpELdZlA?=
 =?us-ascii?Q?qKcUWBSvULMceT5VaVWypxcMww3sqvS9XC9/5tzwKZC4kBNa04o4ryEL+QtO?=
 =?us-ascii?Q?mj1nvzT6kIQ631rljz0QkZbEy+UQHzG2/O88nJ9NzVQQaWuEgh+GyT6hWL86?=
 =?us-ascii?Q?EN9qgXTQuxySP3dt7lQkqoGNa92Lk146MdZmt7IEkXJGP7u2Wxr1JylNX4Bs?=
 =?us-ascii?Q?dBrtRqiNxD+FwQ3TM3tB3ZrB1GzIHGHogR7N96K1zCkRv1pARDlV4Jdkn34o?=
 =?us-ascii?Q?HfMwQ9xkFUHNQjIfoBU9VGXPAd7EcyvAkx5gD+7rbhnbVy1c0vAjnlF062Gt?=
 =?us-ascii?Q?ld2ZDIEgo9k6e5rkgLg4fYqhpQcke2zZgCuXICUJXhvzGKZcEEt9nhPB/3zA?=
 =?us-ascii?Q?WRdjKa2ePHP2WmTq70I+kFdHYfEsYlbPctp3+Nb/rlJu9X8VYAMsLIuufTPa?=
 =?us-ascii?Q?h3r3PY/B8YystZaTvnnJEr9ia3GVJfqXBlcuJ7H6v9IlzJSTlXpsO4LNOVzG?=
 =?us-ascii?Q?edbzGDyS8VgjjETuenJwiz21EmaSPOqc4niyOkSZcIPBLIcnzDfcsItH2WKt?=
 =?us-ascii?Q?ZI1TYCfa0T6X8zocVlbieacUDC9PRmiuQGuIfvljYTYGTiENJGiu+VtzbZav?=
x-ms-exchange-antispam-messagedata-1: TT0hK0jvcCyxfw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hOszR1SWWaKrqcX0/fXmj4tJxSiXrHx6J3RmYAYQ44OAXSxABoCn4jY+YE+wRiVUHL/BHw2NfTo1+yQzcxEFyl4GaTF19pc8mhG8AuqdgvkkIVc4iFcKRhgbPBvCKS+sYRmtshxo00hs9BCT1Q0s5jRr6O9lv6okBfw4eAxAdQ0KAzdSlXsNGPcPaySohx590ab+9wQD0Qz5ROg+3wj41+grHGyYrEtRkjWUsMoZvJDtQvvoIhm2W3u1O0X0d+6LUgHdKaGLgDgrsR+BGHtzZhuZNlYY3Nz3CK9cCVejLyUkHOLkCAj0kczqRfm1PJWQ63+4FRLLyApr2MvG+UKgRg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lolwCZ7CtYNpSaAjAYMGJs11PKOttFbnGvSTZDqHcLlSgmO6ScBIMTDBVw3ObazAOLXw/p284sumFyjA7LEcG2kEZsfZqZfM2VQhXSg891S67akiRY1HUQ698lXfzS3DjOGGyrXJ1emzD6VkBO2TC1FTta2gSUyZq5U5k0au+C1jw0pmQGaB11FZeK3qt7LB3H+G8ssfSK859FZaefE+uwPuMJ5O+n6QXHz8nZJi1Sb45pz9cvRfk9OfQXtJH3NQ7czRqr+ogDf1itKgUM0iMSmvv7WWpYuuLCtR1poH+1XO5SECigLGToyb2uUekNhmGZ5GkeU1minXRtTEDCxiyqYeIwj1WShfJNz5UjnxZ2pj9NZTUH35jfm2ql+RY8EhJT8yXxWJeEwDUBo4h3FRn4B2IdwfZw7p1H3ZjdlpOjjsQ/UYlwoESEdNHF4MgOhO8cFkIqS0OSFKvJRyCNax4OsZ7SLOO06G3BxDF95v25dpgzjSApOP73v7SMoZlWUBrQT0t1gOh7Ed+4jrAYhw/RTGLCAOP/NwDC4ZBYtAjqWHraw5BWePAg1a/Vky2MT6Lbm0f2RUujnjwhr6qS6Xrr+CMTUXYzolImjfI60bAHnJMW/Lwj+UW1gWzeZzikNU4sMRZ1TWRY3CWxOe1T7LeQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56163a0a-06ed-4f03-9857-08df0b39ea87
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 10:39:08.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXwX/4kwMnYFtROUw/TPlID4LjK8vax6Z0p+xHmArYSb/szplq+WZATByoQnBvJglCZd6xw9zJ+teqt4M4ocDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR16MB792437

> From: Shawn Lin <shawn.lin@linux.dev>
>=20
> do_read_extcsd(), do_write_extcsd(), do_writeprotect_user_set(),
> do_create_gp_partition(), do_enh_area_set() and
> do_write_reliability_set() open the device but never close it.
>=20
> For a short lived command line tool the kernel reclaims the descriptors w=
hen the
> process exits, so this is only visible to fd tracking tools (strace open/=
close pairing,
> valgrind --track-fds=3Dyes), but it is flagged as a leak and would matter=
 if the code is
> reused in a long lived process.
>=20
> Close the descriptor on the paths that return to the caller. The error pa=
ths ending
> in exit(1) terminate the process and rely on the kernel cleanup, consiste=
nt with
> the rest of the codebase.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
