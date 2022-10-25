Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC3C38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 19:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiJYTQH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiJYTQB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 15:16:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB7814EC
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666725344; x=1698261344;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Qh6qrxKm/P+5cEeWfN2YbaPt7+f/rsy7jnhgEySUklc=;
  b=B19NGF+zqcNtSLsOHpus3f5YSkhpsMe5B2NojI12QpBLbWeMtFSxZqq/
   1WmglYBUGE8iJNZ7ak8jAYAZUGJGzlnyjZ1yMvuprModbnEHlskmiDZYx
   YqgLiUc74nzzjXHE3kT/1ZtuTu/x8QwD84Mpl71NKqxGTXLDgBwJZ5cHv
   Xu6qBX8Xx6SutrRn9F53o5CVDuWGby5Bge0nmLQnMLxviQAlVMEzGkT1D
   U+9EWNjNac1x9DAqkJg4G2Q49iikUr4JpfDoEMJXjoxgw1UmT8YlEFwns
   u07JgbXCAS6aaXgQLuWkTvcYDLLbZ8vaX5bME6krxMCqxJaVRN/uq2TrQ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,212,1661788800"; 
   d="scan'208";a="213022025"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 03:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAzLoF2zmTFAmu8UpZkXiGFWJ5Evx8M1ba+7+e3MIUeFb8hq+gUvodOgwXIkq5cZmTbtQYWCFO0b149wr2gu1fCfz/zR+LbQnbcodVWw6tQiayrZzVERw9jewXLIE5vJ4ElNGGTXcXkk38yMsQ63uClzFnXQATEkABqI5BZGcVAE+x8Av1vqYpME1GzpLguDo70y7o1ByepSnBWZmsC77qG3BQe7zY8spXa/EgBCCHiaHqEqZjlmmZSk1p2afYcKyJCBA9xiBfonY7kpH/eUoCCtKer5U9dGBJUCueM+wa8B9MAARkgun1ux5bS7pwlR/6IfX8Xp5xSasc0c4muSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k47TzOmEYz4RHIKkqrXZCDujhr8b+kI4ol6CqGKTs48=;
 b=L5ozX6iLWTNlmGyLcX9A2fRpB7Zeb6Kosp9W1EGn4BWUcCp161oDVx7U4v3rkq6doKsXRXhDXvXCgLECa//QhvcMEYOzUs4W/t5xlaEUHIg5fadK1TwpqQD861CW277V+nCm+sNHW22+iyyFYkl1rsSaWSqRzt4bh9J/yXIwhH6WZWb3b+cIh90bbJ0L1P8cnm8tkuUY72vkAIMCtrDZ5QrxucWgYMizKNBGgbvBonuoOHMbxZGl4h4tIUnOY4rHOypvB38MqYRuyEc17xiRuszPnBU+l3Tbp6u6z4wKg/RBmRJVNoUCdEUXnpJ4qOwZrpuADPZwjA86zulclf62Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k47TzOmEYz4RHIKkqrXZCDujhr8b+kI4ol6CqGKTs48=;
 b=KaV6vtc20MZBtXUx2/5wToNRuSXkWW6sMG5c97bkbxqVCqlkJmVsfFAhJL99PbagWiZozEwoZw+Ry0Lkr603Co5L5rsLwZGf/I8kYMM2tO5MGNobbZFlbEbfoeXRRrb5clXLGa+dWdLmyr9VC3Lt+OhCfpQFQrISKyzOFw7c8ko=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB4629.namprd04.prod.outlook.com (2603:10b6:a03:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 19:15:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5746.025; Tue, 25 Oct 2022
 19:15:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCH] mmc-utils: Implement alternative boot operation
Thread-Index: AdjnzoBSTaQo1pFFRXi0S56OT7wLqgAjLvCgAAfAMnAABrwyUAAAfFQwAAO2L5A=
Date:   Tue, 25 Oct 2022 19:15:38 +0000
Message-ID: <DM6PR04MB6575E8A0128E2A6C0466F8DBFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <d4ac7077d94743ed91c1b2b81fc5e164@hyperstone.com>
 <DM6PR04MB6575BC99A106EE2D430CA9BAFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ae6767a4abef41cd9068c467947646c9@hyperstone.com>
 <DM6PR04MB65750C59F17F38ADDBEE04BCFC319@DM6PR04MB6575.namprd04.prod.outlook.com>
 <64e67da72db8434390b0af6843d22594@hyperstone.com>
