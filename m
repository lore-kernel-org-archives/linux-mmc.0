Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646FC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Dec 2022 06:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLPGLn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Dec 2022 01:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiLPGLj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2022 01:11:39 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68940462
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2022 22:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671171095; x=1702707095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zgs89iKMxxFd9aGp0ZQYWXInZSACKREPpLiP+z5rpVs=;
  b=mRKYedfKAvAaxMSICs11kwI0eVJWS+fw0zOp90nfF+ur0z9BtJ6Fv4T1
   QMnRZsfeh8GKnEChOdR/G/UjFxAOMsG8c0720026XbfAxNHZkBRhUgYS9
   E4QOgbal3NojPNqO7feqAUyZd44DqeHp/Q4uJ2oFXJoQhQMej1D/bqRT8
   23VtO+ZdFNI4BUaMMke5e/r+uhVnXiYvMmqvHug1u0eDNPDI3qsH0R6/R
   OiIMcwrDG7yqOSm0FMR5/PoJ37mhh51zTDj6G1E34fZ4Pz+8fQa89mFdK
   6Xe8nrmHqtwt7ikZEsjKSodicDQYs+OIRLZri4OsUkCbM11ScGRvuq4vh
   g==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665417600"; 
   d="scan'208";a="219043165"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2022 14:11:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYVV/rLxEYKQKmICmT88NsMW8ATq7glA7BifozJt4MbP82pN61/j9Wm56H0/J0GKV9h4f27LNeRagclL5VlHEtWjLhzxF3gN8Iu2sp+XBGHGZuC5MGKqdBd101bMHre8AyD2bST5KAVXtbHLGnr30YoxoZ7Dd0QEOY6qsvNm8rSc17+LTiM4NnpcI+6Mjk++cPuz7MbNvwOVGfJXPl+dznquJsI/ks7pdEgA52SgNaraAtxOwJAPMir16Kzo5LNAlROv3+hf3LXrWdzz0X6fJsY2B/i8PugPdAACzsu+hUoLuzTHWVUU3nmGNsLX3VIm0iYqmKvcq3FjLAtxTPZmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFICGG5i+ds/VseDk//UfDs8lTsAPc9EtGwoMBuT69g=;
 b=nxUlYUSpyNgsw1RFsFav2EgsTrZskcf+fBcBWO2SOWBSs3l5g6u3Nkrs3hKj/T68CLGndpHPJJ73ZS//SNNKxOFmFgZrMDYQZXHHK78m89DymqKxDJlpC3b74PeiDGV/aJIna4URs01zTHEb7kfI12w4XU/5S4pX2g6OwDrFoSPhJGEGCt7DuJ84aSFR2H8chnXQWOcSDeef9t4KGmXBtopI0LWcsRlMyXTwTBHLRTWI74lCUzRPyfKiVYcPeDJ8YvFOXNeEUFelPRB5KIjbfgCl0pbHQPe4QwemlXXKDfNwQNjLhA4zO5ymn/6mmdqxaqfObY+nkorfpJmwvWLG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFICGG5i+ds/VseDk//UfDs8lTsAPc9EtGwoMBuT69g=;
 b=G5OW/AuufgiDRYfR1Qc70a10GJnWTtpv9gP4CUYeTuqCdS7pQVIfYJQYBgG0nI+k88R3AkUrVVaLGfNioPyIZMH8qiohDi36rs9/sxX9i2hA3Y/AiOLjNIwT2izN0BtOaVE04Ou4t2gjuCu163lxi5nP8koJYYg3WTKPRx2UzBQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN6PR04MB1140.namprd04.prod.outlook.com (2603:10b6:404:92::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Fri, 16 Dec 2022 06:11:29 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5880.021; Fri, 16 Dec 2022
 06:11:28 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIAAxzoEAAAK4ktAAIxua4ABHzIXAABjXHUA=
Date:   Fri, 16 Dec 2022 06:11:28 +0000
Message-ID: <DM6PR04MB65753AF0D64AC7069DEB261EFCE69@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
 <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
 <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
 <256e7a78852041ffbea965e3e3a71863@hyperstone.com>
 <DM6PR04MB6575450E246DBB0880A818ECFCE09@DM6PR04MB6575.namprd04.prod.outlook.com>
 <d6e549498c6a420da4e703ce27a81774@hyperstone.com>
In-Reply-To: <d6e549498c6a420da4e703ce27a81774@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN6PR04MB1140:EE_
x-ms-office365-filtering-correlation-id: f5102e6f-3a15-4356-760f-08dadf2c5ed7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAZr0DIs/fsu/U5IX/OfbSqGewnit92RqcLy5UgaFdYOI0AFq9Y2GFcSzhC6iMZpGyKwZK1vdRavteQj9rv1nnhwTcLN7u/27Wxqt2pZ5QMqa3iSUdn6DsfC4lVYFIxJCIZ6nZX92iSud7LQCZx9J8MOo7nc0pNScneJOPo34j0fW5yNM8Y6d57ymo3gu0ghfO2KhpuDh3qVGokn1SvcwI97p8WFuZ6amXpTZINf5YURj4FJtvRsgbHErFgIy90quvAa0WkhMc5A45SYMjR6G7OYECU6ljafurDDE4FBVjSHZOW26nX52iqGoUg022s5vSfq9jdM6iLtWAU/K6gqBmoQUCY6j0qJBz6p2bGN61jMNI1D3VfrWrU9c7YvawMA7KKHIDdss/vX/DaaAHMfoxn8FzHQbK/xvkbKhT9rwzeGBdaj0Zb5YYruA8/SvTokNl8SziH6cTgKJ76fqYJe5xfM8nkQ41YgwKAlI5SMm9oln7vNUqn5XSDpAAoTnAwl+qWWodmH91crTzcdJFUzb2+4J8cWI8/i5nJcfjHmXqrjojdi973P3hgDTuNRHBvNDqm3fzbyAz52G6BAnigPC3pTID0/UC1bxyIA5B2g+oQbM7lI5GqDsuZHdx8V6xKcjzgIMpMxcQBHt1joW7wtHb+v1AfM6Iu9ex73dMTNjTZOLsFVBIwNZXQDFeOzuTbb6EVFGqU2XUzQ0wRNKa8QVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(38100700002)(38070700005)(83380400001)(52536014)(86362001)(122000001)(5660300002)(2906002)(55016003)(82960400001)(8936002)(66556008)(4326008)(26005)(76116006)(41300700001)(9686003)(66476007)(8676002)(478600001)(66946007)(71200400001)(7696005)(64756008)(66446008)(6506007)(54906003)(66899015)(6916009)(316002)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pn48L/j6DE5sSRyWi44GIm0j95Ue6haLrRzpUCo+vVM1m7PpxAbdRdjB0C?=
 =?iso-8859-1?Q?VEP6x3CqIo8HvJZ48qpLclLcDYRAsa0u5AOzbhM6ns7vH4ptFbuaRRGnsm?=
 =?iso-8859-1?Q?YbsGmwmMgWXnYFMeHN8zEbSMMQjeZBLgjjoiFDH16VYo8+Hdife/9fx3bu?=
 =?iso-8859-1?Q?BnfbUvLFkWNCxRC9yW/uU1ENuZbfnQVg6dMogO3EaBUxVEf2coRtzOCSFT?=
 =?iso-8859-1?Q?jJYzt2dAPSkTFioe//iAF5oxcOEVzzuhKFrRylPmtywdTLnd0TqUiCAySQ?=
 =?iso-8859-1?Q?hcTZIWLnROpLFm/ff63RNmhgVSuqfwXBl0Ey1SMocnKv01gxetqAOHzByk?=
 =?iso-8859-1?Q?ojEleMrlse12/00xZh2AgTmWjhHvFWmuc5PzZBezrWFT0/PxymbEgUNJ8Y?=
 =?iso-8859-1?Q?B7dqlMZbk7xxjodyA7Wnv4ayqfr+6wP3OQ2WYiQW3mIIN0n6fxXkxuZm4V?=
 =?iso-8859-1?Q?RaO8JH6FERiV2f6p0QoRcY9BvHwG0nx1Apmpgh4OV0Z3wD7niuNm0TMAUD?=
 =?iso-8859-1?Q?VuRs/7a3etrFKzpr+3g///240LaB9Dj8QM6wHnF+p7GcyLl2Qixzcj5e+1?=
 =?iso-8859-1?Q?cICKnrXeVA2mvPhfWE+7Uw0WSBeqHyprPF+r/CLKwCgJpvg/aAV8p/A5tl?=
 =?iso-8859-1?Q?Y2ztSgTiCbXoB2h6IChPRhAFPWHCHQql5O8MJT1f5D3yXPf/ZJzBZ95gsu?=
 =?iso-8859-1?Q?WaHXXoHWrAODPubWXgH6Pltg9+fDnNOiMctHMn0d32aYGLf69j/GErRgMv?=
 =?iso-8859-1?Q?0tIJTptsAqVHC2tSAYOls1SbFV81W78nVGue3uuIb+Ubs1DA3qNPeE3k0U?=
 =?iso-8859-1?Q?WTQ38fDNJvb40fm4wpBXUfZY6728Ca0XEek2RE096MqBEi1iHcO8QhM8Zm?=
 =?iso-8859-1?Q?TcpiWnO75E9s3xIMeORXmrkBKEsaMQ24P2BdYHSiYa9w4AGVmNDrhaoQml?=
 =?iso-8859-1?Q?WnbaklTjzOmBtxdNxSk8sxruF48sZjHAFOj2gqR8j5dA1pM0+TYlmahAC0?=
 =?iso-8859-1?Q?yDNXjhUR9Eyt0uXSHkfXDBt2bNqRNGMB9HMQXAyNnDZKEZ58AbNGOo++mK?=
 =?iso-8859-1?Q?6XsxSx2LYhIuwe431lhWbwjbLFt47cf7VHhh4AeHx2vgXBw0txNBglcjC5?=
 =?iso-8859-1?Q?TRB80fHPKmrVssXwCbrAh1iTXwiuY6mWaeqomQ3tvCSpVZMMYw9S4Vla83?=
 =?iso-8859-1?Q?b/oQ1+aD2ZTWrm2ocKoEYkSRr/arlOes/+agS4KvOYWedxgSkzb1T8oHHy?=
 =?iso-8859-1?Q?q46EqF/LRW2wwDG2uvgwrt4B/l1V4o0x4jSUPGDfV+viLx8D1vADqPYlnv?=
 =?iso-8859-1?Q?Gql45i9LbtOfM480xgBcELyvd8MdwffGWV2H+GVclqaxwlqihsWBZwrxC1?=
 =?iso-8859-1?Q?q6uNZSThNsSU2S/t4ay8hyMBNstNeR1sgET987onVfubO7+aGWt4Iu6Jrf?=
 =?iso-8859-1?Q?PeIpFzKYvy/OrzqWsS7mJlNFBrIX6FMq5vO5vfLsJJwk27OLyo1d9r+Ix0?=
 =?iso-8859-1?Q?NYbqhB6HwCG9wYQMxmnJVHWI5UT6KI+EV5ZfROZP5hprMDTRSCJY6lqYZo?=
 =?iso-8859-1?Q?CygtFDzWRjFeqvXngaYTmxjI1hDFJXFRe7FDuqjwQnKPjjNaNxKPhFHDAX?=
 =?iso-8859-1?Q?OKqM+PhFak1Nh0rKpAGjpeY3f+rsDOknhO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5102e6f-3a15-4356-760f-08dadf2c5ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 06:11:28.8611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CVGvcx/EN9veJJsbN+3U+LG7ApwyNU39rwZeNUGPcwp3rYzFlRr1zEP50ovQnmZiah1Fu4lvrOFtYRh7Rx8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1140
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
>=20
> Hey Avri,
>=20
> >> Yeah I have indeed only seen ERASE_SEQ_ERROR, but added the rest
> >> because it doesn't hurt.
> > ERASE_SEQ_ERROR - It is set when e.g. CMD36 is given before CMD35 e.g.
> the following CMDs are issued CMD36 -> CMD35 -> CMD38 In the response
> of CMD36, ERASE_SEQ_ERROR error bit will be reported.
> > This can't be happening for mmc-utils because it send the correct seque=
nce
> using multi-ioctl - Which assure it can't be interrupted by any other
> command.
> > The trace that you attached looks like a fw bug to me.
>=20
> I disagree, requoting the eMMC spec I quoted originally, considering an O=
OR
> erase address:
> 'If the host provides an out of range address as an argument to CMD35 or
> CMD36, the Device will reject the command, respond with the
> ADDRESS_OUT_OF_RANGE bit set and reset the whole erase sequence."
> So CMD38 must trigger ERASE_SEQ_ERROR for OOR on MMC and it is a (HW)
> bug if it doesn't.
It makes sense but let me confirm first and get back to you on that.

>=20
> >
> >> Why would you say ERASE_PARAM shouldn't be checked? Or are you
> arguing
> >> it should only be checked at CMD38 (i.e. the X of CMD35)?
> > ERASE_PARAM - It is set when wrong address is given for first erase gro=
up
> in CMD35, And is reported in the response of CMD36.
> > This is actually the only error bit we should look for.
> >
> >> (In which case I agree, just didn't want more than one error mask)
> >> Seeing a ERASE_PARAM would definitely make the erase not happen
> >> (that's all mmc-utils should really care about).
> >> ERASE_RESET may be removed for sure, could be checked when a SD ioctl
> >> erase fix like I described is in the kernel.
> > ERASE_RESET is set when any other commands apart from
> CMD35/36/38/13 is sent during the erase sequence.
> > This as aforesaid, can't be happening for mmc-utils.
>=20
> I disagree here, too.
> Just because we are not sending it doesn't mean the card does not see it.
> The card may sample a CMD start bit at some time during the sequence, wil=
l
> not answer because of ILLEGAL / CRC mismatch.
> The sequence is reset anyway (out of sequence command received). This is
> not unthinkable on neither SD nor MMC bus.
Vanishingly remotely as there are no cmd nor data error, but ok.
=20
> ERASE_SEQ_ERROR at CMD38 will catch that, too, though.
>=20
> >
> >> Then an ideal mmc-utils erase operation checks that no relevant R1
> >> bits are set at CMD38 RSP and all CMD13 until card leaves PRG and
> >> stops signalling busy.
> > Are you suggesting that we should include cmd13 as the 4th command in
> the erase sequence?
> > I am not sure we need it.
>=20
> I am.
> At any point there is some operation making changes to the flash, be it
> writes or erases, the busy will be asserted (assuming cache off).
> When busy is deasserted host needs to check why this was the case.
> Consider a flash voltage drop, card may signal e.g. the general error bit=
s, but
> behavior depends on the card of course.
> If issuing a secure erase, I would like to know if busy of CMD38 was
> deasserted because of successful completion or some other error and erase
> was in fact not fully executed.
> mmc-utils cannot fix this on its own, so for now let's restrict this patc=
h to
> OOR erases and so on for MMC-only.
OK.  Please try to reuse the send-status code we already have.

>=20
> > To conclude, IMO only ERASE_PARAM should be checked in the response
> of CMD36.
> I think ERASE_PARAM should be checked for CMD36, ERASE_SEQ_ERROR for
> CMD38, I'm fine with removing ERASE_RESET check for the patch, it is caug=
ht
> at CMD38 ERASE_SEQ_ERROR anyway.
> What do you say?
Please let me confirm first about ERASE_SEQ_ERROR in cmd38.

Thanks,
Avri

>=20
> Regards,
> Christian
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

