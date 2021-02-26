Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D31C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE2064EE4
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Feb 2021 08:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhBZIea (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Feb 2021 03:34:30 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:29195
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230006AbhBZIe3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Feb 2021 03:34:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5Nt/D39ylnhEHIII1+mshHApqwj4JeCi9PNrEJCjOLCGUhgNlJdfD0qREW8jQ5AiNqrrcsjIrUlyFMnEUuPF2eK5JOI98sHAQgUl6HKjj6B7aQ2KYLlmDV5h5vFKEmQ1NpQ2WjmGnTGNTdH+w1rrGGquAlOb6xo2XGu9GBiOyVfy9UAGq93OZe83Xhothe20BlVJhTmVoJDUWDwgYbPp3vhKbkEs5KJi3D8hQNvrr0RugbN4VaX8G8iwBk+eMW7wiOoH7tmMswyqozYk/H9rVKMqsjTMo0n2A7PkCCJg7dw5dIYK292KyjAp4GrQrK38/miA5XlSw/FsvQPNWzhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdoWW3eUGYFB39ynlgG7YRMJJTBBfmNktC/un6Q5Hfo=;
 b=QdgynGsVRUGsHxAe8HHFYRJALMcdDtDeqihy19wPvBAqIhkyB9Xn4400yibWQ6r2b2REtGohY6W64XZW6T3upY041NhNOKOQdcTIiYx0/ABd1WB/rJkLADnhDcavQX+QtctFmDA6FNc8pekSwpqM0xdFcCB/x1iWDHQIODcjWjNW0UlLLiH4a9564M+HvVnFI/kRI4qyiaXlVE5tTLhKL6SbwKpv2A+v9osNlQ54lRWQ9Uz6Y76vkpaqHlRww2o33iVqUISGhCxif4ssDTPDp8H+xL7qB16KoGMJlfVINYWIb5vo4wVvFp2nTpnlKMvDBiAqBhvuduVh4OdsjITmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdoWW3eUGYFB39ynlgG7YRMJJTBBfmNktC/un6Q5Hfo=;
 b=OtvITpb7nHnJ8tjBX1J+ANLqRJS7ro8u1UrMVNEnmTADglEw+GLbQKke/Uc8UqhUAKbyrgbFSXZ4BbVIlbSr6oxiudf2eRmWkRJOPKKDlGwJRrkBeD3ti5Tc8eGi0iK+60clMN1tUFl4pXiB+chpEEZLeLi2YfjA2gIWewuDFkQ=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6823.eurprd04.prod.outlook.com (2603:10a6:20b:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 08:33:38 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359%7]) with mapi id 15.20.3868.031; Fri, 26 Feb 2021
 08:33:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH RESEND v4 00/18] arm64: dts: imx8: architecture
 improvement and adding imx8qm support
Thread-Topic: [PATCH RESEND v4 00/18] arm64: dts: imx8: architecture
 improvement and adding imx8qm support
