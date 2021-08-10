Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD91C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 07:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B78D60F38
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 07:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhHJHdW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:33:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:37378 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhHJHdV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Aug 2021 03:33:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="300440581"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="300440581"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 00:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="506034541"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2021 00:32:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 00:32:59 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 00:32:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 00:32:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 00:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS+SFFI5icUiCUUU9imSGLLht52QK3vAPrbDkrrvY3uHFrkx6e8ssMonDeveeTjeFTEtF3uEzhXgZEhrYfnIA87/8hWVvWqJz4b+ARBJr1zuDcn4KfToZMqEp2LCXwq7CDfioAuwR/xkfts5/op/3jcVMClFvVgNP4DU5UBkyvdfUDzfoyZQNwhbOV6CGzFuGk6qyohCD3gaHuaoUIWRAnlZ/dxzPNUkgdFwotP5tZ3LTpWhumgUKhBL+eKu5Rft7lJYBZZeczWI5sQIC8OzL2T9BbSKktZgUjgIZ6XDbbr3FJdsb4Gh3Kvs+ESd3kvJoM460dZbASnjN/qPDDSO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rk6R02vV7zVqwpAU5MGdPoQnOECUitoo/zO++gPcyA=;
 b=heq44OmdaZIkhF7xJHQGVPkL1ZuJsKYEqSASU6pMrsvvjsWb5qPGVNpefP4bzB/LpFXvuETdCJsnz/uWkcpFE/MNN8T4sSEg+tU7M7P67nYqZk+1mNDqJMz3xUwgExjohjjalmJqP9ykYCJGPReDFda6jHSPMI8on86WqDj+iqN0e8AzckEGkhCCsiCl3GDAliHtalqxYZQZfmRK+g3EyuScDPRtrovl1VgZFk3RG1/zRFUGS7N+iWh0mT0pAeWNnh7bwO0hv5IbixGHV0OV25Zu9ohCqcchgJzdy/zRTrY87v8wn62qd2WM3GsCcWqiliufj0WBOD55kxGIXNIORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rk6R02vV7zVqwpAU5MGdPoQnOECUitoo/zO++gPcyA=;
 b=Ti+pR7v/c1uiHFow+ZCUFXQNbx4RtAzjzRX+ktfBO8lAXqoITzeL8PB/dgKbZdb8kgb+CXCoVunClIsvLV5Xp7YVPrYweqmiqVA5fHfoJDKMCJyLfFXOoxsZPtGpoaXhb6SnceGIQULljHJF7iniap44cr9yqdlVlqTvUA5v+VI=
Received: from MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13)
 by MWHPR1101MB2320.namprd11.prod.outlook.com (2603:10b6:301:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 07:32:56 +0000
Received: from MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3]) by MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:32:55 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: RE: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Thread-Topic: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Thread-Index: AQHXhQzRAwmHks3vwkaXAOpN1lCV0KtmfYEAgAQx92CAADsqAIAAJ6HwgAATgwCAAUGykA==
Date:   Tue, 10 Aug 2021 07:32:55 +0000
Message-ID: <MWHPR11MB17898D0E3A0A4DD993AD7E948CF79@MWHPR11MB1789.namprd11.prod.outlook.com>
References: <20210730063309.8194-1-rashmi.a@intel.com>
 <20210730063309.8194-3-rashmi.a@intel.com>
 <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
 <MWHPR11MB17891909766F5295AF34B0578CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
 <YRDqQvKQ71/824Lu@matsya>
 <MWHPR11MB1789D2B707B39CB42322C73A8CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
 <CAPDyKFp5HcCfsoLgBc=D9RKOrVY2SuV3FKsFCVT2=WaxZBsNiA@mail.gmail.com>
