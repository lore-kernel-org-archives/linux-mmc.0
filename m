Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0096BC46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 11:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjAPLVn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjAPLVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 06:21:41 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FB31DB96
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 03:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673868100; x=1705404100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejoouuaPP++RVRLimdyziyfLpzP08WjIVCbX9Wt6VN0=;
  b=AXDCsOY3GbYWf8GfcriuyArUnxbZgGx10WUGTE6dBCc+dInbUTNCh7sO
   7ALq/UBYTVQHxKcwNjzCAaYhcnoZ2MRWaBve4FFlcu59dMb8+c9XZjX9h
   7P3WThlWHnbaJeFK1ilXUBn9vVdNgq7+dOJnAU6/+/aLtoRXqP3qt0IwI
   +zRM3MIjf9VkrzHvnVW2rqnLU5DPLactRvWn+Jkmp6d6GnuKBlkKgLCpi
   Z3Bme0D2BviAkujiZnZ8UDuPquNfpHbChHcQNQ3dZ/FhiBeZFqg+kANNV
   Pr2NILCgbtU6agPhugKoNeIiFIsU8rcyGzka7xne/i6DOlL64DWVgSj1c
   g==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="225932253"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 19:21:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx38Ox2n/xyGNKMH4b7I3Z8bSvgSnmoBsTyLlolwbkb2kR3TngScDAPp/RbU/NWKYsi1blW/ijo+QEMmYIauqw41/HnlM3+rx5ZXJLM028df4OzsE9GPNv/88/oslrntJ2tGGPzS0IED8AnmIg/isxWYdO+ZvDhKIaXXlvvA7aGAS8u+v2lFhRbNE9Ta8LNa+nhr3VIRs0ouFMJwSaCEBWW8596b204+4IntymGCQvfs32l9v0Sk3kpVWSYkYfkzoj4UTFGyIaGYaoYtM0UkWTTeGmFO5ubUDWOsqEn0m9zZjTITTp5BKFHh8seCKxmbh1L/kW0MP1ojcktvr0xqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrS8/525FSptp9UXYzZ6CgGKz/39zha90HdWYa2vw9w=;
 b=MbnOVhrF+G4j+xwY9Hntt8UR+s+7H/x+sLBIU/eN6i/qfZRHVgDejnDetzid5qWD0g26/GiVFqoNv3FOWdrceF7XkDAB7sr34E93RoTdQTUTJ6WhWrsgCdyxkTwGggKk+NkfWsyNC7EexxTXVUu3wikNLQ+HW6Z86OApbF64NsvjlkyO1MFuWXXULBAOk0HouKlvtA7TxB6bgeVGN5FHI5zwY4JutiYPwjexGWi/2mflR4MOys39uq1nKWaVXLv1VrJXnL835eLe8OKQdbbPsrGBJSUyEeMbV7JHWPnl26rcp8cpR4PoxVwXNU6YyZInC3IvbOg//FRF43Ts1iX2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrS8/525FSptp9UXYzZ6CgGKz/39zha90HdWYa2vw9w=;
 b=YwwaIfGr4f9gWwVjSLHEDbxzrhTCw3YUk9Qo0UJ2N/1TrbyFcK1igjaC1bMhkI2uITtzwHvfEfDxVw9XSYPB1LKabdPsYY0rtQFob8+0i5hyWJytRXU7/+GI8yDn6y3D1qwf81VFbD4XXqHL9j8v6twv+YNbCD/QUjfDj/VCVKw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7981.namprd04.prod.outlook.com (2603:10b6:408:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 11:21:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 11:21:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCHv3] mmc-utils: Add basic erase error check
