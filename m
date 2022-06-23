Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340D7CCA47F
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jun 2022 19:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiFWTe3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiFWTcF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2022 15:32:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD18AC1F
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656011113; x=1687547113;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OPDJbqFrSiiEkzjXYZeacCia3tvXu590VXOmfXSgezE=;
  b=pWS/WC9wFhoSplLqE2rGfgAfxQahAtN2yuQ77/8iIWZeQE9fDYASj5UP
   5C0ewUqi41qRYyZIHBzukd5T7QnZb0jvZRvjSodLrkvgHCcjjiczlIeoo
   2p3mEZOGQqz0ufTZ1Y/nPYZj1aEOaaDfQVQ3MBqY7kZc/hXMvjVjliU74
   D0MyxwwqvzwmXdrZx4Nsx7rbYVjXc+1OsISwcyY77UCw4Njukk6rBwwQA
   Z8wBNcBRl/hJfu4qwBuZiVOh2sLnMP6+khUgKn3kxr+N15LfYXhsF2t04
   miwvAc5vQWTj0JNqeza/MtK7txUUE9qbCioOC1qt7u70w6u/jMdIRfQVE
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="203950767"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 03:05:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjrMVrfUS3Oj+/VD7DZlQXu7VH9FRdlv/BYBRoIo9B2hThUoLjVfRRWOO2uURn4K+rF+CnkKj6cFbNRDQ3GgKbSlbSnOCJjIP6Gic3wdHhy7CBn6Fsc7pLN38Z9fiNGo+Nzd3/rSH1vIVhjhGaOWB5jphwGdhHEONUVQEE5uHC96MJNdHLZ7w54jOfUNiESBR6KlpUbSgvknDVT+PdaqgfldbP1qUhawVqVVPtep/uMwdnJsIbyOU51svIEU9QdX+gWWLXxB4AfCpDgl/lHzXSkRHgd+lCASX7N2QOvIIk2EbRsGyCECj2pDkHbcFmmfB5lnJdN01wYGGm12y01Wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvbqgTu/KXYxN3vMx89/sWAX1cjoc9bBQtK0st1vm3w=;
 b=I2FNJaNRxlmNXKl1U3vIzLlgm5ceY4taHPaSO9pvUOWZr+TcNENv5hnOaEbb3F/hRXp0n6wq1nvAb/PjTJNlDsGQMZgq5cLNA0ZEzdYdZ6rl3F7IHHWSaDJyrrW6vQqPJD0bReehBWMHW7dpbG484XuqyaaYRjD2HVYcnXSYQ0Ej8qN9yKudTgQVZOA1/VQ5dyDQ4n1s6UGJ/U0VoqK21cTMQi5tDVkKBTe+Ywc/wBeTbkCnRrVgSBWOeBE08Aktc6TdaUHbyv72eFoxBuASo5s8cVZhGLMis9KyyDCqU9kgC4OpspUGPCpoKkrpxJ81ibOtniwPSZjvodpOHs4R2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvbqgTu/KXYxN3vMx89/sWAX1cjoc9bBQtK0st1vm3w=;
 b=J4Xi3/8Ndcf2Pgpe1EkNR0PoDlyU9K+gB/0PUV54ffeTSbQCXP2volNP8XIgYWm1XI+1W4e6WbMK3DZun08X8HuAa7Xj9E0dDwVjb0hUBvZMfALsn/XOaMQ0dhuLYdb0v93ARM0ex023wt99EyYJusUpAhlXCunGsxhM/2vrCf8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6831.namprd04.prod.outlook.com (2603:10b6:208:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 23 Jun
 2022 19:05:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 19:05:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Topic: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Index: AdiG7NFoW471gNuQTayLmad2s/EH8QARZS3Q
Date:   Thu, 23 Jun 2022 19:05:10 +0000
Message-ID: <DM6PR04MB6575D057E9198C72F60BF24EFCB59@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <dc8b93a5c0b24a59b42278c761af1892@hyperstone.com>
In-Reply-To: <dc8b93a5c0b24a59b42278c761af1892@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cecff812-97e2-45fc-905a-08da554b4bdc
x-ms-traffictypediagnostic: MN2PR04MB6831:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i02HEIpNWqgMjzWKtNCbaHSF12uMj9M2Y994/LWNvw0ir5ISAfkuMOKMOPiXDkiRIu88Yp+KF+n86zOz5rjbsyEJIPmMBEn6oVey9RK3UDMxuEoEIuMJKqRK471QhpGEOs1akHZ1iii5fFcmv/dzP3vlACJVno3Aur1LIzaNRAQ2TJTNFj4dErZI+jigRiYnpPP7TFPGxg1TBFRZmElbVWkTQoGTtAsT9VtV2Hpb6hFnqg66qagLcv4x3VAB/iROhyk9DFXU8UgclEa8L+/LENlFoVllQLulrnqkFYgSTSIRBZraI6Z+lpgZWAeHebYmkiJeLmzlkXx2XuaHl6XHWE/6Y0J2c/2dAX14d9VF91mzOGsfzigxs5ph4AyzHnFoR7oUWGpcY2rUNe2ySlkcyKktrV1OfTR7SMAqWaQ1E0Oprr8QSLxaZvFQf8I0jmmg/besoJ+M5iOUewXEQ4el01YaPU+WYwva6dbSq3HA+aCd0vhYHWGXiobBE8KHIx59n3BYNyGHqSPdVVvdlwxyGC3prYFejftUbiT7/4jmyDGu72I09tCpKTfAFJ3W8nUmrDwr5Vi5V3He+v2DFqg2YM5Xc8OcwYOw+50cJJ6TzfQh6Zl/Fj0HZroGt5Nr0YW1I6J/+A488hHJaDAVYkSr4nkGKwG5r6UGIoYiC9hn76IUyaG5l8664j4CUuqItzkTLP5wev7yHOmP4ekm8ppEikW76wpsy1IpS8afZF+0ACPTgI+M2+nBwSb7KcNAnhxKOinI6VOgzhHgAPmJxuIyUZN8kaZM8dMjmQK+sUDg/So5Vz+KrKibYH5oySLNBqPi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(186003)(5660300002)(6506007)(55016003)(110136005)(66946007)(478600001)(41300700001)(33656002)(122000001)(71200400001)(76116006)(8936002)(52536014)(82960400001)(83380400001)(66476007)(26005)(86362001)(9686003)(38070700005)(8676002)(2906002)(7696005)(66446008)(316002)(66556008)(64756008)(38100700002)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LMGTFJcAeWc6qoJJEH+n4LJZSMuaYad4pNG60chy6H37kG17KvfycttOzr?=
 =?iso-8859-1?Q?S4Bk9Zbxtbefsv4dcZkdtEV3GRhcJqHdZUnhz3+EbDjONS9jCvY49PKkFG?=
 =?iso-8859-1?Q?vgRiKdAfCueqmxMv1wIxZ30KVknxA6cCDPMGB1izxe1/rnXph3zCfwVSLA?=
 =?iso-8859-1?Q?AQd/HiJzVqxPXtZqVz6L4nac/JXq+aFEED3fdEUg8QrOWRV3B5MiTcZNf4?=
 =?iso-8859-1?Q?Jd9zZkLYjAIdCQh3p130SNEYXnZgZtf3j6jlWzU2TQbdg+H2rWXnhbzdhJ?=
 =?iso-8859-1?Q?yl9o+q1ZjWUAR6gk1RKLjTdp53h2M5wRBG6UdXWfCuyuIwCtP8X1vLW4SO?=
 =?iso-8859-1?Q?pZahCTyVSLEnL+3gNXK6m9tGKz0HpSzCKhg6SR4Phet1+R/eGfLta965SF?=
 =?iso-8859-1?Q?2V2RmMvoPutJcO+dXv29FDJVw04ifvaNXaoGTlVcu5R1+0b4oJc2YeAShp?=
 =?iso-8859-1?Q?Ds9nNDDWPRGVsLCIgxBYczFcDubL6/h722Y9kTsccsoaJD2ZagsuId1knb?=
 =?iso-8859-1?Q?FLnHnOo5vuJlOpUCYAbzaY4hBpm9HHudzlH29n46lK0Dg3vWW4qu2Vx8CY?=
 =?iso-8859-1?Q?9EzFOqyQboxOhRJRjqXDzsrTtiBNI8dANgNjsVNRrAFbKM3Y8mEGuqm+LN?=
 =?iso-8859-1?Q?/iaZPl05rr2BZHMnZ0isls6UFxywDOqMKalD+1gpsdLRGHkzC7W+nxCFUm?=
 =?iso-8859-1?Q?WR1+1KOnrRWxVhUjSmL+vE7+Q8FemlEAtis4hXwgkxXLjyHKChs3b2NVLI?=
 =?iso-8859-1?Q?A/tNZv/O8HxryDBf7/sBvz/NXzU56ZbrDUCC5/LoHF57FIRZEQpMwDUJIG?=
 =?iso-8859-1?Q?Ub1e06UJZJp/UzRlz9vUw+dVKEA5JsNu1FWfhpQXEFUXpaI9sWkrdJCBpc?=
 =?iso-8859-1?Q?DCI1QZ3EAyfkd9MOJdcoanuG529zuQIQElKpBl7xFvYpfouS4Wd1d9SILJ?=
 =?iso-8859-1?Q?WHPTNREstvgdMphpOmQrGnqukvGSiQ6cn0OHQCv/25nx8oBxX2wcK8PkRl?=
 =?iso-8859-1?Q?V4EpFd5Guwg/+FzhQtGInZgxIa0gkuNfeXDxRgxIZixy/JenGlpxUsaj+2?=
 =?iso-8859-1?Q?czDnGA37n7iqENnOL6qbjgdODJYifB+GprWDhBXkmJFkmg4uqwvsdFTRoD?=
 =?iso-8859-1?Q?q1/BDjJckJgk75NRshJBCpHDNbAMsxCi/KmXSm4IrnG7IUfvJxmzOfiAK+?=
 =?iso-8859-1?Q?a8dcUqgdsncWAhVy0IxI3bPqb9Yp2zBNVsR7GN7oBEML1LWq5371sz/1fV?=
 =?iso-8859-1?Q?zunGoo1VhrfMxHhBP3AzXKwQ9Z4GsDxG7IRvewSADpmkgq0rDPGXjMCTAv?=
 =?iso-8859-1?Q?92X3QUr6IFr+FBawHi6Qb/xsCqm3qe+pA0tehcElqvrX+pM3jpP88P4h97?=
 =?iso-8859-1?Q?PP25fSc7GtI58jFOVW9NyoGeATPIoQNHXexj1JS8Hm4GdWQ/SZt86cd9ZI?=
 =?iso-8859-1?Q?JChb0XDbVrS4KdYpGgdLU07joZzripK08lMlIueBaUCxRM8Xq7AQME6Fdo?=
 =?iso-8859-1?Q?qjF/jYNTftZJItAWSMt9hzXDXlHiZLMs4BXNHBzAgpqUodbs+NuRL5pb5m?=
 =?iso-8859-1?Q?e5cZ8Wm7wx4dSn8/dMZYu0ESK2JFauaVyafro6stIPA7hgaeOOWKcYT+Tu?=
 =?iso-8859-1?Q?tZs2tdyAeKxrDBwVzc5obG+44NNVrcJc+hQddqLE6xSG7lhlgsuauG6H8B?=
 =?iso-8859-1?Q?rmovqmOn6w9Q7pqckkwc2IWY34LNoP+k8UwY3N6a/4S/11yqXgAeU0fsjY?=
 =?iso-8859-1?Q?2iYa4sAobaRYfx9NRKMsWdSnxZCFVJ/w0RM+stpK3oBDQTiGzGpwMXyPTQ?=
 =?iso-8859-1?Q?/BtYWybwQA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecff812-97e2-45fc-905a-08da554b4bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 19:05:10.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oi8XMNGscRdsTyZj8vdRXpneL0jfG9cJvqzGjXp2fV7bMV4euAo5Y3QGqoJEj7wehjOkPF4vIPlLqyRsbyKf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6831
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Hey Avri,
> Thanks for the comments.
>=20
> >dont
> >^^^^
> >Don't
> My bad, will correct in v2
>=20
> >
> >
> >> FFU used to divide the fw_size by native sector size.
> >> If native sector size is 4K the accesses need to be aligned and a
> >> multiple of 4K, other than that CMD23 SET_BLOCK_COUNT does not
> change.
> >I am not sure what are you fixing, aside of violating a spec requirement=
:
> >" Downloaded firmware bundle must be DATA_SECTOR_SIZE size aligned
> (internal padding of the bundle might be required)."
> >So if the fw fluf is not sector-size aligned, you need to make it so.
>=20
> So clearly the commit message does not a good job explaining either the
> problem or the fix, so let me try again.
> First of all I only care about 4K native sector size devices here, the re=
st works
> fine, the behavior should not be changed by the patch
> for 512B sector size devices. (If you think it does, please speak up!)
> 4k native sector size device FFU is currently broken in mmc-utils.
So maybe make the title say just that, and also add a fixes tag?

> Why?
> We get some firmware of fw_size bytes, we want to tranfer it to the devic=
e.
>=20
> Let's go through the code:
> First we have an "alignment" check, which ensures multiple and sets
> sect_size accordingly.
> sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 : 4096;
> if (fw_size % sect_size) {
>         fprintf(stderr, "Firmware data size (%jd) is not aligned!\n",
> (intmax_t)fw_size);
>         goto out;
> }
> Then there is the following
>=20
> /* calculate required fw blocks for CMD25 */
> blocks =3D fw_size / sect_size;
>=20
> for native 4k device this is now the mount of 4k blocks of fw.
>=20
> The fw is now transferred in one CMD23/25 transfer:
> /* send block count */
> multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
> multi_cmd->cmds[1].arg =3D blocks;
> multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
>=20
> Here we have the problem already, it sets blocks, the fw_size / 4k as blo=
ck
> count, this is wrong, should also be fw_size / 512,
Right

> the patch addresses this.
Not quite. The patch set:
multi_cmd->cmds[1].arg =3D fw_size;
instead of:
multi_cmd->cmds[1].arg =3D (fw_size >> 9);

>=20
> Now we have the transfer, with an incorrectly set CMD23 as we will see.
> /* send image chunk */
> multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> multi_cmd->cmds[2].blksz =3D sect_size;
> multi_cmd->cmds[2].blocks =3D blocks;
> multi_cmd->cmds[2].arg =3D arg;
> multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
> multi_cmd->cmds[2].write_flag =3D 1;
> mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
>=20
> blocks*sect_size (data and fw_size size in total) is intended to be trans=
ferred,
> but CMD23 has just set it to fw_size/8 sectors.
> Furthermore I think since we are transferring everything in one chunk, bl=
ksz
> and blocks should reflect this, even though the kernel does not really ca=
re in
> that case.
Right - here it's not a bug, but I see your point.

> The patch addresses this (this part should not change actual 512B sector =
size
> behavior).
>=20
> The error is just a misunderstanding I would say that CMD23 acts in chunk=
s
> of native sector size, which is not the case, its argument just needs to =
be
> divisible by 8 in case of native 4k.
>=20
> >So if the fw fluf is not sector-size aligned, you need to make it so.
> For now the FFU will cancel for non-aligned fw_size, I did not change thi=
s
> behavior, so I'd say that is fine.
OK.

Thanks,
Avri
>=20
> Any future comments appreciated, also I will try to make the commit
> message more understandable, but if you have suggestions, go ahead.
>=20
> Regards,
> Christian
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

