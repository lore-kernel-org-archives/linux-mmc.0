Return-Path: <SRS0=WFPw=3U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B040C35240
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Jan 2020 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5684524681
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Jan 2020 06:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q15FgP7c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M2Py11Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgAaGRT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:17:19 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16052 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgAaGRT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Jan 2020 01:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580451439; x=1611987439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iMVwOU6rxlhl8Qey25l5l57S80KNWd1CplCXq7ZvgOg=;
  b=Q15FgP7caDpLKbDXW2PNWX8mgxNNmBVLNEWQ3WJyEZV4Id9RphJYvTtB
   OFZdqVo0eC5xeTE0CV9OkPb4xyy7Hziy4FHnVoKaLpliFwNfzKB7ZPMad
   Q66znD0LOY8/mcx/PMZQdspo/G+qgE1vmBc21aJ88Xyb5qowpWZax814k
   hhy8CkD4LYe3ICw0/FcgjZQUgtREoUk/1XGMpuldaQKtyKcgt2U+NeYrA
   0URRDz+e7eBBh1/d1LUyMvsMS7AcNYvbNjAfEkoRJnX4zkWERlHJ2ezdx
   jqQmdjfHOrhxCNE3Kp6otEjcVVviobVd3fIkRwoZoHvbhpA3rkz8gOjsI
   w==;
IronPort-SDR: mo4hvpYV2aKr2QEX6/NQshSFTf3hXHaHrbOLBdMFRFDKv8eBhRny63rfJoqVcJGLia9aXq5gGE
 57cpyQJmJwnUVczTqnTa6csP7JgzLR5loikUcWI7Ws4DoiFZf6wtIXmEu39AgR65kqyWpU7gJb
 NCfzf5fGyqoA8rpwgK9FeCYRo2kqQhS1lgrVgckkUTa6qMCXLBYPJyxVymnDiz9zSLfM0F+4Jj
 68qoLY4q6SlPMamFFDz7Q+aJVcnwVlikTpdR5FyDpyrloY5+07wlwKiZDqoqR6e5w69Sa1gZSA
 R18=
X-IronPort-AV: E=Sophos;i="5.70,384,1574092800"; 
   d="scan'208";a="133165491"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 14:17:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM7kXRQiWusgTRBaxYbCJtHeTIKJAYmh0ovYtLhLL0WmhqQE6UoufExjUHK3CdUpDSROmppir/Cf3gI7yhEY7hWuFbMJuq/QOEPHHBBvQ5xCKiPNyo+M9grbReH2o++vpdFm89f1Edbs4Zpxa3/6WrcBVSvShW1jJgfQfuwnjK5MMD15gZxgjl/T9b8bvgpvR6J5Q0BsQpbJwPJGOADPyZZkMsbq2m5OfrTTdntMs3zaIojxg04+t6DTa5NazuoMYjB0lUjDMY1ECwOp3Jcnf8COivNu463uGuJftZRAeyEAaCMS3K/E74ee7+3jDAumKGr7WkHfaZan78H7iOd4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMVwOU6rxlhl8Qey25l5l57S80KNWd1CplCXq7ZvgOg=;
 b=MNmlwp+lYeO3b4MQJdnQGmvgJc8WWhaCHcmC2UE0Owl2MAM4Qxc2oQAASXAgDfARxNL+oxmcBq/ak1ZyjNAwuCj+DgzqWIwkeQaxY5nKGNGzp8IWCbaFt+SNuF+y2f5Dwfxc/xz3GDQgD9OOiqn8t9lySXonpoVwrO/taCH/Ijr5vI5FaRjKgQe5mDYGWT3AyxpfSd9UkKfyczMOkBa4blOmpyKnrghKXjjsoE6fvsPilDFhWQ07lMU26ToxXdBMtu2cJFcCcd/t+hItMO6EzRFYyHqoVhv6R7b16DrLb4fKQ7wIMJrp2ntimp/nHoiMycYo8rYh1EGyCts4H7oT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMVwOU6rxlhl8Qey25l5l57S80KNWd1CplCXq7ZvgOg=;
 b=M2Py11Qjy9usSQm5LF+wU284/8Yn/6qbSk/9i7oNLRdWLOQKuhcyfCr/RQf2OWv+35Ew2eABaW4a7PlGSatjnOO9nOXx7VspFU7rgYWoKjGbljLGPEnQB2+rB2X0fEhVylS1ziWP9P286vRx72kfI97ll8oQ1Rbq9qzlR1TAjAM=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6191.namprd04.prod.outlook.com (20.178.247.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 31 Jan 2020 06:17:15 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::b870:3f25:f3be:535d]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::b870:3f25:f3be:535d%2]) with mapi id 15.20.2686.025; Fri, 31 Jan 2020
 06:17:15 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ming Lei <ming.lei@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zachary Hays <zhays@lexmark.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: make ext_csd dump more human-readable
