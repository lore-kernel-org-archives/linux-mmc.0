Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D546127
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650348; cv=fail; b=hbemBkwBQvPScEj1tV2beocCzqeW7DN37tGXpuq3alq4qdWaWc80Z8OjYQQWDCsM/zwmKx/758ss6UUgSyvoSafE4HB8F52iFYvciakZmGsOpZf7tVchVXAgGqs/b8lcQxpXGhn6Qag0dFhzB7iknuNtzpy4EsPyVkU8aVH+Mok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650348; c=relaxed/simple;
	bh=z4DAYE37WPCl6aEJzJEK8bwPETB4kGp34ivuSI+0d94=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnFDEWjoaHQaFL9gAUD9kZXDmpkFLyIiTANTKgqYYqSEaizF9fKhwo5I41fr3nHT06O9FEsqJdM5Z6L/xyVkTarDbMuea/Gf5W/iZ3x+GhhF3dZkBmm8s/ovpyNihVzLPztlaY/Sy/JX0jJUvnvuBn22545ST6Z3JEGjly6VtBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TXVd0qpY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IycGs6EN; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TXVd0qpY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IycGs6EN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709650346; x=1741186346;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=z4DAYE37WPCl6aEJzJEK8bwPETB4kGp34ivuSI+0d94=;
  b=TXVd0qpYF2Etz2jZYbIW4MH1QGIJLdzD52sKBmVfMBDtEzTq4LrubGpL
   abk72dZtaQxOtx8f5r7+NyyfQFB/ofI1/DQNi+7vV6aRNeehq93zUsDz4
   4niyJXWtkLW6+44DpiwS387DlJ++w4aAITlxH0Ak64/uzdDdBG0grnzMo
   69HrqhqvU9Bh011TiptX/JPqViuBYlzdr6e+ZhqVc3ctrFzjeklyGC0/l
   iBmeDvK+KLDzpWJriYgKrbyl39EERNO0wizFEoho3yJ/4br2tIw0SC+Uv
   r0pn0TSwR0UTg4STSNJeFKCwToVwi9lulFZmjORCgs2qK5ilmtky1RDzO
   Q==;
