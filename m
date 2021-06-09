Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66DC48BCF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A88D61287
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 10:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhFIKzz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:55:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33732 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbhFIKzs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2021 06:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623236035; x=1654772035;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aug4HcWAs+oevmvz19waUqRv8k41SvxRQ50gQ2Qx/LU=;
  b=XvhwLW2FhbSVmGUj1vFjiW+qHszQyrT46KIFvqGyg7KBsRQyySqe0u0i
   uzfzSPn1ufHLxQQvx2ecM3m9LvSEJ5T82NkWrYqcg1EDO1MOnCmR3pOcT
   BTMTUrHmsJogmKzi3LUpJERnpAYROOEmS41Q/U6urJVN7PCtpb6/8vRTN
   4TGHUBYAlI+hdX1k5vbk/wnDfj/9xFakx02QqsBveDJPX/tduwVgd7zZW
   uOBoTw3yCvCz3m3RdaZBgCCJ8tfI283Ik+FjUJNrrTFKoTSDPSFTK2rEh
   IQDE35k7lU7c6/x1ZTlVzMKYxFHeYZAXo1uvggbFxPTIFK30I1BtVi2cb
   A==;
IronPort-SDR: WOch7w3sFb3tEwe7PBVkx5G8yUzgMkRpIjUZoF6Ej4CQaqCTCaSgkGjRQroXQ0/enxB34UZeuY
 5ysj8rl6NVg4L2iswytte0VjlVjqTDAhU5oKHN9XTZV4LxBa/yutszFluW+bfj4fjSjIrvP95c
 xUjv1hZ00sYUc19WPxwJ1fqTE8cOJN5+aCcxSaAI3PomWkyr4Vr146J1OgaDnGW6S+pqXdW+Rf
 bRIWVVZawJZgac5WQSoOOgRo49x0cV7jQV03UMmlQKcEKVVttI8OOUPUdZYzE/Tmjpvp6Riwz4
 XOM=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="171839587"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 18:53:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK4rCtyVC0K2QUKi4cUDRmwBQAr9mc2JJ54maqLohVWlvU29A6qvODvUzejGslYxYWH/TJrM3EunfjBqdbdgVVlSH6KUvI2y4bx8DhZBBF5uDvacKul/pqI6FlY48TUFa/LWp2fj1Ekkbp9SMenw6CbmXuwaY9hACSDcF8bNQ+kyA9b/TOwzp4Rls+VXumuOmg+Ziz3tF+AchXA4lQtPBdw/EuK5xMrfjW3XSEmFkhas4TlHfYGYtXnk0CgIKTKQSBDSsQz8KJQeAVLvM+jqoyClynen2xCDAG6xgB3RLra+ci/gu6JzuSEk90axyP8QpvphOz8EvqFYsoEPzhXVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aug4HcWAs+oevmvz19waUqRv8k41SvxRQ50gQ2Qx/LU=;
 b=O4CJpeTTrwDS4WiwOzYyjJ8Irg+DS2iK0kS5km0vRdyXgD4Ei849ZoK6+OpQexE1/qsFxtEPgDotTumx9DnBjK8TMtIejXdTNpe3bWB+OvtpjllmXhsK5tkXtD7cGukg37pkP2B5PJjM/uMrcALv1IB4Bdt4l4DOKKt7zXiu6eYb/ienzfIGHIwQA+hDGS3IfZEmiIu87sQ52winS8MnnHrogKUr0Ij4EkrDkEQvIwXrTuNHjW9IJOtwtJPtvGIVHW1yPywelDDr3uITljnQYwu9Wp9nSQvdPWh34srAwbW5TXv+o/9bd1yIIvi3yNM0ZGq2YmYmUfnoV9bt02lA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aug4HcWAs+oevmvz19waUqRv8k41SvxRQ50gQ2Qx/LU=;
 b=Is8mmUXaTWDwfgNjlYAolpr3R/4nDw8Uj85SndlXF8WFFVekhKQ+Ni/323/rRPo6+9Mk3UNdQLqIT2pw+U6MiuxGXuvobkcZK30Y5n+4C+Aywsp23VuvVa1IbcR8v4H6xbDQFVPPHwpCSHQgV1920AC8B5ZFAg+o9QUTQ7RbJIs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5625.namprd04.prod.outlook.com (2603:10b6:5:16e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Wed, 9 Jun 2021 10:53:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::78af:772c:a69a:95a0%9]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 10:53:51 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: RE: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXD2WfUw9V7TgJkajnPZV25duWqsJzJsugAGrE2A=
