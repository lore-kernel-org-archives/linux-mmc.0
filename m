Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBAE80A97
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 06:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjI0G6R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjI0G6K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 02:58:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A5116
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695797885; x=1727333885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PjA024utEhyt7eWYXPP1Q2tekG9pqeVoSTR1SKTimdA=;
  b=raNszdfWH939YEXf3FdfuiLQFNuZRzvoZJasyWLu1LnzPo59rr9a4gK8
   ALExi9lMNnc4sTxvwUWQnbI1ZaIsSnK0CKzIERhbU+CS5j8U8Ilh9npVj
   RNgbm//6pa2QW6rTbVsPerbrL/Ez/uBxQ6/aVHxSXEdmLaIauhqby+Wgw
   02oporRuoYJHQlRDhg4KIXcYcXmHPC2wNtaYWLDcMACO9+ykKkYwMcTUy
   /gW1jgjBTP2uJbI5CGtNKBipuMXZFpf2/txw1sRgj7IIjCi0Wg5lllqSH
   +MEawkBhgxTCkzDpx0uxjvKOZn+Qj3VfuwQMZDzm7BymOyx+cShzrdCMu
   w==;
X-CSE-ConnectionGUID: +Ytt6GE5Qf2eUiH4jjHOlQ==
X-CSE-MsgGUID: okpDq8LaQfOOH4XTQPl9Ag==
X-IronPort-AV: E=Sophos;i="6.03,179,1694707200"; 
   d="scan'208";a="243263570"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2023 14:58:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inmu1cyL6HQ/qoQ/m2bfP9B3QrLxkNUIiNiY0LPgo3HcjVyQWguYTi2DXTmCe82vO+Ny8IsxVnWEHRcQuogVFvA3gC662C52um1Jvu95/dtBFLE3zOcZDeyW5uc5stTK1MZMWYQiElVzRnsIwhDHdidpEwhtywPuFhudVdSO8fSCg26Rgy83fBeyKjgglz1mU2MChPU00SZmMCArcY1FcOoJm2atXQo1xLnxW8VecV6iu1D525y5G0QEhcznE9fwO71VP/5RFkqNT0E0KmQW5HGrQP1GZQy/XnMJfnueztJJprRgaPDd0IFJP8aHPr8BxmILMQt6kCsLddlUmjV7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjA024utEhyt7eWYXPP1Q2tekG9pqeVoSTR1SKTimdA=;
 b=W0kz317ol1+GeTdtdih3OquJpPX4topzOln+pFglAde1oDczrA4NrzQahJx0wFq2XKkYODPJbxXWdcRMYBSVin2j+2rHotB8gOS42j4m3apIWDHtcbKn/9VBWKxLbon18QhfTIZOJoQoisY8GDzwaCw/j+aDhMVZ2ya52smZxipnq69oDWmmRV510MNQhcGIdEk9JNoT9w/CFmlTxiWZ6wXUpcfrEWeZG3p+ZT1SPByCJN0xIPaYEfA98B1JUI5FDZpm5EWtO/U5lQGlGD4XptwJc7JaSV/nDPYrRyHAYakKbsMNEKDFJMEoUCx4uDpGPvSiSe0F/qtVmp8vocbGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjA024utEhyt7eWYXPP1Q2tekG9pqeVoSTR1SKTimdA=;
 b=pxKq47jblh2SS/wZpMaoT1hvRIEO0OGeyYzWmYFPoI3IkJXFkwiKwXyEVBjPIrMljZK/OpD3HSGFggitfWl3v41WUAepxnoZ3HcqY/Fs9eOyMzpZLEJbnms6m/FXcZiy7Jx3hCBkAEogtOOsk8lOAzCVXNReU/mp9LTrgdyQSug=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7753.namprd04.prod.outlook.com (2603:10b6:510:e9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Wed, 27 Sep 2023 06:58:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 06:58:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: RE: [PATCH] mmc: Capture correct oemid
Thread-Topic: [PATCH] mmc: Capture correct oemid
Thread-Index: AQHZ7kTUPwat9XGrUU2JPe8+twf97rAtNxIAgAEL9gA=
Date:   Wed, 27 Sep 2023 06:58:01 +0000
Message-ID: <DM6PR04MB65750256A49720817CA8FD40FCC2A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230923173728.1781844-1-avri.altman@wdc.com>
 <CAPDyKFpkLaQJCw9VHcsxTC4XeVajpH+s5r8iztjrkKUXvUmyag@mail.gmail.com>
In-Reply-To: <CAPDyKFpkLaQJCw9VHcsxTC4XeVajpH+s5r8iztjrkKUXvUmyag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7753:EE_
x-ms-office365-filtering-correlation-id: 17e79bdc-18d3-4afe-bfd6-08dbbf271731
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0HKdZ/QdOMJrn1cY6kgCcig+A3MBU8ZYlZFUvhaNcXuXdxkNEKZZD4R9y7ptRujreW/8W1EmvItADSv7fnFtNqB9UclKK6284JLEGJ/f3Ld5ddtQlVmRZWrK0Z9MIhYdnMGhA54eh1N6VWaL5tUSjqI2skLOuq8NThmBkW8AucLi7mzFlyer03YBdHfGOS383i5yLaBg5uLuCFWQTllwpWKpnhBRYKXvVnJsIO3NaQ+w3mBEe5qumlGqfQQY+Oh6f7PH0GIrqDqQpiI/xSwbv+luBGx0wR9t7GYh+zDOJUSNyyN9jOKnelGaJ680HKkbwdV3zDHqiM9cbi7MaIzE4UasC99YY1Gs7Ss/kRA8vZvr+QE3fuui/9gbe/KW8EzLFg3PTsOrJESGTy76ooTfhbO4+o7sZiZSLPe3G2p2XdLZkXNXVSP9RoZA7v77nIlKLd/xUUBmpA5c6RKjU+X1AZ62kdUuWdzZUHGvKXneSgVuwk35v0bBzGFzqHvFBhM/blrunKma/UIyD/WQrYh7MbN6gbrmRkzKC3tmAjTJBvmZ/s8abNwq1g+cN++0ijNJ06oqiQ6eH4TCH38EnPqlfHSWKDJxGi1lSH6X6QUg5aE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(38070700005)(7696005)(6506007)(5660300002)(478600001)(83380400001)(8936002)(66946007)(66556008)(26005)(9686003)(41300700001)(71200400001)(2906002)(4326008)(64756008)(316002)(66476007)(54906003)(76116006)(6916009)(52536014)(8676002)(38100700002)(66446008)(33656002)(86362001)(55016003)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29lR3BkcXlFZ3FMeVJxVXEwTFdEbGdXbHB3YkU5dFlIZjF3dXlDZ0RsZDZr?=
 =?utf-8?B?YlVSeWRob09ra21BMllGbUpYTTQwTldIVUtVYmtQYk42T2NWRjI4K0ZScE5L?=
 =?utf-8?B?N2pSRFBqbGtLZlhEa3luRGp3VXJ1U1JmQitXdkVnNWN4azF6MFJMVFFoSXN5?=
 =?utf-8?B?VWJONFpRRWxQQUVjUXVFL0xubWs5eHp0dUMyOVVnLzgvWXBMUmZKa1JZa0F2?=
 =?utf-8?B?ZnJnTjErSTN2VTg3TGd4RmxNczB1NU1oQzBuU1BsQ3NDVTA2OStDV3IzU3p3?=
 =?utf-8?B?UXNPN2NtZnVySkVMTTBuYURQMVlEc3ZlQzNxWEsvMFFaNHdjOUQxcDY0Rmsx?=
 =?utf-8?B?ZFdJWlprZHhqUE1FREI4cWxwaWdPVG1YVVh3dnJJRFVDREVVaTA3U0hLSWVN?=
 =?utf-8?B?Nmd4cStkSXEvQmQyZkhuWStMSG1qcldxWXRjTVozNnRTZmhoZ1FDRlgvdTZV?=
 =?utf-8?B?US9saklQZktsblpVTHg3TFkrSDVNN0VlUU9pUGUvTWNjeGdtRHBuN3Vmbk10?=
 =?utf-8?B?THdOckd0UmsrRURuTmlaMWVCOHU3NVZXc3RwUzdxeGRNbEJiMnBqT0N1OHdl?=
 =?utf-8?B?RW9IYzEydDBwdHhkZkx1enBpYXRMdXpRQ0NxMHlCWXdFS01ZR1hhRXc1bFlR?=
 =?utf-8?B?RDVBS1dYZ0IwNC82cE1DNUwzc2FMS0lvSnZqSG9vL29pVER6RG5sazY4Wnli?=
 =?utf-8?B?UG4vaUNNUzhDaVRYakV6UXM1cTlCbVNtOVRSZDNkRmFUZ0VpZ0N6cHdOb1E2?=
 =?utf-8?B?Q2NscWdOYUlESXVNTU1raC9IcUtQZ1FseEdTVllaM2FJTWhXaWNHUmpoKzQ4?=
 =?utf-8?B?R1V3SUwxTWZIVU9qZnV2R1JmbXdlVHNYUGFrVDBoL0t4N01yUWxGZStSaW9P?=
 =?utf-8?B?WjY2d2FRaW5ieDcwMk85RDMyZnVVSEl4UzVJb0QzdmpQUjg1U2wrMStCMXd5?=
 =?utf-8?B?SVV5dGs5d0l3UzVsUTUzZnZUMWt2NWJrTHY5QjJtM25NQW51MHVia0N5UUkw?=
 =?utf-8?B?M3J0WE5lYmx6UHRZblo2QlJqYjZjSXBYS2RsNklEMklUS2tBM3Y4UHNXNEVN?=
 =?utf-8?B?aTBoWXhzZnVMMXdpSXJkdHJIb1hEdDZGZ0VyWmsvZmR1ZEh3ZUd3UnFkZzhP?=
 =?utf-8?B?S1JVeG5mdXVrVjNSZTVoL3pTVXJ5cXcvbWtxM1REREVnVUhzeXgyR1JKRmtj?=
 =?utf-8?B?cER0Rzl5Z2NqMmkvSVU2Y00wOTJjRENGYzhramJPbmVubHpOa2tsRElnaXpM?=
 =?utf-8?B?NzZ0cTFybVlnQkxpOVVZeU56dkZhUzMxMWc4MjlsRGh0V0N4MGEwUDdFRUI2?=
 =?utf-8?B?cVhQM29BSW5Ub0txbmRheEV0VVgwZS9oRG5NOGRKSVp1VGV3R0dPL0hQMHNi?=
 =?utf-8?B?WW9JSllxbnFLWllIckVZZDRmTk1mV0VhQVJ2cGxScWRWYXMrakFQSEFhRVJv?=
 =?utf-8?B?TGxYVmhXUWx1dERoMjRMUVVNcDMwSy91UUphQm1BekM5ZnBHcUNXZXZEQStH?=
 =?utf-8?B?b0RGMERqMUxQWDdhTElKQitIMHRWdnZsRDRCZjdwUzg1NlFjamZuTEFSVDg4?=
 =?utf-8?B?QkVTL2VXR3ZwVXVwcHNDL28zM3J2aWdvWllDd1hyNVRiTmptakJ3b0syWUo4?=
 =?utf-8?B?bWxPcHBFdkFTdkR2dE90NWVPQ1F4eXVHUjV0NnhqaWJ3UjFqNjl3V1hyTFJx?=
 =?utf-8?B?YTJ3anFHdy9uLzlpUGFzaWg0ZFgycXN6NlUvR0s1alpFbzF6cXBOQUlEVklx?=
 =?utf-8?B?MjU3S1kwd3hKd1FlV1pBV1J3ZTNVc3M3STZhQ0d1dlI3enhzZHM3ZzJBUC9H?=
 =?utf-8?B?K1h0Y1E2eW93eHpwa1lyKzBqV00xd0ZwUlA4SGNaSExqaEx5Umgvc1BrTjQ1?=
 =?utf-8?B?dmlsazlTb1YzeldyeGYvZTFPSmZqV1RuQ3Vqdi95dUwyVlFoNSttWWdWRHRT?=
 =?utf-8?B?cm9NcGtpNXFDUGdXZm1JWE13Z1l6Y3Fuc2RiVTRKamgwVkp2ZnRpVG03V3ZO?=
 =?utf-8?B?QmM5bjNSZVF6OTNvV2gzWWVGcm1xc0VGL08zMUZDci9ua215MnphNHhDUFMz?=
 =?utf-8?B?QlErTktOc3lvV3h6aUtXV1RQbnlCWFBNUDVHN1RQTHRLYnB0OWw3Mmh1bVFC?=
 =?utf-8?Q?IsfG0Fbn9p02JwogyTZ8tf7ne?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0v5EExNQcu5rPhdHgVP6V08pSsXzyAAnkUM+peYqZ/KhstvMWmgqNAIdACQnTi6Q+rz7dW4cyJGj0ep2HXgNgES+5uX4oPR/Gs4sfGRhWZUIcaPlFsJydRLbSd+csAWA4hV/ucMZc4O2PbAsQTX5LA/bf6PZuFdZRr57HTEWVVM6GCrLttLRVQc4yyQwDFeN0eapBD2CFC9rCVupxZZh8FQykZtizeQYKrBxhyhux85aucWMsTr5qQT+oblGlFOJrmM3PkcNij0TvxdjF0uU2pVb61kpWwRV5HwVYgsUgAVoNOIls9hoCxZh9mwQ5AS+lych6NKvk1L2ZV6quiCaD0d4PFCDQJKbH/r5MklO8iv6J1WFLXMLMSAsdGrRXgkIX+2DoeDW/F6YcnO3+QOGcZmYDoQZQZ/eRxPlqjj0FYMEHmWmwxzbNgmR0ARwFVB5HKhXEBKrcj54FGx7dq56K95OVGOtOpgY78kqPbTtHR/Q3V0B42EJRworTceQm/SFd0Bj5Dv6EyJN1YKnB4IAnX3iIjeZuJ0KmZ1/9QYbDZYEAsb0DqmgMnLSwclVH5Uo8hJqrFZjIo9wy7ILCNg/ESZhBJVKaWlnuAkmGlT6ifJON0bnz74Gp7CGz9UznQZZslxBtVJOaBWdYMiz0DsKWBztJ/l+2Znlm35KFy+0r5LZtGXymQ5FnOnUAeIN0KLEaSvpYCRvWH+klEDpFtman9PeBI8TBMm6M1lTrilrhd6TWtcm+hFVOb7ChGBLGcs31ZqknKWW8CiroO7zFRHb6bHLHb0V1d8LcNyC0RJYltqFJSH+q2PvXCmwBwdF2XFSQvMQwZAygd8aGpjcNm9xiQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e79bdc-18d3-4afe-bfd6-08dbbf271731
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:58:01.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaO2hOmzV3TDQiRSOG8IutxThPeDRba1OV2RF6yxplQIwTLrYwMHmi7XI/deQGYeT17SQkupY2vT0bPkNmzCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7753
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

IA0KPiArIEFsZXgNCj4gDQo+IE9uIFNhdCwgMjMgU2VwdCAyMDIzIGF0IDE5OjM4LCBBdnJpIEFs
dG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgT0VNSUQgaXMg
YW4gOC1iaXQgYmluYXJ5IG51bWJlciB0aGF0IGlkZW50aWZpZXMgdGhlIERldmljZSBPRU0NCj4g
PiBhbmQvb3IgdGhlIERldmljZSBjb250ZW50cyAod2hlbiB1c2VkIGFzIGEgZGlzdHJpYnV0aW9u
IG1lZGlhIGVpdGhlcg0KPiA+IG9uIFJPTSBvciBGTEFTSCBEZXZpY2VzKS4gIEl0IG9jY3VwaWVz
IGJpdHMgWzExMToxMDRdIGluIHRoZSBDSUQgcmVnaXN0ZXI6DQo+ID4gc2VlIHRoZSBlTU1DIHNw
ZWMgSkVTRDg0LUI1MSBwYXJhZ3JhcGggNy4yLjMuDQo+ID4NCj4gPiBTbyBpdCBpcyA4IGJpdHMs
IGFuZCBoYXMgYmVlbiBzbyBzaW5jZSBldmVyIC0gdGhpcyBidWcgaXMgc28gYW5jaWVudHMNCj4g
PiBJIGNvdWxkbid0IGV2ZW4gZmluZCBpdHMgc291cmNlLiAgVGhlIGZ1cnRoZXN0IEkgY291bGQg
Z28gaXMgdG8gY29tbWl0DQo+ID4gMzM1ZWFkZjJlZjZhIChzZDogaW5pdGlhbGl6ZSBTRCBjYXJk
cykgYnV0IGl0cyBhbHJlYWR5IHdhcyB3cm9uZy4NCj4gPiBDb3VsZCBiZSBiZWNhdXNlIGluIFNE
IGl0cyBpbmRlZWQgMTYgYml0cyAoYSAyLWNoYXJhY3RlcnMgQVNDSUkgc3RyaW5nKS4NCj4gDQo+
IEFzIHBvaW50ZWQgb3V0IGJ5IEFsZXggKG9mZmxpc3QpLCBpdCBzZWVtcyBsaWtlIHRoaXMgY29t
ZXMgZnJvbSB0aGUgbGVnYWN5IE1NQw0KPiBzcGVjcyAodjMuMzEgYW5kIGJlZm9yZSkuIFRoYXQg
cHJvYmFibHkgZG9lc24ndCBtYXR0ZXIgYXMgSSBndWVzcyB0aGUgb2VtaWQNCj4gaXNuJ3QgdGhh
dCBpbXBvcnRhbnQgdG8gdXNlIGZvciB0aGVzZSBvbGQgZGV2aWNlcy4NCj4gDQo+IEhvd2V2ZXIs
IGl0IHdvdWxkIGJlIG5pY2UgaWYgeW91IGNvdWxkIGFkZCBzb21lIG9mIHRoaXMgaW5mb3JtYXRp
b24gdG8gdGhlDQo+IGNvbW1pdCBtc2csIHRvIG1ha2UgdGhpcyBjbGVhci4NCldpbGwgZG8uDQpB
bHNvLCBuZWVkIHRvIGFkZCB0aGlzIHRvIHN0YWJsZSBhcyB3ZWxsLg0KDQpUaGFua3MsDQpBdnJp
DQoNCj4gDQo+ID4NCj4gPiBJdCBpcyBpbXBvcnRhbnQgdG8gZml4IGl0IGJlY2F1c2Ugd2UgYXJl
IHVzaW5nIGl0IGFzIG9uZSBvZiBvdXINCj4gPiBxdWlyaydzIHRva2VuLCBhcyB3ZWxsIGFzIG90
aGVyIHRvb2xzLCBlLmcuIHRoZSBMVkZTDQo+ID4gKGh0dHBzOi8vZ2l0aHViLmNvbS9md3VwZC9m
d3VwZC8pLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFu
QHdkYy5jb20+DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9tbWMvY29yZS9tbWMuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvY29yZS9tbWMuYyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgaW5kZXgNCj4gPiA4OWNkNDhm
Y2VjNzkuLjRhNGJhYjlhYTcyNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL21t
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+IEBAIC0xMDQsNyArMTA0
LDcgQEAgc3RhdGljIGludCBtbWNfZGVjb2RlX2NpZChzdHJ1Y3QgbW1jX2NhcmQNCj4gKmNhcmQp
DQo+ID4gICAgICAgICBjYXNlIDM6IC8qIE1NQyB2My4xIC0gdjMuMyAqLw0KPiA+ICAgICAgICAg
Y2FzZSA0OiAvKiBNTUMgdjQgKi8NCj4gPiAgICAgICAgICAgICAgICAgY2FyZC0+Y2lkLm1hbmZp
ZCAgICAgICAgPSBVTlNUVUZGX0JJVFMocmVzcCwgMTIwLCA4KTsNCj4gPiAtICAgICAgICAgICAg
ICAgY2FyZC0+Y2lkLm9lbWlkICAgICAgICAgPSBVTlNUVUZGX0JJVFMocmVzcCwgMTA0LCAxNik7
DQo+ID4gKyAgICAgICAgICAgICAgIGNhcmQtPmNpZC5vZW1pZCAgICAgICAgID0gVU5TVFVGRl9C
SVRTKHJlc3AsIDEwNCwgOCk7DQo+ID4gICAgICAgICAgICAgICAgIGNhcmQtPmNpZC5wcm9kX25h
bWVbMF0gID0gVU5TVFVGRl9CSVRTKHJlc3AsIDk2LCA4KTsNCj4gPiAgICAgICAgICAgICAgICAg
Y2FyZC0+Y2lkLnByb2RfbmFtZVsxXSAgPSBVTlNUVUZGX0JJVFMocmVzcCwgODgsIDgpOw0KPiA+
ICAgICAgICAgICAgICAgICBjYXJkLT5jaWQucHJvZF9uYW1lWzJdICA9IFVOU1RVRkZfQklUUyhy
ZXNwLCA4MCwgOCk7DQo+ID4gLS0NCj4gPiAyLjQyLjANCj4gPg0K
