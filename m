Return-Path: <SRS0=AGpe=AT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B1C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 01:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166A120774
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 01:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcCYZPul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGHBcj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:32:39 -0400
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:40682
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727945AbgGHBcj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jul 2020 21:32:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgJLre4K8kbvhe6x2I0dPinj3/buIYZmeRUzeyz4g0lrCWxMPXqPm24daDtURDvc8ITN4qqe7yeYKFAnudmSMyPeMyCiR9en79E4XxD6IQuEN+D9C1OQpLmtm9l5wcD6ETJyIPP6nIVvutxSgmGhlgAn7t5JFtAer95pCNqTt/rIpnLaMRnnfFjAwdj9VArbEDUedUPIdNxh9ned4GCKonAM3wxG0njs00njpOO/IRqiP86kxOx593hdbvr2djDTwNbLjA0+WGqECnDLcnxzp+vMSJt72jLzpMVuqpL5FnpZ+VaWcqI+qELR8kg35L92GyP78ap4mX06bud96NisIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCVsP4NyYQtBBQECbBa0WV2TJG0OFUO0231KoC7+L2U=;
 b=k70lvlhOvS+V/sO5JzR03rNJSc+ZaWCZWT+L3brPhSZYURHYtxnD8xNQLnAmKNYZjPI6ZRGfbV/N3HvMBc8xtZOPJ9EMuRBOwCmPNYYXqGkJXKTVUVuyx/QiHvkjb3SQGW2FNmlLYtHkZO+ObyLeJYkZ8kuABwYuseQygYaN50GDVFm/fIvmvxRautJYWALiLrKLDZf1FPetlab7Nb53Z/bRqchWuNXY0BTJr9MWNPFNhhPjrl7srqwnP2RBb1r49Mknwcpn6fd00RW5wJW+vuN3cR0RyxA+sOkld6wDfo/X0XF1gus7c9sP3SWLck+uSsAsdUWRXA7hTvTXMlH0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCVsP4NyYQtBBQECbBa0WV2TJG0OFUO0231KoC7+L2U=;
 b=gcCYZPulW2/dV2iYPD95srZCJHGFQShrdNkhdW+PhJeS7yPYUOEp1TtKfFAh2mI27OOEXZcXnibv8L+GeAKTZC56w4sXLquSRKb4C4mnPUujY77DuJ99XK9Ewofz0RRDKch99EJJJsL5e0qXpz0xq8/2Sg7pm/l86j49PEid9pA=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0402MB3837.eurprd04.prod.outlook.com (2603:10a6:803:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Wed, 8 Jul
 2020 01:32:34 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::7545:cf5d:b8b0:4ab0]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::7545:cf5d:b8b0:4ab0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 01:32:34 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Angus Ainslie <angus@akkea.ca>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: sdhci timeout on imx8mq
Thread-Topic: sdhci timeout on imx8mq
Thread-Index: AQHV2sbvCEHvj/D/X0ygL9UYOXYdc6gMVz+AgABAnwCAAmog4IAJcLlQgACPfoCA2XSGAIAKjH+AgADV0LA=
Date:   Wed, 8 Jul 2020 01:32:33 +0000
Message-ID: <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
 <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
 <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
 <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
