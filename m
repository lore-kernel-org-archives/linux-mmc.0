Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644621DFF8
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650892; cv=fail; b=B0WNB/5GlguHXOOXyoMj/g8nhjgaHMPipcjAM1G/21cQ2PbAvvbWOIKtejGQl1yznkol3SCkZ4UC6SOHCiTRyyexhI00SGbh3OmuAgGb1sYf3xD0jxCEAIiIKIGC+8U0rTFdOkVA6gDvMf1bunTg51HmJ0vfG1tSAu+Ub1QPifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650892; c=relaxed/simple;
	bh=vwG6efSCDSO+pe/WzdEJPPZ83Jb9CCWFOvjCfEIGkM8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBB7OeANr1SJZMzRTgb8rq0OByD2kViLUv3EHugHQOk2GRu3C2Aop1QhZaLgFMEB+woZW7hurNHL5zYIL9bs+mK1cK0qxBYW7bVp6izN49YX91s3WhY0XztXkgG7odxjsnlj4tAkRPsfelcov4EGV+uXuWIGM9soaOF+yxIay+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xh+hqVFc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qgf2tAlD; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xh+hqVFc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qgf2tAlD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709650890; x=1741186890;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vwG6efSCDSO+pe/WzdEJPPZ83Jb9CCWFOvjCfEIGkM8=;
  b=Xh+hqVFcLdPOWjcWWI8NbT165rS2CdAe97j3xNzPIariR8LBmBBna7/Q
   mmGtMwd4ekEnvJJIsdvP0ui1GlxuUCWc1Uhp2Q/iHwnApUH2MqFTNcjNR
   7X3qWPuPhk/UF4hWxaQ4s9fH4uxxZTQdiSPq424yy11q6Hx1azZLAAeqa
   0Lr4MzfcD8Nwk9QnIYOuFTbOJi8i/Jaw9dDib8eiNmhBclWrZiNim7tCB
   et6ZzoL8CCRjU+XSX7tTLXpR6XwZKpnZ/T+kk8ZcjUVeuVR3I39VEDID1
   Lh0zTDE91CEP7JBEW0poEzocJ0d5xjYWhxz/62q0W8lNYoWjL/SfZT3qw
   A==;
