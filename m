Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD91CC433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 06:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF8A611CB
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 06:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhEFGQL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 02:16:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47537 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhEFGQK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 02:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620281712; x=1651817712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AEfCpWbfiMQAonOuOwHG2cBhNBN+32i6gRRZV5+5rXs=;
  b=hKO0IPwEF4AbEol8GA/QQ+BbtmBVBEVC1agx5414xjVdCFBdk5MTk+RL
   1NFMkewXcbA1sD3Bt9bsXo1+IKLSfpaaUBFoKxBCyVqDem7qW5E+RYHan
   y9QI54vpsG+/M4qCZn51ioH1hiyaqnd+2Y2fqoRKc/8Gs5sdZB7SJk1Rm
   RWrQJYh6oIuzVcwHUENapdmm1W2DXAPU22vexoStdLk+VhG9NJaVQ2ulp
   mJfaMImMJOcsbRqE9/h23hsXW+zc5yAgs1E5p3ZG+FBOqVbgFgip6uHcC
   0MegI4ndS+e2EatyZqXgXlTT9W+kM3nyCUGeai60+65HzvkL09jt/Nkvh
   A==;
IronPort-SDR: LO/llvRHcISUeQWiKcN8+hqaW6ZLos3TwLxu6lO+H++cABFuCVsp5UJ8maVMR5ipOUhi3Gj7pQ
 9EUina2hcMi+ul+L6dujvo7Q+UXf9aSVEWIBgFRJCdJzQAKx46hlMjnl3K9ya3i/J00V/rnxMr
 VeSsAyFcI9/h+dsHjgVgWnY7pP2ZwfOj0RCmmW8WhSTjIiaI/7UT3F1SWIZnOS1mgbcw2wRa2Q
 0vjFeP3qKzBnMNHQkCz4nNpRucAFHOecI+C6+K75INHTUL9zbx6neqyg4mPFgBTGPKiIc5q46x
 +mg=
