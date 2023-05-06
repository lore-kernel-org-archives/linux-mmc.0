Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F5C7EE24
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 02:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjEFCh1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 22:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjEFCh0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 22:37:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944982D63;
        Fri,  5 May 2023 19:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWmuVxrNopuvVQC6LQ/gVBvmU5uM/JwpZUj/QRyzTaTS07mYxJzZ8wi/DP74aNe8OeegF+SmVGn+N5TVnqfe0UTVPB6YokZUWSl/7AQJ7qAd9+oWHzEF1mf26CwSh7c6pra9abRehFOYG7wq0nSzeNDS7ouTcrAyFRAKJu8dd0b84GCNYkKMEdfxJZ5LhYr7F4edp/M4m59SCFvx6pM6/yHINY/9wnQ2kRySQojhZfMe+baczlOaoAArCqut7BnNUQwMCKsVhOqf75WNc/ERrHensUn8HVyntUcI3aMMo1EdepQd4tc379hBpUs4MV9XiiqvLrHxlf5GVAQHEfpXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S7fgci7WRthgUM82rIhJhdWcH2HPvJ/CynlqomncM4=;
 b=BZ8N2QgZoOj4kLwxh2WzbWKJCdru8LLgqrInVS8Gcbr4FREmkt/br0ro2ONyTWgeF7lZzVhN3LMQvPzfq/wXabyl7wDSSRczlU6pBdhjcusGKTvac9YYgEeHBs6Rd4/ob4ne+Vh05CjPjipUl4rnOT2hlW2UCKwMnfTjotVB3U2Oo1+1pyHKnDFaxG65eWQKlx8eUHlhYZuG3A9knKnHJIatylhXGfPtTtrbJuIbQJ3nP/2R/dOIlb8Ys42t5VQ1OWV0HQ9u9AqWZGOYQ1O+hG4RHD6ysmR5/0YjcccDv8tK+UjQaALqlOfdMcn0OY5p/BtLY5Ph5zLHE98J7cX95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S7fgci7WRthgUM82rIhJhdWcH2HPvJ/CynlqomncM4=;
 b=UEF/GTSCuaZ2+nXZQkz4oTg25LXycnWTtShKep/J4c8rYkitTPImVkuaYyEEva2ttnbLkcDjmaKIZqQaIqu1Fm4UNDtk7rl6N1aCCT4JRnMvhEGbWbXgwXBwhaSOfU8kZVYkhR1ZIPDAPUybYKDVefzILsbWhLcpqSLu6oy+cyw=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 02:37:21 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 02:37:20 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>
Subject: RE: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Thread-Topic: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Thread-Index: AQHZfznU1FszfifvBU6TZCq/G3gpYa9L9PSAgACSxpA=
Date:   Sat, 6 May 2023 02:37:20 +0000
Message-ID: <DB7PR04MB401046EF6FFFB367BFE4741090739@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230505101246.289278-1-haibo.chen@nxp.com>
 <fe8c1063-b8d4-1707-5434-89b3d1edf1a8@linaro.org>
