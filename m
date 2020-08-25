Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74102C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C87E2072D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 04:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LC3ot+Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgHYE6K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:58:10 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:41940
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbgHYE6F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 00:58:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLoyspInkfYkX/g3c+4LXx1S+gp+YUru/QHlh0IxOPZqOFmRUdetD/yIrPkFuvTeUyhWbw5DnLeSOgjtji2iQzIa+/nJx73wkYMB0e5MQWwoT9jdMj45tfZmoezB4dbNGs+jTrOL7lVMFvRkzfi0h1nS1/rJKtEPf8fzByd8atJFENj9ZG+YChn0TX2mErb5lTA1OOab2sode9q2NUvP4TkVBW6XXuwJHxszF6cUteIS7GHgGYMJHbmNxH7x5N0xfPm2cxFZqkJj33B/JTdlw3b93vpIlPjDYzQvv+GkPjF01JeDyPYbtflxVcHjz6Ln+AYrCKI8CgfWTfr0VV0xVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt81K9lTCWgkQF4gHCHB9yjUBPufJwEE+V1hVKJR8dM=;
 b=CZce8uAn7STA8VA0L3ds2pOb0Bxo/Cgwe/UJNLoe+L/Cj+won//+NmULDLXHsugHpq43WkLuQbFKTx6TSWMLv+1t2BpxeByAnWz/3woWCv8hfB1sL8w0opxQp7DRbfppLhHf5Dng/mQ3ThA6ymaYCpcbx0HySN2YkuUM38cP3w/O2Yq0/CBgFLyfoVdxecSDmKZaPEcXGr+oJPz6B8qxWr1doHsNBaCIouSAwwy1qpnUq4WIcrZt2IsjVGGx6MijfNMyApch6iiyQAkgVJsBsh7P7pWQx3idaIrCYS+53rQNVa6ZmF87Xngbh0lTHziiZvU5wI9dm1lri3d78FQV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt81K9lTCWgkQF4gHCHB9yjUBPufJwEE+V1hVKJR8dM=;
 b=LC3ot+TzLdfz6dYe0WOlY4GK8ZNGWTc6iKgXZI52hiJ3VkEg62vcEuHcjaLYPXv0k6vlQFtAhymbL1XFGki/wx/7cCc/HZGkRDK7Waos19ltQcETQLGBh/iLvGWJevTyIhpZ5dV/fsLAa6zg6Dyw9I5Id3yKQzVCm+GxYkVWNkk=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BY5PR02MB7026.namprd02.prod.outlook.com (2603:10b6:a03:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 04:58:02 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::48ec:6240:92db:c6bf]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::48ec:6240:92db:c6bf%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 04:58:02 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        Michal Simek <michals@xilinx.com>, git <git@xilinx.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mmc: Add missing description for
 clk_in/out_sd1
Thread-Topic: [PATCH] dt-bindings: mmc: Add missing description for
 clk_in/out_sd1