Thread-Index: AQHWw+WOPsPeXihFEkGKFZ3JbSQleqpqqrNg
Date:   Fri, 26 Feb 2021 08:33:38 +0000
Message-ID: <AM6PR04MB4966254794C77A1491252FF7809D9@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
In-Reply-To: <20201126105900.26658-1-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54543de7-bb87-4e50-2e81-08d8da313731
x-ms-traffictypediagnostic: AM7PR04MB6823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6823F9853050731A5C80C9FC809D9@AM7PR04MB6823.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfd69ueQpHNkw1e71NMNNZDzlJ7eh2QDDFu2ECtSiAMQNRHx4D3R6np4j5GUUf2yBI56IR1XaV4BqJgQGchQLK7wYQYPZZwhkxdhbvIp7I5pJRUF6aqsJ7v1avtqWTZIP0iQdm7AsDUgl9aCi088n7Jii5//DZXkPQO/9lYdwfkuVPQbZgPp1hFl1dv4ak7aIll/f3f99R8uT8n3T9J59ZQFu2iIt5BjcynABvzokgcZ6t3sK2Kd0+ez808wONKqUozbYk7OmCE/+ktutE0MWsZhHsTe2RsW9Sfh9hHQ7emljuCHKFlD0ybvP/gm5gyH/3l/drZXjpWxHGaXQFdC5b2w/O4H4qZnI4UoKAvs6dEYch4Bfv/uVi+JULJyC+RHKs8yF8cxgMj/gKqne8+VaYsUWTOkEvC+cZ9e2y+xsh1IPkbim/vuVan+1BNCkWJfzV1wAyUIKpYrXmOk2/WTrKdja1CajiVTmmFVVROCv1NmOq/iI49M5riX6BhzpvxYvVYuVZ7/YJk2FVoysY+UJeNpQsIV36M09SDK38XTRR8TO8CK3pHSEUa/6wqbRnSi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(316002)(71200400001)(8936002)(66556008)(8676002)(2906002)(4326008)(44832011)(33656002)(52536014)(55016002)(66476007)(6506007)(9686003)(54906003)(26005)(86362001)(5660300002)(64756008)(66446008)(66946007)(83380400001)(6916009)(7696005)(76116006)(186003)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUhnWVZISktsNXN4OHhmWHJPZldFTjlYY0hQQ0locGZpRjc3V3pGMmM4SVQ2?=
 =?utf-8?B?N0V1aHZrdndTYzlFb3BIdzRSd2FDUytWbUU3eHRFSHR0aEtqQVpwNUMreTI4?=
 =?utf-8?B?Y3Z6N3VjQ1lRWXgrM2xwanQ2bHJKWTBJL0Vwam55YXJ2SWE5RkpkODRFUWhQ?=
 =?utf-8?B?MHVXcFhlWHEwOEFFb3VjeE16REZhdlIxWm4wRUNpUkpxWVZ0Nk9DQXZadXht?=
 =?utf-8?B?cjdNNUpyMnI1bTRVSVUvclRaZjlhNzdUcjdnL3gvUFVVOERubFNwbzZybC9F?=
 =?utf-8?B?cHdJT21KQUJvRW1RVDNiQUNDSUljNy9QYlg0UzJ6VjBTbzNJclJKOTNDZjBs?=
 =?utf-8?B?Q2JEcGZMdXY4eFZ0OTBvMlVyS3hmUm00T0d5OGhLYUcyWGdodnh2U21sT2lN?=
 =?utf-8?B?THhsMWdEemJEZTJDYVRpVkVRaWNmb0w2SFNqbGJ5WGRFY1BDbzRCemhER0Ex?=
 =?utf-8?B?dWwyd1JkNVJ4QkUvTjJpZTZleUFxcmUzN3M2Rzk0c1o0UnZwbXM0empXbzl5?=
 =?utf-8?B?OExDRmwvRzBNRmdrNHk0dy9YaGVURTVHcDVQbUE1RlRkc1U3QzhaUndTYjM2?=
 =?utf-8?B?TG9GYlZING5VeGZBeHVldGw3T3M0QjF1RXlLSGNhR3Juc25YS082TUFiQ1VO?=
 =?utf-8?B?b1hEdDEzemRCZVVGaDJPVkdPZUlybW1nN0lvd0JlMFpIUUxoaUdiWEhLY2NE?=
 =?utf-8?B?ZWpPT1FvZERIam1ZdjVJaW5VSzNBd3ltejJPWUtPYjZDTDlSQkcrTCtIYlBH?=
 =?utf-8?B?Z1lhUEJUeWdoQVkyeHhTcEhjdGw3eklhcG91VFFkSnl3bHo2WG5ZcXduSmF2?=
 =?utf-8?B?T0NmMitxd3l2MEUwclEzOHY5RUYvRHFsR1Jvb3QxbU9KMU1MYUpTdlpVQk5q?=
 =?utf-8?B?RmtpRGx4V0h0ZS9JUE1KZmYrQzBRT2U1U0dYMFpONWYvay9lWVNhbmV5NXY4?=
 =?utf-8?B?blhDWlpsOWQwbDlGWDMzekhYZHNCakZtSlZyVXhIdzZ1UTgvdHE5cnFYcUIr?=
 =?utf-8?B?bXhSRFdCbEtKSVAyMVE2dGdDSHRjWWxpeXA2OVdTWHVxUlBWQmtkd09YTVUz?=
 =?utf-8?B?MFd0ZC8zVTdiKzkvMGs0bFFtOFRwQUhKYmlhTGJodTA2eW9zMnVzVmZlVjd6?=
 =?utf-8?B?T1lrU3p4T000YnZGN2ljOWFEditic3dMMVFlZnJpQXdHTE1YTkx0Z1pLenRu?=
 =?utf-8?B?cGIxT0lvdG9aZGpHS2JhYTI2ZXFNZ1Y1eC9hM3RTQnE2UFNsRmVWekNnOUFr?=
 =?utf-8?B?V01MVnptUnUxaCtOQUtKRnJmWVlqQ2NPemFVSndPRktOOENBWjZuUXp1QXpR?=
 =?utf-8?B?NkQ4akZNckJnMlhoSk1sek8wenZid3FLRWVnWkcrV2grOFJiakVJbjZmdHdk?=
 =?utf-8?B?c0hEQmdDTGtuVUZRc3hKcTd2SjJNblhnZHVIY2JIM0xWdmZSeHJudjhSOEdx?=
 =?utf-8?B?RlVMcXFLU28xb1RUNHpDZEpocFZLeWtQdlc4dmJpUHAraE12bXJJR2hUZTkr?=
 =?utf-8?B?ZStjM20rUXl0S1RiK3A5MEZoSkR4bEVCZDN0eEFLWExtVlBNSUJZcGVvUUJH?=
 =?utf-8?B?TVVlbmFzdUpaZ2dGVnprUk1waUxrNHpCdFRTM1NzZGdHSW9jS0NtR0N2d0R3?=
 =?utf-8?B?SVZQNnBOTlExWVBER1ZHcUs2dlJpbk1sMGZhRUVnV2w3RGhKRnBXYWRhamdB?=
 =?utf-8?B?NnQxUFpuYmsybkdERDRFei9wYWhVZVgwREdsbXRmUFZ3djgvRk45TFhSREEz?=
 =?utf-8?Q?ZafqeizMRZiZxgXYZjZZ7vaCvVDd/F9MQNcePRh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54543de7-bb87-4e50-2e81-08d8da313731
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 08:33:38.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XggTZEdieuMkzo/xBnwHHPNp/t7XK3bocfmr9aVQkc7UIquDieJKUOmn8MB/aUV/6h98TsVp5uM4XFwON2SJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6823
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgU2hhd24sDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0YWtlIGEgbG9vayBhdCB0aGlzIHBh
dGNoIHNlcmllcz8gSXQncyBiZWVuIHdpdGhvdXQgY29tbWVudHMgZm9yIG1vbnRocy4NClBsZWFz
ZSBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byByZXNlbmQgbm93IG9yIEkgY2FuIHJlc2Vu
ZCBsYXRlciB3aXRoIG5ldyBjb21tZW50cyBhZGRyZXNzZWQgaWYgYW55Lg0KDQpSZWdhcmRzDQpB
aXNoZW5nDQoNCj4gRnJvbTogQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI2LCAyMDIwIDY6NTkgUE0NCj4gDQo+IElNWCBTQ1Ug
YmFzZWQgcGxhdGZvcm1zIChlLmcuIE1YOFFNL01YOFFYUCkgYXJlIGNvbXByaXNlZCBvZiBhIG51
bWJlcg0KPiBvZiBTUyAoU3Vic3lzdGVtcyksIHRob3NlIFNTIG1heSBiZSBzaGFyZWQgYmV0d2Vl
biBkaWZmZXJlbnQgU29DcyB3aGlsZSBtb3N0DQo+IG9mIHRoZW0gY2FuIGJlIHJldXNlZCBsaWtl
IERldmljZXMgUmVzb3VyY2VzLCBDbG9ja3MsIFBvd2VyIGRvbWFpbnMgYW5kIGV0Yy4NCj4gDQo+
IFRoaXMgcGF0Y2ggc2VyaWVzIGFpbXMgdG8gaW1wcm92ZSB0aGUgTVg4IGFyY2hpdGVjdHVyZSB0
byBjb21wbHkgd2l0aCB0aGUgSFcNCj4gZGVzaWduIHRvIHNhdmUgYSBsb3Qgb2YgZHVwbGljYXRl
ZCBjb2RlcyBhbmQgYmVuZWZpdHMgdXMgYSBiZXR0ZXINCj4gbWFpbnRhaW5hYmlsaXR5IGFuZCBz
Y2FsYWJpbGl0eSBpbiB0aGUgZnV0dXJlLg0KPiANCj4gQ2hhbmdlTG9nOg0KPiB2NC1yZXNlbmQ6
DQo+ICAqIG5vIGNoYW5nZSBleGNlcHQgcHV0IHRocmVlIG1vZHVsZSBiaW5kaW5nIHBhdGNoZXMg
Zmlyc3Qgd2hpY2ggYXJlIHVzZWQNCj4gICAgYnkgdGhpcyBwYXRjaHNldC4NCj4gdjMtPnY0Og0K
PiAgKiBtYWlubHkgcmViYXNlIHRvIGxhdGVzdCBrZXJuZWwgZXhjZXB0IGEgZmV3IHZlcnkgbWlu
b3IgY2hhbmdlcyBsaWtlIGNoYW5nZQ0KPiB0byB1c2UNCj4gICAgbmV3IHNjdSBwcm90b2NvbCBi
aW5kaW5nIHdoaWNoIHdhcyBub3Qgc3VwcG9ydGVkIGluIGxhc3QgdmVyc2lvbg0KPiB2Mi0+djM6
DQo+ICAqIHVzZSBjbG9jay1pbmRpY2VzIHByb3BlcnR5IGluc3RlYWQgb2YgYml0LW9mZnNldCBw
cm9wZXJ0eSBzdWdnZXN0ZWQgYnkNCj4gU2hhd24gR3VvDQo+ICAqIHJlYmFzZSB0byBsYXRlc3Qg
c2hhd24vZm9yLW5leHQNCj4gdjEtPnYyOg0KPiAgKiBjaGFuZ2UgdG8gdGhlIG5ldyB0d28gY2Vs
bHMgc2N1IGNsb2NrIGJpbmRpbmcsIHNvIG9yaWdpbmFsIGFkZGluZyBzY3UgY2xvY2tzDQo+ICAg
IHBhdGNoZXMgd2VyZSByZW1vdmVkLg0KPiAgKiBNb3ZlIHNjdSBwZCBub2RlIGFib3ZlIGNsayBu
b2RlDQo+IA0KPiANCj4gRG9uZyBBaXNoZW5nICgxOCk6DQo+ICAgZHQtYmluZGluZ3M6IG1tYzog
aW14OiBmaXggdGhlIHdyb25nbHkgZHJvcHBlZCBpbXg4cW0gY29tcGF0aWJsZQ0KPiAgICAgc3Ry
aW5nDQo+ICAgZHQtYmluZGluZ3M6IGFybTogZnNsOiBhZGQgaW14OHFtIGJvYXJkcyBjb21wYXRp
YmxlIHN0cmluZw0KPiAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBtdTogYWRkIGlteDhxbSBzdXBw
b3J0DQo+ICAgYXJtNjQ6IGR0czogaW14OHF4cDogYWRkIGZhbGxiYWNrIGNvbXBhdGlibGUgc3Ry
aW5nIGZvciBzY3UgcGQNCj4gICBhcm02NDogZHRzOiBpbXg4cXhwOiBtb3ZlIHNjdSBwZCBub2Rl
IGJlZm9yZSBzY3UgY2xvY2sgbm9kZQ0KPiAgIGFybTY0OiBkdHM6IGlteDhxeHA6IG9yZ2luaXpl
IGR0cyBpbiBzdWJzeXN0ZW1zDQo+ICAgYXJtNjQ6IGR0czogaW14ODogYWRkIGxzaW8gbHBjZyBj
bG9ja3MNCj4gICBhcm02NDogZHRzOiBpbXg4OiBhZGQgY29ubiBscGNnIGNsb2Nrcw0KPiAgIGFy
bTY0OiBkdHM6IGlteDg6IGFkZCBhZG1hIGxwY2cgY2xvY2tzDQo+ICAgYXJtNjQ6IGR0czogaW14
ODogc3dpdGNoIHRvIHR3byBjZWxsIHNjdSBjbG9jayBiaW5kaW5nDQo+ICAgYXJtNjQ6IGR0czog
aW14ODogc3dpdGNoIHRvIG5ldyBscGNnIGNsb2NrIGJpbmRpbmcNCj4gICBhcm02NDogZHRzOiBp
bXg4cW06IGFkZCBsc2lvIHNzIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiBpbXg4cW06IGFkZCBj
b25uIHNzIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiBpbXg4OiBzcGxpdCBhZG1hIHNzIGludG8g
ZG1hIGFuZCBhdWRpbyBzcw0KPiAgIGFybTY0OiBkdHM6IGlteDhxbTogYWRkIGRtYSBzcyBzdXBw
b3J0DQo+ICAgYXJtNjQ6IGR0czogaW14OiBhZGQgaW14OHFtIGNvbW1vbiBkdHMgZmlsZQ0KPiAg
IGFybTY0OiBkdHM6IGlteDogYWRkIGlteDhxbSBtZWsgc3VwcG9ydA0KPiAgIGFybTY0OiBkZWZj
b25maWc6IGFkZCBpbXg4cW0gbWVrIHN1cHBvcnQNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vZnNsLnlhbWwgICAgICAgICAgfCAgIDYgKw0KPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWFpbGJveC9mc2wsbXUueWFtbCAgIHwgICA1ICstDQo+ICAuLi4vYmluZGluZ3MvbW1j
L2ZzbC1pbXgtZXNkaGMueWFtbCAgICAgICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUgICAgICAgIHwgICAxICsNCj4gIC4uLi9ib290L2R0cy9m
cmVlc2NhbGUvaW14OC1zcy1hZG1hLmR0c2kgICAgICB8ICAgOCArDQo+ICAuLi4vYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDgtc3MtYXVkaW8uZHRzaSAgICAgfCAgNjggKysrDQo+ICAuLi4vYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDgtc3MtY29ubi5kdHNpICAgICAgfCAxODQgKysrKysrKysNCj4gIC4u
Li9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OC1zcy1kZHIuZHRzaSB8ICAxOA0KPiArICAu
Li4vYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtZG1hLmR0c2kgfCAyMDIgKysrKysr
KysrDQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtbHNpby5kdHNpICAgICAgfCAz
MTEgKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFt
LW1lay5kdHMgIHwgMTQ0ICsrKysrKw0KPiAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0t
c3MtY29ubi5kdHNpICAgIHwgIDIxICsNCj4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFt
LXNzLWRtYS5kdHNpICAgICB8ICA1MSArKysNCj4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHFtLXNzLWxzaW8uZHRzaSAgICB8ICA2MSArKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhxbS5kdHNpICAgICB8IDE3NiArKysrKysrKw0KPiAgLi4uL2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLWFpX21sLmR0cyAgICAgIHwgIDIwICstDQo+ICAuLi4vZnJlZXNjYWxl
L2lteDhxeHAtY29saWJyaS1ldmFsLXYzLmR0c2kgICAgfCAgIDggKy0NCj4gIC4uLi9ib290L2R0
cy9mcmVlc2NhbGUvaW14OHF4cC1jb2xpYnJpLmR0c2kgICB8ICAxMiArLQ0KPiAgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsuZHRzIHwgIDUwICstLQ0KPiAgLi4uL2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLXNzLWFkbWEuZHRzaSAgIHwgIDM3ICsrDQo+ICAuLi4v
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtc3MtY29ubi5kdHNpICAgfCAgMjUgKysNCj4gIC4u
Li9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1zcy1sc2lvLmR0c2kgICB8ICA2MSArKysNCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSAgICB8IDQyMyArKy0t
LS0tLS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQo+ICAyNCBmaWxlcyBjaGFuZ2VkLCAxNDU1IGluc2VydGlvbnMoKyks
IDQzOSBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLWFkbWEuZHRzaQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtYXVkaW8uZHRzaQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDgtc3MtY29ubi5k
dHNpDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OC1zcy1kZHIuZHRzaQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDgtc3MtZG1hLmR0c2kNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLWxzaW8uZHRzaQ0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1tZWsuZHRzDQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFt
LXNzLWNvbm4uZHRzaQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhxbS1zcy1kbWEuZHRzaQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1zcy1sc2lvLmR0c2kNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0uZHRzaQ0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAt
c3MtYWRtYS5kdHNpDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OHF4cC1zcy1jb25uLmR0c2kNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLXNzLWxzaW8uZHRzaQ0KPiANCj4gLS0N
Cj4gMi4yMy4wDQoNCg==
