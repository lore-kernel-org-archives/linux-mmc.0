Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA5C4361B
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 11:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D8B238A0
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLQLh1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 06:37:27 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:1318 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgLQLhY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 06:37:24 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHBaGQ2017146;
        Thu, 17 Dec 2020 03:36:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=dmaKlNoZzFafU2HueoWbGoZbsvklx9bxjYBEP/SvSvQ=;
 b=kf7TXZ7EU4kMMake2Z2lldeJOukCB/S2pJLX2p+5Z5wI7g4iVgqjDkKV8u/sDrGY4u3j
 J19+/PbY7qEfnnS4nCNz3TTY/u1vzVs0oLWDP6RBVxVVFJ1ebo1VXDf/2WJpItXf1nZY
 oNtnkWRgyEwqsg6JyFeVFr189d/tQqotFL2SMJSz6/okpH1DapUSUYQvyrKT6JDINaTt
 iCRteyIeDimbiYE3R+llJUcu9BJBEaPKN5SOW+YNPD+smAYqwLCGW+U2fUnZ04GwDW+J
 Z5I6v0hvzLDEccHz6Ac/aFBXBaYF2W0qYLhEFNckmG1VhG6dKCyZJs965T6MBjHNr/uM Jg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35g4rp0a3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 03:36:37 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 03:36:36 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 03:36:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 17 Dec 2020 03:36:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbUTQBVW0PABz04zcShb+HoMZMkhX+ftSSoXA8xZUcX1X1W/crlktaIfYwhJyWquNXjc2PlEg5yO3qF1yjvR9Jl0sXlPfB+JtXrs5bwiimBlCCEutV3JvJPcLPDWIOiZZ8sfTNSHmcsRzp5Sq0O06rxkMOnkcqBM+bVPV4t87U21tS31E/9spErAyKgkksbPAcXO4z7xbEfH09NleXoyJpYBRhLDuh88wnHmWsuKDIv+pKGEc1jCKXh0L521jHmxACLGBbyZ+whaeumMF5ot0/1jYnVxTOsxN02X5vf4xzSQuY4pMeh7gzf/i31cPpirMUSPPFUUnJ9o1JWcMns2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmaKlNoZzFafU2HueoWbGoZbsvklx9bxjYBEP/SvSvQ=;
 b=XJjGNPYK++POPyLN+43CZbyM8KofCT2BYp6KTY1nh9X5kO7lHHPlXzIfCovnH4iBk6+z2ax2Gb/kpzzLKF3tLBNY2nOa8TjRAu6zfp2o7CB7A+RJu9Gv9lo6sXF1fRWzNM3tNT/BdixkrYukLGWvmPjoYraV0G82R/LSemSsIU+gYxnn6RDg0ZOzI+vvwHSp2tv2fPbjruWY0jwX6pKotY6yqvgYwrvXrYpbDOxTy3nKC1QTrppKHp0SzGWp6tBRT7sm00NoyR94swR1T0mryo/aPtWdpz/yji83C7xmrqQDt5ayorYr887FEBpLmbCGEkZpDbRZtR875QWi3Uc36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmaKlNoZzFafU2HueoWbGoZbsvklx9bxjYBEP/SvSvQ=;
 b=XP2T13w1jx6dPn5riDrxFdGnNgTFbwwzjv4+/VHXgq/y2O5PUUoH0X/w8UtXio4Mf0vTIrAY2J2ON5LrBiAI4z3jjwCmEK3J/9wG4AmczwMmR+wKrVgXGXaaSkLtGk561Hjvx2nUUAj0tCG1EBm9yLcAl6GztrcWs7CiRznv4sI=