X-IronPort-AV: E=Sophos;i="5.82,276,1613404800"; 
   d="scan'208";a="167281024"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2021 14:15:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsDP4MfeSeC3yIrrNJDNOmmzko0GJuLN0vDCm+Bt4SGZib0+gmcU1DDGQzZ4QTi5XjC1qiHrQUK9KxV3HfJSBFBznWA65buieMHvEbajyUAZp9tNq6BvxZsTemtv13Nbghch7H3hlRC1KF54cTPyfTJXCy/VGrg/Cj75+vKGnIB8y+xNGnvXdbfK/fgARdZO/E15zORf5CajivSONeHsZAn35wFlAOzXRv3grkiRpjLHEjqGawCQ1A951fpnV2bsF494lun5TEEcedbrXISSH6mFlTLFjSZ4L4OrFOwoe1OwIIvr7rZ5BswD5H7HttXmklevfS8OCyeC3xH2/EXMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEfCpWbfiMQAonOuOwHG2cBhNBN+32i6gRRZV5+5rXs=;
 b=jxWD1TnrGJrAglHd1oAb3n59m3vKkpoLHF+Wj+Ff/2Vtbe/BPkR7st59jFBLsXi3QEZF9+akcExEuAirUXuKJw89sZB/5fqrcXTzHqFp2laCJ2Mb+kz0hNrcyr+TBpIK90RS3pb5O08zkUc/vyKBayF2SPOa7m9QlaPHqQZXN4ZOzwkeLjPtW1trMP5BPbgjB/LBTtcq7ECSVE3MwwCsFlo8QC4MExtCuAT5Kh/AufReQqUXoxjg029uPA1P0+MdQ+uHx7AqMwaQvu8dAAU4j1pLaUvyl0mTKJ+8qhvdbM2yGn1+E319OZ+f+p5d/WgzNiKbYepre7cOyzTHFsh2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEfCpWbfiMQAonOuOwHG2cBhNBN+32i6gRRZV5+5rXs=;
 b=VvS0ZcE89PtY0nuBQvwBSF9lDl55AMhCQoWBO5Py3XjD2E5qi2xpLWnq48a9B2CORgiC49CrULTml4mApV0+KftNtlD9MkSriM3o0o0iQRxiCaAAMrnjfB5yDYCv6j9W+uKMlO3b4AkaXXijdBcuGsxSpxvrrHpv/eVw4NkFPYo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5353.namprd04.prod.outlook.com (2603:10b6:5:109::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.44; Thu, 6 May 2021 06:15:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 06:15:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "zliua@micron.com" <zliua@micron.com>
Subject: RE: [PATCH] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Topic: [PATCH] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Index: AQHXQa/VaowbfC/8SUWt8lUpDQ+oa6rV+kgg
Date:   Thu, 6 May 2021 06:15:11 +0000
Message-ID: <DM6PR04MB657570DB58E7ABBE2C3B0449FC589@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CWXP265MB2680DC98B32CD4B49AA8A224C4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680DC98B32CD4B49AA8A224C4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hyperstone.com; dkim=none (message not signed)
 header.d=none;hyperstone.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc8f126-e266-4400-d3e7-08d910564e0d
x-ms-traffictypediagnostic: DM6PR04MB5353:
x-microsoft-antispam-prvs: <DM6PR04MB535304EF40A30EC68C8B6CB5FC589@DM6PR04MB5353.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54aEYTs2GAMCxSJlnab297N+eNLfT1f+U5Nbmd9YR1LffGaLKSXch7u0t0acr54197PYQX2NpDUGNOhBVi+WMPT5rNBpcH8j4p0gGlPzx22KO3we8+2NkjNuAkLVKWbXDiftK83doQO2d33ReeIQpT75fDCJwhyOm/h8hNw1bBl1vW/j9jYQBNQkL3urqBf/nzAhVVuicdiTm7NGca1ohYY147z4qm1ww8LoAfTuouJRQF5GyooykCsPn2upphuaAQLn3nVJOODZ4ksOovvsaee/E8+6cdqKj4wIHU0/QL1qP8yTydPVUIDESc6Upxa/wPcnPK0rF7mZvC7TmXae6L+V6BZFqK31ISWsp6vWPDB2R8ehpTBjf8jEfwbnHThZ0wvvs669N6LyUl9n3OPXJ77JiIes/+Hk94TUT63F2nP9+i0mjSwziob0yYlBALjdwUFrZmw7OuJjm7fPnQQXQwo9TKsEJ9uYQkE8UQslObbvRhlkXmHH+S/ohB2UtvYu1JJs4t042smWNrjyMLfuyvBmq/huHQwL646owJVOzRnevRynPg2GYT7Oq9ReiLYRqaeENIGbpalP4Uu8pIzBzxl+eUjCsp38tIX1YMXh8yo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39840400004)(346002)(376002)(2906002)(110136005)(316002)(54906003)(4326008)(9686003)(52536014)(8936002)(5660300002)(55016002)(8676002)(478600001)(186003)(86362001)(83380400001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(26005)(33656002)(71200400001)(7696005)(6506007)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1dlWUZQR0JjUFllbVJ4aDlPbGtweXdWZzA4VFZQaFpEZTVqY0dwTk5KTzhX?=
 =?utf-8?B?K0Y4eVVtYjIzTVdBOEpTa0c2RWpSRXhtYW9iQmdMQ3dtNVR1OUY4cy9lNkpI?=
 =?utf-8?B?U3EzcFBjQTBtV2RYNTdmeFd0MWZYWHJYc1RDYnE4akljL21TK1NMeXNEOWVz?=
 =?utf-8?B?V3U3N09RcGdXeVZ2SnRid0ZoRndzOU91Ly9qem54RlIvVDgxdXZWNnZqTDQ0?=
 =?utf-8?B?ckpiNklNaEJjM2Rwd0VUWXViVXhRQVFzV0hYaElxS05BbmlqMmhtREVjOEFZ?=
 =?utf-8?B?Um50REgvZUJnWUk0eDlEWHpscUR0QjUyUWlEN1JlbHlub1lpU29LR3ZCY3hF?=
 =?utf-8?B?VzdKQkloNUdwMlg5OHgyZS9RNld4V0NlTisxbXVoTzJ6RFFMM3pMQmYvSTFI?=
 =?utf-8?B?aE1GQlRVQ29FY2I1aEhTaHhvVkxzQU9mRmZlWXREV1lIVXdpYlE1QUo1bFVi?=
 =?utf-8?B?OXdGMy9HcWd0MnQzdEJTOFRBc1cveStlMmQzWDhya2RGeWx6cTJTMklvRXNV?=
 =?utf-8?B?K3RScWFhSW9ud3FZYVNMY2RGajV1Y2dhWlpYV0dWQmpPV1U4TDBuTzN1Yis1?=
 =?utf-8?B?NkpQTGZKOXdrMzAyRmUwOHlwSnFmRjJEUFlDcHNkajNiVEdPYXM5Ym9lemM2?=
 =?utf-8?B?eVpuL1RFTTdldklqQ2FQTFM1UU1VOGdYYjlId2R6cG5qUTdvY2h6TUxDY3Rw?=
 =?utf-8?B?NG9KNVY1aDg2eHJpZFNDVHEvNWlOUjNnNWo2Vkd1RzlHMVA3WkJDcGFqeGcw?=
 =?utf-8?B?czdFR2JmN3dHVFVvN0pSUmcyOHpXRTh4aTdkVEdSYmpDMFE4SjgrdVkvRlRY?=
 =?utf-8?B?eHFLZ2tDTlpJWGdzbFlmOVdlUnNwbjYzWTI5KzdKaEJ4LzNGWmd0dVdid3cx?=
 =?utf-8?B?aEl2Q0lHclV0bUwrOHl0RVh2S0ZhZWhIOEV5eURkVm5rQ3cwaXZYcVcrVUds?=
 =?utf-8?B?QzEwWFdjLy82Ni9PdnZRa2JURjkyUjlCSHpCWGlLNGd2ZWpqK3RPV0MxZktI?=
 =?utf-8?B?QVN5eFdRVTI2RlIyRlBLVEJ3Vm0rNzBEZGFsNU12Yi9XNXpmYllPL1h5RERi?=
 =?utf-8?B?OE5HNUhvcCs5Y1QxM2RtTmhhWExVM241WWZEb2pMM00xdTJmYTNjMDdoejdj?=
 =?utf-8?B?UE1pTEsvcDhsMmRzQktqRFNhQnhlV3FMbkVwR1JaSmpmZk03a3VKSEcraVFB?=
 =?utf-8?B?MXdzR1I2UXEwQlB1SitMeVE4K2dkdmJSNjlQZjdpV1VINm1XdnFnVTR3NGl4?=
 =?utf-8?B?UVpzZ3ZEL1VRaVNOcTNlM1dRTWtJa1BOUGlBSkUyYUE0SHByTUdxb1JZNWpu?=
 =?utf-8?B?N0I3eklFVFZ3QVluRGwvY256dFY0c3BRbGhlcVRqQi9jT3dEUytTVktxdVha?=
 =?utf-8?B?ajgzZVI4cUNzN1BReFY2RGFQa3NjeW9FbTliRDkzb1crOENrV3RNQmRPMkVY?=
 =?utf-8?B?RGxHS1E3TTdCcURkbHhQSSt2alBTYkpETnhIYm9Fd1FRSm81eDdxaVhTNWN0?=
 =?utf-8?B?ME1NWm1mQUlQdS9zMGl2VElMVC9OMWFBek1ZeU4wV3ZTbmx6dFByOE9HM3NE?=
 =?utf-8?B?akJQUmJKMmdLSzh0SHdIUVBWUEhJZTJaSFE0Tnl4Z1RqMyt3STRzMEYrZzlW?=
 =?utf-8?B?ZWxvKzg1QWM0Q1JrVk9oQUk0UVJ1dFFJSngxL2pCQXFLOFFpTmlMUVhFWlA2?=
 =?utf-8?B?N0ZQZzloQVI5MjZYYzIxa3ZVTzU5TVJ4aDllZzFaL0tNN1phclBrblp2R0xD?=
 =?utf-8?Q?2hOYjx62MUJXI1RL+4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc8f126-e266-4400-d3e7-08d910564e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 06:15:11.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1RJU/7B3F34difHQnwAb2ca5KHipxDmHLSBNGzCGduCEqdhIHigtZnHoZloRAryo5L7t+ZdO2I4AzNViwa4uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5353
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBQcmV2ZW50IGJ1c3l3YWl0aW5nIGZvciBUUkFOIHN0YXRlIGluZGljYXRpb24NCj4gYWZ0ZXIg
aXNzdWluZyBhIGNvbW1hbmQgdGhhdCB3aWxsIG5vdCB0cmFuc2l0aW9uDQo+IHRvIFRSQU4gc3Rh
dGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9laGxlIDxjbG9laGxlQGh5cGVy
c3RvbmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyB8IDMgKystDQo+
ICBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmggfCA1ICsrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiBpbmRleCA2
ODllYjlhZmVlZWQuLjliYWY5NTYzOTY4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiBAQCAtNTkzLDcg
KzU5Myw4IEBAIHN0YXRpYyBpbnQgX19tbWNfYmxrX2lvY3RsX2NtZChzdHJ1Y3QgbW1jX2NhcmQN
Cj4gKmNhcmQsIHN0cnVjdCBtbWNfYmxrX2RhdGEgKm1kLA0KPiANCj4gICAgICAgICBtZW1jcHko
JihpZGF0YS0+aWMucmVzcG9uc2UpLCBjbWQucmVzcCwgc2l6ZW9mKGNtZC5yZXNwKSk7DQo+IA0K
PiAtICAgICAgIGlmIChpZGF0YS0+cnBtYiB8fCAoY21kLmZsYWdzICYgTU1DX1JTUF9SMUIpID09
IE1NQ19SU1BfUjFCKSB7DQo+ICsgICAgICAgaWYgKChpZGF0YS0+cnBtYiB8fCAoY21kLmZsYWdz
ICYgTU1DX1JTUF9SMUIpID09IE1NQ19SU1BfUjFCKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAmJiBUUkFOX1RSQU5TSVRJT05fQ01EKGNtZC5vcGNvZGUpKSB7DQo+ICAgICAgICAgICAgICAg
ICAvKg0KPiAgICAgICAgICAgICAgICAgICogRW5zdXJlIFJQTUIvUjFCIGNvbW1hbmQgaGFzIGNv
bXBsZXRlZCBieSBwb2xsaW5nIENNRDEzDQo+ICAgICAgICAgICAgICAgICAgKiAiU2VuZCBTdGF0
dXMiLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5oIGIvZHJpdmVycy9t
bWMvY29yZS9ibG9jay5oDQo+IGluZGV4IDMxMTUzZjY1NmY0MS4uNTFiODA2Mzg0YWIwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmgNCj4gKysrIGIvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5oDQo+IEBAIC0xNyw0ICsxNyw5IEBAIHN0cnVjdCB3b3JrX3N0cnVjdDsNCj4g
DQo+ICB2b2lkIG1tY19ibGtfbXFfY29tcGxldGVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspOw0KPiANCj4gKyNkZWZpbmUgVFJBTl9UUkFOU0lUSU9OX0NNRChjbWQpICEoY21kID09IE1N
Q19TRU5EX1NUQVRVUyBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHx8IGNtZCA9PSBNTUNfU0VORF9DSUQgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8fCBjbWQgPT0gTU1DX0FMTF9TRU5EX0NJRCBcDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHx8IGNtZCA9PSBNTUNfU0VORF9DU0QpDQo+ICsNCllv
dSBtaWdodCB3YW50IHRvIHVzZSBhIHN0YXRpYyBpbmxpbmUgaGVyZSB0byBhbGxvdyB0eXBlIGNo
ZWNraW5nLg0KSWYgeW91IGRlY2lkZSB0byBsZWF2ZSBpdCBhcyBhIG1hY3JvIGhvd2V2ZXIsIG5l
ZWQgdG8gYWRkICgpIG9uIGVhY2ggdGVybS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+ICAjZW5kaWYN
Cj4gLS0NCj4gMi4zMS4xDQo+IA0KPiBIeXBlcnN0b25lIEdtYkggfCBMaW5lLUVpZC1TdHJhc3Nl
IDMgfCA3ODQ2NyBLb25zdGFueg0KPiBNYW5hZ2luZyBEaXJlY3RvcnM6IERyLiBKYW4gUGV0ZXIg
QmVybnMuDQo+IENvbW1lcmNpYWwgcmVnaXN0ZXIgb2YgbG9jYWwgY291cnRzOiBGcmVpYnVyZyBI
UkIzODE3ODINCg0K