X-CSE-ConnectionGUID: +LA2jMp7SAG6W2sAOHmPpA==
X-CSE-MsgGUID: Ahr/g3q6RUSreUn6id0oFQ==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="11448070"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 23:01:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsH2NEloovA3/NR6YR7XiYqIrSRw0CW3lDrFLF9Wc0E1iBP82wLWqiNR7e4I+KMD5O166GqoGCp4+LXqgEYkiv3BltbTZVRYoUZCyaHjOZzG/2x2go5UwMCGOumUfRCf3NhKcyIll8B6Ms35OaqbpwjH/9Qju02ObQw7bIXO4t4mVcIj3c43+O8gETX0DKXV390mw3I/qTinGQ0JkF6N+TVubyEL01dsQVk/nkSXob7wF3/DHepmR1aJm2ZM+esPykYLtMrLYBHFy/6xasHFEE1iUbgAv6WFcNr2y8aJ/DeT67B9mJaWllajaiHmQbRmtHxUYv9iVTa7FtcKd3nMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy0KqBdKe0M3S548Xc2vUeGwHJowklYq6lDATcx6Cpo=;
 b=PPO22GZBjGNZoq+4k7MCAH7McrMkqYXSijEUdZzZdeX2R3z6/OIJhA/yOU5uxFgTJOo5k3ILkMge/1onPuaIw6kPKzInw4ORvwhnc1nXBkLeo5IxDQam/PFHmoJ/OxEdoT3NJKIE4rbyyN9g+xKu8ejBQqXpBCvttH0tD2S1XyzHbfSlTjzJkRVBZCMHnNoEX/7YvxiCHSkdLzJuqpic5EFpeezdhOrHFZpQ8PWJ7S34vOmokslYll3MeMJ0xOJN0PdRInw1ChOo5RCpZfW8xYJik4L3rRVY8VhfKNmU+qdkI0s1ALMOD/zcBWbqH6TFIcThGmbLehmY3ZVlN3MS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy0KqBdKe0M3S548Xc2vUeGwHJowklYq6lDATcx6Cpo=;
 b=qgf2tAlD0OrLLyiyurQ/jRHyvyN/BaoD0lsO26iL5chadJ29ViB+v6VdQLmaUgqr/pQXIxqd/t4A4qG9jYIqpuB7zri1ypiDAD3jVvxgmPyoAhQsfhAhm4pRgNZcygd60yd+y110MEAJBUsz1UW+4vqoMfXhFrMF1aZZUiLrDdM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6778.namprd04.prod.outlook.com (2603:10b6:5:24c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 15:01:24 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:01:24 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Thread-Topic: [PATCH] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Thread-Index: AQHabuz0WTKcfBgH7k6fEfzpycU7TrEpO1zQgAAB4CA=
Date: Tue, 5 Mar 2024 15:01:24 +0000
Message-ID:
 <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240305105949.392092-1-giulio.benetti@benettiengineering.com>
 <DM6PR04MB657512876A037D82CC78EA58FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB657512876A037D82CC78EA58FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6778:EE_
x-ms-office365-filtering-correlation-id: 675b062b-4273-4a1c-6beb-08dc3d25208b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OazlUFYD7PArukte5ZDjMOsMZZyvJ39QDWwXoWyOX6gwAPFo3IA54RfXb6YlSHTljLBGRVqf5xgMhu9JhtHBgqB8VSh1ZB3nPxm+6b007hIa8OYOaKPTVDYKhBD42DXkMPv225AusGLXuTWXFKHGKCbFDA+yb5xsunPQaOPxHwWY47Y6lDw3IJdCct7ZlMg+F02Ybl5xDHjMfOcE/qpcQoDZBYXROrp+6UYzubZ3VRSgRW8W8iwcxJ1XCv0LLr76neLjbXbIbwqbhw+HVWumYikFojzOgSNR1U9fyFbad7j8W4gXbPV/s9W5UaPTiCtq18OoewYcB7CoFHL6IF658HWVX+j4tI3bOBrCG/1akQPPD/mJAzxStGqqA0LL93imP7MqKt/akX/lAd4L8y65hPALskHVnmYdYXY0+VR8x+hlZZm8tvMaUgu3LS2ATyZ6XcfFPqov1gYzhddh5eFioFlr8PO/yzjLzTRrJZyLST0P6nlfXTxLLy/NgDkmtLwxYzICFEN6YTQENudFqFe9uwe4Vsfj0cZe8dyQn/OI21/Bvqh/wrCLCpSp8Ur6qP6NWxL+ZCsaZaz1P4EUpSVqwsvGMOVTP5UDV+mU3erKZ5aKKb+cXyIC25DApXe4CzMX7FvcYUMDioEBAPMk1Gkvzs2yEecvPzkaJnh4npLz3Bg2m/1+GlPrx4Z37eNCqUe6PrCvFPn8cdIjxqmBRg0TpoCphgAPjs7yR4ufFxRhclE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?30cCfIxPcqNmg8dnKi8ai8YULdfFkefhsS/ozx3HOWUm9/Ko3qVKGg+tHHB2?=
 =?us-ascii?Q?17mUzxRQVYox44rlbveWmjmGvq34QBvA57TDClKTRzs/bwLwrBm/Qez+cW/T?=
 =?us-ascii?Q?J6pDmY1w9nQzfuDl7JZO135wdPdeSE6X+y6re6/BvYsfy+8qvb2PyWzTjfvC?=
 =?us-ascii?Q?DUQ3z4/sltNzLPGbd9CSmgKq0oBE+P9wUf3Ol8W3fX7qaiM9GyNxfEsb9tJo?=
 =?us-ascii?Q?2m8K/4evOVcpLz+gEntKLMJ7gT7/+cIOZGpuUlu2RiW1eEW+5aC8T9MW5Q0I?=
 =?us-ascii?Q?Vc4OHb74bm09Ax6TPvlykAYitWtIoVYo+BbSt4AfIfnc6a8KWolyzR8rRvDn?=
 =?us-ascii?Q?5KJxOPWjkncUUMYcCCKwJj3aqxRra6LzTQdJ2AfhwPNWS45nYjPZIS2mVnlO?=
 =?us-ascii?Q?mJwtUTU5EYREQq1loYmgoLaR8tUblVv2Oorkewt0wmSWJV/pEXRqRy1+35Lo?=
 =?us-ascii?Q?VfKuuwmoNzW/DyO3v8RsugIEYujUFgEUWkXW2JBjSFprGAChwKBwSy0oToSW?=
 =?us-ascii?Q?vOIDDqwYSuaW1S96qRVtiyBmW2SsoCswyxBfqh7Ev0DFoKzvJv7soBzM0v2l?=
 =?us-ascii?Q?9rfufA4C7XTlh8K4X/O/Yw4/YO7lObJ32Ovu5hSsDrhxs9J239rcCG579qwS?=
 =?us-ascii?Q?Zb+C7I9/B/46ZSRul6ItT2rGIJfwDXXPuNlTn6FIS8iy8arcRZ1tM2dG3yjN?=
 =?us-ascii?Q?K/KYBye3UXbKTo+Kz752aMCEIEPS61vrAKegEod4YXyWwX67Jh8xW9b/ZTOe?=
 =?us-ascii?Q?2Jl+c6NtIt0Vn9GUYM/csJkW4vsy39YafQiq2XHTRGhc3NpnqHgov0eAQj4Q?=
 =?us-ascii?Q?50WiYbtSU6NS4sZ/u7eZlrIxfDjF7BWtyjDIJbRYN6In3mE4YLnzEbvKLkaG?=
 =?us-ascii?Q?I+QSH+iqeRcszNJHWMzFvzEJW/TgM4fE+2/zCPakrt8YpRsJLnnKwmWBRX8S?=
 =?us-ascii?Q?g/7PAQvYenz5K5H0aSZKiNvhqw7nOzJ+yaVrnYnxH5+S3ec0cIrH6nZsiwct?=
 =?us-ascii?Q?gpbVbNhKPk39IGsX/5+5zwsxD8AW+foetvWD+5kwT1MUll7olWvNDLPLzeO+?=
 =?us-ascii?Q?8m4asOS1NbyoJenubYpd41azz6ddsMTf6SZfbiJjziT6NcIAEzlv2HkbN5X4?=
 =?us-ascii?Q?RltTRxUZ2ZCSYmidzjPlmDxVhr7Pv6rct4ePz5jmMqydeE1kJf0uCyFaDueI?=
 =?us-ascii?Q?2XIb4J1+3dCJv0IWsVZeyBtFaGUR2FCP4hzLNsiUYrbZj8c8M1YFR2E11u7T?=
 =?us-ascii?Q?aSugOL/MQZt56UvnO6NxRXZ5ZwRuVdqyzUdcygjBky9lmZG256l4LGFGz+9t?=
 =?us-ascii?Q?zf/I3/IuBYpWHUsadRmdJhM7JZUY0hfZI6q016bTKubgev4qZEK9Rkq9AoWZ?=
 =?us-ascii?Q?yNayMTNOpYJ6L/DUTXd0ETZhmqK3eppFTJyk1dXurjKpTwnAowN1UGPLt3vS?=
 =?us-ascii?Q?h3FT6QaYWVQVJE/mJHWyv8vZKR6KIB8m2f5N19LN/v5uWirhQ3dmlijhsaDP?=
 =?us-ascii?Q?QerqOddauuyRhMt7n1q0NyK4yBB4k6Mx0q1f0/NadSSg8+pyOufWoLtCo4Z8?=
 =?us-ascii?Q?ty/4XZN85LPl149x4E8n21M6C6NrY5K+be4dVpws?=
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
	aNJjgGGvUU3tA9VaQVKJCqs2uPC7/gOJbosEpydUzxkXXMjxO6SdgvQGbUGINwQhM4yuhzw/BLGrNoe3/IhVgKpv0CNU2Swl369g6kr4tmIufjDG0HFbcYQ7S6jkHvT0lJk5OkW3YPl7noG6XQhGDpkjAv8K6zRIRoR0msiA6XgiKAXAcP9N4llbucS4L0uLTlGjGJIlqqXwI3mBm1DWWExiWnDx3tm2D2aOlubJ+90GGMLgIux8oUPkodgRbvDWodULYRgystovApckHT2XNiI4wZOaKqGPTpflRjPfKvBCoewsO0wHbwgoR8J9U11PXHyzZa1i2Us3ZIKqP+AlwlTjUrJpcZ9dKf5fcv9dVQh1ttOmNJe82i00a3niBvJnuVT3M01DjMFuHPqCWJmmsqI7HhCj2PqfTcd3Tk889v7FIdcjZAiqXRPiHK+/0oBjkPcj5vV7JPneCOl4eAfAWHCgBp2OkQdMrJPDGfYkXtJbjhprN+8vVtjPHZmsR8UNpF3efXJ3yALmTaAjF9dv9DOFJbn0L9wkPI3K427Cmeoypnf1M2+uiu3PQwVmK5AVuhF2RhUorjc/jEAxU3Z9gT2RwsvEnBRvtuSvyCK87SApfNougp84BMbMA/MA2AF1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675b062b-4273-4a1c-6beb-08dc3d25208b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 15:01:24.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xsk8kmBkHpRBGRDc5zWDYxiTRygs4V73CHF8todQ5jMQBapCbDeBy/q+3HGcpSU0lKKk5w6nMR5RHvGwHADzCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6778

> > When building with -Werror=3Dstrict-aliasing error is thrown:
> >
> > mmc_cmds.c: In function 'do_ffu':
> > mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break
> > strict- aliasing rules [-Werror=3Dstrict-aliasing]
> >   sect_done =3D htole32(*((__u32
> > *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
> >   ^
> > cc1: all warnings being treated as errors
> >
> > Let's fix type-punned breaking strict-aliasing by memcpy() the variable=
.
> If any, I would just revert commit a1b594ca735e.
>=20
> Thanks,
> Avri
Or, how about this untested option.

Thanks,
Avri


index ae7b876..10f7532 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -58,6 +58,11 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3

+static inline __u32 strict_htole32(__u8 *arr)
+{
+       return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
+}
+
 int read_extcsd(int fd, __u8 *ext_csd)
 {
        int ret =3D 0;
@@ -2807,7 +2812,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_c=
md *multi_cmd,
                               __u8 *ext_csd, unsigned int bytes, __u8 *buf=
,
                               off_t offset)
 {
-       __u32 arg =3D htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
+       __u32 arg =3D safe_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);

        /* send block count */
        set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
@@ -2827,7 +2832,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_c=
md *multi_cmd,
 int do_ffu(int nargs, char **argv)
 {
        int dev_fd, img_fd;
-       int sect_done =3D 0, retry =3D 3, ret =3D -EINVAL;
+       int retry =3D 3, ret =3D -EINVAL;
        unsigned int sect_size;
        __u8 ext_csd[512];
        __u8 *buf =3D NULL;
@@ -2835,6 +2840,7 @@ int do_ffu(int nargs, char **argv)
        char *device;
        struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
        unsigned int default_chunk =3D MMC_IOC_MAX_BYTES;
+       __u32 sect_done =3D 0;

        assert (nargs =3D=3D 3 || nargs =3D=3D 4);

@@ -2968,7 +2974,7 @@ do_retry:
        }

        /* Test if we need to restart the download */
-       sect_done =3D htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PRO=
G_0]));
+       sect_done =3D strict_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]=
);
        /* By spec, host should re-start download from the first sector if =
sect_done is 0 */
        if (sect_done =3D=3D 0) {
                if (retry--) {