Received: from BN6PR1801MB2068.namprd18.prod.outlook.com
 (2603:10b6:405:6b::11) by BN8PR18MB2578.namprd18.prod.outlook.com
 (2603:10b6:408:9b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 11:36:34 +0000
Received: from BN6PR1801MB2068.namprd18.prod.outlook.com
 ([fe80::61a6:8154:b0ca:399d]) by BN6PR1801MB2068.namprd18.prod.outlook.com
 ([fe80::61a6:8154:b0ca:399d%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 11:36:34 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHWzJBGAAft6IQ2BkOkVnoLREcZc6nxyUkAgAXb/lCAAHB2AIAACZ6ggAFrHgCAAALOcIAADKCAgAGYuEA=
Date:   Thu, 17 Dec 2020 11:36:34 +0000
Message-ID: <BN6PR1801MB2068B9F13F0E21BF726562E5DEC40@BN6PR1801MB2068.namprd18.prod.outlook.com>
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com>
 <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
 <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFoWh8Ms3hqgWwkQgx2a9PZa+GLcYhgXX68K0ZC5JJAzHw@mail.gmail.com>
In-Reply-To: <CAPDyKFoWh8Ms3hqgWwkQgx2a9PZa+GLcYhgXX68K0ZC5JJAzHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [27.59.203.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf7780c3-fd7e-4f52-46b5-08d8a28001c9
x-ms-traffictypediagnostic: BN8PR18MB2578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR18MB2578549CD90191406F4E7CE5DEC40@BN8PR18MB2578.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKex9P4PBtR3339eOH8zFWc/weVVe9GXodtKrLPM4FPTxLgowezafRP77hrxTlTmGWR5MW85SremKUyx3zSm9+chRzPQoHgwh2psDcpog7YZNsqAOXQGiTUfR1CTcZPJMInJHzjnK+CNU+US8alZiQ2N8tF2S/NSaJ7gyaGHvmX0Ao8gCJJvtcxw/l0uZdKwMQTdAB4aPdy/+DiGgDwR3a+M0QhXiFeXHhCCK+oQhi9KsBF1evmQfX7KI7U4+kCPNacUMjZFUTGCUrget7jcCBXB5h3w//7AfKSb6aIHhsAq+tLsD8b8KbD6MTFzjCRlsgD2VpppjjM30iUunTu9vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1801MB2068.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(186003)(55016002)(33656002)(478600001)(4326008)(66446008)(8936002)(8676002)(6506007)(26005)(5660300002)(7696005)(316002)(76116006)(71200400001)(64756008)(86362001)(4744005)(9686003)(54906003)(83380400001)(66476007)(66946007)(52536014)(2906002)(66556008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SnV4YjZBdW5WVm11RU9VMXNWS1RjUHU0emJ6ZWxrQ3ZaLzlxSXprdTBESmxW?=
 =?utf-8?B?Wmc3MndiVWRsZVZ5L0FuSkNGZGJRVnllb3J6N0kyVE1vYkZZMzVaNDk1TDNG?=
 =?utf-8?B?Z0Z3RkVndHNYRDNQS01lalZ2S1l1V1ZFQ29ibnRXV2FMWXFrNnFPNXB4ekh1?=
 =?utf-8?B?bFRRU3BNTkd3cWVGVndwYmUwL2M5VU5QMG5MRngybXBKTUpaZXAyZ01EV0pO?=
 =?utf-8?B?UHphNnB0SFhpQ0orVGJ2VWdDeGZ1ZzZ3bkUvT0V1Qi91SGpWYU5ERDFESHFp?=
 =?utf-8?B?K2YvWXh3dURuU0hHUE5hT2hxcVBCaXhBa1lmWk91TzdBQ05nOVhLTkJqYmsr?=
 =?utf-8?B?a0FtbkM3MGJkTXJWYkd0T0JxYUppY3YyUGpjekZ4YU5OWUZYQ2lKV3lQVVNl?=
 =?utf-8?B?STRsL2ppOXJLaDVhZDJzbCtsWC8zdjM5NmVqb1JoY0hKRVQ2dEF1Y21DalJa?=
 =?utf-8?B?UkdRY2psYTJ6T3RObjZQRmZnQTdCNm1TUk5jYWZ5ZDMxeTV6cWhEa2QrK01t?=
 =?utf-8?B?NlpVNGtFbzdkZHNleXd4ZHMxZEVHR1FxRTZUa3psNDlQNWNWM0l0WHJwbVRO?=
 =?utf-8?B?NnMyeHozMXAwRmVMNk5pQVZuSHhwVlpKODkwOXJQRVRIZXhXcjZPZDhnODBQ?=
 =?utf-8?B?aWhKaVZKQ2FUeUtSaDRxcHBzSlY2USt4QzhGR2pZR1Y5SkwzNTRxckpyMnha?=
 =?utf-8?B?MXBtbUdBRi9vaGIvS3VlZ0FsU0VGTnd3Q21PenA0QTNqYzFqWGZaQ0JKQlc5?=
 =?utf-8?B?NjF5cDV6YzhiZ1RMajJxSFNUeGJKbkl1UGJtY2JCZGNaR3I0NWxZMUJmci9u?=
 =?utf-8?B?TTB3OGtXT0pYQXY5THd3TWowUVkrTktiYVFTS2g5NlQyN0J2UXFuL3VKTHcw?=
 =?utf-8?B?NGc5dld1dUtNdkJ4aVBHMDEzeThNclRPc2M3eEVyUW5GMDlLM1pKdHlkNVJ3?=
 =?utf-8?B?VGxvaUFoOEMxQzJ2ZFF2YzRSQmdRLzBNTmZFdTY4SHo2T3BWMGZrU0N0TU12?=
 =?utf-8?B?a3pUOHVhYW1TRGp5cDVQWWpXb3Y4aW9jZVZHdnovNFVhcWxkSUpTdzB5aEFl?=
 =?utf-8?B?eXUxaVRXRTA3dlJjN1JuYmUxR21CWDk1RStmQ0FBejFDZ3dUY2R6MXRIS0VP?=
 =?utf-8?B?aXd1dERJMUtyUHVhYU9Lck4wWko2ekRMYnZlaWwzdVh5OE1qUk1LZUVaWWtk?=
 =?utf-8?B?a1liOUhMSU5hREU2Z3daVnE5WDBralc5RUVOSGw1TTR1NEdDUXNMS2hKTmVT?=
 =?utf-8?B?RWc2QkdoSjhnam45algxV3EvdEx5cVdRcEdnWTZlWmRzbVA5anBzZmZWejc4?=
 =?utf-8?Q?P1DjgbBWPTxaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1801MB2068.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7780c3-fd7e-4f52-46b5-08d8a28001c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 11:36:34.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cldU+UXm9prPHO0zdcCbIBwoF0PBnSgLo5MHyLruvQ2dxXnIqQxaNgqN8wgz8I4jFaj46BqmXNxTNfakaz7uSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2578
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_08:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQpbLi4uXQ0KDQo+PiA+PiBBbiBleHRyYSBjaGVjayBjYW4gYmUgYWRkZWQgdG8gc2VlIGlmIGhv
c3Qgd2FzIHJ1bnRpbWUgc3VzcGVuZGVkDQo+PiA+PiBhaGVhZCBvZiBwYW5pYyB3cml0ZSBhdHRl
bXB0Lg0KPj4gPg0KPj4gPldoYXQgaWYgdGhhdCBpcyB0aGUgY2FzZSwgc2hvdWxkIHdlIGp1c3Qg
cmV0dXJuIGFuIGVycm9yPw0KPj4gPg0KPj4gWWVzLg0KPj4NCj4+ID5Nb3Jlb3ZlciwgZXZlbiB0
aGUgZGV2aWNlIGJlbG9uZ2luZyB0byB0aGUgbW1jIGNhcmQgY2FuIGJlIHJ1bnRpbWUNCj4+ID5z
dXNwZW5kZWQgdG9vLiBTbyBpZiB0aGF0IGlzIHRoZSBjYXNlLCB3ZSBzaG91bGQgcmV0dXJuIGFu
IGVycm9yIHRvbz8NCj4+ID4NCj4+DQo+PiBZZXMsIHNhbWUgaGVyZS4NCj4+DQoNClBsZWFzZSBj
b21tZW50IGlmIHJldHVybmluZyBlcnJvciBpcyBzdWZmaWNpZW50IGhlcmUgb3INCmNhbiB0aGVy
ZSBiZSBhbiBhdHRlbXB0IHRvIHdha2UgdGhlIGRldmljZSB0aHJvdWdoIGVpdGhlciBvZiB0aGUg
YXRvbWljIGFjdGl2YXRpb24gY2FsbHM6DQpwbV9ydW50aW1lX2dldCgpLCAgcG1fcmVxdWVzdF9y
ZXN1bWUoKT8gDQoNCg0KVGhhbmtzLA0KQmhhc2thcmENCg0K
