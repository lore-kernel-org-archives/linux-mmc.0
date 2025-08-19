Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F201863E
	for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583476; cv=fail; b=GAT2B2R+bvJKXVT8pV0soXHnQ4GVxp9AjsqjIxnDQJ366ZD8Ucqq4FbdTJqAbkZsGHu1hW/Zr1Zsvbnf2Uo7jLSLx+WKDzOnUYwFt9vCn2p7Z6MEzCbp4Z2ekCgMLhmnJkorhRa8vsYP0PLy/dumpyScDcHCitdf7wrO7VDE7oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583476; c=relaxed/simple;
	bh=YlHxKbxHwTrLBTMVCZWuOIGYwp8n+oZ+ew2d3VHsxrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmJLeqktyymW7vNZu6e44a+1UWGeVvedYcLcWSyHubQzCzzfJNu0euAToHKc2k1DSUfp6FYhzwUfTNlqroJukExmwdwZcPLgkKnnDqyqDyNza1jft1h7wGZTRWRGiAPYSAP7XLdAWARmVtqC3Bag0HrK8HidfQxBneQWos2wmAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FglB7pXU; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FglB7pXU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEcMkVxR8awj2MhMJtNuQf7sB8d/mpsuQlsXlLoY0/bJE7uGAmUnh/bIt/M1+aklfn+aa45oaBoXwKeHg0TOAfyW+6/1n9t51nZDScGqmSw/oeJHk1eZawTZg1zAE5NE0mt/RaZ7yPUo3hOGzSyFOTuWSEsgCx8OQYCd/ToiPJbbneYhZSrwwHdtaKjIv1TGW1B2v7xvhMncZWiV6bdfnGCGRNhioJFzBvRMdt2vBvAkWQZBe31Vdk2SNIJwwxQRPQGesq4TE3eAyueGGDnUPC3vc5iD7A8Ul9YPMFSGVCCgFDgJNrgxJ8WegV4nMmeJdXOPGwPqWpdX2RsLJM58Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWkd2dNMGpKZBPsv1fuChT0qBwo2UzlUUbfNj4eazlY=;
 b=fVnJO7ACVviKWgZv+iafd/EOSiDyPBjs6hInsMvdNmYr2r+LaJqEXj5suI2qOZhP4EHc3NcYoU0CBA43mTk7kceN+dpVNbO4MPSkz8bXLIEFJyhmmGRiTRoFkzptBanKpnl9sjL8xYtPFuZxzw6Arw38H1hG1SwBZQFVIfHTDkv8rlB/+9Zp9cP/Ygd/DtNy6pOjtNYqN0Z5IwSX2nXL9T6Z91BxnfNIfL3rb/IGbiG6YTMvNV16njBH5R1xzm7J7ZNZhM81cJ4SMPhrTG1PwcESkCnxWPCRgWaDJoCkWxt/J2T5/IAgtM7ut0A602I67xc2MqIO+SVbZO+FDG0hLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWkd2dNMGpKZBPsv1fuChT0qBwo2UzlUUbfNj4eazlY=;
 b=FglB7pXUzUWM/4xmslfwWQmUHkBs+if+1c73NDaiTBOawrbU8UXr9A8W1cpDrKb5676U2vgmDhS9N3qlp4K5bCFp3/Ak6PsKaQoGckqKPK5mS4jZ7wRytjmQLCGEvCHXxgg/WoTbdq72nDqJ4ij+FkhbZtO4kgPbu6/5lba5kMg2jaqG5igbQ8GqfxwCqDEuFi29sFjfPrHtnyWdSMGDIBb+gFuVguPtOkr8w9IBiGa8ECqe0v3DM62rvj4MHSonltNuUfXrgLppwVn4BQYdslZJbS8NdWw4UZV5QBLaIUHe0JcaKfmfWEveQgDGnceMnuJIvInygZTQ+RpJaPvLeQ==
