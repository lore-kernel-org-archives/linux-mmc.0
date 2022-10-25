Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E8C04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 17:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiJYRZb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiJYRZa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 13:25:30 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C911808
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666718727; x=1698254727;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=xyUHK+XNpq9siL5YTqERkVdTB/uGaCNrNpkyHR3msJM=;
  b=RQt1sJF8Qk429UMq9+l856tf32mr/2VXsuTwhbaNj6R0Eq7b5kzf8Jfb
   7EWCv2E9fKGsYhJKPjhWxl/uPkT4Q+XsUOcmggUnOGfmYMth0ocnBdHTo
   8geDS9YLS7wU1pMJPWFqQm1JNEjKqdgU2sgQb6q1U3ABVNigyA2e6Kzhj
   Fakb722mYCPVaA0PwxaRnQHqBTST2U6yDPBbqo5Y53Sg7vIFnBrKhMkvH
   tzfgoNRz2yTAJDtucjZvcP7DxJaxTpDuy/ap3Jgc+vo1ZWbdJu9Z5xwvd
   zq12Uf60K5QWU+GzXBrWwfihWUl24R2zlOLhpm4j9TMG9rAOZuInu65MN
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,212,1661788800"; 
   d="scan'208";a="214707023"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 01:25:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euFpTLdElqIowmwo4aqFFHkQLiB8iIXLZ7B1eQ+6UhR60AsLRxXm1qINBdlJ3UUoXK3I5VTquuQAdAnF5dWA1ognBQEJLSciHS/r+U+9IQ7tfba+9ZLUtDVVWqZBCX7Fj6pO5D4Fjgdeavd9xyydUcoVaJ656B0dP5IK/yFdvIpvKhwMSScHjGt7Q4+luAmZtuJq9t6kHckd5f1Q5HRIDZlOgmzHT4z8/TudlqG1qtUcsSPLK4CSbQUFr2xM6RH0iBgbqfYtbVCM2EhIxETcZC/nmRWz3iyCop/htm3+fSkqidNqh3SRuxMRt8e/iA2s8kfbNvnpztn80FnagkOWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtrkXIpR5cxLXN5SdeDKTkcVppD6CVhZQOBSnTPiVYM=;
 b=AK9J1O+uOcHoJnqSMKMPe9z1fJNjEZfG5dxWNj9UpY3me199KsDFPQpf/Enz32Y7PxSovYQpqrBakydbsvfmXKodaub/opbt8A5xVWoNBATxJ70zirshAXqwG2asKmrnnSfPk5CvFGqeVBL0Bvbu8OzR3gAiYtB7aid8K1K9BJFuwzbnNWnlwwBAq2UEIEU+JcwdXE0zZPN6rYzY9Ha2iuDUVN8W4evze9ONbGVZNtTT5ZtJ1USipkzdyejXmccbPlJjTKYsk1GYkJ0Ax/3L6uXfh2aaJ0TVUVnCUzIzdh5Y0kWUy6LDbCb/4AtY1dZjgc3NzVHCKwmKUP+Z3RvqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtrkXIpR5cxLXN5SdeDKTkcVppD6CVhZQOBSnTPiVYM=;
 b=D9YzAjYe1AAC9qq3k+A3w+w6IUR8xfeqtGs052ehftotr+DANsjO5Y20GChngIZDKQSHofKimnnVSg4EUipvVMUey8YTCL1370gA6cDvMk3F/arT2xmOwsghdhaeJRn/AjYHYD6v4jGAVC6ocoOzIlUXm25Z1dTmSPpDIIICMcE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR04MB0201.namprd04.prod.outlook.com (2603:10b6:903:39::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Tue, 25 Oct 2022 17:25:22 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.025; Tue, 25 Oct 2022
 17:25:22 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Index: AdjnzoBSTaQo1pFFRXi0S56OT7wLqgAjLvCgAAfAMnAABrwyUA==
Date:   Tue, 25 Oct 2022 17:25:22 +0000
Message-ID: <DM6PR04MB65750C59F17F38ADDBEE04BCFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <d4ac7077d94743ed91c1b2b81fc5e164@hyperstone.com>
 <DM6PR04MB6575BC99A106EE2D430CA9BAFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ae6767a4abef41cd9068c467947646c9@hyperstone.com>
In-Reply-To: <ae6767a4abef41cd9068c467947646c9@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CY4PR04MB0201:EE_
x-ms-office365-filtering-correlation-id: 76a2d9b7-5a14-4071-686d-08dab6ade58c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FZyJKmvklQ+G/7Qg02sAcW9luhqkU8eHCbkZfO1DYbs2S8gBUYlR7ImnkiRsVKpEWTsv0EhugKn5tAemWsBebgwQksSSMuwvnM+PnY2A25mqL7rU2jiZmtBYSCMVTyneLInhqP4dhhL//gvK3sd0FHhu1s2MMChs63idmerIaz0j654LOIlpj0CEn5j123yWI6kgx0Y1tRE40qBVQSHXHuQ0728jgiy9zyVLwuNPY4453vXxW3uwMZSWu1ufJuZBmuuVyeMU2/spmVmDWcTghJGRF1Y+rwC74cyDsuOs0D/j3/eEpISYHOtsnI1rv23/rxO4ZWX3LSYDTvKauQO0CFeGuE20JJu37t4sVYy44hjThDvD/qMWrtiNDh1W3I6xIKsJeEvt9D3bRGDJreqQ5hzQuK3mDvOwt3XcQaa2Vlw6Llv++13/Me7wE90FW0IWb89wrbdvKACHU4ehKwQIF8YwnHwYZyk6Zs47rVGCcdFNKhf5Lm+4GbbDV2/Z9uLVkl+imm/bIv2X5PL+6WnoV5IBWRvalcmW3hRu/s9fnC/6gtHL7wIOx2N0/Yq3q+8OcbQSIa3ygdaERFE8PvQ1aoc5K6VAaFAKL6d2K9N49fFMVBhyqHBqPAb6oO7ksMD9zH83Fmjo7YIRLOIQGLfnM4DYtRrVbhmP8KcH2PLGQfxsXIhMy6boFO3exV2/t61Rg428ED4odKMrAYbo/7vHP1raDaLb/y2Dgm8PEN63yqGr7jWvlXMD5Zo9MRcduOfJyCjOGYeVQpTOyEsga5QA4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(478600001)(71200400001)(86362001)(83380400001)(66556008)(53546011)(8676002)(110136005)(66946007)(66446008)(6506007)(64756008)(26005)(7696005)(76116006)(52536014)(9686003)(8936002)(41300700001)(5660300002)(38100700002)(66574015)(122000001)(55016003)(33656002)(316002)(186003)(2906002)(66476007)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PuoQUTs/8VoeP/xMHxirfxK0nubo9S7JISZ7a6nkyfzQvMHH6QaYAaO0Va?=
 =?iso-8859-1?Q?vpcbq6BM0IfVxB+xMLKwsgi87zBhyvyxk4HT5Ag5QdianKTtJdrTvV2rfK?=
 =?iso-8859-1?Q?FBkuc2Fpr63w2mPDbh/jhdWTcvTwuU2sLxBY64GhOTJywdeAbjcQhTv2tQ?=
 =?iso-8859-1?Q?X3LMoCZDntsI2A7rjAHBVADXNWWJBKShOD6FQKrQb0PyCB0G6o7n8LZF6k?=
 =?iso-8859-1?Q?CInT1/whTbqJty0631Pf11YeYLSlJ8S70EmiRR5ZoKCgtIJvld2i7J98aZ?=
 =?iso-8859-1?Q?SIxSwtnYsl8KJjiw5srk9myX1tdZIKyXhhbNcPa+m2/kI/xovmwpYXo6Ho?=
 =?iso-8859-1?Q?HvKK+15h365/+Uc/pY4ByPLRPXlJSP0LuiIZ6iTn9hoGSOiMVm/5VToaDp?=
 =?iso-8859-1?Q?hMDfj1KU5gIdtor2XOX+v7IfaggJQF/pOtRkYzhgrZiUX/MJo0HgAP4viG?=
 =?iso-8859-1?Q?D0vnfQhySq2yD3gdYiK9FmvwZkHpgb1YUxr+U9pVQm4Rq3SQH/raks79CP?=
 =?iso-8859-1?Q?ao1++rNt6ee2SigI5uFzMLiKe2KffocpXVzEm9mmw51j2RX2VXGF4m5TBQ?=
 =?iso-8859-1?Q?DVdOuo/PG45V0i0c4IzUjlPWIsLMpf85vvOYwDsE2A8WE1/SlNne25bwNe?=
 =?iso-8859-1?Q?Se3tyZFmV+EjjaikHkvik28BxQ5HcxiVoQ26nS7Zqw6Ppz0u9HEnNo8+Lp?=
 =?iso-8859-1?Q?b/R9/xJgViErXvTwIV89z4neEuAGBCTdZ4r+farSn/htiA9+fqg6Y4w6FL?=
 =?iso-8859-1?Q?zJ3pS+Yd0D7SOXK0X/Hm39bWV9IcuUKJpUBFGnp8sy9Dt2uuA3qPEF/V7W?=
 =?iso-8859-1?Q?DuhDQ5J1kC/B64u3yhKw073v88RP/FqUFHrls3zpLf2PeAbkN03XSGeOCq?=
 =?iso-8859-1?Q?ir0Tz2doYVvA6ziVi3qcte7S0bsJiISkGbHOdMgtr4wqV3ZR1MqUnmGmjQ?=
 =?iso-8859-1?Q?JU6+xYSVEbVkGvpw7ZM8LZwbvZERtVBTmM+Qk47AinmwBXsmiGoPLv5KhQ?=
 =?iso-8859-1?Q?vGFcQERRVn7XcK5V2EOk3CicbsVRtUIZ3RQyS0yY8+86T7jMarCk3AunFY?=
 =?iso-8859-1?Q?9/B3+LQwemSyHSbVcdSOb+jvamOf/m4iyt9uvCjieDHu/QIUopzFhsBCq4?=
 =?iso-8859-1?Q?WvGNE606iQxrGIjnjAfYc6zC1b/hDc4NIKmTpTywd9TG48EiWn0nX1LZA1?=
 =?iso-8859-1?Q?Aes4SxGe5gIEZQ9DeSBJS+dGyPcRFJxZrudQduHvYYEQW2VLC+YIVAunNq?=
 =?iso-8859-1?Q?BMmpnvqqWa2/MVBS5gizhwR2UrIgOaORLp85mAD/yqCQhTYh4xgaiDzla4?=
 =?iso-8859-1?Q?6V2RtI0SRc583GMbx4Kbo9Ir4hGGgbEr5ASsFaRGuakZISFQEgTIZRwh90?=
 =?iso-8859-1?Q?6KmqcZaP/RjKQmyva5/NkRRnXao8DINQjRNcWKwW1p/MmWSYDVQ3/O/msP?=
 =?iso-8859-1?Q?x1SgW8pIILX/vrgiqtqBDunhgHlEnKX5x+sVhxndOOAoo7grGgPrOsK3b6?=
 =?iso-8859-1?Q?UmAJDxOxViE3s2Ar9wMnQpFtn/NzTMil3uoe5Y50X+04t0K5rycz1iOhzo?=
 =?iso-8859-1?Q?hA/i6s77NPRDY4cw+Iijxr3bcEdvJVdAE7lOP0XXug6d4MBnSTnKqv/Btk?=
 =?iso-8859-1?Q?3lFuw8nv6knf8xvsoRrUZ7qCf7CWHvacQo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a2d9b7-5a14-4071-686d-08dab6ade58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:25:22.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlIt4NjQUVSXZKYTNyB76mPK8slDrjkwZ4k8NQCncunLguXyALDwDaY9kDq/pB7UXbwiGsYK00snxERA4lxVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0201
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Christian L=F6hle <CLoehle@hyperstone.com>
> Sent: Tuesday, October 25, 2022 5:14 PM
> To: Avri Altman <Avri.Altman@wdc.com>; ulf.hansson@linaro.org; linux-
> mmc@vger.kernel.org
> Subject: RE: [PATCH] mmc-utils: Implement alternative boot operation
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t
> the content is safe.
>=20
>=20
> >> @@ -255,6 +255,18 @@ static struct Command commands[] =3D {
> >>           "Issues a CMD0 GO_PRE_IDLE",
> >>           NULL
> >>         },
> >> +       { do_alt_boot_op, -1,
> >> +         "boot_operation", "<boot_data_file> <boot_blocks> <device>\n=
"
> >> +         "Does the alternative boot operation and writes the
> >> + specified starting
> >> blocks of boot data into the requested file.\n\n"
> >> +         "Note some limitations\n:"
> >> +         "1. The boot operation must be configured, e.g. for legacy s=
peed:\n"
> >> +         "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk=
2\n"
> >> +         "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
> >> +         "2. The MMC must currently be running at the bus mode that
> >> + is
> >> configured for the boot operation (HS200 and HS400 not supported at
> all).\n"
> >> +         "3. Most hosts cannot do transfers of the typical size of
> >> + the boot partition,
> >> adjust <boot_blocks> accordingly.\n"
> > A redundant arg?
> > Since blksz is 512, Maybe just set it to be ext_csd[226] * 256?
>=20
> As the help above explains this will not work on most hosts.
> Limitations of maximum transfers of like 512K to a couple MB are very
> common.
> One could just read the max, but I found it less misleading that way.
But isn't the mmc_blk_ioctl_copy_from_user impose a hard MMC_IOC_MAX_BYTES =
limit?
So you won't be able to read more than 512K anyway?

>=20
> >> +       mioc->num_of_cmds =3D 2;
> >> +       mioc->cmds[0].opcode =3D MMC_GO_IDLE_STATE;
> >> +       mioc->cmds[0].arg =3D MMC_GO_PRE_IDLE_STATE_ARG;
> >> +       mioc->cmds[0].flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> >> +       mioc->cmds[0].write_flag =3D 0;
> >> +
> >> +       mioc->cmds[1].opcode =3D MMC_GO_IDLE_STATE;
> >> +       mioc->cmds[1].arg =3D MMC_BOOT_INITIATION_ARG;
> >> +       mioc->cmds[1].flags =3D MMC_RSP_NONE | MMC_CMD_ADTC;
> >> +       mioc->cmds[1].write_flag =3D 0;
> >> +       mioc->cmds[1].blksz =3D 512;
> >> +       mioc->cmds[1].blocks =3D boot_blocks;
> >> +       /* Access time of boot part differs wildly, spec mandates 1s *=
/
> >> +       mioc->cmds[1].data_timeout_ns =3D 2 * 1000 * 1000 * 1000;
> >> +       mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
> > Don't you get "010" prior to the boot content?
> > Most cards have their EXT_CSD_PART_CONFIG_ACC_ACK bit set.
> > So you need to eliminate it from the boot file?
> > But your compare show that the files are identical - how so?
>=20
> By configuring the card to not send BOOT ACK.
> With it enabled there is unfortunately no way to get the transfer through=
 from
> userspace.
> (The host will sample part of the ACK, CRC wont match and so on)
This doesn't seems to be a reasonable requirement from the average user -=20
e.g. validation & field application engineers who address eMMC issues as we=
ll,
but mostly other embedded flash protocols - ufs & others.

Thanks,
Avri=20

>=20
> I will address the rest of you comments in v2.
>=20
> Regards,
> Christian
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

