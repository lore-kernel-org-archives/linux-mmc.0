Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736D8C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 11:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiDZLTQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349498AbiDZLS6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 07:18:58 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029E38BFE
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650971748; x=1682507748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=laAxuf/WqiEa6xjC4iarpJ57FWJRMTurmNJlHKDKpcE=;
  b=MOylMzFhsFsWM2GyiSJmuBpAxRAFLvdXUVVaVNMWYQkGsmoisqlEugcr
   Rx8OPfx/gxD/RbqIuSFOLEnIwUo5yRieSrs39vTDUZuUK6Zjbcc9/GWDS
   S1Z0zWzTuepOjUUUgfKfNElFYCjtyOd9pqTIw/J406xILZk7wKlnvCHq4
   8SH5MBz7pdeK9yQiYurRBJcU1mfBEhMyTLp7ptqL2bRrNn91jMXj4KxUs
   EdXIASeSKOod2bpN5xT8h5Tl8w6HtSE9JzKwA0aWxzm9E29VkuRlBws//
   fNsXGd6JzH9D7qcyejo+7DSU/A00SZDFrF9PNwzA3pnrUaADxr9ZT11K0
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643644800"; 
   d="scan'208";a="303055058"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2022 19:15:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO54kz9X9xs7JLgm+8AkPD9yg1cHmU31MxNVEZ/muwgCE/anToFVQ0KtCDjvkHLg/5OiRnDdMq6q7zCMnsIrpnjxsu3ywErrw8fA79LNvfwOOU8YNWjhzpt9xNaYH6CvF5ZqLzbb8ll4+H73/6o00NZz6+J4zelMU6oI1uvS49zKXrn7+RHxyrCOFYMO1rSBlRWI+47komWSeqGs379NGUbSbH/JDRXqiAuhjC+kRo2hn7pGiBDDcoUX55NjMJE1SdpLu2wLzblxihsVtYkWv7SPyo9VUK9o2ZzXhllR+C+B/6p1rhpBzzzcZEnyXnqMlE/5lGuaig4V1fea86UsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laAxuf/WqiEa6xjC4iarpJ57FWJRMTurmNJlHKDKpcE=;
 b=CiDe8yVGNDJyochXqNEdYa1HswBBYiz3SxSC1AkUeu/Ov8PoSmS+dH+Lzmy7NI1u8fI4fr0SG3CUxDmhPMJm2uPXOXzDikbUrxe4p3sIhc8n3sWZBjd0x1Hcr0IjMLVgL5hmlBjRI/5YOCeiyoYLYf5fURBtoupKD7Eo354QqhgL2ax1OQSA8e66SbFpTs2zbK/zUcSkcUhBnlZT6787EUVrGHZHnQHmf7rG+KnRqhYJh94PuU+WaacFemrOdG7i9MMGo0Xk+Q9T7A9ydIM9ziDLpTPuHNSYIGzaHGrhbviPQa021BQr7Ne6nec+gB5AcUSTXQuo4XglC/YkPv8E+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laAxuf/WqiEa6xjC4iarpJ57FWJRMTurmNJlHKDKpcE=;
 b=KKG+QCaG1tF+itFWFFspBv6UEc8ZjqwhRM7mfs51hL6WX618uG+FORfP8gPoBCuFmfdEftHC1mC5GRoM9dEBTTj+rb6Cgku8G6w5IIRHEun+i6DxTJy47FJq6mDYTJTf22zntfVQu4mTsqyW0V4isbKj6aucpe/suornMn3yLx8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7891.namprd04.prod.outlook.com (2603:10b6:5:35b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Tue, 26 Apr 2022 11:15:44 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:15:44 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ming Liu <liu.ming50@gmail.com>
Subject: RE: [PATCH] mmc-utils: Fix build error MMC_BLOCK_MAJOR undeclared
Thread-Topic: [PATCH] mmc-utils: Fix build error MMC_BLOCK_MAJOR undeclared
Thread-Index: AQHYWVVYo+7FKCan9UKktJ0SRd8aKq0CCxfw
Date:   Tue, 26 Apr 2022 11:15:44 +0000
Message-ID: <DM6PR04MB6575CF281ADC4FC975274FE0FCFB9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220426100605.36019-1-ulf.hansson@linaro.org>
In-Reply-To: <20220426100605.36019-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 333a3945-9059-4824-d20a-08da27761b6d
x-ms-traffictypediagnostic: CO6PR04MB7891:EE_
x-microsoft-antispam-prvs: <CO6PR04MB789138902C1E04F56B830667FCFB9@CO6PR04MB7891.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLZi91z0m29dIC2sQNpga2sKqn5tDA0EuMWeoE1EzhpiENX3zv3oiok0SDdqm8kt6+iZDEqzs0wYMg/3EG8gnqc6ckCn4qjiSQOGwUV7rspHSYAO+urjxaHwW+usI8tJttI9eb8Ss5O3Nmyt7XycGzGYjv1qDUy8sV2YHSNyj6U2UfzE9v4xE4y7d9PIay5GwZnanRuaulVJPjIeegWEvPQjhZHv6VpNpsY9pe3QAQwo2mQbJ8NMYgD3Ssq8NlpEw6w1hT1QLWeAKtNfwA9MpoAHv2ejWAOfTJ1km1c8m+DhGIrgQmFiV5rAScsXnAqptCbrRqChSgdM9MDEaLj6APAumsXOB84HPsId6cigCuh28+TG+qKQTcug00fJLuQzWxOhC6hLbVb/IuIZjo/65dxe/VKMlM3z6dJnGHoGHxVlGt1YwJsbJXr0GnIpkX006hbbRYQAiYfyNNVqdrOcX3fApUTeLhq+BmZnrZg2YOwFDzUpu9yto2HHL7skwzrwLulD2+G/SVdIxps7fBjxS+LDZpRUyZfyOmeMEqYySCVMxmiNyAL7aUUDdB8Ew8NNHl7tk4UEDs22fsaTmaeIzdsxezEXI+SuHBvfscnpaxBYxveLzU3Qvrn7BO0iUJmrRiQD3AhEdFhequwy4W2NxVzVC2GinJVqRJaa/rnOSkDhrS4Okry5mRp5g7M3N3HWMycDjumoDU7N+dGpmWLThg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(76116006)(66556008)(66476007)(66946007)(4326008)(8676002)(38100700002)(4744005)(71200400001)(8936002)(9686003)(508600001)(6506007)(86362001)(64756008)(186003)(26005)(52536014)(83380400001)(5660300002)(2906002)(66446008)(38070700005)(122000001)(316002)(110136005)(33656002)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rvRgfEE05rl5qnEBFbsua8RytCNdGkx3YXPBTTxU3CtaTXllnUUB/w2u+YU0?=
 =?us-ascii?Q?zIh8Um6eLVGRdkJGfyD3Qq3/AmTYQAJ76fpbJOjIfRPuewvp9mWOSR3e7vB4?=
 =?us-ascii?Q?MGai63yR0b0RPrHGvA3KW02W2lyOfnjBNckTGT/Ekx7LcdvtmH2FcjWeQA9b?=
 =?us-ascii?Q?Zp105LCHqp+9khonQ8HQM7McDuPOC+2gexyZOaLMEVDcnsClDpYuDqA7aqVa?=
 =?us-ascii?Q?x0JYeoNbFeOpdyyjmRYCLmRecTiDzlEsH8anr8xE2b5C248TyRDdhWA/FXWq?=
 =?us-ascii?Q?6WPSaNZ5nj77ZhSLfcMM0uknqbvNaOXHLo+TSu4ZJ0PvaFhCMWIUPeUISRYV?=
 =?us-ascii?Q?w7YxVL67c8CHaktr//V+v/h9XG3o3Cosf329RF4nIwgPxqi+kidx47h+Jp/O?=
 =?us-ascii?Q?w51MXgzKk8AzL+TzMBWB3n00WiqpDo6w8em6Rjhq139u2f1X5xjF9Jta2TA+?=
 =?us-ascii?Q?65mWVkrGrZqYfcrF88IJ2Eo8ZDTwamkqjDhUxVfChn5qtThp7En0DDqLOGVf?=
 =?us-ascii?Q?JDIShwILU0lKghAzlEI4EHkd39DGz2+ZP06qNJy1gkYfrcxF6Ru55/kU/TxR?=
 =?us-ascii?Q?RaZE67OnqatHNHdvQxTlW/9YFtkwi+vfeDSUBm9GImpCUhAI/cKth5FP60Q0?=
 =?us-ascii?Q?9QFe07fEmp+wZ+agOhbU9wkPPcAJT+MXmfDF4iyjcFXeqSyZXPSFZFmu/4Je?=
 =?us-ascii?Q?dGqJnm6FxkOpavwXWCwK5O8Lsg5Vru4v6qmV25rVjQT1c63gum+9Tdj3tlCF?=
 =?us-ascii?Q?9vfUnX/s5JsCjZMkl6hPvtlA2P5qTPmO6uxSwvTt9adUa+Kng6IKz4aLapci?=
 =?us-ascii?Q?jDSizVJxGOuxRgQLln/EdfUCUbErctU+cjJpS6CIQQ8Gfiwk1VcbuEvQZFTj?=
 =?us-ascii?Q?XptTevMYUZmQJfmN44G5GkCmC2yBqdV+s90brb002GfJrc41OCRwtE6G9+6T?=
 =?us-ascii?Q?66nm2eymUq5YY+wPgdbjdN+ifyJPh4i+hX4rtRXofURrWhSJRt3lyurQLIxH?=
 =?us-ascii?Q?lDdS12wLuhOaRx2k26nfJ7xmiWpespLnUa9uPAjuXqE41WaxGhP3HQrYRBqY?=
 =?us-ascii?Q?FXu6L2GX9UgKqEMtjG2h5VmPc2/OQRCegbqzQLq1eNkbBbgaU9v3Qs84N6II?=
 =?us-ascii?Q?Tf0feXX/jx+Z45owLp4fOT4AtpO3cExpTD3Bgtz3wvqJURbWodnZglaAvCEV?=
 =?us-ascii?Q?xpNowWvkshn5FzVaExTAfnNiaQdT2vBJdSs4FekDJd+o+wFeRboR7eoLzZCb?=
 =?us-ascii?Q?mI/t7GrBQWqX1sKeZzT7hYdGRIoVb8K7Q9Lv7Y24B153kP1qtuWieGzf5iXW?=
 =?us-ascii?Q?HNV7mXL9PjV6sW20+bpDpQa12eU8E0uCdkA8avLYgv7DAwH9x0qw3PdgDZod?=
 =?us-ascii?Q?8Pvzdtl76IO1PI/oOj1FL9fwhRrndl7tjcDcXFYtvUTU8fyjk7a7p5tpNBp/?=
 =?us-ascii?Q?xy/0p+HokexfcvdhqReJBGoCq0Ni+WmU2O3pS6QFfK34ffiW9gY0MBR5Bk8f?=
 =?us-ascii?Q?uWrDPzWkbpPlSbMXvCklauNYTwFKpACIRXALluSEqGk0lgxuy+5xYZxPXdQN?=
 =?us-ascii?Q?pA7fnZkRjN5vdYHrFSQi1BrGtrPoiubxzNCAfDpus50jLZmTAyLaym7EqXc0?=
 =?us-ascii?Q?FUnMFS44QV4TO+WRX5qeoTJ/2YpwodtA3g6ZWJ+gcZMdup+aWtcBSgDVpscJ?=
 =?us-ascii?Q?whqEPbxcYyUjILvfK/1OuhpZ8EF5Bibi4NO7Ywzg6AHZvvPNEo038DkkmBIP?=
 =?us-ascii?Q?djhPVmFIPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333a3945-9059-4824-d20a-08da27761b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 11:15:44.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OttCwnBw02U3P++gIlpHkHKkAqHLFZqk0IYejl/jr5b6wAlSrsoqozPn4cRSwgqCHLyX3Aprx0EMJtHu+5M24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7891
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> The reported build error:
> In function read_extcsd: mmc_cmds.c:72:18: error: MMC_BLOCK_MAJOR
> undeclared (first use in this function)
>=20
> In commit 118dc4a0909f ("mmc-utils: Remove unused MMC_BLOCK_MAJOR")
> the
> define for MMC_BLOCK_MAJOR was dropped. In a way this commit is still
> correct, but unfortunately it also introduced a dependency to a commit fo=
r
> the Linux kernel (83fc5dd57f86 mmc: fix compilation of user API), which
> fixes the mmc uapi header file (mmc: fix compilation of user API).
>=20
> Rather than relying on the commit in the kernel, let's include the missin=
g
> header for MMC_BLOCK_MAJOR.
>=20
> Reported-by: Ming Liu <liu.ming50@gmail.com>
> Fixes: 118dc4a0909f ("mmc-utils: Remove unused MMC_BLOCK_MAJOR")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