Received: from PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 06:04:31 +0000
Received: from PAXPR04MB8335.eurprd04.prod.outlook.com
 ([fe80::5d59:d07e:ef5b:9bec]) by PAXPR04MB8335.eurprd04.prod.outlook.com
 ([fe80::5d59:d07e:ef5b:9bec%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 06:04:31 +0000
From: Rex Chen <rex.chen_1@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "wsa+renesas@sang-engineering.com"
	<wsa+renesas@sang-engineering.com>
Subject: RE: [EXT] Re: [PATCH v3 0/2]
Thread-Topic: [EXT] Re: [PATCH v3 0/2]
Thread-Index: AQHb/5jKKMfeJLbuxkSeTm0rnYSJSrRoXdKAgAFBO7A=
Date: Tue, 19 Aug 2025 06:04:31 +0000
Message-ID:
 <PAXPR04MB833574367C8BC478C5196201FC30A@PAXPR04MB8335.eurprd04.prod.outlook.com>
References: <20250728082230.1037917-1-rex.chen_1@nxp.com>
 <CAPDyKFrSYohNh3tFRZoaPjAm=4GOe_Q1P2RS=8GD7i=BhD=UZw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrSYohNh3tFRZoaPjAm=4GOe_Q1P2RS=8GD7i=BhD=UZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8335:EE_|PR3PR04MB7402:EE_
x-ms-office365-filtering-correlation-id: 4f6d3d31-c8d9-48b9-6281-08dddee643b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZKEgljzjcD4WB+Lm8KL8somRqA66xwuC9578GkWEFDPtDspWpECuBjgAxWTp?=
 =?us-ascii?Q?kWVzxt+hn4ICS3ELLlQqH5b5xeTkMpm3vL922GOoVbGK4FkM/TxLZ84PbDBO?=
 =?us-ascii?Q?FDBkxkuWcPchvEyqMJVJv5I2phYRrurvFGkdXuNLcI7ZHQaEfk6a09NGn/RJ?=
 =?us-ascii?Q?dkquj3h2FgMmJ93Hndluptn0P9QkZnugYYIr1ABUYAOm6sxL4UFdgyjMH7LJ?=
 =?us-ascii?Q?DMMS5pKS8j1o+yB1spOyv/jotyBORmj8IKAtUFnP/oZ0jq1hYzTNzzrOvP0S?=
 =?us-ascii?Q?098a07rycUVBx9onbCWvX9mFX4Jx7ObybOl8r9azX1DhuIl9WVIz/iwRAXXx?=
 =?us-ascii?Q?EPyTO6QfQV2n4BBPEaUtKWig3SW+A+vBIrb8f3e5mBKkUb4dxfAJjOkl9DvG?=
 =?us-ascii?Q?Ab+dM1RBJyOKW9G3E9mFlhQX1HuNclHbNnLDz72ryfQcLkiXEFpXOKgThqLs?=
 =?us-ascii?Q?F2moNavU3OXLMFwnVlVqKDhUjSI/9L1GjXrGfcNgvCRvgGtenoZ6iF6dO0wW?=
 =?us-ascii?Q?OH15Klxp2kzZqaudpolCmm1TxdXSVCeUesBS8CWAq2JYuixPx0usxEB/cgTw?=
 =?us-ascii?Q?W41Q0Rgg0dW44Fc7L0D0Wt4/bTVxq/xUpE5rqxAMzyV5CU4dewku2Xj6AVRS?=
 =?us-ascii?Q?73bUNAV9w+od8Ux9Y9W8k/O0GnDLHOSoY/b14kEzPjzPJ6Ki32KpsWFgSUqO?=
 =?us-ascii?Q?4FSojT9BBQff3pchg6HUz4lQM5hPBkIB7WFn8yOUewwc6flXu4matJluiLMV?=
 =?us-ascii?Q?ZHtCzQAjQS8uodpBYZd5/Q15aaTIqig5hgrJJvBOgJDykmDqlGKpSa9MWbyJ?=
 =?us-ascii?Q?MO2nswARlF8fogvsiule1ocM15hJ8f8I61wIKHOTLMpfi23GjduAJZ8LbLky?=
 =?us-ascii?Q?/u7vGTRCj4PAvIp8P7uNiIPwfq9Vnl6xFsmK1cdXM4DdXyVr+IUb7XChu+PW?=
 =?us-ascii?Q?0ydEL0404H4XqpG7wgIN7p6JZbAgKSA1SJOWaOCH4t92FwSnTjUu4KlV7MXm?=
 =?us-ascii?Q?MMzkl3TbnopLbGI7F42jXxMqHT3wiPzjy7z6CHIBUbBrKsfZ0kRkugnZbuUe?=
 =?us-ascii?Q?/1SYPZNMjnqdB8W3ucqOhdxnq9GgKALaRTCIxZzgARYa5TKUksrkpHACjdju?=
 =?us-ascii?Q?/Ad0BKy8R/74p/ehMnqeXCaKbFKtnCeUkP93uk1nLiNfrFJU0zzBsAO+WWC4?=
 =?us-ascii?Q?F9LztbhyKdCjfL6fSTDRYukBOy5EixQ1+HyRWQg1kvijrd/0Y2PJtw+X/rEG?=
 =?us-ascii?Q?E9jszjdSzEwpeI29AwB09ko2N5JJDsX/JWKgeVhMiyBBQ7/nJ9s62yBVIm91?=
 =?us-ascii?Q?Lrvmnn4E0LGRPBnfEO3tOV1Ug80G87PbB4uuSJn3qlFXUMM+L/a7JFequ1Ov?=
 =?us-ascii?Q?z35OL8ZKK3c8g0X1flB3fjbhjFz+unt6g6PMuTdkiFRkl5Ev5pPV856AHDt7?=
 =?us-ascii?Q?S8sUa02GQAT5U0S/Xpz73Ez0Bfsw6pub8vMkQrxCjUkA8lWVi4WyTA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8335.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?58zUwnQ+5wbff+jOA6B0wJlHp6a4ZxvwFjotQzYpkedC8jz5eOLiLH6vz1BA?=
 =?us-ascii?Q?flm1ZIz0dCk58cmcG/p2VcGYuGxWjUgB4q60hnIQRjEW909ve0V+hB6WjeZx?=
 =?us-ascii?Q?EkNSFjwhXbC+imhDUFdSJ0Vo5aj26hXGY44qdJDfpbWtuJuljqvBUohOzcTF?=
 =?us-ascii?Q?bzbO48yZzwT8ypNt/uXzyeiD7iLLGmLLHlnGgm5NgXVI476k+nws2/YVrtrS?=
 =?us-ascii?Q?AoYENo/59vuPWkAz4IrjtJHYhd4fJ9Xu8npX4Ab9SPCZr/wgmPzUAYFFJiBx?=
 =?us-ascii?Q?wJ2w68bz8a9f4GY/ACo7DSZ5QLOsiACNDpsJzecHJzBep85cPZo8Ju6MLByo?=
 =?us-ascii?Q?+FvaM1lqxTqsPmitvfRau6SeYovaHeCWrofNBVszGfEUPx1by0c+iE/c5aB6?=
 =?us-ascii?Q?8oU+WwcWm/nKOh7jpNS7l9tDU/DrMBTDvTKNn+K8+pURxKHAXyt6JM5Gxp3Z?=
 =?us-ascii?Q?2INB9TbgOC9EApafO+ZyrnwYRoVImDgvmjqNBoBURiiewzrZhGIkMXP3dW+f?=
 =?us-ascii?Q?qk2mXwrd4uIRLh5fzSKFsS19iVlBhrLa/ek/j2qwu7ng4U7Fw7F/0XdZknmk?=
 =?us-ascii?Q?z4vNi6g1CbPL2ox4fd0IQnmLli8t5RmdSZq3yzNjP04NlVs/I+i2g2f+xLtq?=
 =?us-ascii?Q?/u7iZkOxtrdsvgB8OBNtkLD2bY+m+YX69F76XxW7yE7ev2Ng3GOsl19AA9ZI?=
 =?us-ascii?Q?BDEA+XhUQPPatF9A1MhJiS4Rg/W+dnE1gz3XFeD4gNNfnn8c2nkonCcZQ+n5?=
 =?us-ascii?Q?WahPotyM8hLgNCy92NSVvhLRmqxckoPoS5sWzk4EAvzgroqiVpCa3p1NQLLP?=
 =?us-ascii?Q?zrszFbaHJ1/fk1ccO56pVaN2HiF3AuNlxfvtg0cq5HiFuVVK51H3/zert29u?=
 =?us-ascii?Q?MTuckMIiaVKaXyZS6mt4h7ZS+fsrFfJ5SmbunXqJMEEuYC4vlxAbxsdJ4Ull?=
 =?us-ascii?Q?e+1VsOM4SHy0ASZ3rco0oZTq5EnW0IPNRw3ESfZulf/2d1eYkcOU/ReMfUJe?=
 =?us-ascii?Q?2vhKe0ZRpB4FNKjydIGAZxR/+1hAT/xU5P7GiU0MNNVULBjzaTAuXPl3tAIp?=
 =?us-ascii?Q?4cPiHU9LyMWXeTY0vRqn7oeOdGsEOjAN+HGrLqPTeMCSFJOpPCbrJ7dHnMbe?=
 =?us-ascii?Q?TyAECwiAQVAfTL+E+JldRhVOSXC1PIzFnRWGLb3DtYTA4r/qnBdZXEgBoN32?=
 =?us-ascii?Q?fe/FrtIwJH8kixCxR8OkkklS1/TaRfbbrxBHLHpQpVmOkHAMnqhHZZJTza3O?=
 =?us-ascii?Q?TiTlyAIxJyJPxl3D+T1zf0LEc2R/CSR0MNZCl55uZH1txLeoNwEHKkO9KsBb?=
 =?us-ascii?Q?BgkBBU95PY8JY0jPBxn7kD+G5PfdueYpwSKv/KA5OlrY2HWsCa/GQ+Ls7bdw?=
 =?us-ascii?Q?xuwRwLIrZrl02wGh74cSphgDrEj7ydoy7DZYV5gUkhkqU/ceMEMrcbqHXssB?=
 =?us-ascii?Q?Dv3HErhpeyOrMsIHIDH5ff+kdvnNJamnr3/IJX5Cv0ebAQWcD0qNBUG/6kns?=
 =?us-ascii?Q?hqeIdkqwAV35hgF10dglXFFq3bc5TVvq10wW2O2cRf0NJxQcdR5NTWDbFtEG?=
 =?us-ascii?Q?G2Num9N/C/I2QTJxZME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8335.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6d3d31-c8d9-48b9-6281-08dddee643b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 06:04:31.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHyv2MqFGyPaBYA+noD6FD3OUxMnRqtSGfgCKjUtEVbusFVw3B1Y0hVDUx+1kgDltq3ESMHxiQWC9udhzYpQtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402

On Mon, 28 Jul 2025 at 10:22, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> [patch 1/2]
> No change for patch 1
> [patch 2/2]
> Add more details in commit message
>
> Rex Chen (2):
>   mmc: core: SPI mode remove cmd7
>   mmc: mmc_spi: multiple block read remove read crc ack
>
>  drivers/mmc/core/sdio.c    | 6 +++++-
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> --
> 2.25.1
>

The series applied for next, thanks!

Do you think we should tag these for stable kernels too?
------------------------
RE from Rex:
Thanks, Pls apply the patch to stable kernels.
------------------------

Kind regards
Uffe