In-Reply-To: <64e67da72db8434390b0af6843d22594@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB4629:EE_
x-ms-office365-filtering-correlation-id: f1781321-7de9-4168-c79f-08dab6bd4cef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/uDG5AUVHRFVB8l8VOi9v3a6xuPIl/o7fldcUmVHARrLVe44Y/W5S8BYWeJ4Dn8lM3RmOtFVDS/S3AqX1peryuqLq5tdmNocc6Dusdh50V45gFY2exMtvNK2NXplLji9PgyjiAP0gWaFe5NxhJpzCY5FOAjZm3o3+RFDSTU2wERCCE6eJRTDxtvVEbCrCGRMk8voNWFBxuji7fMOfpoy4yxLG9BNCS+rGvvL8gH60myZbTUc8wBXOzNqcohJSlF9kEbn97dBKn0ZrBndKmUl6eOSDsQGR7sFWWn8HKiO3I6tu2RknudnvQuMDDEnuRZKDcfW2TEiT54JSUz2V2sLRAaoBUySaRaCRAgLQOfUDBpOAooSuoQsZL4r4sAdiHHoUnEZ0JX7wYZv5463kXVgU1wvUvBg41RyPVyeAUKiwSfSLBDq4eivqDVttPJQPusQnTxcViHsBu87nmVnVkRQJZRh0FZ/ys3V9/Ah+7tdx5GY0TRmfv1Zm1SIk36LBZ8IeiFvyUUKYLqbuPi8/lXGNFaKP3W05CxEw8c1ZQQCE1lo19c1ZVJBGMN7Num66P0SdHIQ9AUY3gUSpuKZvuMQgIEYjVDsJDFt0+LzZ1CsifdpZwkvaTWXUwqiHak8fqwVm2FmtkpwfRU59mrRcUe9PYOjGjwzGxbghyF3qoxRBLmBs1WaDiYeZOCPrCP4lrrcVL/N3vCV5bKzT89fAH9TAXEWF9X0mxkPCxjsT9wSh67LWogtE4IySY5gYosg/Uq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(2906002)(38100700002)(82960400001)(5660300002)(55016003)(122000001)(52536014)(83380400001)(41300700001)(8936002)(110136005)(186003)(478600001)(38070700005)(66556008)(76116006)(64756008)(7696005)(66446008)(66476007)(26005)(9686003)(33656002)(6506007)(86362001)(66946007)(8676002)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mqicTcagem4lYxSb183tpCOjoteHRZcpOkl0BPLqXOGOKHMedjpXPtCAeo?=
 =?iso-8859-1?Q?lmONr0pCK6TEjuIPyezkgrlSvSeCitjY2u6bDisbsa/ZiAqQTjXctmFp0s?=
 =?iso-8859-1?Q?TQwtEnNo/MQPkx5UPIF8Y8a3/V+8WiBbbrldN9SswWXQtxXB1DnKDiP2ti?=
 =?iso-8859-1?Q?pibXEgzaiibar20ofOxP777pTrrohlEA+Dx6zO1oJewu+VkDvsD7AvZIep?=
 =?iso-8859-1?Q?g29Nva/oljP9JaODtSooLlhLdNR+KuIIPGb9DSjVgrjiEUlu0zywkEbnm/?=
 =?iso-8859-1?Q?3LQqqLMkgtVhoRQyipiQPBDxXnngaXWe+WcK1OEZufdVhmvXNY21nTy/5g?=
 =?iso-8859-1?Q?KQ4g/KIyHHMzaaf8EjvbFXfol7NerV5YQqh3eJllwnMPakqTa42R7VcU8+?=
 =?iso-8859-1?Q?zmvV14Y7lrkde1GZ7SUevOXyna6rVtiMKipTwXl4ureAj0Icdjqh6dvh7t?=
 =?iso-8859-1?Q?Y2Smn+L0rfSSdlmc2G9ERQP9FtUS8HpT6jVArgdk+/GHe7Bwd3OSklReq3?=
 =?iso-8859-1?Q?zmuvunpsav6N62dRW11IaCdclKU/L3KP8r21KDlq74pTENkQCqRTNpqAtd?=
 =?iso-8859-1?Q?iUtxV5j/zaBW1SwKcwjPJ8vxOX9KN2B53wtwtDWaKTkcNEKpr3mnjVtKZu?=
 =?iso-8859-1?Q?Zxfh5xovLZbxa6gTbPMuL12gRBEAYRm6w4m6LgsrByrPRywOlnUmHF0jB8?=
 =?iso-8859-1?Q?QMmrSBiDRCJejEw48hGUWqrO8W6r0wxYz/EN3StGOtuwdzA/v31ezdXfPd?=
 =?iso-8859-1?Q?uYe+sMIt2tVDQcSHdH+THbRmxZj1s/t+HreT70B3A1ZutfxC91TWZFMmez?=
 =?iso-8859-1?Q?2Kb04WYeGz+4h5m1QQxgaOLFtKzjetBM7CcH0hESlrrjjJf8Z5aR0fXtsN?=
 =?iso-8859-1?Q?TXwTigIvEuyRimjOi0ISXkD8NfThi5EUMQYEh0lsh7urPW6bd9xyEouJlg?=
 =?iso-8859-1?Q?vkRalRSoUvhrjHxf874lHc8zeBu+jspZv+2BfHkRcQTrhWfj/leebG2Y3s?=
 =?iso-8859-1?Q?P1ng7I1XHINYRrlXUnJApkLxEdEHc7F/Zg+mjtwSA6ls5/gGG/NQGg6tdt?=
 =?iso-8859-1?Q?kvIg2Qo0PoUJyrokcNR99O17rz1N3lAvJ41UW2TGPOhWdEt/hLNvIdNzlX?=
 =?iso-8859-1?Q?jPRpHK8VoBYgGjcomYDwuTufxiqB8uxsTDOmBNMs7WGCuVVmH1BA65yvbZ?=
 =?iso-8859-1?Q?/1H7W81iKMrhNk85RRni0US0LaMlIq8ILdHve+v0r4fAVslqzJ3QbvMQ2H?=
 =?iso-8859-1?Q?rW3Lbwy7oBe2jQfYwsZCiIH/ggoz21bhfhqPP8VCL4pZ+qG6sIkTvhh4pf?=
 =?iso-8859-1?Q?w3PO0Xo7cL0O6VnD1RXtUpXJHAxhGl8+M3C5+vAEIOIVKD/z8czPjWe/mu?=
 =?iso-8859-1?Q?4THRUIriOS16mstsfmPPgc012AqkU7E4zWlJh1sOMEoZiu7KzN6q/Jmj/F?=
 =?iso-8859-1?Q?qZ40i9gNq3ayApRPlkNI+QITvi8oQby7Yyp0D78I0MsQ8qwTqW0h2aroN8?=
 =?iso-8859-1?Q?lHWm6gSObJY+2ssABl1AWDXO4dWWlIo1bf8blrVkHujoEtj2xy9FeW845F?=
 =?iso-8859-1?Q?vYPE4j6FdoiomqV8xjcvxMZ9Z6zyqmRs+1qGpELuC+6QvMMAwpZuSeAB5m?=
 =?iso-8859-1?Q?ka6WqJF/W7d8nb1GDH8tOxlCNpswBvqGiV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1781321-7de9-4168-c79f-08dab6bd4cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 19:15:38.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LM1EOjz2bu8FyjhdMZTnEUzl75VO2JendM2pFsV/8MZnLkrmxQyX7FDDxSIF0ur8o3UNlrrr8GuewM0NWj/xJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4629
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> >> > Don't you get "010" prior to the boot content?
> >> > Most cards have their EXT_CSD_PART_CONFIG_ACC_ACK bit set.
> >> > So you need to eliminate it from the boot file?
> >> > But your compare show that the files are identical - how so?
> >>
> >> By configuring the card to not send BOOT ACK.
> >> With it enabled there is unfortunately no way to get the transfer
> >> through from userspace.
> >> (The host will sample part of the ACK, CRC wont match and so on)
> > This doesn't seems to be a reasonable requirement from the average user=
 -
> e.g. validation & field application engineers who address eMMC issues as =
well,
> but mostly other embedded flash protocols - ufs & others.
>=20
> Is it? I mean usually they configure the boot partition, too and mmc-util=
s gives
> them all they need with:
> e.g. mmc-utils bootpart enable 1 0 /dev/mmcblkX But yeah, if this is too =
much
> of a limitation to be considered useful then this patch is not worth purs=
uing as
> pretending the boot operation is a normal block transfer for ioctl and th=
e host
> driver only works with boot ack off.
> Anything with boot ack on cannot be done from userspace and not even host=
-
> controller-agnostic, i.e. would need its own host_ops call, which is a bi=
t overkill
> for testing / debugging purposes I'd say.
OK.
How about test that EXT_CSD_PART_CONFIG_ACC_ACK is not set,
And bail out if it does?

Thanks,
Avri

>=20
> Regards,
> Christian
>=20
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