Date:   Wed, 9 Jun 2021 10:53:51 +0000
Message-ID: <DM6PR04MB6575996048A99DF35041BE67FC369@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CWXP265MB26809A40B098D219C44E70FAC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB2680581A95203C5CF304DDA2C4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680581A95203C5CF304DDA2C4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hyperstone.com; dkim=none (message not signed)
 header.d=none;hyperstone.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96133a61-f897-402e-71c6-08d92b34de33
x-ms-traffictypediagnostic: DM6PR04MB5625:
x-microsoft-antispam-prvs: <DM6PR04MB56258E69D8F3165D4774ECA0FC369@DM6PR04MB5625.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7O095a4rf5ASrxepvkHr4EznEQ9UO78L+/gz9IRflRSTxZgG6eqjmZopcFZ+kHyKs8l2V8aWq7n7qXFNeXRlI7QHE2J+2yCGPd/7pkm0LGUM6/vIzsOci4bqTxVZQkow4u8FzOEVgBDJ8lHcPGp2+4YoltQdlwD4LG4kTgfLLuCKISTKSVToizg5DzLGk7oLFKS4/AsF86dN8yXRJjxJOKtr3s8p0+dbj3QC8qNujeZAzeZvpYgjSwdl0unKuwwaa4HqHPQZ/mpKbbNDgcNww9s4ltDkv/ogkPGx/hc79lA4tdCwLh6yKMPXIWu7pPlIqwKW0VnD+f51i+lnw576lqo7g7z84AN5IFwDQTFjilPTXw+O0L6E5lKqp+yzZGiYDhJ9yVW/vt3ssNl8Acf9rbcZ3YE3ab5z6bGYjjM4Kd4H+EKXVoO50O0AdRpyWYDGpU5TZUlvB1fR99UQAo/r5gNvn1UBuT+QHOBIKHEJPcWwoF4W5Bfxbf2CMQpPheNIi35KJN92zzXh9bWgq5BGR5rPrNZhT0/UVWzqreEsmFCtbmuX8QPBTUetsKNqa404b8ewWypJh58rIKqzFYFszelzQrzmA8moeXDPFzNdbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(76116006)(8936002)(478600001)(52536014)(7696005)(66446008)(83380400001)(64756008)(66556008)(316002)(122000001)(55016002)(38100700002)(2906002)(6506007)(9686003)(186003)(26005)(5660300002)(66476007)(33656002)(66946007)(71200400001)(8676002)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDc0bVVQR3FabDBtTFJVT2ZMbzErRzhYQjQzaG5JWHdOSTV6eUU0dTI0em5K?=
 =?utf-8?B?c3MybDVNMnpnaFJEWjVONFo5aGNOMnpsWXl1Rllrdk5HajRHYnNYRlRGR2xy?=
 =?utf-8?B?WkJXSk5MVDAwWFBjcGNyN3FZWTJ6bFd2QVFVLzhzZCtHMmwrOURmNUw2citr?=
 =?utf-8?B?bWw5dm5aeU9LNXAzY2ZmL3d6cjRLbnRnYm9WWFNUc0N5a2R6NnZPN0ZpT202?=
 =?utf-8?B?dXFVc0RFd0R5RnhQa2hNUjVuSzFVTm5wYTJlL3JXN1JPTXV5aEptV3U0VTAz?=
 =?utf-8?B?WE5UUzh4Qi9ucTZlVWJzWGJBSlluZ3lYTVRZQnljTk1oUkJ6YVgzbm9TWkdw?=
 =?utf-8?B?Tk5KbkUrZi9JOVpZdXk3TjlQeHNZeDQxL3Z6M2hoT2RFT0xBTlIyTUlRWXJw?=
 =?utf-8?B?dTFYNTVldnc1TGUrdFRDY1ZkQzF4a2Jpcy93QlU2UCszSmdZVlA4SlREbUtm?=
 =?utf-8?B?Rlh2VzFBYnVSSytjSTBRdHJwZTlFRDR4Tk9YRnVuNjJmWGU0UmlialBFOThh?=
 =?utf-8?B?OEdiVmQ3djY0dEllUXJzbHduSmI3VG0xdjRlcHFqZ1FnNXFIM2tUazF5QzNU?=
 =?utf-8?B?Z0N6UUJEYTB2WThhUFU3N0dnN3NuSmtpWVFDOXVqMWtSR3pZenk3NzR1WldW?=
 =?utf-8?B?NzRCalF0ZFJrTncrdXdOUGdaWHNldFI2OEdsWnl6aG03d05VT2s4Y2Z2YzNR?=
 =?utf-8?B?K2p5YXFSdXFNODlKbEpCbjRROGx1NUhtT3hLOVAxb084ZDNlMWI1M3BVKzcz?=
 =?utf-8?B?aWMvTnNodjIxLy9CS3BEc1ArYUR3TUp0OGtxeW93TGR1MnVrM1FXV0NncEN1?=
 =?utf-8?B?Yi9BNm5Ua0NnY2drdG5xYWRsanExOTVkUnpBN3pzOVNsdHB1NjgrVDY1M0dj?=
 =?utf-8?B?bjdsNWpMdmtTNG05UHZod0RUQTdWbW5pT1BTVU9TV1IyZThacDRqaGNaU1cr?=
 =?utf-8?B?Wmc2NU9hN1hQRGNtek1KdklUVzFLK2daU3hKZzBUeGU4a0Qrd0gzZGpHcVRY?=
 =?utf-8?B?RGZBVFVyQkh3cDc0aVpicm9NaG1YUUdEM2VLc00vRllTVEcrNHd1S1lFYS9B?=
 =?utf-8?B?TkJoWFV1NGwxN0tITHArSnZuWHB5NWRjL290eFJXdzFpT2hSYjc4K3VWRGpl?=
 =?utf-8?B?MmpiV2NsUnU2U1JwOFBqYlRpRFBMU0M3dkNnRE9jTVNtQmZ1YmNqc05ZRGhS?=
 =?utf-8?B?azUxVE1HdngwbWJwRkZQL21ETDhUS2dSSEJKNlpoWThMbWdFdWhXNjVEUytJ?=
 =?utf-8?B?L01QZ0ZHOENjUjIweE5Cb1k5OUYyN2hSTDlOWEx4Q3M1YjNqOEhhQVJkT3Vj?=
 =?utf-8?B?VHoxVnlzZGpkU0xtSGtRVm5TUVVydko1aUV3VHZXZjI2OW9FUGpZd3gyRUFW?=
 =?utf-8?B?Q080dEI3MXVvTTBRTVVSb0daWllka1p1RmYvenZpbVVxaVNlT2EwdDFEMFpu?=
 =?utf-8?B?T1hVZzJmamZ1TnE4UHVrTUhLQUdnT1BTTWtJU0cwSVRVeDJQRktQSWRFcThR?=
 =?utf-8?B?djNZSVlpTUZQNWo1U3JZL3F5SFRqOEw1b1J0TkRhUjdCVmIrbFp0WGc0ajRJ?=
 =?utf-8?B?b1BIazFjOFhPVmxZRzlHVHhwL1c0VVBKZ25FSTRidjJEUnhTOWFrYXNYUlRz?=
 =?utf-8?B?TzhZOXplclphUisrYVdJWXo4NlNnWkR3aUs3eW91K2R2cHQ0NWJaK0lXWlJG?=
 =?utf-8?B?YVlRVzI0dnRXZk9sUm9IQm5Pb0YzU2ZDNFZMTVhpK3QzS0JHbUFETWVkbkp3?=
 =?utf-8?Q?Xi9Hqu1A/4jn/wBF7ceePYjvDWxNFMSzZ87LHo+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96133a61-f897-402e-71c6-08d92b34de33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 10:53:51.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbKBXJFrHmRNmnnd5aD6sm+k8FloTGCpAI02VfDtxB2O8KPHFzZTT8BPpIZ/Y4MrsDBMS7UGPE45HYlH/epLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5625
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBQb2xsIGZvciBUUkFOIHN0YXRlIGlmIHRoZSBpb2N0bCBjb21tYW5kIHdpbGwgZXZlbnR1YWxs
eSByZXR1cm4gdG8gVFJBTg0KPiANCj4gVGhlIGlvY3RsIHN1Ym1pdHRlZCBjb21tYW5kIHNob3Vs
ZCBub3QgYmUgY29uc2lkZXJlZCBjb21wbGV0ZWQgdW50aWwNCj4gdGhlIGNhcmQgaGFzIHJldHVy
bmVkIGJhY2sgdG8gVFJBTiBzdGF0ZS4gV2FpdGluZyBqdXN0IGZvciB0aGUgY2FyZA0KPiB0byBu
byBsb25nZXIgc2lnbmFsIGJ1c3kgaXMgbm90IGVub3VnaCBhcyB0aGV5IG1pZ2h0IHJlbWFpbiBp
biBhDQo+IG5vbi1idXN5IFBST0cgc3RhdGUgZm9yIGEgd2hpbGUgYWZ0ZXIgdGhlIGNvbW1hbmQu
DQo+IEZ1cnRoZXIgY29tbWFuZHMgcmVxdWlyaW5nIFRSQU4gd2lsbCBmYWlsIHRoZW4uDQo+IEl0
IHNob3VsZCBub3QgYmUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSB1c2VyIHRvIGNoZWNrIGlm
IHRoZWlyIGNvbW1hbmQNCj4gaGFzIGNvbXBsZXRlZCB1bnRpbCBzZW5kaW5nIHRoZSBuZXh0IHZp
YSBpb2N0bCwNCj4gaW5zdGVhZCB0aGUgY2hlY2sgc2hvdWxkIGJlIG1hZGUgaGVyZS4NCj4gU28g
bm93LCBpbiBkb3VidCwgd2FpdCBmb3IgVFJBTiBleGNlcHQgZm9yIHRoZSBmZXcgY29tbWFuZHMg
dGhhdCB3aWxsDQo+IG5ldmVyIHJldHVybiB0byBUUkFOIHN0YXRlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIExvZWhsZSA8Y2xvZWhsZUBoeXBlcnN0b25lLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1j
L2NvcmUvYmxvY2suYw0KPiBpbmRleCA2ODllYjlhZmVlZWQuLmEwMjE4N2U0ZmFkNyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2Nv
cmUvYmxvY2suYw0KPiBAQCAtNDEwLDcgKzQxMCwyMyBAQCBzdGF0aWMgaW50IG1tY19ibGtfaW9j
dGxfY29weV90b191c2VyKHN0cnVjdA0KPiBtbWNfaW9jX2NtZCBfX3VzZXIgKmljX3B0ciwNCj4g
ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGludCBjYXJkX2J1c3lfZGV0
ZWN0KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwgdW5zaWduZWQgaW50DQo+IHRpbWVvdXRfbXMsDQo+
ICtzdGF0aWMgaW50IGlzX3JldHVybl90b190cmFuX2NtZChzdHJ1Y3QgbW1jX2NvbW1hbmQgKmNt
ZCkNCj4gK3sNCj4gKyAgICAgICAvKiBDYXJkcyB3aWxsIG5ldmVyIHJldHVybiB0byBUUkFOIGFm
dGVyIGNvbXBsZXRpbmcNCk11bHRpLWxpbmUgY29tbWVudCBzdHlsZQ0KDQo+ICsgICAgICAgICog
aWRlbnRpZmljYXRpb24gY29tbWFuZHMgb3IgTU1DX1NFTkRfU1RBVFVTIGlmIHRoZXkgYXJlIG5v
dA0KPiBzZWxlY3RlZC4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICByZXR1cm4gIShjbWQtPm9w
Y29kZSA9PSBNTUNfU0VORF9DSUQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfHwgY21kLT5v
cGNvZGUgPT0gTU1DX0FMTF9TRU5EX0NJRA0KPiArICAgICAgICAgICAgICAgICAgICAgICB8fCBj
bWQtPm9wY29kZSA9PSBNTUNfU0VORF9DU0QNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfHwg
Y21kLT5vcGNvZGUgPT0gTU1DX1NFTkRfU1RBVFVTDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHx8IGNtZC0+b3Bjb2RlID09IE1NQ19TRUxFQ1RfQ0FSRA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICB8fCBjbWQtPm9wY29kZSA9PSBNTUNfQVBQX0NNRA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICB8fCBjbWQtPm9wY29kZSA9PSBNTUNfR09fSU5BQ1RJVkVfU1RBVEUNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgfHwgY21kLT5vcGNvZGUgPT0gTU1DX0dPX0lETEVfU1RBVEUpOw0KPiAr
DQpBcmVu4oCZdCB5b3Ugb25seSBpbnRlcmVzdGVkIGluIGNtZHMgdGhhdCBtb3ZlIHRvIHRyYW4g
c3RhdGUgZnJvbSBvdGhlciBzdGF0ZT8NCkFjY29yZGluZyB0byB0aGUgRGV2aWNlIHN0YXRlIHRy
YW5zaXRpb25zICh0YWJsZSA2MSBpbiBlTU1DNS4xKSBpdCBvbmx5IGNvbmNlcm4NCmNtZDcgKHN0
YnktPnRyYW4pLCBjbWQxMiAoZGF0YS0+dHJhbiksIGFuZCBjbWQxNCAoYnRzdC0+dHJhbikuDQoN
ClRoYW5rcywNCkF2cmkNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBjYXJkX3BvbGxfdW50aWxf
dHJhbihzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsIHVuc2lnbmVkIGludA0KPiB0aW1lb3V0X21zLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiAqcmVzcF9lcnJzKQ0KPiAgew0KPiAg
ICAgICAgICB1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmll
cyh0aW1lb3V0X21zKTsNCj4gQEAgLTU5MywxMiArNjA5LDEzIEBAIHN0YXRpYyBpbnQgX19tbWNf
YmxrX2lvY3RsX2NtZChzdHJ1Y3QgbW1jX2NhcmQNCj4gKmNhcmQsIHN0cnVjdCBtbWNfYmxrX2Rh
dGEgKm1kLA0KPiANCj4gICAgICAgICAgbWVtY3B5KCYoaWRhdGEtPmljLnJlc3BvbnNlKSwgY21k
LnJlc3AsIHNpemVvZihjbWQucmVzcCkpOw0KPiANCj4gLSAgICAgICBpZiAoaWRhdGEtPnJwbWIg
fHwgKGNtZC5mbGFncyAmIE1NQ19SU1BfUjFCKSA9PSBNTUNfUlNQX1IxQikgew0KPiArICAgICAg
IGlmIChpZGF0YS0+cnBtYiB8fCAoY21kLmZsYWdzICYgTU1DX1JTUF9SMUIpID09IE1NQ19SU1Bf
UjFCDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHx8IGlzX3JldHVybl90b190cmFuX2NtZCgm
Y21kKSkgew0KPiAgICAgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAgICAgICogRW5z
dXJlIFJQTUIvUjFCIGNvbW1hbmQgaGFzIGNvbXBsZXRlZCBieSBwb2xsaW5nIENNRDEzDQo+ICAg
ICAgICAgICAgICAgICAgICogIlNlbmQgU3RhdHVzIi4NCj4gICAgICAgICAgICAgICAgICAgKi8N
Cj4gLSAgICAgICAgICAgICAgIGVyciA9IGNhcmRfYnVzeV9kZXRlY3QoY2FyZCwgTU1DX0JMS19U
SU1FT1VUX01TLCBOVUxMKTsNCj4gKyAgICAgICAgICAgICAgIGVyciA9IGNhcmRfcG9sbF91bnRp
bF90cmFuKGNhcmQsIE1NQ19CTEtfVElNRU9VVF9NUywgTlVMTCk7DQo+ICAgICAgICAgIH0NCj4g
DQo+ICAgICAgICAgIHJldHVybiBlcnI7DQo+IEBAIC0xNjIxLDcgKzE2MzgsNyBAQCBzdGF0aWMg
aW50IG1tY19ibGtfZml4X3N0YXRlKHN0cnVjdCBtbWNfY2FyZA0KPiAqY2FyZCwgc3RydWN0IHJl
cXVlc3QgKnJlcSkNCj4gDQo+ICAgICAgICAgIG1tY19ibGtfc2VuZF9zdG9wKGNhcmQsIHRpbWVv
dXQpOw0KPiANCj4gLSAgICAgICBlcnIgPSBjYXJkX2J1c3lfZGV0ZWN0KGNhcmQsIHRpbWVvdXQs
IE5VTEwpOw0KPiArICAgICAgIGVyciA9IGNhcmRfcG9sbF91bnRpbF90cmFuKGNhcmQsIHRpbWVv
dXQsIE5VTEwpOw0KPiANCj4gICAgICAgICAgbW1jX3JldHVuZV9yZWxlYXNlKGNhcmQtPmhvc3Qp
Ow0KPiANCj4gQEAgLTE4NDUsNyArMTg2Miw3IEBAIHN0YXRpYyBpbnQgbW1jX2Jsa19jYXJkX2J1
c3koc3RydWN0IG1tY19jYXJkDQo+ICpjYXJkLCBzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiAgICAg
ICAgICBpZiAobW1jX2hvc3RfaXNfc3BpKGNhcmQtPmhvc3QpIHx8IHJxX2RhdGFfZGlyKHJlcSkg
PT0gUkVBRCkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IC0gICAgICAgZXJy
ID0gY2FyZF9idXN5X2RldGVjdChjYXJkLCBNTUNfQkxLX1RJTUVPVVRfTVMsICZzdGF0dXMpOw0K
PiArICAgICAgIGVyciA9IGNhcmRfcG9sbF91bnRpbF90cmFuKGNhcmQsIE1NQ19CTEtfVElNRU9V
VF9NUywgJnN0YXR1cyk7DQo+IA0KPiAgICAgICAgICAvKg0KPiAgICAgICAgICAgKiBEbyBub3Qg
YXNzdW1lIGRhdGEgdHJhbnNmZXJyZWQgY29ycmVjdGx5IGlmIHRoZXJlIGFyZSBhbnkgZXJyb3Ig
Yml0cw0KPiAtLQ0KPiAyLjMxLjENCj4gSHlwZXJzdG9uZSBHbWJIIHwgTGluZS1FaWQtU3RyYXNz
ZSAzIHwgNzg0NjcgS29uc3RhbnoNCj4gTWFuYWdpbmcgRGlyZWN0b3JzOiBEci4gSmFuIFBldGVy
IEJlcm5zLg0KPiBDb21tZXJjaWFsIHJlZ2lzdGVyIG9mIGxvY2FsIGNvdXJ0czogRnJlaWJ1cmcg
SFJCMzgxNzgyDQoNCg==