X-CSE-ConnectionGUID: 1aSK28/CSeaKc2F+UUeEIA==
X-CSE-MsgGUID: 2M0DabQET++6HKFTf815Lg==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="11093799"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 22:52:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRDL67e5yy5lu+Pnll2XzWaf0h81M5eM6EhMmyFBGFfhHqnnKbi4LFUcs2TgrsnY1RL+IdIeRhRhx55hF3vj6ofYOb50vjeBZSuj1PBRhzchOZL1/qtVQLj0ZL5BDJxH7Pvq9AtNCGr8bk3BSPQrZrVWMkUsydfXEpIHwSObWObdOBrkRw6Ky/qebMSJ1yPmIzE332IQwX2lVNOdULnRR/SLKg2AYNB0zISwoBuenMn9rx4/gZKJZsDPizFFwFKTqyU/X1Yzv9BvN2ZqJUDM8Zq/B5J2+rAbMR/YqVlESm+oVQQifTncph9AKJxnGk6mf2QXNNbfztpsRVVxvdvbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7D16wmYu3UZDeTFsEqXkfXAlWlcUiFm8D/a3/43A14=;
 b=GOmIq7Cc/NzuLNIo+Ka4fy39iu++kn6N/xLKaqrAlEsxMblx/GofqYNlF6av7t8ePPEGJPmQpHUHT2xcDAIzusb2sMvZHEPEo1f5isrfBbDDfbwG6vvCeCy+DrpCFoeq89hfdxpOKT3Sj7KuNU5axJxUEXK0erdmCU9W7Pl/uhuIQ3/HmDCh28AvfO4IvlFroAThBxB+eX+ni9LTxFYWHizZzZily3u5vSoCFV3+0KN7oHMN9UUPbzJdfpwzpG7u2uUKCFb/eTd1xrsb7I5I8dMmxAag609yKIWNmPHRGNCGlqpmoVBfQF3B/XDNCRw/npqtczIn0/Q2z7SzNQ5Brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7D16wmYu3UZDeTFsEqXkfXAlWlcUiFm8D/a3/43A14=;
 b=IycGs6EN6qsvl15Q+LYj+pBQAqVAzqm9Fwvc1YmvIzCWfEHoAgyFygpfUlu7YuhgSRTy7WbYg1YoDVlDuHlo1EdSoTz4o1LAzf0fMJmOgeryvz7T4ap2nOj1XoLtiZ0Fmorm/ISVYj+t4EX7DXQTtxlom+9CVPGrfbfBapbHNSs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6505.namprd04.prod.outlook.com (2603:10b6:610:67::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 14:52:23 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:52:23 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Thread-Topic: [PATCH] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Thread-Index: AQHabuz0WTKcfBgH7k6fEfzpycU7TrEpO1zQ
Date: Tue, 5 Mar 2024 14:52:23 +0000
Message-ID:
 <DM6PR04MB657512876A037D82CC78EA58FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240305105949.392092-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20240305105949.392092-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6505:EE_
x-ms-office365-filtering-correlation-id: cbe47bb1-d72d-46b2-cf42-08dc3d23ddaf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wQry+jXRfs/+kF85AZzafEc8x82skGqnGl/HWDgQ9U210arjRlm7Iihndu+2+ijIndMxO7jM6MF1UUEiDmrWRp135dZekLv5VYx5AvGzfJBagrTpwKLpuhZ4IIRyUWfgTcAp09VhJ89uHIsqFDKMOpNQDBX77xIkZvhSBh9fO9zTuP/159cm+dSYb1ss6HdzwmAEZbnEjviRmZaIYqsXEioYO9GMoHstYH+qfWsFq+QvcZQOFNqcbz5MEoYyLFwx0ea93wPm52Ep8o4w3UvO5sMuXavv+i/xgK8zy575K6NaKqkMr+GShlp+30MGAnzKoVfYEBHNuOZVWmtm+LRTe3H8bjlBZNWYHsJTE/spTCKC8jbhYMJ+2SGuse/2AlwJp02ciK6UqX63JY6lG32rkmnHAiOnGf6iXDqA+rJRIfh3YXbtHVosVOGqw70JsJECMBmzGdah1NRULml8p/LKsJXQki6Cg+kJJ3ua+JmxJv2SJEMm3C+uxa73AvaEges8wPRY1yF+oxNTvXjwqaVmvg3EclLWGe7g3Vqrs80H+rY4dlzYAztb6RTu+gv4a6ZFYAtxYId/hCxIiVu8ki4Huf09NOc9Ea/c7fItkFX5qaodnjFNQd8nSbkfzkXx53hl5RBzTnfAvwBT7labMn71+PpSgR5RNnko26TrJ3nsnA4luCoNSx1Z7LvxaNCF/lhm898Vj7EhKT7SFkX8zOTmjlLSXPtYwZzL+ycuwljFmNo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K1pKF/fvpXpk0M/1apJCvsXeaBt8oMlOl5OLFIN8TnxQ6UeYJ6WrDHGUU53C?=
 =?us-ascii?Q?nW7x1OzPLcoGPAjlkyrjnGO4A7XGCQWAaIuu1UcAw5IbKynT5WssSpsNWUM9?=
 =?us-ascii?Q?G6w6v84C+L7OD/9pEINxI5qV6UCLom8pFxkaBi7RfTmE5JlWsn+HlUykr17o?=
 =?us-ascii?Q?WE3hQiayeoLEPbDxo8EdLgDTInJDtDEHIfW/tEWjIF5/yH8bxs/s4kUplKM6?=
 =?us-ascii?Q?nG5437kN2ySQlilAPhqlTCIuuGR2VqWn3VcT9Lh1mCyihzcKDZrxfReZ7PLV?=
 =?us-ascii?Q?6IjuKPI3ytzplnmkoneM2mc859ndyWqA3OJ50IR1/Obb/MueZLjjj65uQnEd?=
 =?us-ascii?Q?1kRB3G4cJ8fyxlF9xtEQD2b9g6fHmHCJr+b0jZ0sf5UjDlhg96XpHziOpK7z?=
 =?us-ascii?Q?hVDkRlcsBC8m12wPx8ZFQ2UDtiQ5AV9f1XQV6CEwtNzFgs/iZpR6X6AJeDmV?=
 =?us-ascii?Q?Xok4+ycqIEmHYKcamSvk5Dnxsl8A6UxfV4auus3N6tv7HCvzqzyaRr4HK/BR?=
 =?us-ascii?Q?rQ/XzHrL4i+i6cKkJm3qzry/+bYeHtlKr5GV7F03jZT/fiuXboRIyROdawmx?=
 =?us-ascii?Q?Vy7q705j4uat//Kdu4BloOeEF1tgCRzJCHk16/KmRp37eAn0VL6CrzOIbFxc?=
 =?us-ascii?Q?S8z8dcKXdITtHockvBhjGesgZHOTYWdDrgAmzszs+tDHqpMhPZio454nifuS?=
 =?us-ascii?Q?PAGH7ywCbtj0KMFSZ64TJ4QrVj7Y8+NOKkfPBHDHGFN2JmDSXy1nnkqA/nAI?=
 =?us-ascii?Q?+qyiyQcdTAeBjQuHM7CjSP5PdqfyfcajpUA89sXZVnZiB3L3vibocyzDWLcP?=
 =?us-ascii?Q?D4tx2yWG/aPtn+fdVoVNjs79Nqgd71qZU1sh8kfpWyv6eOqbkkU9BXWKvS9J?=
 =?us-ascii?Q?/xMwm1rSt9PUog0YmxR+naZB3ZNeuhkRB/z95WRE5PkNRu2BhC20AVEzRWvS?=
 =?us-ascii?Q?FZam6f0i4NUVcg2JNp02ieIzpu3jutxW34r0YeuKyqTKm3BSyY+EgIOR8rG7?=
 =?us-ascii?Q?jt2vj3fN7JWuYXndw559WBC4XGsxWUlr6LZfhBxs465eku2l5YCEmty2qh83?=
 =?us-ascii?Q?ye4j57yZM82srN7l1tvv/YBJdyuKtGBHPRECOsFX2Ari50tIZSgiUxNMg/3P?=
 =?us-ascii?Q?Gr8X5obAsPSy3BdrMa06vlL7/3yVGll7uzGKoyW48hqBY94Ew2YhcN84JtkL?=
 =?us-ascii?Q?Dbkj7J3Kw5zKIhJEYSGm8LppPn3C2XgMaHV/GbPKzvD9XHUXfxetpySlQyw7?=
 =?us-ascii?Q?eWDfw0KFZurBEGf9I+50BaekWWvK1eV0WWPmWHIMftHFe4KO8dV4l4ylny1O?=
 =?us-ascii?Q?/Naw2MtHocU7E8f5a/+HFeqSKWg8zkCoUNzx+hC5qhkBpcTR+baSBfgI+pRx?=
 =?us-ascii?Q?SzePx9LXFStMzsOUc/cfjxoM35xe/3pr6YhoJ78Dj810pg8elG7i8yTZJOa6?=
 =?us-ascii?Q?+TOapsr2GfCjH8tEKlc/lR2ujCgbhByqgtHnTSLxMuWd46A+UjkvwGnAnumT?=
 =?us-ascii?Q?uqwcEgBoh4qoUCKVtRkOSpmRoJKRBLlJH5klFjG9h6TFS255Nc1DGvMGDTNk?=
 =?us-ascii?Q?WwWLqpnTzLU/dMop+CgLIsB2CglmKAVNv51wHaRK?=
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
	5xiUDeBe/kbJV1tnT0xoMn1CuLHCdUDY5xUlNIQYowmhnduMiPhPpZyh87R9PSuvK2kt8SIeccrjAMzDuVapzyzOdQ4LcP0JNYPgcseTedlcaPU1yw5hS8RCUaLiDsJuJVRodGb1muFgibHOsNBxyiayX/pKPe4VbmP0386R7ewBVX6kOHhWOJgAfbUbMBwmYqv0qRLArqmu7+PP1OZmeuBkZ3oNvXx0r5Jh9s+qWU7/tuWKcutx3KxlEKMZ2aHCIWmEl5erSQaevseeRfIjr/mcKmLtX7Z3WwdWAtsjwLpNTLPW18BZEoAozJf22EZmA6qa5381CWTHix3dXQe41cBWRqxe5OGIyNWG1hlcCQmlT0aekDxzFixzi4Z+s++V3K3G+PPOMMYTTHhXjd4vkSP6VqvmnJA5KGFaU7vD9lWVwyFbvqCqend5j4UOO0tfDx/QCTri0FeUcBByc6L9/eCD4aoJmADcNjLZ/VOTRvrPMh60gkFIpIKnp9Ht7UpKo3zVxXQyNolvOC/073rRjTZxw1Hi5g1VO2nMptWcj+ez9vJ6xM14u5RKcz//5zBiHREAz7QSBNLs7NsW0NGA20lFzBHbJtbxz640Y3IZGQXd95RvkcqP/3QSiI2/Fmre
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe47bb1-d72d-46b2-cf42-08dc3d23ddaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 14:52:23.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uY07w7gC2Dy3+vX7Lt15GHn+pvW4MhbfmuC4eS9uMLMMd1mEyRz0z312pAIBreqbxOe51IV0n6MKYO5sfSTjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6505

=20
> When building with -Werror=3Dstrict-aliasing error is thrown:
>=20
> mmc_cmds.c: In function 'do_ffu':
> mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break st=
rict-
> aliasing rules [-Werror=3Dstrict-aliasing]
>   sect_done =3D htole32(*((__u32
> *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
>   ^
> cc1: all warnings being treated as errors
>=20
> Let's fix type-punned breaking strict-aliasing by memcpy() the variable.
If any, I would just revert commit a1b594ca735e.

Thanks,
Avri

>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  mmc_cmds.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ae7b876..dcd60aa 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2968,7 +2968,8 @@ do_retry:
>         }
>=20
>         /* Test if we need to restart the download */
> -       sect_done =3D htole32(*((__u32
> *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
> +       memcpy(&sect_done, &ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0],
> sizeof(__u32));
> +       sect_done =3D htole32(sect_done);
>         /* By spec, host should re-start download from the first sector i=
f sect_done
> is 0 */
>         if (sect_done =3D=3D 0) {
>                 if (retry--) {
> --
> 2.34.1
>=20

