Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3435C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 00:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D33A20769
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 00:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbhAVAzy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:55:54 -0500
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:45984
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbhAVAzv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Jan 2021 19:55:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAShxNaj3i5o05cYgCwHF07jyV0O6CkBpapXKp3YDI8wGpkGPRcDJzSbp8CqZG5GCViYF6M0s5fj1sra3x2Y0OqwAUh6NfdfgyidYyhr4BRIeHw8AzwblHs7LsoDkexWnH2+zYx3ROz8ewpdyjo9OS70mpPEG7BNYAA6Ae2HfyprAHe7Yh6OyFMffQpZZQqiCN3gKLEQt+Wmw8fZQbBemba2Lg7h7U7tgm4FkI7TTp0AB14tqL9Qn8svQOjPmwpS+kQyswYSyuwdwZLC5S7PQUGjveXDcZ3mFTFS+Nfz0blgWhM+48f1+FLH07qfYgbXtLJhwiaQfh9orx7GRW0Hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm1f5xyAhpwlg9rXv//B2JDwCcZkMY3eIHHVdIgxyLc=;
 b=mXQS3pozsOpQUeEOAmDuMT4BtFXQI0n1qHTcPewHelAd60+SFtvGkk6G+COk1JyjalknpKVVI8i7bLs2Rre8Hoyfod/WO4O0YK2UwiayDQlUDMsAaqq5/LQ3ha0SywfmO95wfZK6PtU1GeqhAMrivtfB7jWx4E8Y7rz0FjYoFe8uMNluGy++/sTIP36KPFWvBnI/KmxEkh/1yiEmHXoXzpenXI8+1b/2HePu/PuohRDO7acFpLUwiEqwytQkZUAKpG4Dn3pOrfBkUvssD1hfZ1uOYoocIX3OWWFkMokiWOXy6w468glcjBpUPVJIRfiesCeJa/0QLJI1LoTENp4ulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm1f5xyAhpwlg9rXv//B2JDwCcZkMY3eIHHVdIgxyLc=;
 b=XBFNrhdVXnhtSqKJ02c/tFHwPVknjPjCZwdgEFeXxdQi5k9F+LX4DJN7FgYA9HtJhTZSlgrdO68WB6BAMd3lONQCPWMzR8oi5ataMpG2l5YQDXkdCTLXm7rvaVmjYgH8FyAVgiYjL8lyPj+DPicySrPpkd2PUCnl9kqJV0jXq1A=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3014.eurprd04.prod.outlook.com (2603:10a6:6:8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Fri, 22 Jan 2021 00:55:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.016; Fri, 22 Jan 2021
 00:55:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Topic: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Index: AQHW76RbnTiL5ZvX1kWERWBmR+4aWKoyPjUAgACUjIA=
Date:   Fri, 22 Jan 2021 00:55:00 +0000
Message-ID: <DB6PR0402MB27606B6ADC13EC6F889D9A9D88A00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
 <1611198593-16287-3-git-send-email-peng.fan@nxp.com>
 <1611244918.545866.2814847.nullmailer@robh.at.kernel.org>
In-Reply-To: <1611244918.545866.2814847.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afa00dec-1822-4b6a-7542-08d8be705886
x-ms-traffictypediagnostic: DB6PR04MB3014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB30148DD8BFEBA5F9B2BCC86888A00@DB6PR04MB3014.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8U7/AK1U+bmqFIpIpzTAybuX7xxLZrY9+IGdOlW0EWr6a3Omu30EDrFdRY6+l94rWamunlu3FN/34cI2iiOKZdb/S8jj8hv9s9FhQwCf6lOZhQxji9Nnv27e1FFmBij8hs1IBCm/UqDF6yRxlv4LA/slbj+SOUijd8H9S1mhlX+c5tsGyJzReHxkedYKjW8yOOYJYSL0l4itSYmyYC75CHvZqyf3cp0hEl3ui7/zRl4XHkVAp1rlgC/IAs6R3HeVzcagY+QofzQoAIaip25/orz6cuCt/x45PwKXQBhrmEbXcoZCUWMzIMypdPxpuB23+mpQBAcimIQLTnbsrukokKPQB/utYaQk2twedT0fDgCdejlO+gwxLSmPBAuqyk5w6U5vYnA0slx1MuGVCeaNdfoFa3HhasDY4y7MDOp78e1yJuyCng+EdX/+gB86s2s0P8A2O6ouY3p68yGvtDLg+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(55016002)(966005)(76116006)(5660300002)(8936002)(45080400002)(26005)(7416002)(9686003)(4326008)(316002)(2906002)(186003)(71200400001)(6506007)(54906003)(478600001)(6916009)(8676002)(86362001)(64756008)(52536014)(83380400001)(7696005)(44832011)(33656002)(66446008)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NFuAqprfKSZrl3Zvf7SCz3zTowPaGJ7WdQ1nFGPoqqkJYyiSlsOkGTNtXxpr?=
 =?us-ascii?Q?9cDu0L8IHWc5bN6CEvfbLKGggpPN9LV97KM+E1ZT+RnhFAPWvEUqXhfT5PCk?=
 =?us-ascii?Q?p+GEONX5sBfYsUT+weOLBZQnihdzJd5D00O+27PJzXI/PoL/DkyyqyBXvZ1u?=
 =?us-ascii?Q?RY5GUrGyUD1K/vss8GtFDVxLhtJhk8+x8MiyeHE5v2wzCmcmbVaMSsQ4UpFm?=
 =?us-ascii?Q?g0CoMgirqtNRAcjV4pNhvRlRpTLaaEot6DZh5I6GcEWrjvHBd4zkB8bzMpHG?=
 =?us-ascii?Q?ByDJJUuTvBL6Z3d5nd8chF4pOQRhzhuN7SicMuvT9FhWv7vYje8sOxIlqR3o?=
 =?us-ascii?Q?cie0xeOVWxV/qYyQu+CPWGa5AfBIa77iTWbwd7WxG4Q+RKDFi/A5Jd4zX4AT?=
 =?us-ascii?Q?zZAXoPO2C323iUl1QHNhSMK+uPn3qeq6XyB+ON3vvQSO0nP3pykAwgqMZOoF?=
 =?us-ascii?Q?XwiNlYQYxj5SKfsqMc/YXCetkCKrGeZ4D7MhTW+L9QMhQpp3/++eeNxAiDEa?=
 =?us-ascii?Q?YwRjiztxqtNqsMy0FLx+RNI+oUY9gRPc1bP+SGbbOcSWP8XqfwaN9PlTAZzj?=
 =?us-ascii?Q?+41IqJ9Fi0VJ5E3r6sUDehHON15K37mfxj4rk9kfALPWING2XKb6d9Xq1fya?=
 =?us-ascii?Q?fkL/2S9inBelHYS/Od8/FXAeBd9jMljiXMkrf3YPjriu1skouA8DZrhF6vje?=
 =?us-ascii?Q?FwoTytCzrxhdKc4XNAdv1sk7Es7Ia+8siKwUdeffFTOLuwtFUswaiLBf7l53?=
 =?us-ascii?Q?I0V5BpUNucMbeFcI4vwy3jSvhqtmqDixekXY1xG4rarxvRMY9j8PiXIqBFXj?=
 =?us-ascii?Q?7n2RTfPsU19DWKmgBC1Z0vZN441xDdV42SwsVqyS58kJPfFtWzgaON6C+30T?=
 =?us-ascii?Q?css7r6hVJDcABt+nD2/nGQDjqwLQ26FYCfLOmEAagXgDVmHMTw9iRhbPR1Bf?=
 =?us-ascii?Q?jhvXko/O+k0CJ6/TGLeopsBZPMNJ32JjCFCQm/gweF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa00dec-1822-4b6a-7542-08d8be705886
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 00:55:00.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvpuE1MLGcPG5ZW6MRW7LmD9Nx/xU+SKKB/0ELr1TwiMnpz+/999JAUJhj12JlfMnCVaoNz/v7NQY3L5pKz4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3014
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock
> bindings
>=20
> On Thu, 21 Jan 2021 11:09:51 +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add clock bindings for fsl-imx-esdhc yaml
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml        | 11
> +++++++++++
> >  1 file changed, 11 insertions(+)
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:

Patch 3/4 addresses the dts, actually I think it is the dts not use correct
clock order.

Thanks,
Peng.

>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cloc=
k
> /imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: clock-names:1: 'ahb' was
> expected
> 	From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc
> /fsl-imx-esdhc.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cloc=
k
> /imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: clock-names:2: 'per' was
> expected
> 	From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc
> /fsl-imx-esdhc.yaml
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.ozlabs.org%2Fpatch%2F1429619&amp;data=3D04%7C01%7Cpeng.fan%40
> nxp.com%7Cc543c002a0b54348d48408d8be25ec0b%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C637468417375412086%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C1000&amp;sdata=3DcISWAn3kYIoqvxr39Mu5NL6rwkebmk
> VN1drRi%2BDNwAs%3D&amp;reserved=3D0
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

