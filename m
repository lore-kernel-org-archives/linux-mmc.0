Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77CC4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jul 2021 05:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D31760F48
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jul 2021 05:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhG3FkW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:40:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:44901 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233424AbhG3FkW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jul 2021 01:40:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="193313664"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="193313664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 22:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="476848065"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2021 22:40:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 29 Jul 2021 22:40:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 29 Jul 2021 22:40:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 29 Jul 2021 22:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnglyxkHT53BCAuD89KbkN0UcoKs1WNuh1KQDPvDYmgx6xYpStZVjW+bJ3viL3mhfOq0oQAZMxLrQA1Db9Hk6ojtdQFAYRtnbmhEHejQh0VVoaqAN7GOkgluX+ySWbveJoWLM0OWj0ZoBptLCGfWqmxAAe2dLazkPlevYJeFVO22qksUDIhnRIMzK5e7uq/gZ+qyux5bt2DtgZLQidoczAiHgVaPbYiY9GpkXyFsT6bjbmTp1iJvwWP5l0PT8CjB4OtKo2eQc3FbgQ7+v3LTkH69flPgqVKgLJ/F38Xh9KxGT1PkkP14KZuZtfnfM0fUytrOZpgPH3gtzcQ9wA/ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE1lQ/BHZQMzclRlyVsoywgzqLsT1Nosc7z4vDKhjMw=;
 b=UqkPmY7tdf9iu1Usxi6u2nJB0Bx67a1g6WN413bh02Y1ckyQf8r87cJMAJu+o1tLSqp9cPQBEqe6HdtQjgL9dRh1D47fQiq8jgDhQPSUhQlycoHlXxNbyU8eopTCJyOcWIJXJWnQs2qSfX38FkWOUxc5IibXEItkXEdWw6JzWeKnrtjGfMYFWLqdb2l/L3L/dG17mMG9psKDim4Vpy6y39al5MyNQUL7YXH4QHJEtMK6Q0p/nRWSrDD0ICPGJLJp5H+sp34b6OULtkiKsAN357tr7gQui4JAhzls7eO+3vCxok2RCIBfc+EVTBLuTaAYXL+5Ep5APynLFdMgQsXAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE1lQ/BHZQMzclRlyVsoywgzqLsT1Nosc7z4vDKhjMw=;
 b=p26t0ljxp22GH01XjMaq5JG9rOqwfsZof3fwURPu9O0Y39xGVRRzzWLTL20dBvSyfE5CFg/NrOWRNNOBSUaRWiCaro0uIg1rSOAMoTH/WaFfyIv7K6sBOUa9RGepXCHTiSU/nusiRyu3XA/NBAziC2zQVBUqv8Sy2zC5vOifVbM=
Received: from MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13)
 by MWHPR11MB1422.namprd11.prod.outlook.com (2603:10b6:300:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 05:40:13 +0000
Received: from MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3]) by MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3%7]) with mapi id 15.20.4373.022; Fri, 30 Jul 2021
 05:40:13 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     "linux-drivers-review-request@eclists.intel.com" 
        <linux-drivers-review-request@eclists.intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: =?utf-8?B?UkU6R0VOVExFIFJFTUlOREVSOiAgW+KAnFBBVENI4oCdIDAvM10gQWRkIHN1?=
 =?utf-8?Q?pport_for_eMMC_PHY_on_Intel_Thunder_Bay?=
Thread-Topic: =?utf-8?B?R0VOVExFIFJFTUlOREVSOiAgW+KAnFBBVENI4oCdIDAvM10gQWRkIHN1cHBv?=
 =?utf-8?Q?rt_for_eMMC_PHY_on_Intel_Thunder_Bay?=
Thread-Index: AdeFBQImTV5mCCSVQ/OIdZntC8DKUg==
Date:   Fri, 30 Jul 2021 05:40:13 +0000
Message-ID: <MWHPR11MB17896798B8037C835FD98D7D8CEC9@MWHPR11MB1789.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: eclists.intel.com; dkim=none (message not signed)
 header.d=none;eclists.intel.com; dmarc=none action=none
 header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d431c225-14e2-471b-d3c9-08d9531c80f2
