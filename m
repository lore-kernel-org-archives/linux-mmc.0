Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C077C47082
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC856108E
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 08:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGI1j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:27:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51062 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGI1i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2021 04:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623054348; x=1654590348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1qAbA8jTySmfhYQBYa6x7O6PnxBYmvtfD6XT2AVBAEU=;
  b=Lhj5UzGUZnSbR2Lzgq/6hKmQqWiq9UN+P/zQ5GqhrqGxF8w7g+wIOYho
   J5zIxsdj4HKipdp1JrVOOAB+QMnDEexms7c160ThNceDjVrRa0NWj8MPN
   xp7xRA7gdFE6F46ialVB1AsNMIf6jlZbCw9BQczRl4spXIjS9OKC2iu+4
   wBON7lHk5JETWmPExq25Eit4NcfNY7MNsMbqpFvaEEvq6webrilH28Jq3
   18Eqo8qA69fNEPsDp/WcZV2RA7/xOxg3wrD6Wf7LFuUyry8U1hJTxuC1d
   RngTLXd/gMZll8vzzvQMx6ULDPBKXWHv9OpSuGbt/pVB5k45+P9+Dcnsi
   Q==;
IronPort-SDR: JhQZBqExz5Z9orx8KyvOym5vieksM/4Iw9unBPinPpMFh9eMvQxoZwBFQmciMN8RphSDgxZNw/
 SjkXJy6lyc+3l8J8jQTAgIbUraSSFPhBxpMHqj7FuhGA4RDy1MiNZRPd21jTl8hURZII6x15Gp
 EB+eKW+l2il7TMszJaBUUOjAktdVi92+0v4z0nU4z4YHsQpuIECLtkH5pIostShOpovO1vfDVv
 JXRQeLgcPfeJmu+qDcCqCpvMkbFNLh+IzYThKSCLHoPYhNqfMObMnGuCvKR2WdrxpyyH9U4r++
 Msk=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; 
   d="scan'208";a="171540571"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 16:25:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlbuya/wn2RoLZ8/HVLHpSKp+MGmvpPulYMh9KVBumPVXcLpiyUrb31IlfFmOIh5jIU1llZfBaknAFIKWoHfZgouujEG2joIHi+eRCGuio1j+icGKJtFAbRobkxsYP/jrTPQn9xCc/WJqPZAO+JM4+0NpE4XcqrXYBKyqxyrzyesqYqd8VfuNL6j43yEiRZjfIXtBqH8/j0XpaEi2iJM2pZMozZ5f6eRiPsPm/5RWlk5GvSqVEveikz09wHJiGKXYQpCJIgFdK/vWl1xgUS/i8uztUoWy1TFPlnYui634qVDPHhNF4Hvtcio3gnhb7iZ+oYInBoyb4eoj6QgPOHutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qAbA8jTySmfhYQBYa6x7O6PnxBYmvtfD6XT2AVBAEU=;
 b=dVJVQrJTWtrmlLY5o4YjVkNF2p9p2mPq5uzj+15CqjUboLDy9FD9+c1Adryus2CesGqz6bn+HeiiC4R7IanCIDpFmUAxbs4CpRvPVB0hwbnyJtOJj0ARiPPRwEbAFt/6gzZpAXKQsxuUiOAxIBtid3/4yELyiC3U1Ou/QExAFBi5ISoWIZvuPyfu7VeGco8zzZWYxfXL7XSl4zPsegOGhUs1OnCSJmvLAKEAVCXLYjR5cXzW6Ta+zqvx9bBcon7NqP4AkwYRojXvJ3ivyIafuM+ruhgEfDJtKLtj9rQ4uYVD6SlgFcldsykk0NwxZ50mfBy97r4hoDQSG5nx5aR5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qAbA8jTySmfhYQBYa6x7O6PnxBYmvtfD6XT2AVBAEU=;
 b=bPWkQLEKTU59IIM+SKCi01YlTPM/z8nvehO3GG4Cimcujl/p1X+q//hq8tPfp/Dva6U0B3mIyClY1GIjj+2qipilREyaRYAKbkVBQ43FKcsP1Qip9V4TE6QG8a9UC4YQIw1K8sReihEJOACgwMdoy33ZojqcxllG9YHw4BleAW8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5019.namprd04.prod.outlook.com (2603:10b6:5:11::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Mon, 7 Jun 2021 08:25:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:25:44 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: RE: Who assigns SDIO vendor IDs?
Thread-Topic: Who assigns SDIO vendor IDs?
Thread-Index: AQHXWaAGytu/AXdw9kOkuTlH+8AjPKsGf44QgAG545A=
Date:   Mon, 7 Jun 2021 08:25:44 +0000
Message-ID: <DM6PR04MB657533988CF85BDF997AE4D8FC389@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210514171233.qerhkjn3redivien@pali>
 <20210528002111.wei44qtoptgj6mlo@pali>
 <CAPDyKFoBaSFSrFFPkYaChcAGHBnxpe=74TbKNqNH6_sh=47ooQ@mail.gmail.com>
 <20210605001621.n3krry7qjhiieb6j@pali>
 <DM6PR04MB657522F2F6C3F0612C8A32B5FC399@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657522F2F6C3F0612C8A32B5FC399@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 919598c4-0e01-4f7f-a4de-08d9298dd88d