In-Reply-To: <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b33dbe0-8d2e-4903-e87d-08d822dec9ff
x-ms-traffictypediagnostic: VI1PR0402MB3837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3837CCE6EA78C4FA9FA1FD2B90670@VI1PR0402MB3837.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPbHmfeWwEijRqYxZcYZnaiLKBo1wXj0v5f5fX7m0x1ZUD2/YUOkoRIHMC+eRn+BQEVgkxYZrrYwFDgUIi/444hk6BRL+lwtlY+JpHD9voa7riqrwfhcS605jfsv6AzYHcQNHCf1xLEM/EZ4JomRzO3XEjIxswV0ytSzN2vHlbyTFvvPmclQbp0zzzQrD/6KPhHjFnVfkDlNWVBN64X9MK1Sc86SZxxYZ05FRoMzQ0KXfeJkfCwyGo7EesKYqTlNQXOj8/u0GHEThCmSXr0r+sfKxbnjRZi6JGwXlHHuvvnVKVHffnkFaq8/Ooc0RuxsXlTSv6GjJ2PFv9Fdw86Qn4jGSO4FXEvthjjBowupR81AldO8phKmgbnf2wj7anq9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(53546011)(26005)(83380400001)(186003)(66946007)(66476007)(76116006)(8676002)(52536014)(66446008)(64756008)(66556008)(55016002)(4326008)(8936002)(6506007)(478600001)(7696005)(9686003)(54906003)(33656002)(110136005)(71200400001)(2906002)(86362001)(5660300002)(316002)(4744005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JMfS7tq7eB3jzMr06l5ZJXQ3bM+D7bJZnN1C33+icstn96EnRb+33dU+pAe2GZ0niaqc2+FdEDc+X2VSICld1+jdWjBdd6mGp56a4RwxAiVoeZpUHc+f26QnbEzdat7a6JEdSbDS7VxhNCnpnRb14n0SjeRiQ9uLLwusODqkjEKaGJgTmSUM2OwMKavHikoLKu/NydXHukrzp/3xtL3B8U5+L1D1LPGwTF6ePhe4aWekwFNCXv3r4W7yOAFcYT7f8y395WKHs4hEv6ie/cGqCcECTxr7We/nWNwdrNuhW1pZIbIZK5NflHZMIZtbFsYajV16zRbUxZUWrZsOPYltnZhUFMde6Uj6GAycBY9n4nfdmORnUnv9C21jLn0ypVWTdiHEfZgzEk4pxBZa6Cn4SRTtgJIEh/5H91P1f1cpyeoJ0Q5RtArRJY2Vfgrhrw2tLwrZha7Wvpw0DAzP7zoPByM1kFEtPVyaMeugrro48u0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33dbe0-8d2e-4903-e87d-08d822dec9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 01:32:33.8361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmKTeRlfFsJud0SYwSYiWs31VzaG2V5C1PQsMA5rXi1sisilY+zQ7ueO7KpyFGQzBwER6pSSBZRA8+nQxKCNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gW21h
aWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+IFNlbnQ6IDIwMjDlubQ35pyIN+aXpSAyMDo0NQ0K
PiBUbzogQW5ndXMgQWluc2xpZSA8YW5ndXNAYWtrZWEuY2E+DQo+IENjOiBCT1VHSCBDSEVOIDxo
YWliby5jaGVuQG54cC5jb20+OyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9y
Zz47IEd1aWRvIEfDvG50aGVyIDxhZ3hAc2lneGNwdS5vcmc+OyBsaW51eC1tbWMNCj4gPGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc+OyBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVs
LmNvbT47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBTYXNjaGEgSGF1ZXIg
PGtlcm5lbEBwZW5ndXRyb25peC5kZT47DQo+IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUg
SU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZz4NCj4gU3ViamVjdDogUmU6IHNkaGNpIHRpbWVvdXQgb24gaW14OG1xDQo+IA0K
PiBIaSBBbmd1cywNCj4gDQo+IE9uIFR1ZSwgSnVuIDMwLCAyMDIwIGF0IDQ6MzkgUE0gQW5ndXMg
QWluc2xpZSA8YW5ndXNAYWtrZWEuY2E+IHdyb3RlOg0KPiANCj4gPiBIYXMgdGhlcmUgYmVlbiBh
bnkgcHJvZ3Jlc3Mgd2l0aCB0aGlzLiBJJ20gZ2V0dGluZyB0aGlzIG9uIGFib3V0IDUwJQ0KPiA+
IG9mDQo+IA0KPiBOb3QgZnJvbSBteSBzaWRlLCBzb3JyeS4NCj4gDQo+IEJvdWdoLA0KPiANCj4g
RG8geW91IGtub3cgd2h5IHRoaXMgcHJvYmxlbSBhZmZlY3RzIHRoZSBpbXg4bXEtZXZrIHZlcnNp
b25zIHRoYXQgYXJlDQo+IHBvcHVsYXRlZCB3aXRoIHRoZSBNaWNyb24gZU1NQyBhbmQgbm90IHRo
ZSBvbmVzIHdpdGggU2FuZGlzayBlTU1DPw0KDQpIaSBBbmd1cywNCg0KQ2FuIHlvdSBzaG93IG1l
IHRoZSBmdWxsIGZhaWwgbG9nPyBJIGRvIG5vdCBtZWV0IHRoaXMgaXNzdWUgb24gbXkgc2lkZSwg
YmVzaWRlcywgd2hpY2gga2luZCBvZiB1Ym9vdCBkbyB5b3UgdXNlPw0KDQpCZXN0IFJlZ2FyZHMN
CkhhaWJvIENoZW4NCj4gDQo+IFRoYW5rcw0K