x-ms-traffictypediagnostic: MWHPR11MB1422:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1422C0B09FA5018FF29762938CEC9@MWHPR11MB1422.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0idiw+vi/LyxmO0d4HuU3hP6Lnx3JDg7ZF2pPpxUvftD/g2DqOSAJCPd8VapXVn/NjDgADEstfSoa9FjMq68qtCmcWOavKFNnut3t5NTpVMbbL8PUkulKfs3MZ6Wv68PDU7LwXgCJIr1sD3gxU0c8JkaMOlPYC4A+JkugTvfY96M3TQe8QEg2EYK+SWwyNgfgi07kKY+v6p9mzq9BJ3Zf0RfeqxyWozNWosfKE/5yg6Y5913fUbwtyt73nY+9cFPkt47OlpfDtyL8NZuuEPk2G+JZ12WMXVyDsCSd+Ci40iWcCPYwhiKwPu7AWyYe1ffN0P2KbC9iRhHIdCfmDR44V7uNxjPJ+FQ9Zm2PPILRuDPeqjY2mZ04CN/1blVyVqxAJo+6ChRP/fSIwvZT/t/vO/szkUVzy6SEbgnwABnkR66KuRHFVm01sUqAEH9dGJO/I1Fl/4v5raJPuQJ/EXUBM1LtKC0S21rUwYRFghWdc3G6uEpkFI+PaLnn+153Y3js8stKNuHnxCD/Xqh96iu7rwGFmLj3EJXYKpC+jnqi6eVIn08JdnCFS8pVvK+Z5daDvJwZJbYGj7uWbVTpS/OxvaBUiAkPzPeCqXs1+DbWToN1LTdkGez51JREkvp5CATPPzQLo88ONbibetiM0+EIOyE6ldi7N3XPobe1Ja6rPqVCNhHsDEafXYHDOXxksH+bZYctv+aPJzRO8uw/TsvBDgZbCiLO/fd5SzsEMpqQW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(122000001)(921005)(8936002)(26005)(186003)(52536014)(38070700005)(316002)(9686003)(76116006)(66946007)(83380400001)(6506007)(2906002)(33656002)(110136005)(53546011)(38100700002)(54906003)(4326008)(71200400001)(55236004)(478600001)(7696005)(66446008)(7416002)(64756008)(66556008)(55016002)(66476007)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnlFL3JDZk1tTEtkbHZLdzFzc0VxeU1RZ291cFZBOElaVGVsSUFOWkRyM2ls?=
 =?utf-8?B?Vy8vb05YajhmOW5wZGhhcnd2QWJzVGtkZlg4aWVBVFFWVnFUaGdBNFBBUCtG?=
 =?utf-8?B?V2oyaDlacGk5NDluTENTU3VxQ1Vub3piR1JQam1QcGxLbkZLYUYxV3JzMFBJ?=
 =?utf-8?B?TkRObndMTXpmRldtYzRlcVdnVFZ3N3FZZ0xyYVBuVzg5blRkZWlTU2s4TlJk?=
 =?utf-8?B?ZFpkM29nYWllbEtBSFRUYXMvbDllUEpHTHV4NUZhYmxOeEpoRjJ0cU1EMEd4?=
 =?utf-8?B?UXltZ2diVjJPVVRYZEpwV3pyOFlibkFNR1ZHdzViZ1V0MDBDR3BSNVBjSlov?=
 =?utf-8?B?dDI5ZXlyT3E4N3ZwTExJSXlxTnZFMnoreGJVRWtOSWNwRTdzSG12eUN4UFZR?=
 =?utf-8?B?Wm9JMmk5cFE1UWRvazh4WGlyWTF2cWRpa0NrTmlrY0pEMnZQNURudlgyOVlh?=
 =?utf-8?B?aTAzK25xSGpWbmdsMXJIZXo0QytDWmIvaTdoUnlCbmxSMks4SWN6RVcwbWIr?=
 =?utf-8?B?d2Q2MHN0Z1RJdFJJa3FSR1VoRTY3YVZHWkFWMjN0RnFLQUZWTzV5Qk9iZnAr?=
 =?utf-8?B?UDlQREFsR1V2bDE4ZFZhVjRPdEU3MmdmY0FETG84UExiYi9WTzV1MjhCam1Z?=
 =?utf-8?B?Rm5ZSFlCVjBYMjVtcDJSMTRXSEh1czV0cDRkcE9jK1FCbHBzTlB3a0srUVJF?=
 =?utf-8?B?R1g4M3o3V0U4TTB6YTlhVXNncEJ6MDltcG9uVCtWZzBlMnM2VEY0eHM0cmpK?=
 =?utf-8?B?Z0hVYm1tZ1dwZnpKMURmUE9uQS95M2JoSG1GYTJEUWhXa3RlOVY3QnY4RWNz?=
 =?utf-8?B?NElmTWNpQUM0QWxEVE0rNVB5SVg1NCtzWU1iaVc0MHNDZVYvdXJ6T1Mzd25L?=
 =?utf-8?B?MmFJV1hWNHpzSnZuUGc4bFVtVldMNW5hUkxIR2h4WGJwMzVMaW1sWTVJV2VO?=
 =?utf-8?B?c0x4L1d2b0ZxY292c0JFNitpSmMzSmNRWThwai9seVFLbE1mN0Vnc3dyTUly?=
 =?utf-8?B?RVFhT2M2dFpYYlp2TFUyWTNMNExYUHM1TFFlWEFOZzVJYm1oMHQ0b250bFRw?=
 =?utf-8?B?czcyVzZUaHc3UDVzVWkzaGJ2T2srZ3EyYk5FeDlkUlY0WExydFZkd0tDVy92?=
 =?utf-8?B?MGdUVjhSK0JheWdyNjFqSnVFN2JyWWxJaGlhcGViOXhzNk1zalY3U0dTdlZa?=
 =?utf-8?B?S0ZCcDdGSVVMc2RRaGNRU2Q5TkVNcDVZdFRWWkVkYW90MDdOYmNWd2JHT0Nt?=
 =?utf-8?B?cHhGSnZla0kvR0xxZzUrOHVZQmdxdy9rbW1vL29lM00ycisvQlA1Q29sZkwy?=
 =?utf-8?B?NTlLbHYwRmNGT1JtK1lpWDZDb2R2UFNzc0VxQjVTcDNSemR6SUN5dEQ4SGNC?=
 =?utf-8?B?R1FMMG9FcTdzU2k5MmVMbkhBR2wrb1pNaEdMMFFzMHBIRGRKVk5NS0N1RGRY?=
 =?utf-8?B?a0hjQlAwUkd5SmZwazVxeE9SZ0o4NlJnOVluL1N2SkNXNzFkeUNIMys3Z3kv?=
 =?utf-8?B?eTRaVlFtL09hdjdMQW1ZMXVwVGVMQzBnN3E3QU5qOGxDU0dYdjEyM1c4YkU0?=
 =?utf-8?B?T21UV0lUaTVvRnRIUlpZTGdvR0hUOGx1OEE4ZVM1Q0dQWkhEYitGdGVKLzVs?=
 =?utf-8?B?Z09hYzVGdjJwODg5M0ExZ0pnSTZjY2x2bHo0S0NCR3poTWhsL0M0Zkc0S3dJ?=
 =?utf-8?B?VkRub1NhUDZoTFBHRGVwVDNEcXhvUFEvQkVhelNhK2FhUldCbVBScmJaY2ZY?=
 =?utf-8?Q?r+cyKTFQ5WMLFctG+HmW5S8YLDjvOC4LIM4Atso?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d431c225-14e2-471b-d3c9-08d9531c80f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 05:40:13.6093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDCeoFerp/x+QYK15kFTRQnaIBl7dpLGxu9wD48mcLcyyMerQ16BmmGHl3LNd48Q6q0flbY+j/OgTqR/vbMCIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1422
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgYWxsLA0KCVBsZWFzZSBoZWxwIHRvIHJldmlldyB0aGUgcGF0Y2ggc2V0OiBBZGQgc3VwcG9y
dCBmb3IgZU1NQyBQSFkgb24gSW50ZWwgVGh1bmRlciBCYXkNCg0KUmVnYXJkcw0KUmFzaG1pDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBLCBSYXNobWkgPHJhc2htaS5hQGlu
dGVsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBKdWx5IDIwLCAyMDIxIDU6MTIgUE0NClRvOiBsaW51
eC1kcml2ZXJzLXJldmlldy1yZXF1ZXN0QGVjbGlzdHMuaW50ZWwuY29tOyBtaWNoYWwuc2ltZWtA
eGlsaW54LmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBraXNob25AdGkuY29tOyB2a291bEBrZXJuZWwub3JnOyBhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3Jn
DQpDYzogbWdyb3NzQGxpbnV4LmludGVsLmNvbTsga3Jpcy5wYW5AbGludXguaW50ZWwuY29tOyBa
aG91LCBGdXJvbmcgPGZ1cm9uZy56aG91QGludGVsLmNvbT47IFNhbmdhbm5hdmFyLCBNYWxsaWth
cmp1bmFwcGEgPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+OyBIdW50ZXIs
IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBWYWlkeWEsIE1haGVzaCBSIDxtYWhl
c2guci52YWlkeWFAaW50ZWwuY29tPjsgU3Jpa2FuZGFuLCBOYW5kaGluaSA8bmFuZGhpbmkuc3Jp
a2FuZGFuQGludGVsLmNvbT47IERlbWFra2FuYXZhciwgS2VuY2hhcHBhIDxrZW5jaGFwcGEuZGVt
YWtrYW5hdmFyQGludGVsLmNvbT47IEEsIFJhc2htaSA8cmFzaG1pLmFAaW50ZWwuY29tPg0KU3Vi
amVjdDogW+KAnFBBVENI4oCdIDAvM10gQWRkIHN1cHBvcnQgZm9yIGVNTUMgUEhZIG9uIEludGVs
IFRodW5kZXIgQmF5DQoNCkZyb206IFJhc2htaSBBIDxyYXNobWkuYUBpbnRlbC5jb20+DQoNClRo
aXMgcGF0Y2ggc2V0IGVuYWJsZXMgdGhlIHN1cHBvcnQgZm9yIGVNTUMgUEhZIG9uIHRoZSBJbnRl
bCBUaHVuZGVyIEJheSBTb0MuDQoNClBhdGNoIDEgSG9sZHMgdGhlIHJlbGV2YW50IERldmljZSBU
cmVlIGJpbmRpbmdzIGRvY3VtZW50YXRpb24NCiAgICAgICAgYW5kIGxpc3RpbmdzIG9mIG5ldyBm
aWxlcyBpbiBNQUlOVEFJTkVSUyBmaWxlIFBhdGNoIDIgQWRkcyBzdXBwb3J0IGZvciBlTU1DIElu
dGVsIFRodW5kZXIgQmF5IFBhdGNoIDMgQWRkcyBUaHVuZGVyIEJheSBlTU1DIFBIWSBzdXBwb3J0
DQoNClRoZSByZXZpZXcgY29tbWVudHMgZnJvbSBBZHJpYW4gSHVudGVyLCBLcmlzIFBhbiwgRnVy
b25nIFpob3UgYW5kIE1hcmsgR3Jvc3MgaGF2ZSBiZWVuIGluY29ycG9yYXRlZC4NCg0KUGxlYXNl
IGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2ggc2V0DQoNClRoYW5rcw0KDQpSYXNobWkgQSAoMyk6
DQogIGR0LWJpbmRpbmdzOiBwaHk6IGludGVsOiBBZGQgVGh1bmRlciBCYXkgZU1NQyBQSFkgYmlu
ZGluZ3MNCiAgbW1jOiBzZGhjaS1vZi1hcmFzYW46IEFkZCBpbnRlbCBUaHVuZGVyIEJheSBTT0Mg
c3VwcG9ydCB0byB0aGUgYXJhc2FuDQogICAgZU1NQyBkcml2ZXINCiAgcGh5OiBpbnRlbDogQWRk
IFRodW5kZXIgQmF5IGVNTUMgUEhZIHN1cHBvcnQNCg0KIC4uLi9waHkvaW50ZWwscGh5LXRodW5k
ZXJiYXktZW1tYy55YW1sICAgICAgICB8ICA0OSArKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1v
Zi1hcmFzYW4uYyAgICAgICAgICAgIHwgIDI5ICstDQogZHJpdmVycy9waHkvaW50ZWwvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsNCiBkcml2ZXJzL3BoeS9pbnRlbC9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvcGh5L2ludGVsL3BoeS1pbnRl
bC10aHVuZGVyYmF5LWVtbWMuYyB8IDUwMCArKysrKysrKysrKysrKysrKysNCiA2IGZpbGVzIGNo
YW5nZWQsIDU5NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9pbnRlbCxwaHktdGh1bmRl
cmJheS1lbW1jLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvaW50ZWwvcGh5
LWludGVsLXRodW5kZXJiYXktZW1tYy5jDQoNCi0tDQoyLjE3LjENCg0K