Thread-Topic: [PATCH] mmc: make ext_csd dump more human-readable
Thread-Index: AQHV1+WMPSsumNr9xEmViuzQnDU+zqgESTDg
Date:   Fri, 31 Jan 2020 06:17:15 +0000
Message-ID: <MN2PR04MB69915F78978B8C979FBC7462FC070@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20200131032008.21354-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200131032008.21354-1-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [77.137.86.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebaea28a-e78d-40c0-36dc-08d7a61537c5
x-ms-traffictypediagnostic: MN2PR04MB6191:
x-microsoft-antispam-prvs: <MN2PR04MB61919791EA3D97F61DFF42CCFC070@MN2PR04MB6191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(199004)(189003)(316002)(110136005)(54906003)(478600001)(6506007)(66476007)(4744005)(76116006)(64756008)(66556008)(81156014)(71200400001)(8676002)(66446008)(55016002)(66946007)(9686003)(81166006)(8936002)(2906002)(4326008)(7416002)(86362001)(52536014)(7696005)(33656002)(26005)(5660300002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6191;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUz7bli0csUmvQVf6oeLaFB/qdYieV3cWY0h8hm6Wc7KYH9r8LLsC6WVqJHDGFBBlsyLOCATVk7+p/Dja668HNU/NMbA657gmFIliqyBhP6GLPq99Cu1ZnlDq8/abt6gnfFitK8ctRt5VdiuE/M6J3DrIIfSpyFW2Q5XMqEngEzKepvrqK5c1oo2h1GwEoi+CodCdoMYFjlUN6q/hkXbq59QmQ9L9mNWV0hAQ08uqaJ9co+4U2tJEOVktphupNgm3VpUi5Sl8QMlTaGmZYtb537GmSoduSac/H0xYS+Q4CFYJM1o6GiDZYGMSEriN8TOk/62KaJbuvIREE/qyxCwTCuUaOd1zZ9m0Jx9Pv9TPRxHpdJT83Q2HGtq9OSa9vz0PaIYuMbIEqWnsS8gPkXn4soGIzt9AS5j6OssdIAz1HAJ4A5isygz0PC+U57JynQH
x-ms-exchange-antispam-messagedata: x/0GSxCuArDtNi0XjdBhic0Xf99RAR4MywUCAm7lL7i0Ib6LeZ+bGgKFu38yKO517CzxnhHR2Imwgd1OGyhbTYQeInOBUbPkKL+HHpiiWRnkI/VN1E8Gv4ukDxTZmCfk9C0f+BY8kj2Nw3m2E96pLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaea28a-e78d-40c0-36dc-08d7a61537c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 06:17:15.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VVnrlQk+F6rB1ONROhbe5v1gLYnAX85IlvZdLP8nStCWuA+2MJ72QK7EeyZDarfxHcjiV7CwpFEQZrKKIlwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6191
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

>=20
>=20
> The current ext_csd in the debugfs shows 1024 chars in one line, which is
> unreadable at least for humans (but perhaps it could be handier if somebo=
dy
> is processing it by a tool).

I fail to see how re-arranging the bytes makes it more human-readable.
Plus you have mmc-utils parsing it for you.

Thanks,
Avri=20
