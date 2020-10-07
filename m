Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59851C4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E172087D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yea0lAXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgJGNwr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:52:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:33878 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNwq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 09:52:46 -0400
IronPort-SDR: d/KyMwgLQortn58h0RpkNAU6ewALlNevLZVK0akVmbwASMvxnk+Dh88ZUtxQYV5SFDMIBfIwhV
 tCoikCoe1JAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="249656026"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="249656026"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:52:45 -0700
IronPort-SDR: dal2e1CGDRGDTawyh0WStP10wHyp6hYODZV0J1ICuA97pYAEpWmkXtAttZsd3wwRD9MrfcUhZZ
 sbN5z5ZOG6JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="342881278"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 07 Oct 2020 06:52:45 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:52:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 06:52:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 06:52:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHG1NR5UwPhcNv28uP6tU6D477oYCzWEQBPLi9ywP41T7c0L6XmZ9oJDiMyNGFCzF7njJu09/h92yw6u0ALB6mN8DQzmgUAmC6ekNMLmuK07GVfxBOwwDyZ7RkjcZR73Te671lNmym4yL/V3n0naMQslAuFEd659LXmeFEy+EVKLA2+7KG2oExmps2XHTLa/xtltlohIz2llWdoF8m6ZMcQMVhqoOnhyfmQaIySBLKh6ZVCfhalNhrKMdJ1+H5sf7e9n2XSwl0OlimxmzqwdPLbGtiK6c8YF4PBCFqKgiEvXaDOaWS/LTOE0p4zNPVDvCLAhamF8sK2Rq4S4QO9hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Iyu6tQEnuUg1hCrnw9Sj3x5AkjHUMmDERkyig8aUM=;
 b=mExJfV+DEdVHljppRyw5gDdKb8jntKgQ9HHVm1zg7R5vtJPYto0tiQ9ENuwstZ6FGcir2/u6lpVNECfaSREEFHa7O99YXTa3ggaszg8fotY4bZCDWbuNwArpqmrrwFemHSHPcj8IuXhT4kncdFH025PTezKyt17r9kXc752UuC5Fx7UO8u+X0jn8dbAN1ewvMXKtCZMrSOxCsEe3/sBtskRggX23FXkjF6/8y6OkmLO4+xnoKBT4EE6GUihPK7rToTZ4hnaMUQUsc25q/1b2qrPxwzzg1d4Lw72c1EpWa6E8Lmse/jLoXiZ7/x7WdcRVkwdHHePI3Pz1rm2Tkc9aLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Iyu6tQEnuUg1hCrnw9Sj3x5AkjHUMmDERkyig8aUM=;
 b=yea0lAXImwNLnSvvrMwUmj88zil6+MrLTDDkhu/ZBKT066OWhw7ISGf1W407AV6jb3XTemwe8qQLvqjiy5EhQGQ/HIWb+SnPTSipywVLnRhZMH8gd0J0Y3KpceG3WYtcWA8xD6ODww5eaH6fx/vzRHiI8mAmu5zSRGBOX2GTws4=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2618.namprd11.prod.outlook.com (2603:10b6:5:c0::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Wed, 7 Oct 2020 13:52:42 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 13:52:42 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWm/mmQ68E6v02PEeQu9XSxqgGOqmLzXGAgABTRsCAAAU4AIAAA1pA
Date:   Wed, 7 Oct 2020 13:52:42 +0000
Message-ID: <DM6PR11MB2876A16148E84AB8FFC0B7FAB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
 <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
 <DM6PR11MB2876F93077CA6705EFAB2E4EB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <db60efac-c583-4b2a-3ad9-7bd93dfb5323@xilinx.com>
In-Reply-To: <db60efac-c583-4b2a-3ad9-7bd93dfb5323@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbbb6757-ea73-4c01-38c0-08d86ac8433b
x-ms-traffictypediagnostic: DM6PR11MB2618:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2618C0C4392A20A008645245B80A0@DM6PR11MB2618.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBnSCfQMf2LKb3usEJ5+RafDVZ0hPbMslRNMT1XqQkBtdbVWMlq8gwlgPgdZD+jTb7RsDuKsFKMVlFBFH6rX7u/D6m/BBzCp5HMFKhPm4Sn0gzOk5relMExUyoulwaBr93OmLlw2YCcLeWxdjy9wM8ReeUEBz0a6DYel9zIODVHf833y9u39CdqF8jIfHhI5epPwP7ye+ofhA80bYDBNe9aohMIuoOTvqKnpneU8jcpJG0kPtYN2ryTHSIlMxFS9HBxE3QcXthi1AoXu7JKtCKj3y1kog1NAotQn8k+chaGgJA03PsRSVakjP1mdmmnFtOiZ5bBMyVQpAR8gHrXSTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(9686003)(110136005)(8676002)(4326008)(8936002)(55016002)(316002)(71200400001)(54906003)(5660300002)(53546011)(52536014)(6506007)(66556008)(66476007)(86362001)(83380400001)(26005)(186003)(33656002)(76116006)(2906002)(64756008)(66946007)(478600001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LCGo13C9eQoHMuSyalJsCVS8WN8snPrdIeSvij80SyF0VTYATA5UYQCz+NWGp2t/wzuUn9cWsl6UFKz/kuuKL46+rlE7wieet0/WlK6Vk4XkF4y2f8uQ3Qm4vMvYmBpp822t5VHhnn/Cx+AjT2+RzbSLQAH6gLUmKIlb2ZYVSWRTbMQEdfLIG76AeBqp1nT55F7fx+MzRlYWd4cZplnvARF/Y4f4sO7ptJc9e9BySlVZ3eSZxvs1TbkAxU1F34fNwyKjOq1eZeEmdcAXOs/PBbR8n9ToxISmicAS5DyHGccEE8ZpCFqL74Q6rDEd74sumEwwUtq6zD/zAYqWY1iptWzs9SXAJRzeQsk4sumutZOA4bGD8BTxGkPkcVASbd3SMLT0tgsmdhhq+HauE0rmMoBV1N5E0PWYOx7xqbyAh/B5Hp8QE7covULGABiQUECBM+yg06SzDDN9Yz1NTRFKRc7PK8vj2h8cxJTEcGaPMwPDxUXnUvxgRvQQGXH8ydJe2nfp4XUiWNXIefYh4o/3/Mnf5ZkQd9iWfTxjWnFEQc5sOtpPv2XalTwkxk73RoHPBCmg8CvRRZC0KjMyx6UrELZOgoCItBKqz83OwIvEC2zEJ3XQTmXj9vH9+LlZo1IpBUBBu7jjBGhSdl9GH0DTRQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbb6757-ea73-4c01-38c0-08d86ac8433b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 13:52:42.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/qKANbaVSmmSTHE3EVw0o4Pkn7oSePYLb2IXBPP8yn4wjMt5dlDgNcnFPRsZ42Qf6Hi7xpvB0hauYnYsREDMpXQ9QG70UmH0GQjVpp9XVco37PFMoMKZmZXpf/pPz92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2618
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhbCBTaW1layA8
bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDcsIDIw
MjAgOTozNyBQTQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1tYWQuaHVz
YWluaS56dWxraWZsaUBpbnRlbC5jb20+Ow0KPk1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhp
bGlueC5jb20+OyBIdW50ZXIsIEFkcmlhbg0KPjxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IHN1
ZGVlcC5ob2xsYUBhcm0uY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPmxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPkNjOiBSYWphIFN1YnJhbWFuaWFuLCBMYWtz
aG1pIEJhaSA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+Ow0KPldhbiBN
b2hhbWFkLCBXYW4gQWhtYWQgWmFpbmllDQo+PHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFtYWRA
aW50ZWwuY29tPjsgYXJuZEBhcm5kYi5kZQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBm
aXJtd2FyZTogS2VlbSBCYXk6IEFkZCBzdXBwb3J0IGZvciBBcm0gVHJ1c3RlZA0KPkZpcm13YXJl
IFNlcnZpY2UgY2FsbA0KPg0KPkhpLA0KPg0KPk9uIDA3LiAxMC4gMjAgMTU6MjEsIFp1bGtpZmxp
LCBNdWhhbW1hZCBIdXNhaW5pIHdyb3RlOg0KPj4gSGkgTWljaGFsLA0KPj4NCj4+IFRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrLiBJIHJlcGxpZWQgaW5saW5lDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54
LmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNywgMjAyMCA0OjIwIFBNDQo+Pj4g
VG86IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxp
QGludGVsLmNvbT47DQo+Pj4gSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+Pj4gc3VkZWVwLmhvbGxhQGFybS5jb207IHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc7DQo+Pj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPj4+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4+PiBDYzogUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj4+PiA8
bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+Ow0KPj4+IFdhbiBNb2hhbWFk
LCBXYW4gQWhtYWQgWmFpbmllDQo+Pj4gPHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFtYWRAaW50
ZWwuY29tPjsgYXJuZEBhcm5kYi5kZQ0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBm
aXJtd2FyZTogS2VlbSBCYXk6IEFkZCBzdXBwb3J0IGZvciBBcm0NCj4+PiBUcnVzdGVkIEZpcm13
YXJlIFNlcnZpY2UgY2FsbA0KPj4+DQo+Pj4gSGksDQo+Pj4NCj4+PiAxLiBLZWVtIEJheTogaW4g
c3ViamVjdCBpcyB3cm9uZy4gVG9vbHMgYXJlIHdvcmtpbmcgd2l0aCBpdCBhbmQgeW91DQo+Pj4g
c2hvdWxkIGp1c3QgdXNlIGtlZW1iYXk6IGluc3RlYWQuDQo+PiBBcmUgeW91IHNheWluZyBsaWtl
IHRoaXMgPw0KPj4gS2VlbSBCYXk6IEFkZCBzdXBwb3J0IGZvciBBcm0gVHJ1c3RlZCBGaXJtd2Fy
ZSBTZXJ2aWNlIGNhbGwNCj4NCj5saWtlIHRoaXM6DQo+ZmlybXdhcmU6IGtlZW1iYXk6IEFkZCBz
dXBwb3J0IGZvciBBcm0gVHJ1c3RlZCBGaXJtd2FyZSBTZXJ2aWNlIGNhbGwNCj4NCj4+DQo+Pj4N
Cj4+PiAyLiBUaGlzIHNob3VsZCBjb21lIGZpcnN0IGJlZm9yZSBhY3R1YWwgY2hhbmdlIHRvIGtl
ZXAgdGhlIHRyZWUgYmlzZWN0YWJsZS4NCj4+IE5vdGVkLiBEb25lIHRoZSBjaGFuZ2VzDQo+Pj4N
Cj4+PiBPbiAwNi4gMTAuIDIwIDE3OjU1LCBtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVs
LmNvbSB3cm90ZToNCj4+Pj4gRnJvbTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaQ0KPj4+PiA8
bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+Pj4+DQo+Pj4+IEFkZCBoZWFk
ZXIgZmlsZSB0byBoYW5kbGUgQVBJIGZ1bmN0aW9uIGZvciBkZXZpY2UgZHJpdmVyIHRvDQo+Pj4+
IGNvbW11bmljYXRlIHdpdGggQXJtIFRydXN0ZWQgRmlybXdhcmUuDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+Pj4gPG11aGFtbWFkLmh1c2Fp
bmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIC4uLi9saW51eC9maXJtd2Fy
ZS9pbnRlbC9rZWVtYmF5X2Zpcm13YXJlLmggICB8IDQ2ICsrKysrKysrKysrKysrKysrKysNCj4+
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+Pj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X2Zpcm13YXJlLmgNCj4+
Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW50ZWwva2VlbWJh
eV9maXJtd2FyZS5oDQo+Pj4+IGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbnRlbC9rZWVtYmF5
X2Zpcm13YXJlLmgNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAwMDAw
MDAwMDAwLi45YWRiOGM4N2I3ODgNCj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL2ludGVsL2tlZW1iYXlfZmlybXdhcmUuaA0KPj4+PiBAQCAtMCww
ICsxLDQ2IEBADQo+Pj4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0K
Pj4+PiArLyoNCj4+Pj4gKyAqICBJbnRlbCBLZWVtYmF5IFNPQyBGaXJtd2FyZSBBUEkgTGF5ZXIN
Cj4+Pj4gKyAqDQo+Pj4+ICsgKiAgQ29weXJpZ2h0IChDKSAyMDIwLTIwMjEsIEludGVsIENvcnBv
cmF0aW9uDQo+Pj4+ICsgKg0KPj4+PiArICogIE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkgPE11
aGFtbWFkLkh1c2FpbmkuWnVsa2lmbGlAaW50ZWwuY29tPg0KPj4+PiArICovDQo+Pj4+ICsNCj4+
Pj4gKyNpZm5kZWYgX19GSVJNV0FSRV9LRUVNQkFZX1NNQ19IX18NCj4+Pj4gKyNkZWZpbmUgX19G
SVJNV0FSRV9LRUVNQkFZX1NNQ19IX18NCj4+Pj4gKw0KPj4+PiArI2luY2x1ZGUgPGxpbnV4L2Fy
bS1zbWNjYy5oPg0KPj4+PiArDQo+Pj4+ICsvKioNCj4+Pg0KPj4+IFRoaXMgaXMgbm90IGEga2Vy
bmVsIGRvYyBjb21tZW50LiBKdXN0IHVzZSAvKg0KPj4+DQo+Pj4+ICsgKiBUaGlzIGZpbGUgZGVm
aW5lcyBBUEkgZnVuY3Rpb24gdGhhdCBjYW4gYmUgY2FsbGVkIGJ5IGRldmljZQ0KPj4+PiArIGRy
aXZlciBpbiBvcmRlciB0bw0KPj4+PiArICogY29tbXVuaWNhdGUgd2l0aCBBcm0gVHJ1c3RlZCBG
aXJtd2FyZS4NCj4+Pj4gKyAqLw0KPj4+PiArDQo+Pj4+ICsvKiBTZXR0aW5nIGZvciBLZWVtIEJh
eSBJTyBQYWQgTGluZSBWb2x0YWdlIFNlbGVjdGlvbiAqLw0KPj4+PiArI2RlZmluZSBLRUVNQkFZ
X1NFVF9TRF9WT0xUQUdFX0ZVTkNfSUQJMHg4MjAwZmYyNg0KPj4+DQo+Pj4gU3VkZWVwOiBEb24n
dCB3ZSBoYXZlIGFueSBtYWNyb3MgZm9yIGNvbXBvc2luZyB0aGVzZSBJRHM/DQo+Pj4gbml0OiBJ
TUhPIGNvbXBvc2luZyB0aGVzZSBJRHMgZnJvbSBtYWNyb3Mgd291bGQgbWFrZSBtb3JlIHNlbnNl
IHRvIG1lLg0KPj4+DQo+Pj4NCj4+Pj4gKyNkZWZpbmUgS0VFTUJBWV9TRVRfMVY4X1ZPTFQJCTB4
MDENCj4+Pg0KPj4+IDB4MDEgaXMganVzdCAxDQo+PiBOb3RlZC4gRG9uZSB0aGUgY2hhbmdlcw0K
Pj4+DQo+Pj4+ICsjZGVmaW5lIEtFRU1CQVlfU0VUXzNWM19WT0xUCQkweDAwDQo+Pj4NCj4+PiAw
eDAwIGlzIGp1c3QgMA0KPj4gTm90ZWQuIERvbmUgdGhlIGNoYW5nZXMNCj4+Pg0KPj4+PiArDQo+
Pj4+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfSEFWRV9BUk1fU01DQ0NfRElTQ09WRVJZKQ0KPj4+
PiArc3RhdGljIGludCBkb19md19pbnZva2UodTY0IGZ1bmNfaWQsIHU2NCBhcmcwLCB1NjQgYXJn
MSkgew0KPj4+PiArCXN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4+Pj4gKw0KPj4+PiArCWFy
bV9zbWNjY18xXzFfaW52b2tlKGZ1bmNfaWQsIGFyZzAsIGFyZzEsICZyZXMpOw0KPj4+PiArDQo+
Pj4+ICsJcmV0dXJuIHJlcy5hMDsNCj4+Pg0KPj4+IEkgYW0gbm90IGJpZyBmYW4gb2YgdGhpcyBl
cnJvciBwcm9wYWdhdGlvbiBpbiBjYXNlIG9mIGZhaWx1cmUuDQo+Pj4NCj4+PiBJZiBzbWMgZmFp
bHMgeW91IGdldCB2aWEgcmVzLmEwIFNNQ0NDX1JFVF9OT1RfU1VQUE9SVEVEIHdoaWNoIGlzDQo+
Pj4gZGVmaW5lZCBhcw0KPj4+IC0xIHdoaWNoIGlzIGJhc2VkIG9uIGVycm5vLWJhc2UuaCBkZWZp
bmVkIGFzIEVQRVJNLg0KPj4+DQo+Pj4gVGhhdCBkcml2ZXIgd2hpY2ggU3VkZWVwIHBvaW50ZWQg
eW91IHRvIGlzIHVzaW5nIEVJTlZBTCBpbnN0ZWFkLg0KPj4+DQo+Pj4gSXQgbWVhbnMgSSB3b3Vs
ZCBhZGQgYSBjb2RlIHRvIGNoZWNrIGl0Lg0KPj4NCj4+IFllYWggSSBjaGFuZ2VkIHRvIGJlbG93
IGxpbmUgb2YgY29kZXMuIElzIHRoaXMgT2s/IFRlc3RlZCB3b3JraW5nLg0KPj4gaW50IGtlZW1i
YXlfc2Rfdm9sdGFnZV9zZWxlY3Rpb24oaW50IHZvbHQpDQo+DQo+c3RhdGljIGlubGluZSBoZXJl
IHNob3VsZG4ndCBodXJ0Lg0KZHVlIHRvIGZ1bmMoKSBwcm90b3R5cGUgIiBpbnQga2VlbWJheV9z
ZF92b2x0YWdlX3NlbGVjdGlvbihpbnQgdm9sdCk7IiB0byBzb2x2ZSB3YXJuaW5nIGlzc3VlcyBi
eSByb2JvdCAsIEkgY2Fubm90IHNldCBzdGF0aWMgaW5saW5lIGhlcmUuIA0KV2lsbCBvYnNlcnZl
ZCBiZWxvdyBlcnJvcjoNCg0KZXJyb3I6IHN0YXRpYyBkZWNsYXJhdGlvbiBvZiDigJhrZWVtYmF5
X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9u4oCZIGZvbGxvd3Mgbm9uLXN0YXRpYyBkZWNsYXJhdGlvbg0K
IHN0YXRpYyBpbmxpbmUgaW50IGtlZW1iYXlfc2Rfdm9sdGFnZV9zZWxlY3Rpb24oaW50IHZvbHQp
Lg0KDQo+DQo+PiB7DQo+PiAJc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPj4NCj4+DQo+CWFy
bV9zbWNjY18xXzFfaW52b2tlKEFSTV9TTUNDQ19TSVBfS0VFTUJBWV9TRVRfU0RfVk9MVEFHDQo+
RSwgdm9sdCwgJnJlcyk7DQo+PiAJaWYgKChpbnQpcmVzLmEwIDwgMCkNCj4+IAkJcmV0dXJuIC1F
SU5WQUw7DQo+Pg0KPj4gCXJldHVybiAwOw0KPj4gfQ0KPg0KPlRoaXMgaXMgZmluZS4NCj4NCj5N
DQo=