In-Reply-To: <CAPDyKFp5HcCfsoLgBc=D9RKOrVY2SuV3FKsFCVT2=WaxZBsNiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f97adb86-6712-4554-c3b6-08d95bd11210
x-ms-traffictypediagnostic: MWHPR1101MB2320:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB23206CC8B09AC99D735A30858CF79@MWHPR1101MB2320.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRqKKfZlFMWIk/GbLu7C7lko10QIGg7ExyBQ0KQYRkiEwL68d1e20dXtjx+deUuLe5pd7Sj5No5dUuYg9Di434xK6Sb/3e3vvB9/Px47gjzmbE+YpwdblS3SZ5EJWLD4hkzHD+hqXdAa5HUoG497qPmtVtS1lVmCXujnvBSvvXSwK/p0jcSclRJk91n3g2GwznyOvu73pL6TESJg2xcjwxPeEPAOpQiKr0i7ipcqE0SZQ228uIU05A2/0953lC5LviT0ndq67KUbDCXd0LaTo3rFE9KyY+Z9hvuYCOOiNRtyWkB1XrlSEsdHT3A5iLbFAWpnZZJQFTTQbCqVhho2Ij8Ba7cLm3A3L5VsGnUD3G9wX/7xDAxh/W9kUAH3pbrxT1i4A0Frz8LS0/DnhOfH1x1TuI2an2zqiZuILAVBgKzzzET0i853DyR5g84cgO9mOhaH6tzPTKnkeQbBoFz4R5TfjwqS9xL1F3wFbadEdIchiPTEHBLKBcrnOSvnZN9CnHlFG1fxcS8oDAm+LUcWDvqKb6gKBHbbmwvpUA+IbaAj7/JX5pUXtAGd0pIkbnojWmry8tR/cn6EU2q/f3KVQ9qnYGf0BbRARv86sH9uSbdH95+LxL3Y6KnJJrUH2RsSstmIY6XM7CPZSb0/Ijb/Ew3Zre31ktlGRyVhGiUVWVPEmBthtWIU6xgvrrr0/Wve1b4fIN7ml5wOcc/CrMrMGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(4326008)(478600001)(76116006)(2906002)(64756008)(66946007)(66476007)(66556008)(66446008)(26005)(54906003)(7696005)(86362001)(53546011)(316002)(83380400001)(6506007)(6916009)(33656002)(186003)(8676002)(38100700002)(71200400001)(7416002)(5660300002)(38070700005)(122000001)(52536014)(9686003)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXhvTmtYMThhRk1kWE9lUEs0NFo4N3pVVXZTSi95bEF1S0RuV2xmSG5JMDdw?=
 =?utf-8?B?UXp6dm9ia2ppWTNYWlYwYVRMODZFTHd2Y3hJMVlIbzVTdDBrZUY2WnMyMi9P?=
 =?utf-8?B?T1RybFJPVVNQOUNXYXhGL0k0OGlhQjNvdXRRMGpjcWVSMVZCMHExS1ViUUJz?=
 =?utf-8?B?b3lUVmF4RlRwK1B4MExBNnRGQmt1ZGFtRktwMzJRL0dWcGpvU1RmNzBNTEFK?=
 =?utf-8?B?a3lqQzhkdHQ3TXdYOUhUZEZhRmpoYWVLZHg2WVhhd3kvZDRqS2htaXpub0pT?=
 =?utf-8?B?dTY1cnR3UDBIZS9wN255TldBdngzNlg2Ty9IWmdkQmIrdEtsbm41TDVCUjQw?=
 =?utf-8?B?WGFBTkxsMEpkKzVYZnlWU2JTWE5lVWx3VlhvQ3k4aUFnMDdUWWJzZEFpeXVX?=
 =?utf-8?B?NzJwMmxLcVBhSDBUZHdVQ1ZPVnlEUDg2a2RrN29OdjVtdDFLR0ZTODEyeFI1?=
 =?utf-8?B?RkdLZWRkdTBIbWg2ME1DdGFFM2MwMTZqMUtlMHZET1dYYmhocHIzOHB1U0lv?=
 =?utf-8?B?VUN1b1BmTUNINEptbjQrWm1iOUxua2QvZVlrUVYrTkhNcnNmZUUyanRCTGtX?=
 =?utf-8?B?RVBucVFvOEg4dTNKZ05Zck01bEI1ZEVWME94c29FVmM5SFEvNUYyNFQxZUhh?=
 =?utf-8?B?citvd0FoeWZSQmorZnJpNysyK210QUl4VkJqWVE1QU1LZ2Nld3lqanlPK0RN?=
 =?utf-8?B?YTRpczBreG8xb0txQ21pK2k2Ri9CSTRHQXZYb0JwU2dDMFVLb1c2MDdYT0ph?=
 =?utf-8?B?NjhsTFh5Qy9kV3VZNStFdjBMRVI1dzBUd2NYR2puUnJBNGwvM0xBQUVUbW9M?=
 =?utf-8?B?MUlWdGFudit1TVB0UTMvQ0hzdGlNN0t6eldIQnB5dXJUZ1gwcEYzWFpXd2lu?=
 =?utf-8?B?dm5oTWtGaWFxNEtvVXp0MURyWitORUQzSC9KbTVSTTBPQTFZTy9yVFhVZmE0?=
 =?utf-8?B?NWE5ZU1wc2JmekxyQTNOSUkwZm5VSU1NRVRTUlIreUtaN3R6TlN4MlYydnJj?=
 =?utf-8?B?Q0tKRDE5OEl0WDNSd2s4Qm91eU8vSjNmTlM5Y3o1YnRQMkNiaHVaeXBaTzh2?=
 =?utf-8?B?SW01bzkwNmZpaWpsVmMwUDYwaEM3d1VXN0RUY29FWHg4TnlmM29YWGg1WGlC?=
 =?utf-8?B?dXAwTHdwM0JpZUNicDJaK0Q4d0MxUFBacWlVQVJuSGxqZjVZUjZ2em1VeVZU?=
 =?utf-8?B?ZUxDNWlMSUVTTXBPNWJBZXlPZjdjS0Q5WUxOaXloSDdlUWpsWlBQZERhVUpI?=
 =?utf-8?B?S3d0cS8razZzTTZ3M2kxY202cmdYZzdrcjRSNXh6cDl0ejlJajlnYVZpQUp3?=
 =?utf-8?B?OSt1L1QzNlkyMTQ4cXc2WXZWOTdGcGJOMmJzVTQ5eFp0eTZuZ0NML3BIK1Vk?=
 =?utf-8?B?czM2cHFTZnJlWTk1WEU5cjVuS295WmsyMmVFOHhxL2tkbUZWZHBsTjFIU1pj?=
 =?utf-8?B?S2phbGlSaDN0djVYRVVKdjFCUUFlcm5sL3lROCticnQ2OU9kWjZ5dFFnSmIx?=
 =?utf-8?B?MUkxeDdQK2RrZTBob21yQWdHSnM4WSszaWwzUTh2M0NiZ05sc3lVdExaTksw?=
 =?utf-8?B?MSs4SlpodHYwSk5LL3JqTEVaRTJ5RXM5NVEvcmd2ZDFRUy9CZ3lRZzhUbTZZ?=
 =?utf-8?B?MnowaGxFVmtGbDFlZ0JBMGhMc05rcFVmQmdTcytuWE8xUGFqQW1xYThwdVBy?=
 =?utf-8?B?ZW8vUTdjM2RvRTZGbG5QOFZZblQyNm1kOXNORUEwU3VDeUNSNmNlTC9maHVa?=
 =?utf-8?Q?iigAR+83gytSjZS+DbIXE1BNMWRk1UQhNwaTwt/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97adb86-6712-4554-c3b6-08d95bd11210
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 07:32:55.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POiiUJU9VuGhZqsOZ1Gx7/usgT1qnjAsS82vnc7zLdacbGod3xVsPAjC6a41gXdB/a0wItKHosfINnApLOSfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2320
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDksIDIwMjEgNTo0
MyBQTQ0KPiBUbzogQSwgUmFzaG1pIDxyYXNobWkuYUBpbnRlbC5jb20+DQo+IENjOiBWaW5vZCBL
b3VsIDx2a291bEBrZXJuZWwub3JnPjsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWwuc2ltZWtAeGls
aW54LmNvbT47IGxpbnV4LW1tYyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9yZz47IExpbnV4DQo+
IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVs
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBLaXNob24g
PGtpc2hvbkB0aS5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbT47IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBNYXJrDQo+IEdy
b3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsga3Jpcy5wYW5AbGludXguaW50ZWwuY29tOyBa
aG91LCBGdXJvbmcNCj4gPGZ1cm9uZy56aG91QGludGVsLmNvbT47IFNhbmdhbm5hdmFyLCBNYWxs
aWthcmp1bmFwcGENCj4gPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+OyBI
dW50ZXIsIEFkcmlhbg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBWYWlkeWEsIE1haGVz
aCBSDQo+IDxtYWhlc2guci52YWlkeWFAaW50ZWwuY29tPjsgU3Jpa2FuZGFuLCBOYW5kaGluaQ0K
PiA8bmFuZGhpbmkuc3Jpa2FuZGFuQGludGVsLmNvbT47IERlbWFra2FuYXZhciwgS2VuY2hhcHBh
DQo+IDxrZW5jaGFwcGEuZGVtYWtrYW5hdmFyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzNdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBBZGQgaW50ZWwgVGh1bmRlciBCYXkgU09D
DQo+IHN1cHBvcnQgdG8gdGhlIGFyYXNhbiBlTU1DIGRyaXZlcg0KPiANCj4gT24gTW9uLCA5IEF1
ZyAyMDIxIGF0IDEzOjE3LCBBLCBSYXNobWkgPHJhc2htaS5hQGludGVsLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgQXVn
dXN0IDksIDIwMjEgMjoxMiBQTQ0KPiA+ID4gVG86IEEsIFJhc2htaSA8cmFzaG1pLmFAaW50ZWwu
Y29tPg0KPiA+ID4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgTWlj
aGFsIFNpbWVrDQo+ID4gPiA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBsaW51eC1tbWMgPGxp
bnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+Ow0KPiA+ID4gTGludXggQVJNIDxsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwNCj4gPiA+IE1haWxpbmcgTGlz
dCA8bGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBLaXNob24NCj4gPiA+IDxraXNob25A
dGkuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+ID4gPiA8YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tPjsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBNYXJrIEdy
b3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsga3Jpcy5wYW5AbGludXguaW50ZWwuY29tOyBa
aG91LA0KPiA+ID4gRnVyb25nIDxmdXJvbmcuemhvdUBpbnRlbC5jb20+OyBTYW5nYW5uYXZhciwg
TWFsbGlrYXJqdW5hcHBhDQo+ID4gPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVs
LmNvbT47IEh1bnRlciwgQWRyaWFuDQo+ID4gPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBW
YWlkeWEsIE1haGVzaCBSDQo+ID4gPiA8bWFoZXNoLnIudmFpZHlhQGludGVsLmNvbT47IFNyaWth
bmRhbiwgTmFuZGhpbmkNCj4gPiA+IDxuYW5kaGluaS5zcmlrYW5kYW5AaW50ZWwuY29tPjsgRGVt
YWtrYW5hdmFyLCBLZW5jaGFwcGENCj4gPiA+IDxrZW5jaGFwcGEuZGVtYWtrYW5hdmFyQGludGVs
LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBtbWM6IHNkaGNpLW9mLWFyYXNh
bjogQWRkIGludGVsIFRodW5kZXIgQmF5DQo+ID4gPiBTT0Mgc3VwcG9ydCB0byB0aGUgYXJhc2Fu
IGVNTUMgZHJpdmVyDQo+ID4gPg0KPiA+ID4gT24gMDktMDgtMjEsIDA1OjE2LCBBLCBSYXNobWkg
d3JvdGU6DQo+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmFzaG1pLCBpcyBpdCBzYWZlIHRv
IGFwcGx5IHRoaXMgc2VwYXJhdGVseSBmcm9tIHRoZSBwaHkgZHJpdmVyL2R0DQo+IGNoYW5nZXM/
DQo+ID4gPiA+ID4gVGhlbiBJIGNhbiBxdWV1ZSB0aGlzIHZpYSBteSBtbWMgdHJlZSwgaWYgeW91
IGxpa2UuDQo+ID4gPiA+IE5vLCB0aGUgcGh5IGRyaXZlci9kdCBjaGFuZ2VzIG11c3QgZ28gdG9n
ZXRoZXIgd2l0aCAibW1jOg0KPiA+ID4gPiBzZGhjaS1vZi0NCj4gPiA+IGFyYXNhbjogQWRkIGlu
dGVsIFRodW5kZXIgQmF5IFNPQyBzdXBwb3J0IHRvIHRoZSBhcmFzYW4gZU1NQyBkcml2ZXIiDQo+
ID4gPiBwYXRjaC4NCj4gPiA+DQo+ID4gPiBXaHkgaXMgdGhhdD8NCj4gPiA+DQo+ID4gPiBXaGF0
IGNvdWxkIGhhcHBlbiwgZW1tYyBkcml2ZXIgd2lsbCBjb21wbGFpbiBhYm91dCBwaHkgbm90IGZv
dW5kIGFuZA0KPiA+ID4gYmFpbCByaWdodD8NCj4gPiBUaGlzIGlzIHJpZ2h0LCBidXQgaWRlYWxs
eSBib3RoIG1tYzpwaHkgYW5kIG1tYzogc2RoY2ktb2YtYXJhc2FuDQo+ID4gZHJpdmVyIGNvZGUg
Y2hhbmdlcyBzaG91bGQgZ28gdG9nZXRoZXINCj4gDQo+IElmIHBhdGNoZXMgYXJlIHdlbGwgd3Jp
dHRlbiBhbmQgY2FuIGJlIHN0YW5kYWxvbmUsIHdlIChtYWludGFpbmVycykgaWRlYWxseQ0KPiBw
cmVmZXIgdG8gcXVldWUgdGhpbmdzIG9uIGEgcGVyIHN1YnN5c3RlbSBiYXNpcywgYmVjYXVzZSBp
dCdzIGp1c3QgZWFzaWVyLg0KPiANCj4gVGhhdCBzYWlkLCBJIGFsc28gbm90aWNlZCB0aGF0IGEg
bmV3IGNvbXBhdGlibGUgc3RyaW5nIHdhcyBhZGRlZCwNCj4gImludGVsLHRodW5kZXJiYXktc2Ro
Y2ktNS4xIi4gVGhpcyBuZWVkcyB0byBiZSBkb2N1bWVudGVkIGluDQo+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnlhbWwsIGluIGEgc2VwYXJhdGUN
Cj4gcGF0Y2gsIHByZWNlZGluZyAkc3ViamVjdCBwYXRjaC4NCj4gDQpJIGFja25vd2xlZGdlIHlv
dXIgY29tbWVudHMuIEkgd2lsbCBzdWJtaXQgYSBzZXBhcmF0ZSBwYXRjaCB0byBkb2N1bWVudCBk
ZXZpY2UgdHJlZSBiaW5kaW5ncy4gQWZ0ZXIgdGhhdCBtbWM6IHNkaGNpLW9mLWFyYXNhbiBkcml2
ZXIgcGF0Y2ggY291bGQgYmUgcXVldWVkLg0KDQpSZWdhcmRzDQpSYXNobWkNCg==
