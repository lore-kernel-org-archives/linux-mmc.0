Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8BEC43334
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 08:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiGSImn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiGSIml (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 04:42:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305828E11
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658220160; x=1689756160;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pCgs5s08JzIXvtivJg5pPQoapADrKGUd5a5a8931o9g=;
  b=FK8nCFfnW46tQxDj2svGV+7SJRGVvhBw06hvws9n5Y60QziQ2EjLGX7Q
   nRlikbHf84HY5rIoFFUVgEQ9mk7X1yahS+piT5ONq5wr7R1cBy66u1fdf
   wRYY+jL/jiS7wJr3yZ7HZ5QDEeRu023lOnCeCgA8a/kx4KHkjhmyDKg7e
   Tu/YEovTQGF0wEbGkIZhTk9TywIN5TKujQVz4e8+1KfbWZkt12a9gWN3W
   AaS4n4Yudi+aHS9lrkFWyS3qgdBUFtbNPtaEdgMC55t8q0h5go0aB//EO
   Bh9Et2c69oYJPgP7dqkX95vTchlD9mb7KpkmOzgQ0tt8ZrrZnTHgJDTDQ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="310644333"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 16:42:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+jXl7xprVwQ6sHUAuJ1bfhaPSBGM/FYe5QDkfEYuvn0O+8tK2g9oYXZCdj64HLIT+6RlqCHuYtmBOiR9MmWijldifaoSBfkKPetDULbJl7q08OCfW1t5x6XNID24KyErVeRf0Mx6BEeaHO97QWWAGPeu7jc1+KjOlynQSIvcpgvSHH33geJi+Db1xk+KdX0DuEcS5fFS3T4qBZpx3efSRQTSLJIPFZkPZP0/6jNvo8sFcuElmdy2dky7klPiF4QV8PG8Rg+yhzXFfnnBzmypQ/KSN3etATr4bsmEwpZuuS6NX5NYVBW7INhkHrYvl8aPHKUlwn64BfXUsYhm+3iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc7ORZTfsp/mIsci/oRRyK+pF5d0hHOl5WttXznWYTo=;
 b=N3/kvNfSa2Da3babYFiC2hjb7dWNrOU0+7cxG9F35KqY3tqj9CYlfyKSFAPUSvhAkfAy82N2Nue5C32K1kb790dN+9iUmEfQVjFPMxyKngqwUU2oKB2b/JyebidAGU3oZ+v8d7/NXDuTAbblPqYKHEhVyZTiKTZIYkW11Se0rtjWfjLgtIKh+6yLkKCvkdBrSBTFcxmg70JIuIRG6D3BeLDxs3WqkxYfHgAcdmXH2ufSxRYnLOdNsuBhYGjIpQ9g2s7RLrrmzxxC9wHRtwWfmkzzbkUFk6LBEJvhHeTpl2L8IE78Mwcu6hmxpcUqjVkfLk3DbjXRvQrOeHenXZ8DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc7ORZTfsp/mIsci/oRRyK+pF5d0hHOl5WttXznWYTo=;
 b=crsrxOG98WgKAPOQ1ZKzxnl5VdFsb79a2rLg8kgjwZ7tZAtyUySVtxAIPlEfFRQbuyxSE2KTiIBIEHDiKGojv2mcmlnHRQKlR+wby1Xj33OZpazVM2KbvZS6I+f39Yq7Lsh/GpYZaz5K1Q1RkEpZrEX8pdCKgNj7E0fmO9wtedM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6093.namprd04.prod.outlook.com (2603:10b6:208:df::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 08:42:37 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 08:42:37 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Christian Loehle <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Topic: [PATCH] mmc-utils: Add softreset command for issuing CMD0
Thread-Index: AdiaoDZBaBhbwaxFRXm22iF8+GujggAAGungACkaz1AAAXuxQA==
Date:   Tue, 19 Jul 2022 08:42:37 +0000
Message-ID: <DM6PR04MB657525131E9BD090A9956D5EFC8F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <fee2ce51a200442f90bea0668466a2b1@hyperstone.com>
 <DM6PR04MB6575A42E7EFD93C235BD5AA7FC8C9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ca03eef23ff5419692b7e15c2f038640@hyperstone.com>
In-Reply-To: <ca03eef23ff5419692b7e15c2f038640@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8a5ac2c-6dd6-4951-063b-08da6962a212
x-ms-traffictypediagnostic: MN2PR04MB6093:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERzGYeVnSp/DMzlzci2tpiMpsFesNTAhS92Q+QJXSBwOHuzhvXbcUMkZ35SdaMoXMjuMFHwuFfwNuG8dYgHCxyQAvGAasSUNa0LcRfaWTyQnRmzEk99uZgOedLjCkPvIZMuVb08eUN6l4s4m8x2kQbvp0OQNvlEfe0+KDLElQPzb33a2JUA+HI6fA9pCyNZMlFKTSF+Q6Qch53OggFkuRu667rdJpH01OahdLjX5jBPoPlybptExbNKP0gdUNUV3oa5fm3lInYPEYRMqoGNdnnMWuUVCd3xIVhzR1ezbgV0Qg/U4OVAbPZIQpbMMidXw9wGtKfYvLx0q5rAnY8KSBMjZtEY2KyoBPtEs9L0PyecuN/cH+w59t/2ANRiiGEnDSIQ9jZCju6bYadytm07U7Ju4TFFB1CvbqMsNcTmVBeZl9dho7+iRtSU66S04QOheRGBmRzomIvZiWQGQvizqm87ZSla4LIvKOPqJhSmUC5NGLOteqSP3p4vMU9frXIfADjk0SzfrMT0F+u5kJbaeSqjhn3AOAsz2ROmkK/aEb0TBLso6+vEaPc+uAgCg3OM+TF2sgYd9mNE/vMAuUE0hIIhGI4Z3e9k3aSqYJFFUIljFSR8zeJSipoT3mdVVnA3ZJQI6AMjHRyyONv4x6xzk5wH6W7GZjkwa5kDPCDxJ6xOTIhG17eTl2l5fQD5D2EjpZhts39WmTi4QsbLuxo0hN7+bic4/6T+m6i8xs9ixDAdyQU+K5YESeaVdALdeMTHsmUBCVemMzqVlmT1Lglsh3h0QtrU7yNpKhdpPiCJZBtMULE4QiiM8ilysGCSOGNDR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(26005)(2906002)(52536014)(5660300002)(55016003)(8936002)(82960400001)(38070700005)(86362001)(122000001)(33656002)(6506007)(9686003)(7696005)(38100700002)(76116006)(41300700001)(478600001)(110136005)(186003)(71200400001)(66946007)(66446008)(64756008)(66556008)(316002)(8676002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AxjIFZLy8rarmlmM7fDp1FeFdewLG124gU5C8lSqeia5mzgABDMNkR7zCPXn?=
 =?us-ascii?Q?X4CkV6bn+cgkUlpNveoO8PmADmZxy22jIKhO8zadReLXCjKNPQ1Y8Y5yNhaP?=
 =?us-ascii?Q?4R2qiIki77sLtOoeQ2FSlAAKTl4W48phD7GKGHK9iqk9+zwTWGc0S4txOhfk?=
 =?us-ascii?Q?6SC0mWgH8V9JCnUzoFOgM4QCujDoMz7t4/hUusEnh3/yuLjtbfeLbaSbzW2L?=
 =?us-ascii?Q?ikp1tkUcpLCuRMxmdu7jIT3/IXEk1eg4xYhKtTrq0gArKqixsf2esthirovZ?=
 =?us-ascii?Q?Jr5qGocckOeHjL6aMSJtxnKpr072H0bo6GhvxM5/7YeN/gXMD9TagROMvLbd?=
 =?us-ascii?Q?d4AqRqiwu2MqafCTFpXZ2BIZhz2sjaxgs2wERy8dm0poX0K9bUabwiRHN1D6?=
 =?us-ascii?Q?4NpkrzyE42bAC1lIIt6V/lI78ICHbVlYPi9Z4ni+2vcHI8TNV/h0PvGKZH2Y?=
 =?us-ascii?Q?qNUKQSSnT25mCodmxcPdRxqR4CovoPLNqoaYNB5dGXw8kiOUsV4dD4+Z3/Wo?=
 =?us-ascii?Q?k+1jNFUQgdpXf/VpL4jc/l46xa+YcxyeHsPhnXbHiR2H7DjurU5pA/2poHdA?=
 =?us-ascii?Q?7NFMCcN89g/xYOZH+xx4PRO/q9rr86f310hDZTWSQ+JYjO5MO+9yiB020lUL?=
 =?us-ascii?Q?qF4r2emXRUNYsbNVu5oX0kXGeYOJUNbhf2h9A50Hf5wnMT8TL2aD/cCbqEPt?=
 =?us-ascii?Q?h2HetKrKusTakUWprPFpijeNWMSXTgFrGihE43GxEfcSE4yy7Y2QrrMfGaVt?=
 =?us-ascii?Q?lE9X/YgvoPLeU6aR1AYtR4T6iQefh+Fflw//laQUdMtedzAtQHt7SxjzLxAK?=
 =?us-ascii?Q?iuEglAWObs63cJJLAkeFrqkrjj3yXOKQsk7iGYmPoTY55UE7gDZhHpExuuy/?=
 =?us-ascii?Q?hEFp1fxg3aLVgggocZvsB3WrFo3LYyK6jW/cq/QSE0uR986/UP/1wtQkUZuI?=
 =?us-ascii?Q?KGZk2UEtma0rEIRp4BODe0fgE/W4UlfsREC25Qyfx7pnx2OzMos0z+aRV+6R?=
 =?us-ascii?Q?8POUyzD31oW0HDg3oIsveI5LhjgcAoTTY9MoQh6QzC6+XEmEHfe00fTTNP2i?=
 =?us-ascii?Q?6BokrvZ9kF4AQ3JiPExkj/pNe5mfyzglz1TqPgU5FGe7QBU6gwcfOU+fvX/V?=
 =?us-ascii?Q?PDPngzCa10xmuSWk2k02enHVCuiGO1lnkwxDB67zNtvcLrXyA88b5p1iZcOH?=
 =?us-ascii?Q?MhfJ23ngLkaDkox08Zzf1KGkLOIYiVgylHNAFwXlliWIs0DF1sldmEoWQZIQ?=
 =?us-ascii?Q?Jc/6HSd+wV61WstW6faMedFrnUx21Z76DR8ko4nlWwxg+Co+k3ZX7/k0prrU?=
 =?us-ascii?Q?/fH0KVeg9QkkHLhVVPzt7WFdS+09JHwHXwiejj6POGXMvwN6uE0tPvmfeBZT?=
 =?us-ascii?Q?2eBTI5hi6JeEx/zcYQzlO7CzU7psgdFwY5HBr2tq/RcV1ROv2226ekYiLP3O?=
 =?us-ascii?Q?wHpRvV6N1uf2gb+T2TSiTAUmN3ZO41x2qa9RY5ONaOT/c8/i/zFnr/GWUK/g?=
 =?us-ascii?Q?KbmsJ63PWOAaFE4pE9lIXdVuOLfRc9CwO7/cFYdv2Lypl3jO8BYHuQByOagK?=
 =?us-ascii?Q?3jpuehDJAtPAiK4W9OOIgW0Qt7g9OWUwuqXHioPH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a5ac2c-6dd6-4951-063b-08da6962a212
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 08:42:37.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdpuWrg+POB9cbYe48o4Isd3IJxJnPo0O4fwA8viG4u88+/LlwwKCBQDqrYSVVJLmAY+0UcHPQWEkhpnOaWMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6093
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> >> CMD0 may be used to see if the hardware can handle a UHS card that
> >> completed the voltage switch. If a UHS card has problems coming back
> >> up after CMD0 your hardware may not support a hard reset properly.
> >I think it's a useful addition, not just for that reason.
> >Specifically to test hw-reset support, I think you should use the
> GO_PRE_IDLE_STATE option.
>=20
> Makes sense to add both, I can do that.
>=20
> >
> >> +
> >> +       memset(&idata, 0, sizeof(idata));
> >> +       idata.opcode =3D MMC_GO_IDLE_STATE;
> >> +       idata.flags =3D MMC_RSP_NONE | MMC_CMD_BC;
> >How about adding all 3 flavors of soft-reset: GO_IDLE_STATE,
> GO_PRE_IDLE_STATE, and BOOT_INITIATION.
> >There can be 3 different command, that calls the same __soft_reset helpe=
r,
> or whatever.
> >What do you think?
>=20
> I'm fine with GO_IDLE_STATE and GO_PRE_IDLE_STATE, but
> BOOT_INITATION Im not sure about, what purpose would it serve?
We can move with these 2 to start with.

> If the intention is to be able to get the boot operation done with multi_=
cmd
> of GO_PRE_IDLE_STATE and BOOT_INITATION and return the data then that
> would at least be some more testing effort before I resend.
> I have only done the boot operations completely in the driver so far.
> Furthermore I think many (most?) host controllers (or our drivers) seem t=
o
> have issues with the transfer size I'd expect of a normal boot operation =
(i.e 4-
> 32MB).
You can add it later (or not) when you find the time.

Thanks,
Avri

>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