In-Reply-To: <fe8c1063-b8d4-1707-5434-89b3d1edf1a8@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM7PR04MB6807:EE_
x-ms-office365-filtering-correlation-id: ac889e49-f480-4e2e-bfb8-08db4ddad0c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77bzyyGzzPtRWimxQp8sVRDMMcAk96GKsXBZ5UNpRvKAOJIzIdXeQnADNqd4smb+VKZwo9JELqt6clIr+ofCIR94pjUmo2lOKJiQeitwmNxQrZvcwh1rf2W7eYkxGOA/3xal1BzQXEjVDIeSGt8K1nGzkUJCWEY7mSt+NGlTJ3xNhpakhbgYwytVMcVAi51iqAuh1/UXlVUQQtAB6jKCy4fo++X76z1s4fTYOVKjDvriBaHsc4stmeRlV83sFwUxx36PtvC2IojqibMI4iABLfUPz56Rus6zgiSXGTBh1NL86fRXEzgWF+mUgHqQXjqf3SIVoUj1+L7kK5Z/GR4m7wLTPqEmPR4PN/MzpAbB4/1yGfYeEbiONe/pOlgo4XAW0Nuu03/MU24tN8JRi8zxvqQpa+n872E9L+FdH40w7qtwsVxrG+svaCf00ScPjLAMYyUBf15tYcxx9UxBXWYcIgLPw5BHwaTyj8sj6aB9RcXc7vldQyxPUWUyzcdl/5OhcWbrinAfTGFoWbKAwVjtLbu3Vg5cnU64L03/mSdZyHh9A5AWks8V4OcOY5y+fslljmAzUV2kfsEymoGsJoS4GIB+KDxRT+vt48f0rTt824k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(38100700002)(7696005)(54906003)(110136005)(71200400001)(316002)(66446008)(478600001)(4326008)(86362001)(66556008)(66476007)(41300700001)(76116006)(64756008)(66946007)(55016003)(26005)(186003)(53546011)(6506007)(9686003)(122000001)(83380400001)(8676002)(8936002)(5660300002)(52536014)(33656002)(38070700005)(7416002)(2906002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDNOOXR0UG5VeFFKdmlTMkUwU0RRY3hmNFRZZHlIN1ZLUFFmVXdpUkwvamQ1?=
 =?utf-8?B?NFJodEJERUFrbUU3ZmtXczhKeEdNYThnNjNyMThpY08wdlJZSHd0UnYwV1My?=
 =?utf-8?B?aVFaTlRLYUpnVTl0TWwyMStoUWxRRDdKTTdsZFZGTzl5U0xZbU1odHNiTzd3?=
 =?utf-8?B?K0NUQ3pnMzVaYlZOMTJRUytHaFhIWitkVlp6UmFpU290Z25VOWdkMXJFNEFp?=
 =?utf-8?B?ckd3UXcwYTRhOW4zQjR0aWpHcHgvaDhnbWZKejk0ZUN4bVdnSWVuY0hmV1dt?=
 =?utf-8?B?NnpXTU1hcmszaDcrVmd3UjNuaC80RktUN0c5bFBXUHpzbWNEQWFMNkJYeHQ2?=
 =?utf-8?B?cTZHNHB4S296UkhSSE1FQ2ZWZHA2S0FPcExISGcwYnhuSi9YUDhCSjIvTzF3?=
 =?utf-8?B?WG11bjEyWEZVNXBKSnNsT3gvN3JFNTVENHVyVGc2R2cySFJuVGpWa2cyYkFy?=
 =?utf-8?B?V1B6eDRZUUVBN2M5RG5HdUpkbDhXQzgyV2h3WlNpNlJUSmk3WUo5NVNrQVdr?=
 =?utf-8?B?ZytwNmhSNjdLVkFtZG5veHJ5Y21URVY1Z3lpTGFNTjU4K0tLZjd2T3JOMFpF?=
 =?utf-8?B?OW1mYmJFWStVSzlRTko2Q3V0dVFsVUUxR3FHcFBBUnBUTjJBclNGMGdZcCtD?=
 =?utf-8?B?b1g3MWF0dG5aS01tNFhzR2p1dWJoTUN3ZThMRXNXRCs1SjE4T0xVZUhRQm5L?=
 =?utf-8?B?RU9ZS0NncDRTcDdrdHVYb2V0WEtxdkRSR2lhbHZTVkJheE9TcDVnVjVGMGFV?=
 =?utf-8?B?TWhLMllYQWNEaXZwV2h4QVc4UzNoMGRmN0NQSFJIc1Fwc1RCb2NmazBHYmFZ?=
 =?utf-8?B?Vko1QXE4dk5Mc3JyWkJqcDQ5NU8xUWlKb0dBclQydG1VRm1WSCtZeXVlM2pi?=
 =?utf-8?B?bGx6dkJkTGZtNk04aEtoVzA3eUR4UjhMczVaWkYwdkQ1bWZNS1NjUFZ4TWJT?=
 =?utf-8?B?TkVJQjl3cjl1UjFHdU1LOWRTV3B6N2tielVxNTJTQ0VkWXBaczB0cWJnRmdZ?=
 =?utf-8?B?OHlhUlpxNmFtMDV1N2xvVno3SHVLQlN1UlVCbEVPUUFUTkNlbk12SmRwWGhz?=
 =?utf-8?B?dzNjcjROUVBPQ1JhU09rRWFIMGZ5TlpQc093L3VIWHJGdXVlNFhPUkpoUnp5?=
 =?utf-8?B?MUZMKzRETDR3MDQyeFV1ZXN2YUQzc2I4a0pYYUE1SzBXRDVVUGJsZmR0ekRK?=
 =?utf-8?B?L0hnSEVkRm92QTJJa3VHaEpHYTlaWjdXTTI3UzJ4d0o1UEhzODc0QkRQL2s1?=
 =?utf-8?B?SHBOekIvZWYvaDMyVFB2RTVCTW9tN21zb244L3pBM1MvMU0yQWFZZnlDRTVy?=
 =?utf-8?B?SmY1NnpOTmtReStoNDlRQW5GMHBkaFNwMk5KZ1UyVDVHYk1TMXdFcmQvcXdD?=
 =?utf-8?B?b0hWU3dwK1B1dFZCMzZ5QlY3R2lwQldzVExOK0dmOGxFSlczYnkwZUdxazFL?=
 =?utf-8?B?L0FaTmxBYnIwZ0xlYkZ4dTdqOWIyVkRPK3VGZVB2ZG92Y0hFamZ2TG95Z2pq?=
 =?utf-8?B?VWl0Q1NaelRWZnVnaEkzT0RrSFZmRkJhbVljRnBDeXFEYkRMc01IazZXYW9i?=
 =?utf-8?B?UE5ocTJ2ek0zZ3pKdTQ4TkpwVUdyeEJ6SEZ2NVIzVUwvcGNqckdEY0huWDI2?=
 =?utf-8?B?ZG9Xckg4cUZrV2ViVm9sdjgwT0l2WWJmVnJQaW01Ry85SDM4WDdVaXd3V2l5?=
 =?utf-8?B?RnE1eStmYmRkWUJhbnI1OXZ5MkhndzN0ZUZ2aGwvS2xoRXZUMTNtdHFDSjlE?=
 =?utf-8?B?TkhxdmJOZzBVWC93eGtXVW94NE1lbTUzak52MjdFUWlpYXM1VDVPWWh0bHo2?=
 =?utf-8?B?V2NVL3QzTkRJbWFVNG9GcDJLaTFEVzBzVnpCNGVtUTJNTGlQVkQvand3SWJp?=
 =?utf-8?B?NUVLS3V5N1VCc2JiWWVHRVoyQmd5QzZ2dWlIem9NQlpRMjltaFVWanZzbGIw?=
 =?utf-8?B?WmpWVEdSZXBBVG9hU2VSK3pyZjRRM0dvYkNKaTRwQ1MrdjBiNHJMN2dQTW1l?=
 =?utf-8?B?K1lVYWdPandwZFhZR283di9VSUhqUUtoUlZsc3lwOC93TGJkSXFleXdHcC92?=
 =?utf-8?B?MmtGemlaMVZzaGNnOHdKalg4QU9BVzhrVVB2RHErbDZ2Nm1BU1JlSXFNR25X?=
 =?utf-8?Q?BtIg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac889e49-f480-4e2e-bfb8-08db4ddad0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 02:37:20.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFLcqYys2tKEfGJizW+AjAAIyWI1yD5gXRZRI4/S/6eqxCwg8mcx0eVMlJKryW1ZQ4ioMjnIBTgVFdbACRR+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQ15pyINuaX
pSAxOjQ4DQo+IFRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBhZHJpYW4uaHVu
dGVyQGludGVsLmNvbTsNCj4gdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIu
a2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGUNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgY25pZWRlcm1haWVyQGRoLWVsZWN0cm9u
aWNzLmNvbTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBkaC1lbGVjdHJv
bmljcy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzRdIGR0LWJpbmRpbmdzOiBtbWM6
IGZzbC1pbXgtZXNkaGM6IHJlbW92ZSBwcm9wZXJ0eQ0KPiAiZnNsLHdwLWNvbnRyb2xsZXIiDQo+
IA0KPiBPbiAwNS8wNS8yMDIzIDEyOjEyLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4g
RnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gRHJpdmVyIGRv
IG5vdCB1c2UgdGhpcyBwcm9wZXJ0eSwgc28gcmVtb3ZlIGl0IGhlcmUuDQo+IA0KPiBUaGF0J3Mg
bm90IHRydWUsIGl0IHVzZXMuIEkgZ290IG9ubHkgcGF0Y2ggIzMgYW5kIG5vdGhpbmcgZWxzZS4N
Cg0KVGhpcyB2MiBwYXRjaCBvbmx5IGZpeCBhIGR0LWNoZWNrIGVycm9yLCBmb3IgcGF0Y2gxLDIs
NCwgc3RpbGwgbm90IGdldCBjb21tZW50cywgc28gSSBkbyBub3Qgc2VuZCBvdXQgdG8gYXZvaWQg
bm9pc2UuDQoNCkhlcmUgaXMgdGhlIHBhdGNoIHRvIHJlbW92ZSAiZnNsLHdwLWNvbnRyb2xsZXIi
IGluIGRyaXZlcjoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1t
bWMvcGF0Y2gvMjAyMzA1MDUwODQ5NTUuMjM4OTQwLTItaGFpYm8uY2hlbkBueHAuY29tLw0KDQpC
ZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWli
byBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy55YW1sIHwgNiAtLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0K
