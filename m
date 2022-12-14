Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B45C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Dec 2022 08:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiLNIRr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Dec 2022 03:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiLNIQp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2022 03:16:45 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079260C8
        for <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2022 00:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671005781; x=1702541781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rMpR+7LOjQYgPVuDt6x7nLv4XyY1fji9RFw/byLmYwE=;
  b=QjNeO0aLb/nlfHJ+VWMZ8ryUVRyW8pr5DLUPBr65SaWd+fdQyhQS28qV
   QRVCrKa+bqe0bW/6Z2VgPA6dl9qQkeoDx9dkeno1aiT3N3IumiJRdP4fn
   3nOle/cHv2UC7belQ3PWeGcPpGIiW45pZcim/ZkOUXOipJpR//opf8w43
   9JJ/kfzEgv8gimnUKxfUZrX/1KNYfzBx650jN9jN6GFiuNlOlLkdRfBWw
   IGPU3aah0IbBbkSGjKZnQdrjcJXsndKfq+KLOS530163gcms2N90Q08Ew
   eNG8RC/eCcKKLCb+y23/Lfv5m40c36W40cKnFETvYNjtOE+nrmU8+DOcg
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,243,1665417600"; 
   d="scan'208";a="322978473"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 16:16:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crXAQFmBL5a7Sy6gwml7vvQpIKKrIZh6oWIEAulB0xVPBm5+yqShXBnNx4+epi/lpkdtpyotVQaZSiaFrSltFwIvugZT/k8CbRG6i7sH/Iz+cLAQs0dm4L0PscatyThW7Uye2kR1r2A347rA5Lkc+CVMAH8Ye4JRAsu+7cJcOjKINNPDNdHnRPiL2sxSZaB+mAEXkRtexfMYzaCRngwb1s0UahFqwymIE0yjTsEu0LFmrVbcoH8rMvpM/woTtt4fdlnEQXU+agBDVGRQDzLpYDnXXDoK8W73wUQlndNhFfo1UBt9O3iJDU5vNTZWUW8BaACTFqXQ4SV8fdLms3u6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGIDnnjgf366SanAhVUHEtegfv9cGzgqrKM8ntVYwo8=;
 b=XLgJvJjx1uZXBh+zza0NhO44ZkqNOQpAqaWpJGufIu/u1XJXk8YuEZRC9xNoSv73kunqgfoNpLGXPur5+K0DFYKmcFR13X0QVVYq5Qy49jfBgAAU/aUMPNr5hfybyjzt75zvmBH60cKsjiWO+zstSqUz+0N0BHDyfiBk82xU21PhE/JdxrgPxF0MJsBq/yuKamQo01x0KNZdb9eplP9eFAOESpz+fB3nnANGClq3Si5NMHShODxvdlfj/6nk0ZJtzbWL2+7+t2AWFnrmILrdiZ5PYL6kV8xgD2J9/oqUhYPbDGdzZ0gugJueqpWRAPI7NTHE3hH9/M/qCfA7ql5Sig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGIDnnjgf366SanAhVUHEtegfv9cGzgqrKM8ntVYwo8=;
 b=jrE9CRG3LtzxOANBVoHmI3ea1zCJUe2k/+2z/Aykz1ryPHbNT+tWHjuQdZnXa8YuhP4PLYpIFDNvpYRKPsTFa4DrmOZbnk6vKzXLxo2uUzre2OFSfBLmqPSi29/MYaWj5H+kejGkdZ8ZY/g6TQa2KCrjqkjNmW2OzpbznXT7hJM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB0517.namprd04.prod.outlook.com (2603:10b6:404:96::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 08:15:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 08:15:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIAAxzoEAAAK4ktAAIxua4A==
Date:   Wed, 14 Dec 2022 08:15:31 +0000
Message-ID: <DM6PR04MB6575450E246DBB0880A818ECFCE09@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
 <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
 <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
 <256e7a78852041ffbea965e3e3a71863@hyperstone.com>
In-Reply-To: <256e7a78852041ffbea965e3e3a71863@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN6PR04MB0517:EE_
x-ms-office365-filtering-correlation-id: 4728fbdb-b860-41f6-76be-08daddab5e1e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDxmk9L9QtmAO2BHGmEe4xdNSmlJrq8I7oDJ4Hg3LMvgUmpVhtg4GDJUVZ/RSfSw3U9wgnbEmEdlVUz94g0Nz/YmJ6dWzb4olUKiet0QrFMIR5XwXEsMzkwmZgOvG6Xq9g2uNpFa1nzvh9eUZYG15GamK/T0oc+m7/ytSsW9pmHL/V6KsPEAtXD0knTjx/sKt5dMbW/lBIv9LDgNjFrHgYFPn2R6VzKwVQ8CSaX+/EBn9I/4qijqtofdBP/R3GPlWtzX6fQEh5xHvLPyVgtRoCeoc9F7IuRixkple0LmVpwcS+l+ZyrU2yAejpVR/ChdOAO6oHBA/LSG3/yNtecKUVCi1ZK29rrqeYErwHDOmgEwvJHgGvHmB2sdzUMs8iaA0HkMOSK91w5fNwds7D04fm0IfMRlUgHjkI1Yf1w506trzKKW2dG2hiuCnQai5ff/ziQVMQzjZBs6fsY5DsjGYUJm/s+bdp7ia7cwzLaVWQIfm6fdLMZfH7tXKAD4m0NMwuYO7uEuUEFOzYS36JL8qET0ds6fBPNew+gm0IW4LPmwjhnDEuUAfuNSrVW4MCm1Dxc+WYHsXyUoGU9iBNvuP0JzBvWmBzq5rokpR9xR1BTPoFQ4z7I0O8eBOxJjX4kJUBzQ6aTQy7odBM2M1vDN+Arq5AYKg5t0GTYS0wLO4CRGNpsQwqII86SRXyjA9GDlTt+LLw/pLXzl7ZKx6Kn87w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(86362001)(478600001)(66899015)(7696005)(38100700002)(9686003)(71200400001)(6506007)(53546011)(26005)(186003)(122000001)(82960400001)(8936002)(2906002)(41300700001)(66574015)(54906003)(6916009)(52536014)(83380400001)(316002)(38070700005)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(4326008)(8676002)(33656002)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GRcKUpuO6VlhpFqZSsod7Nj7wVDiKFxyPTLxIZ32M2yJppeWQhb+/gHFir?=
 =?iso-8859-1?Q?5ku9BXeur7ujlB6me7hZ8/CR7Hh7KCJEDTBEQI1JQaDxEw5rCAip8HMwQJ?=
 =?iso-8859-1?Q?9BlXyx0eAXQYY/wiskYVVxDHpEyvLZuJaERza+ZZYh74XmmLfZDpkvdTdY?=
 =?iso-8859-1?Q?vaFUAXaZoVceWk0WdPNvRbhgSW1Vr3g3JYbIl+enB1QVebie4GVXsvnhMg?=
 =?iso-8859-1?Q?ME4rfZ1Ht8QJKrcY49Qpb7hNv1dkc6yCNMCA2mMv96cLpQpcb2FQ1zjkcM?=
 =?iso-8859-1?Q?HjRtjXI6+7YRqOHikK75jum4DrQ6SEooPjmVa7AFwI4Qx76TtyCRKENzl1?=
 =?iso-8859-1?Q?0BkMkDP5ThC2djrgWAXOs8jqnYUdqFBXcFaeV5/1R99hlBC78i7qIt5pbO?=
 =?iso-8859-1?Q?w0Pm9VKUPiX3Sv5NpnEL3rCQvskQMhcSas4d+/1WiBPppdRtQt2fsbVRxH?=
 =?iso-8859-1?Q?gYN/awawixydkIv0fl1M/aavNA1YsQkQvzGjm0dvxPvMfurD2DBdlOvWqg?=
 =?iso-8859-1?Q?jYyf535HWzDmK5/NltIjI3XyehDRmfGjvIyB45kx08Lbeu8KGbpsO3l6Qv?=
 =?iso-8859-1?Q?1Y6DlcsSawVnjwh9GEDOXrHrBS82UuNlOF5NE64FbNz33CfzdwRFh2Q2YA?=
 =?iso-8859-1?Q?i8feym9HO1NY8o5nK4DigDFVf0MrnanZKwa7dIN2hI6+jcio1nNUU7Mpum?=
 =?iso-8859-1?Q?T8QsTmmta2TFPhHztc957uA/rtxs0GTrwhXuTFwwKE+l7+GmKWJ46enC/M?=
 =?iso-8859-1?Q?kMuA/jgU8IG1rYmlSGYLS3FIuBAO/X+nGOaDzclFHQqcyew7/zTaFT2/m0?=
 =?iso-8859-1?Q?8MgVx+kmUSp4PZNx1TsahRD0AMcHMHzN7fnWuM9MF7uEV2jajZ8FS4yTAD?=
 =?iso-8859-1?Q?4MWK09UphDyWoS1dwnYP/YzzFnsKRBZSno88PE7JVcpnQ9jjAvRW4g85CM?=
 =?iso-8859-1?Q?44o2yym2/1Rh6AdAIgyU21Z84ml5yUcuaQkiOD+tIn/EsvCGV7i/Tdrg/7?=
 =?iso-8859-1?Q?O9PRIivsUIUJbko9MLRmZsAJ8OFtBejP3RTQ0OFBujNt3Nsnr2JiSQy+3R?=
 =?iso-8859-1?Q?hTzJdJV8rcEHjZikDqyrH5vj/1wXJXfgeWp8kSrctPbzKZtR0mBSxvNSGD?=
 =?iso-8859-1?Q?HK3WhA9C6Vi02O/dy7oWnjECIRsRS5FYL9VFcOGsufUcgUSG1dImi3bU9F?=
 =?iso-8859-1?Q?iiPGMtAxu1FFbdLGqgncY2sR/gYf1tGrT8CKI3eZNGZuKJWTGSV/y1du/i?=
 =?iso-8859-1?Q?EX1+PIFurOFr6xB4lk/LjUF5m80IzAk4UD5kOBF0i/bxMdfx3mTWzYQkaJ?=
 =?iso-8859-1?Q?TQb/oVZYwddq0IMcqkkvX+DwRYh9zW0hQsCfQED047vTeCG9AvO4hO/UsV?=
 =?iso-8859-1?Q?EnfmKr0sERAWQvrkXPIRoXIbieVu0/O/8+Qkbl0y0Ut+ICeyal1hSHFhj4?=
 =?iso-8859-1?Q?x0s/N35S3DNSfbc6RsLP2XugOURhGpc4A38r+vGkOp2nLto9igzrZ333ED?=
 =?iso-8859-1?Q?iQx4YLMKjUt1O9bQQuhS8jzL33L7fE0qrqZ3LHQ/h1ttjVxDZBA2LICS9E?=
 =?iso-8859-1?Q?PpKqf0evYbFd/nEP01fZgllW2jJV1Zyf95kPqYyh4W5Aqx5xdiY+rp9dPn?=
 =?iso-8859-1?Q?5wFwLZZsqdKqYtBkuEyH0LnDOvVDgzWFt3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4728fbdb-b860-41f6-76be-08daddab5e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 08:15:31.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q43yzU8nRME7lTXjrlFBeTCwvcAgPcwqzsQpDaXSnwwm4x3qos2WR0JQmAB0hVV2OY5iCsl3L7YJiG+QoZ0J+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0517
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Christian L=F6hle <CLoehle@hyperstone.com>
> Sent: Tuesday, December 13, 2022 5:26 PM
> To: Avri Altman <Avri.Altman@wdc.com>
> Cc: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org
> Subject: RE: [PATCH] mmc-utils: Add basic erase error check
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t
> the content is safe.
>=20
>=20
> >> > For SD a CMD13 after CMD38 is required, too.
> >> > I guess I can add that.
> >>
> >> Just realized that sending CMD13 is not sufficient as the kernel will
> >> poll because of R1B and clear the error flag.
> >> Anyway I have this kernel patch for a write flag bit that aggregates
> >> errors during polling until card is in TRAN again.
> >> I will send it then, since I don't think there is a good way of
> >> solving this for SD in mmc-utils, please consider this patch on its ow=
n.
> > Leaving SD aside for now - I Still wasn't able to get an expert opinion=
 -
> holiday season etc.
Got it now.
Although table 70 seems simple and definitive - Apparently I misinterpret i=
t.
Sorry about that.
=20
> > While waiting however, looking in Table 70 - Device Status field/comman=
d -
> cross reference, I can see that :
> > - ERASE_RESET - is not reported for any of cmd35, cmd36, and cmd38
> > - ERASE_PARAM - is 'X' for cmd35 only
> > - ERASE_SEQ_ ERROR - is 'R' for cmd35 and cmd36
> >
> > So potentially only ERASE_SEQ_ ERROR may reside in those commands
> responses.
> > But mmc-utils uses multi-ioctl for that, so there couldn't be any mis-
> ordering?
> > Which error bits you see in which command responses?
> >
> > Thanks,
> > Avri
>=20
> Hey Avri,
> Thanks for having a look at this.
> Yeah I have indeed only seen ERASE_SEQ_ERROR, but added the rest
> because it doesn't hurt.
ERASE_SEQ_ERROR - It is set when e.g. CMD36 is given before CMD35
e.g. the following CMDs are issued CMD36 -> CMD35 -> CMD38=20
In the response of CMD36, ERASE_SEQ_ERROR error bit will be reported.
This can't be happening for mmc-utils because it send the correct sequence =
using multi-ioctl -=20
Which assure it can't be interrupted by any other command.
The trace that you attached looks like a fw bug to me.

> Why would you say ERASE_PARAM shouldn't be checked? Or are you arguing
> it should only be checked at CMD38 (i.e. the X of CMD35)?
ERASE_PARAM - It is set when wrong address is given for first erase group i=
n CMD35,=20
And is reported in the response of CMD36.
This is actually the only error bit we should look for.

> (In which case I agree, just didn't want more than one error mask)
> Seeing a ERASE_PARAM would definitely make the erase not happen (that's
> all mmc-utils should really care about).
> ERASE_RESET may be removed for sure, could be checked when a SD ioctl
> erase fix like I described is in the kernel.
ERASE_RESET is set when any other commands apart from CMD35/36/38/13 is sen=
t during the erase sequence.
This as aforesaid, can't be happening for mmc-utils.

> Then an ideal mmc-utils erase operation checks that no relevant R1 bits a=
re
> set at CMD38 RSP and all CMD13 until card leaves PRG and stops signalling
> busy.
Are you suggesting that we should include cmd13 as the 4th command in the e=
rase sequence?
I am not sure we need it.

To conclude, IMO only ERASE_PARAM should be checked in the response of CMD3=
6.

Thanks,
Avri
>=20
>=20
> For an erase call like this:
> mmc-utils erase legacy 0 0xFFFFFFFF /dev/mmcblk2
>=20
> the MMC trace (according to spec and most cards I tried, this is one of t=
hem)
> looks like this:
> Format: timestamp,type,CMDOPCODE,
> for type 1 (CMD) and type 2 (Resp48) then the next field is arg/response =
in
> hex.
> I guess rest is more or less self-explanatory / not relevant.
>=20
> 325533.758261654,1,13,00010000
> 325533.758282029,2,13,00000900, READY_FOR_DATA, TRANS_STATE
> 325534.549850485,1,08,00000000
> 325534.549874693,2,08,00000900, READY_FOR_DATA, TRANS_STATE
> 325534.550132818,4,08,0,512
> 325534.550132818,5,08,00000000000000000000000... REDACTED FOR SIZE
> 325534.550693693,1,35,00000000
> 325534.550710026,2,35,00000900, READY_FOR_DATA, TRANS_STATE
> 325534.550761651,1,36,ffffffff
> 325534.550774485,2,36,80000900, ADDRESS_OUT_OF_RANGE,
> READY_FOR_DATA, TRANS_STATE
> 325534.552136276,1,38,00000000
> 325534.552164568,2,38,10000900, ERASE_SEQ_ERROR, READY_FOR_DATA,
> TRANS_STATE
> 325534.552227568,1,13,00010000
> 325534.552241276,2,13,00000900, READY_FOR_DATA, TRANS_STATE
>=20
> Hope that helps.
>=20
> Regards,
> Christian
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