Thread-Index: AQHWefAjQIJv0fgL10uselMOSXyRxKlIQ1hA
Date:   Tue, 25 Aug 2020 04:58:02 +0000
Message-ID: <BYAPR02MB5896EA24D2A0BE05BDE71451C1570@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <aef586778921c93377ec2f31c86e151b6e93f6c7.1598257520.git.michal.simek@xilinx.com>
In-Reply-To: <aef586778921c93377ec2f31c86e151b6e93f6c7.1598257520.git.michal.simek@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [103.250.157.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34f2f94f-bf5d-4a47-d2d8-08d848b37230
x-ms-traffictypediagnostic: BY5PR02MB7026:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB70265BBF8D34AD3A1B851927C1570@BY5PR02MB7026.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gik6MlTfieNn3gr6mLnpRWClx5qqJ6veLBmbMAjU3ka5+D/g76iKV1bAhrR+CfGHV/6qN+8N9MFs7Q9pr2O+0eYiLoYUi2aRiSHnf86HZ64L3OkMZO6o3CpIDkVB9jiw+rNVZUsG9CUPO93Z2nFcwPISpWxL/ISbjnKqGvOdjN3dr14K1P2opvAooZNlfRTs49BGjgmlmdtiagqr00HJeMTjXB1HTDiOYnEBdjH3ztrPHZgl3atXfMQKdQMQ++WOWHxVAspbgScS7TpajcLQK1X2vb8osJFyhxrtt6CiKEXbFo4KB0GcLrJrBFi258ac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(5660300002)(6636002)(7416002)(66446008)(66476007)(64756008)(66556008)(8676002)(4326008)(8936002)(316002)(76116006)(110136005)(66946007)(9686003)(55016002)(54906003)(6506007)(478600001)(53546011)(186003)(71200400001)(7696005)(26005)(52536014)(86362001)(2906002)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ms/xqj3L9IazqZHRqPMbofng3VziS1am4FZ19zhYDiGBc0tsYhaO6+lnghtpPYBnro0s3+iIXx+C/1B4PX/5kCZ9plZdZ8jJoV5xcdQ7KQ1gSNNv4ysbjCJ2orZ1xRgqJKZ4QmqrZ2oJVlbNVdf4zXyCRGK5mjJ/UrGpuvUQc/unbYEb/+y13VZSFwPrAQX3sM4BB+ne/szN78q7GyGmFtIGXFZ8seqNKcR0/Ok23oJ/n76kLtLZO27pEXlSic6pIY2Pih30kQ8wZck4DOwhE0hMT3Fyh7toLWpkMD+lXj/k3GoXR5HiRorXVuNPqsxpyAH6gKOfbHz4+SqA2oi6+7ON6+bfnH2m/g65a5Nnrb2BV4D/2KEceIeS3pUsyhH1S43rqGCBAov95KFj4pSEojmB/9CYDpfREyRNyc2MbY/HFMfY/qIqJceba1IdT5S4O1FdE0Zwx0r8KZBHJYwmuin7Ofu2IOzpnFpj943sOhOMq1LdQnUvwRhpKGM594V4jHFMJ5Q4nSiyV5y8TnGeUsPCOGFpjysUJSswQPmmi0j/JSvy9WVrpk1HkRx+bAWVXNqJ9qyxDYaJ3h9acLx0iKcmv+Eu3kdJrpkIRbeo1YlnZHM7EIH416Mv/b4XlPS7JlGACIfKaSVwbW3bICqntg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f2f94f-bf5d-4a47-d2d8-08d848b37230
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 04:58:02.4033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYzU352Ck4fSQqFAkXurBYJ5E4nEKc25h9n8z5rq5midqSF7WP/ffXGl6tzZygOTcI1pkaD2bJs0+OO2pJn8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7026
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Michal Simek <monstr@monstr.eu> On Behalf Of Michal Simek
> Sent: Monday, August 24, 2020 1:55 PM
> To: linux-kernel@vger.kernel.org; monstr@monstr.eu; Michal Simek
> <michals@xilinx.com>; git <git@xilinx.com>; Manish Narani
> <MNARANI@xilinx.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>; Rob Herring
> <robh+dt@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Wan Ahmad
> Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> devicetree@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: [PATCH] dt-bindings: mmc: Add missing description for clk_in/out=
_sd1
>=20
> The commit a8fdb80f4d47 ("arm64: zynqmp: Add ZynqMP SDHCI compatible
> string") added clock-output-names for both SDHCIs before DT binding yaml
> conversion. But only clk_in/out_sd0 clock names have been covered by
> DT binding which ends up with dt yaml checking warnings as:
> From schema: .../Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> ... mmc@ff170000: clock-output-names:0: 'clk_out_sd0' was expected
> ... mmc@ff170000: clock-output-names:1: 'clk_in_sd0' was expected
>=20
> Fixes: 16ecd8f33c6e ("dt-bindings: mmc: convert arasan sdhci bindings to =
yaml")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Manish Narani <manish.narani@xilinx.com>