Thread-Topic: [PATCHv3] mmc-utils: Add basic erase error check
Thread-Index: AdkpnBz4vb9STB+lRhSmAMC2A/DE0gAAHMPg
Date:   Mon, 16 Jan 2023 11:21:38 +0000
Message-ID: <DM6PR04MB65753C0B73BDAF2BCAF47A6FFCC19@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <c91cdde6288d4db6aad45f5d50d129c8@hyperstone.com>
In-Reply-To: <c91cdde6288d4db6aad45f5d50d129c8@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7981:EE_
x-ms-office365-filtering-correlation-id: 8581fb66-fec8-4096-4ebd-08daf7b3d599
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UmPUFOK6+R+USySMpEwgqVXKXlBkS3gSx4lYrjxHFADa0C1pdgOyZDDN+3WkexrAtTosCzBl/TO4Rfvb98NMeW4VVjIMtsxw6tPFnrCRL5re0+aHEtASNef/ow8tMf/S6xfZuXXS+dlZ4RWA83V0XQpRNlckWD6LunN+Pnf3UxshziRVir7QFKAapS+8a9I8c0SfEL7aJSB8X3wv6keR8y3TfRcL23rHoLNI3x7Qn6aNtP+URUKOGCGhqzcWR3vtNcpxQrtHV24IRUmLSOCPaJzPn9nY1bQ4hN/nRGflQIs5+9lej+b7LoAzr/EgMS1DKYbYlgokHokVDuqjK5eQc2XwI1rE/vlmFT4M0WnkzBB3rRQzI5Gvxuen2LFtRVxAkYGPIK6eO586yN35tDQ6OI2xKdjmaS4RhQuuFv04dQ0QVjZN9Payuz3TUUkxdAvGwgwALsBfaGjOvJO0b75/Kyglu7lB0WwIIeWeUVqmgNikhllh3l0eH6SxeDmYeAp4DXmIb+t2FNQnGWDnftFJ5NwWHdMrMNLqT7viEu6QErfKQHlZThhdn3boS90MCihBFvTImnQoDSOTHAth9DJUiA9LOY+XbCc6g36seDGKb7zgr76riQOPYYHZRm6Zx5pF28Oj0ITSS+pU1cxByxhp8SjbyQPisgkwD9/Rvskc4HHXcw19i1gV/bN6QvMyF0ZwkPv8nLaGFbrqROOc1GNC7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(86362001)(33656002)(9686003)(26005)(4326008)(64756008)(8676002)(66556008)(66946007)(76116006)(41300700001)(186003)(66446008)(66476007)(316002)(83380400001)(71200400001)(6506007)(55016003)(110136005)(7696005)(478600001)(38100700002)(122000001)(2906002)(38070700005)(82960400001)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BUSAyJNjQMYHuYPTh4i9X+Nwb6M7ktJI1Xk11HqBbfcWZuYuyrJMi29e7k?=
 =?iso-8859-1?Q?1gYcJlUN05ze/bMFQUWNdQk1zQAuO5ZCRitGu91T9ZWTL4OyDqxrPDn4/5?=
 =?iso-8859-1?Q?fEAV8eCQCseqegyFOQsBRaiTE98q+EKZbM/LLrL1pal1gB22CNj6yUJTn3?=
 =?iso-8859-1?Q?xj0KGMaGRteumYZG75BP3Y30KA1Aqg/gsXxboWH0srgX3p8Ex/JU3ziR4I?=
 =?iso-8859-1?Q?TtRMRvT+g0pR27yVqQQ2DHt9QfujggTbnvrfUdY7JxAz8O7OLjuJruo2ay?=
 =?iso-8859-1?Q?mxIr7+ehabTi7jHVQrv27qO37W5MaXdhqe/jSIjO9gcgbr6xV5/RuWHaMb?=
 =?iso-8859-1?Q?//h5+eNn4Ev+/A0kTRdwqtx7TLVN8hhKpvny21ry2ju14YVBvc4YtIb962?=
 =?iso-8859-1?Q?yJ9l8U+I/jD7ZUQtNSo0Ep53XqoERIVHe5wht1BicYEMPC4DFJgFmbKKmi?=
 =?iso-8859-1?Q?ZHP2SXzqIRBwpDHPpQL0vLPIuLDBe/5GghDLvuvawsf39JaKKBLE45oR7o?=
 =?iso-8859-1?Q?Fq0FMBlBTWHQaA8ACgoWbRc/Po0s4SojkBOy9Pvb+csZMRyvMwot3zqLSn?=
 =?iso-8859-1?Q?OagS0VS4IPADZJKO4EMw349srWbOhC295Pu80oCDG13DlPWk0VfOfl54kL?=
 =?iso-8859-1?Q?RIxJEd1WyPLyeJB3tgK3Q/a7OJXaP/D9H406ViL8aaiL9ifgJjOKQ0eA0N?=
 =?iso-8859-1?Q?r6qMW+eaF1qc/ShY762N1nso5Zae31Vca10kOM+wr9j6AA3Ct+5iIvtz8b?=
 =?iso-8859-1?Q?44wEy0kyLCCx8k8CYE6/k4J+5LQOm4PmCBWsOvci5Cjd2Fk3Lweav/nJX8?=
 =?iso-8859-1?Q?DH50suBauLTWyBJqjokNjegJtFxkZHwgv5/6N7jbTd+y88G0no/HENW64V?=
 =?iso-8859-1?Q?uOuMuRAJRjRraw5N1aBD7c38XclrNUw+9vZZgtUz89WjwxCZCNAtcQGG8m?=
 =?iso-8859-1?Q?o5eQkyH5gXFQf6bQk7xEeE6lYoEjnmpLcTre92aWK382IR0wbVct07phP3?=
 =?iso-8859-1?Q?DoJ3hTBmTu7kcDSnnVD2Ml27JjPVxD9NyXOsQQXHddCG35xtgUWzmxV+Vv?=
 =?iso-8859-1?Q?mqqfn37vrxqe29lOMNTMo203EBdmij0DXiGq+S6ZcfmZNQTy9EWAf5MX8M?=
 =?iso-8859-1?Q?o/mwXMSIHK7zv6X7HYrNyrHNFPjQD2H7B/ULEsj1V/lIvWXHYqd8LZ9Poq?=
 =?iso-8859-1?Q?wJWXk8yJNhmenK084ntiGtjWMZtK613ILstN7PHZVZjklZyNbGnr5bweJH?=
 =?iso-8859-1?Q?wWU/oOsPv7CSRIrNicZNtG/dqSF0Fbm958WwT4zTLX7SM0z8guBBjzxn3N?=
 =?iso-8859-1?Q?D6S1obxvI/fEeYnbFZaJJ1hAUkp3X+UO1CUyqOrWY6Ip0MCU5s61Tx1jhI?=
 =?iso-8859-1?Q?mu/NfOSd0GnYrlFnQj06MfYyfdk6yGitYYDWcWwIZ9uk5ZGx46oskIrYuC?=
 =?iso-8859-1?Q?fxmfCkD1yGZv+mbFnyI8nh2c0w0f5ma5jRZqnWdWaIqgGcDR4MisdoR83C?=
 =?iso-8859-1?Q?E19344GXiULNRzSVZ0nwC3d+dOLWMsd8flkewGT1lVjHB/MJm5apzm1MAY?=
 =?iso-8859-1?Q?hCPJXhPU+CPSxdojaikEIJ9QPZdvH9/ddcngNbmSy37GtKMhos4UzL/DMN?=
 =?iso-8859-1?Q?egr5AaX4XBZE3BB6X7l43u58m4EzPut6j7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ylAXj3FQo/H+d043/E4z3CxkyoHSahl0vAzPltBZhNnx4v721xUrXAJaGoLVIQ8Eh2BEOEgPsQjtlIEpa0FSD0kXe1s9PFfuLDGIyMXO9XJF8kmJ0Dh9+TBePcRlHEDRwFs37ZMsPCelIihHUUlwnH0O1C8g4D1/KUFFr1vWVVV1rNQnE3sKBPcxWdnonHGY2n/cSI4VlJt6GjA0Xu3C2dVS9e7NYkveXwQaIlBGWdKiX5bzFCZPtrjObDm0THt6lUXoTuiILPPAEtpaoDYLKWvhLNtyRqlKrGUe8fVymywBJ+0Jk/zgQpOle0Hexf2LcnZ/fRNoBHb8J0/CenFYbT8avWHusMYcSlHUvzRpqcVrNVpbh3x6dKx/VQO/g3gU5knUdOAHA0yhxUMURb1mJkDVMMQfTaT7qsbvQiSVpv5MjDyhJ04UuVObK8fHF5jqfotafZ2S9sEWsmHj19fSMOzat0m+LyBkTXVFJj/oAqy2EVS5RhPSpIAOngKb3YdmGiCEJpOzJdJenGphimAF/Fg2azXiHyZVYUBciSiy7E5Uxuoa8xDQmInVa0oZGiw59885n23M6Bvp1NBjMr9isilH6EM7f6YtzoKV0v0cG5xJQPQqnXkl1INSaUsm/tIZGOdDmuNhwVES9kW1xrjBPNY+HwwfVlpbCedwwXQSL791RVonAEVNHLvrLuHBsb9kjUuQ3pI0oQxp96TXFBE/OTMrOpBAtdJ0u5BfYKmIzpsWV9X87pSm9Sm3XHFBJY/TbTWJT8ioBFwjZ5UodPL069FwDdgVl2/nERJsXN2aIClAXvlSyLtPckHIYVGOcFuaF37R4iSb77f8iu4C4q5YNivI3ygztfyu0PTCUubYAPQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8581fb66-fec8-4096-4ebd-08daf7b3d599
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 11:21:38.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAYfQLtxPktVa0oRy1suiTjxPEx8be0JUHlm5gd8FjCp1PNqzpNFpUUstF8tLJgUvJo/4cYIOlOOj3lOBqpJFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7981
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Check for erase specific R1 errors so e.g. an OOR erase is not reported a=
s
> successful when it never executed.
>=20
> There could be checks for more error bits but R1_ERASE_SEQ_ERROR on
> CMD38 should catch all that are reported by hardware anyway.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> -v3: Check for ERASE_PARAM on CMD36
> -v2: Remove unneeded error bit checking
>  mmc_cmds.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index e6d3273..6c50bbe 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -54,7 +54,6 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> -
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret =3D 0;
> @@ -2668,6 +2667,18 @@ static int erase(int dev_fd, __u32 argin, __u32 st=
art,
> __u32 end)
>         if (ret)
>                 perror("Erase multi-cmd ioctl");
>=20
> +       /* Does not work for SPI cards */
> +       if (multi_cmd->cmds[1].response[0] & R1_ERASE_PARAM) {
> +               fprintf(stderr, "Erase start response: 0x%08x\n",
> +                               multi_cmd->cmds[0].response[0]);
> +               ret =3D -EIO;
> +       }
> +       if (multi_cmd->cmds[2].response[0] & R1_ERASE_SEQ_ERROR) {
> +               fprintf(stderr, "Erase response: 0x%08x\n",
> +                               multi_cmd->cmds[2].response[0]);
> +               ret =3D -EIO;
> +       }
> +
>         free(multi_cmd);
>         return ret;
>  }
> --
> 2.37.3
>=20
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

