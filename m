Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F866C3DA7A
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 12:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjABMCR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 07:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjABMCF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 07:02:05 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2A243
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672660923; x=1704196923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DFIs/h33X7W+NjwTk2CAs9XaBF55HLfJSfoN3ySP4Xk=;
  b=inYOSE6rUPKOz00J/WQxVchvJcx2TtUIHruWn9Ebnwo5j0OVyzHC9/0n
   troKKe7KmNRDuprp2tkMy1pqi09lFHsGGu7HmSv+c8HncW4zsavn4PfjW
   rE6BOwfDQC0Yfet77j1zN/pS9bjXmZiOQRmT+v3Zd/6BFhRKfRiPeg8mc
   eEDO6ChiVFmgxeTiz2EwYhk6ci29ZXIPNXqCzaBLWs97kWMb/GmWPWChp
   NILcmu2VbaiHY2ecRBZdNQ51NraB/N1abNH31cbtyiQ5+bBR683WITyo5
   lcN/YeX7YwGkVz7Ql5COlTy/lhmMSpGDzkTTx9ZA7iWto11HZQ2wSjsgj
   g==;
X-IronPort-AV: E=Sophos;i="5.96,294,1665417600"; 
   d="scan'208";a="218084068"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jan 2023 20:02:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9zKNbvzmuGNBqNb42GTLMZZCx+ccKAqiuSeamk16clhG2JEqtE7oOV5nZDcZ08xWlgdPptbdjS8H/yqBTxabV3tGw9ewVLHBLARUss3ZCWIg5d2ntWVdeOx2e2lx4CMi4PQ+PUl4Oj9nPgnUoDhnawZKw3hQgn9prn202F5rPBlsRhBL8LoTyWav+mq4YAAkwr60gRWSPQ+Zi5Eh+Kerx2on2unVKC7CBtGJ3/mSqgtGrgk4mUocrSen/C3i5pm0stTKjalLnRduzDKkKDmKZ/u7/neA+CPiXQdWY79Duco1xig6uiNiPfLDovDQs8ab0J5x24gd0qeos+wQWpA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkUWgvy0CR/PBoI70g5QpH+c28IaAxdXZ2uwztyCV8M=;
 b=IakdjR9/b2DQsmFrO+CfdQiVgRBlfmrNt0x9PBNXYwpH8Qk2ZH5KoXlxClbYSf5st8nKbJvgXdNLp+0w9gpWDYTzlodDx9wdZHz8bS0HiLnLp0z0vyyUKCjORW2UENcKvWFPE8shvG9bWPqsxhd3gsmhEv+6ogGqMrVlDOwDZ0PmiKFjeTq/KsV3cJlR67P5aD+aVQmzzVIZTJT78SyjRttErTgZJ8cG/35WFv1fJk/Mdjs2FL5fOd3pCLMMjMBjTBCWUmdP1Rry1u93qu36U7O2M6Rr8vSnSAPuzeLcgANIwUi9wAf702eheuLFKxX6n8ADr2nuXRzLOepltumrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkUWgvy0CR/PBoI70g5QpH+c28IaAxdXZ2uwztyCV8M=;
 b=lUT5KaovpHNvzAkPlL0qlEPz65vR+/w2485LmnRQceloOaLkswrLNOJyb40JupA8/ufzbDDvIBIc5zYcTNQtnxg4gs1wB7mGivWyrBWv4QeY2FkDl8Ll7CUnlgrUzKb4kejm3s3Ul7/exwqRlSxWscmEx+3lgPlBdHdTuQM9J+4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4682.namprd04.prod.outlook.com (2603:10b6:5:24::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 12:01:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 12:01:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIAAxzoEAAAK4ktAAIxua4ABHzIXAABjXHUADYzD2QA==
Date:   Mon, 2 Jan 2023 12:01:59 +0000
Message-ID: <DM6PR04MB6575A84C5616DC3C1A6FAEF6FCF79@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
 <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
 <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
 <256e7a78852041ffbea965e3e3a71863@hyperstone.com>
 <DM6PR04MB6575450E246DBB0880A818ECFCE09@DM6PR04MB6575.namprd04.prod.outlook.com>
 <d6e549498c6a420da4e703ce27a81774@hyperstone.com>
 <DM6PR04MB65753AF0D64AC7069DEB261EFCE69@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65753AF0D64AC7069DEB261EFCE69@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB4682:EE_
x-ms-office365-filtering-correlation-id: b59c9b97-8d81-47f5-c9a8-08daecb926da
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44JCm0TkQMtzTWhfrgV8QFayWsbbSm8gpC8KxsmE1n67+F6hzSVj5E8P1r/UVqXAtV5/ksBRzbODP7FOrSzxWmjNsP6pMWfKesEKk2mr+Rx2BEbs8NrKo96YFHjSSW+0U3bkk9YyMrEezfchXokqsRRBeNAreKk2JrBqnqtp4f+3G3QK0sgfN3hvPc6uZjZqNJAiGVC3i9iyBWXUNRKNuvsPY3+RboBTpp80f0xqwMmKeNRlX1JGCVpPhWPxVMoyWf9x7sfDt24rxDLyGopiasy+W1gZYINX4Zyy7/Ze/4pg3N2v01fKv/13Zw8dVztKsLsy7VUzxs5nYekGdnE04RqyuLhbbVSMT09LMN/Cxv+3LqcWg5WtyGbCYoezYuh1ODpoCnkgbogWDhq/hj9WBjRjiS3A5eprcsA6EOFZ+r5Zsf5MN+TPtINivKcwakYQ4ROow2WJm769GQFQX/CXTkUk9LkdrLv2azdv0hYwrFcSsMmk5ifbNj81M8cqXlKJVOc/8pV/BAJ4U81ELqOYpGw3Aaz1r5TD3W+xKPRT2Ic0ETVR8mqNg1vetsDUwbc/nn8c564css2BVp2YVRMe87+lEmyY1+pCutRwlC7OEzLrBvgCwrd9IjCOcKsHk16vz7XakEJLIryyfzXOZ5Aw/r/3CX9Ls074RgNNlu9dYaCStcnXqhYnHwEgdoOUIz9SxupzKNtiR7utNhfoyp1a0RoznQXvwOAEzw1mKUW8ARc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(9686003)(186003)(26005)(83380400001)(55016003)(86362001)(33656002)(38070700005)(122000001)(38100700002)(82960400001)(66556008)(2906002)(64756008)(316002)(110136005)(54906003)(66899015)(52536014)(4326008)(66946007)(8936002)(41300700001)(5660300002)(8676002)(76116006)(66446008)(66476007)(478600001)(71200400001)(7696005)(6506007)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bPJckBjh7TL6BtumUPb6g19XzoQwfo4yyZCFpJ+fFoj+lx4oFZlw12Tgr+?=
 =?iso-8859-1?Q?f/CQeWJUTCQ6ktX0vwCPRkg2UU58lzyaRFerxfWIeBbOF67L0MlK4isQBb?=
 =?iso-8859-1?Q?Qd3nPXEjT2xSz68eH17qPNWmhcV2qy9cEUwpvRXuVQJKFJBkstQp6dFLhk?=
 =?iso-8859-1?Q?GGeARiw7VM2u941MEwAIJnIxJ8xQOfJ6AnRu2kdRPJ18RWaHSzndRRxTRk?=
 =?iso-8859-1?Q?C2idiaAT91qKEIx1IA3V56S2LD/M3a42C9R7bWprw2EprUDyCNRmqWElbu?=
 =?iso-8859-1?Q?N8TXE4Dsuafpps7k0aj06alqAe/TL+v0/CLWYDMgR5ddQFldSOFiGFTBmb?=
 =?iso-8859-1?Q?crD55UTryS8RJQGVCKkeg+R7H2WQPkOw8RAhvwAhbANwOaBAHcXDjV9lNE?=
 =?iso-8859-1?Q?eB9XzyEEDbfhIyY2dH2nB8IYZuh86nLDst7gxEHv92GBG6BDslee4JMjKz?=
 =?iso-8859-1?Q?3li4uofrH0dpde+EOLyQmWa0bZ4QqToMBDyeOah/QYCJCIxVzGUJwqjU/S?=
 =?iso-8859-1?Q?eypXKfJYW0tb0DDbH/CWw4RNx2bSk8KexlgO8EuhVEbOp2DhV46GTw7TlK?=
 =?iso-8859-1?Q?NvlVgGoBvkIFkK9MlJQ5UKzTHoZFOuyIM2ThQJmWhInZHPVgH3otDFrjY4?=
 =?iso-8859-1?Q?u3DHRthaRJWJZ0SIzxV0hQy/kLLdcMWg+wZAXYsrfZMbh92rADWpv1Smor?=
 =?iso-8859-1?Q?hftbs1RGXa2TUobKKhGh8u/2A10gsD0GxjcOaQTf3/QbEGJO6igCRrtHlC?=
 =?iso-8859-1?Q?BpN8S1QOQ4gmE7r2IuIK6/wXM7Yg403PaMmYidOZYf2s3Rty6G8exme7E9?=
 =?iso-8859-1?Q?qn5Ix8rgpZE7uj6lCj8hgwaCo0Fve0PATM+nI+eHjMxg8a1FVNlt5q5A6V?=
 =?iso-8859-1?Q?7R2RcjcQM9RVS6SSUo3ZE8ql9QKqYtPuceSmM27osCsdgUnwz1IK/GzBqp?=
 =?iso-8859-1?Q?b8oReIKV6wiWOY+T8PLu2KxZV9uAvTRwkDCzb5nGogXS6JIvdvrtnJNLTr?=
 =?iso-8859-1?Q?9Dsw4vENTiOVBDL9gav+dXeAlIUGDzywVufAYdL0VZUIqm5TH4i7b6S6Iz?=
 =?iso-8859-1?Q?YFSyYwmq6REm8Jx/Lrc3Qpwckq9rnLaJ7pS4Xttg7aTiStm5AzTpYkuxwl?=
 =?iso-8859-1?Q?VmBsxzlJW/A6UAEBeVEJYoV7LOKR0prSuozj7DtQ1512IkxXJOOjRloTTj?=
 =?iso-8859-1?Q?ghExbaB8/RV054h1EqFPQzHC+PaBZ0je2yEuwFoB9U1nXobF+0hGqFo77D?=
 =?iso-8859-1?Q?OQ94lnmaryLSIkxp6a2JVWy5bvphWbbdg8r/PCEQNi2tNbn5cW6px/1h4z?=
 =?iso-8859-1?Q?oQDhRumrlx2xtUnXh9swDq0tP33wsrorp5W+fKVEuvA0D90oHmP3mxR3lj?=
 =?iso-8859-1?Q?qTeSy1eBZSJzAxNjNGFxxA8DwmMwudiCQ5Vs6RT/nkpeXnfStXuhn6yhtu?=
 =?iso-8859-1?Q?IAeoAdJbrId9EcExsznSzkJ6IxgFW0rr+qLGGT9qKq9bBTMA/5LukDZYUY?=
 =?iso-8859-1?Q?yNm0p6H3DaxNJHhc0mZN+mJN6+MON98jQD/tpN6Tznq1EfZBt4w0/CGY21?=
 =?iso-8859-1?Q?OMwaTfRZZw4hdypIRhc6GQamVxbcGk+uoOGPqshKmldww/AiTvh532knaC?=
 =?iso-8859-1?Q?xDOWiNLEtEXh2kwRJlSTTaYPzaPjGA/BmC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59c9b97-8d81-47f5-c9a8-08daecb926da
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 12:01:59.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x2ajr7DP9S28Bbu+KRonP1Gu2i96SUa9lY4PffZ/Ml599x4ehiCr2pHRzwYiwogjLnzjvWX51whDRbee382/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4682
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > Hey Avri,
> >
> > >> Yeah I have indeed only seen ERASE_SEQ_ERROR, but added the rest
> > >> because it doesn't hurt.
> > > ERASE_SEQ_ERROR - It is set when e.g. CMD36 is given before CMD35 e.g=
.
> > the following CMDs are issued CMD36 -> CMD35 -> CMD38 In the response
> > of CMD36, ERASE_SEQ_ERROR error bit will be reported.
> > > This can't be happening for mmc-utils because it send the correct
> > > sequence
> > using multi-ioctl - Which assure it can't be interrupted by any other
> > command.
> > > The trace that you attached looks like a fw bug to me.
> >
> > I disagree, requoting the eMMC spec I quoted originally, considering
> > an OOR erase address:
> > 'If the host provides an out of range address as an argument to CMD35
> > or CMD36, the Device will reject the command, respond with the
> > ADDRESS_OUT_OF_RANGE bit set and reset the whole erase sequence."
> > So CMD38 must trigger ERASE_SEQ_ERROR for OOR on MMC and it is a
> (HW)
> > bug if it doesn't.
> It makes sense but let me confirm first and get back to you on that.
>=20
> >
> > >
> > >> Why would you say ERASE_PARAM shouldn't be checked? Or are you
> > arguing
> > >> it should only be checked at CMD38 (i.e. the X of CMD35)?
> > > ERASE_PARAM - It is set when wrong address is given for first erase
> > > group
> > in CMD35, And is reported in the response of CMD36.
> > > This is actually the only error bit we should look for.
> > >
> > >> (In which case I agree, just didn't want more than one error mask)
> > >> Seeing a ERASE_PARAM would definitely make the erase not happen
> > >> (that's all mmc-utils should really care about).
> > >> ERASE_RESET may be removed for sure, could be checked when a SD
> > >> ioctl erase fix like I described is in the kernel.
> > > ERASE_RESET is set when any other commands apart from
> > CMD35/36/38/13 is sent during the erase sequence.
> > > This as aforesaid, can't be happening for mmc-utils.
> >
> > I disagree here, too.
> > Just because we are not sending it doesn't mean the card does not see i=
t.
> > The card may sample a CMD start bit at some time during the sequence,
> > will not answer because of ILLEGAL / CRC mismatch.
> > The sequence is reset anyway (out of sequence command received). This
> > is not unthinkable on neither SD nor MMC bus.
> Vanishingly remotely as there are no cmd nor data error, but ok.
>=20
> > ERASE_SEQ_ERROR at CMD38 will catch that, too, though.
> >
> > >
> > >> Then an ideal mmc-utils erase operation checks that no relevant R1
> > >> bits are set at CMD38 RSP and all CMD13 until card leaves PRG and
> > >> stops signalling busy.
> > > Are you suggesting that we should include cmd13 as the 4th command
> > > in
> > the erase sequence?
> > > I am not sure we need it.
> >
> > I am.
> > At any point there is some operation making changes to the flash, be
> > it writes or erases, the busy will be asserted (assuming cache off).
> > When busy is deasserted host needs to check why this was the case.
> > Consider a flash voltage drop, card may signal e.g. the general error
> > bits, but behavior depends on the card of course.
> > If issuing a secure erase, I would like to know if busy of CMD38 was
> > deasserted because of successful completion or some other error and
> > erase was in fact not fully executed.
> > mmc-utils cannot fix this on its own, so for now let's restrict this
> > patch to OOR erases and so on for MMC-only.
> OK.  Please try to reuse the send-status code we already have.
>=20
> >
> > > To conclude, IMO only ERASE_PARAM should be checked in the response
> > of CMD36.
> > I think ERASE_PARAM should be checked for CMD36, ERASE_SEQ_ERROR for
> > CMD38, I'm fine with removing ERASE_RESET check for the patch, it is
> > caught at CMD38 ERASE_SEQ_ERROR anyway.
> > What do you say?
OK - Lets continue with our current understandings.

Btw, you might want to consider support for SD as well (in a different comm=
it) -=20
SD doesn't support cmd35 & cmd36, but cmd32 & cmd33 instead,
and its response nuances are defined in the SD spec.

Thanks,
Avri

> Please let me confirm first about ERASE_SEQ_ERROR in cmd38.
>=20
> Thanks,
> Avri
>=20
> >
> > Regards,
> > Christian
> >
> > Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing
> > Director: Dr. Jan Peter Berns.
> > Commercial register of local courts: Freiburg HRB381782