x-ms-traffictypediagnostic: DM6PR04MB5019:
x-microsoft-antispam-prvs: <DM6PR04MB501927D4F8C64DACCC8A669EFC389@DM6PR04MB5019.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQO+/cfeCIDe96sEsCQ9ao1210c/+L/tgpiAemGhvRWSbKw2j0N8caMbPafqRsQbm/x7KFm0CQwapV/1dqo40I6SEA5dXJldgYIdBeZ5ikLcHn1GaWNV9hLt4/l1QnwwJoRkY0+OT6JgQxejiIT3zS55U8dlqLk5E53qMrEVQ32xUupOHe4ud7NJ0ygpxCEGl+dxuEXc3EMCmsSLcpA02P0z3jOA7yKLbMKtirevNrWF5BA96nHy8pT+nBnqMzhNxIRJVT6b5VlXHWkjBs67qP84Es8D8fQE+mY40DLhCv1DWlyklHU8VC633wpuxnCPYxwFkEDMcsSBpLqqohgK5YBGtYOgDeMKuzbCNtqn+hWrm13X36Ai1+lIBsGy6PsNT5SWMEfs5F6DfAg9KvNiF7oJPviLBIrLZML5iI6b+ITs3CvzRs7lYOPiFZLR0K4iVRQFWfHIQcsWb77DArIhKXS5BHjKRK+s3xPwACFQhLqlG2OuPuE/pYlXtUGIoSV18YL8W69y7oVwzc8Cd5NHJWKfuFS4ZGbf6fIYAArVJTPtJ1YLycz680AndazfUaQPdaQy9PBJqoNtB6wxRKxbno50WzTMlZpD9NPBQ2Ayd9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39850400004)(396003)(346002)(136003)(33656002)(8676002)(66556008)(4744005)(66476007)(86362001)(9686003)(8936002)(76116006)(7696005)(4326008)(316002)(2906002)(6506007)(26005)(66946007)(5660300002)(66574015)(110136005)(52536014)(64756008)(66446008)(38100700002)(122000001)(186003)(71200400001)(55016002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?alpSVndJUEx1aTZOS25hZmFkNmRZOC9JckhCMlpQMjU0R1lSQS9YSWJ5cm1W?=
 =?utf-8?B?NG5US2JwcUhCclQwR2pUZmxyTGpZTE9oU25BRXVXZ2ZUczNmb0VuQUFoeHNs?=
 =?utf-8?B?RjRJaC90R296U3hxQUVKV1g5YWVmWGlJVFlVYW5uc21WOFhZelAxNXlWWUhN?=
 =?utf-8?B?Y2pqZzduRFdzYW0yME5wK0t6REIwSlQxakE1U0E5YUZxL2JDYUdPcFNwZzlj?=
 =?utf-8?B?RkJsdnBXWlVlVm1za2tSTjZDTy9mS3NIVW1veEdhRzlaczRVUnRQSXVYcGhI?=
 =?utf-8?B?NjhvbVhHMzgybWVsSnhqa2NWQWk0MUlsaSsxZHc0a1ZaeTRYaWNTMDFBZ0Zl?=
 =?utf-8?B?Sm54bVgxN0hlSm90aDZCTTIybHZ4RjY5UTQvYTE0N3NsUTVpcU9TazlISFpM?=
 =?utf-8?B?c3JSa0k3Z0ZxWFh1Y3IvY2kxVzl1VDlrVGdvQjFCb2J4ZEkrMUV5RFlTNEo3?=
 =?utf-8?B?YU80NW8rM0Z2dWRZWnRyb21SaFZzdDRQQVlzWmFFVVQ0ZWowOEJNRnFVWFd0?=
 =?utf-8?B?QVEyTnBzVHNBME1PME9SLzBXRWgvU1E5N0VlVm01VXZ0aHJiaFdreU55WFlS?=
 =?utf-8?B?VldYVUxTdy91MTN3SjVVbjdVVFZZTzZhTkpJbm5tV2lXRG5MclJjdFZpZHJ6?=
 =?utf-8?B?cXduOU54eEhCMEJCYWxFOFYzeUIvdW4rRUVSVmkzZ1hROFpYb2tMaThCRGlm?=
 =?utf-8?B?bDh6YjN6ZkYvOThTUlJLM0E1MUZwVythQ3hiSXAyeHF4dFAzMDYwbS81Q1c0?=
 =?utf-8?B?bTdOemMvUEEzdXhRVytxZSswOVo3RXFEdXI0NlhPbisrckw1elRBbTJLY1N1?=
 =?utf-8?B?SlpLelI5TXpyeE5PSS9FRENoUWI2K2RDR2oyR3ZZRThtdERpNzRPZUdXUkNH?=
 =?utf-8?B?blNkR0VoaWJEdG56cU1BRTFMZ0V0eHBUTDgwMzVkYWd0RU9ST2hFT1FiaUlp?=
 =?utf-8?B?dnFpWG13M1ZXRE9lUUpFdVArRkdMbWdwZysxbi8xME9nQk03Z3F1eHBabG1j?=
 =?utf-8?B?WjM1QmdFSHFub2dkR05MN0FrdWxGWmg0RkMzU0RuY0x2RW4vVHMrNStYUHpD?=
 =?utf-8?B?SERUQStPVWhubTRRVTZiRjdSbVB0U0dCc0N1dWQxRXJzUC8rR3dNUjV4TXVy?=
 =?utf-8?B?N1RBaXhuelM1ZDk4RkkzWHdEeFJFMU1YdnZJd3lZMGVsMGg1YXV5MktyU2hU?=
 =?utf-8?B?RVZPemFBSEwwaU1qdmZGbytnYS92cCtLTzV5amFZcmlOSzVabC9CblFnZG9p?=
 =?utf-8?B?YndHUXJCczFaaGxPUERqZldsUCtSRGh2RjRKOExvYXhBU3dWY3ZaV0xYeVdr?=
 =?utf-8?B?M1BBbHFJN081dk1sK3pRRStVdXl4aGMrZFZ1NHZFWkdLalRicHhQRDVubXY1?=
 =?utf-8?B?RjBzRGtTdGpVMjRiTkNkQ3pZT2xyK0J1cWtXMGRURDYwTEkvU2dxc0ZFMnBy?=
 =?utf-8?B?cWVPY1NFcjMrMFFxd0lUelV6dzNtdzRXdTRMaEg0elNpbStYTGJ0eGllUVc3?=
 =?utf-8?B?NHk2WjF4dElxWmt5Q3d6b1VBa25PK3EyQU00K3dEOHN4YzhwOE9pNjFXWDVK?=
 =?utf-8?B?OEIxMzlsTXJva3o1Y3c5bzBGbU80NE50UUh6RUkzSGlBYUgwODNrRXJyenVr?=
 =?utf-8?B?NHFwYUM3bzZlb3duWGxjL1Z2SzJTemNTeGcrcDc1dnFGc0Zaenh1RitjRlRW?=
 =?utf-8?B?YWJzblpCUFhjc1FSTUlFUXpXZHhrZDFOS3UyNzRrRkNtTlUrWHk4WjVSb21R?=
 =?utf-8?Q?t5tmuwwakXvxHb+UhDD99TIwsJOFLcsicnBgTaa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919598c4-0e01-4f7f-a4de-08d9298dd88d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:25:44.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEy+jWU7evCh/1KYm7tLSUHYdsvI0B1gbfhgPhqWOkEAfjvm83h8uTXlhYDH7Pw8Gb644OR/k4ox9HzJjDZ8Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5019
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQo+ID4gT24gRnJpZGF5IDI4IE1heSAyMDIxIDEwOjE5OjM1IFVsZiBIYW5zc29uIHdyb3Rl
Og0KPiA+ID4gT24gRnJpLCAyOCBNYXkgMjAyMSBhdCAwMjoyMSwgUGFsaSBSb2jDoXIgPHBhbGlA
a2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhlbGxvIFVsZiEgRG8geW91IGtu
b3cgc29tZXRoaW5nIGFib3V0IFNESU8gdmVuZG9yIElEIGFzc2lnbm1lbnQ/DQo+ID4gPg0KPiA+
ID4gSSBhbSBzb3JyeSwgYnV0IEkgZG9uJ3Qga25vdy4NCj4gPiA+DQo+ID4gPiBJZiB5b3UgaGF2
ZSBhIGNvbnRhY3QgYXQgdGhlIFNEIEFzc29jaWF0aW9uIChzZGNhcmQub3JnKSwgSSB3b3VsZA0K
PiA+ID4gc3RhcnQgdG8gYXNrIHRoZXJlIHRvIHNlZSBpZiB0aGF0IGNhbiBiZSBhIHdheSBmb3J3
YXJkLg0KPiA+DQo+ID4gSSBkbyBub3QgaGF2ZSBhbnkgY29udGFjdCBoZXJlLg0KPiA+DQo+ID4g
U28gSSB0aG91Z2h0IHRoYXQgb24gbGludXggbW1jIG1haWxpbmcgbGlzdCBjYW4gYmUgc29tZWJv
ZHkgd2hvIGtub3dzDQo+ID4gc29tZXRoaW5nIGFib3V0IGl0Li4uDQo+ID4NCj4gPiA+IEkgaGF2
ZSBsb29wZWQgaW4gQXZyaSBhcyB3ZWxsLCBtYXkgaGUgY2FuIGhlbHAgaW4gc29tZSB3YXkuDQo+
IEkgd2lsbCBhc2sgYXJvdW5kLg0KV2hpbGUgd2FpdGluZyBmb3IgYSBtb3JlIGRldGFpbGVkIGFu
c3dlciwgeW91IG1pZ2h0IHdhbnQgdG8gY29udGFjdCB0aGUgU0RBIGhlbHBkZXNrIC0gaGVscGRl
c2tAc2RjYXJkLm9yZw0KDQpUaGFua3MsDQpBdnJpDQo=
