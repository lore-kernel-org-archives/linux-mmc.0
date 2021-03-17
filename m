Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E9FC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B6864F72
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhCQL1V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Mar 2021 07:27:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22908 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhCQL1Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Mar 2021 07:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615980438; x=1647516438;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TYownkM5vZnTMK2pj8LnR71o1HVaegOWvvuP2vi5Shk=;
  b=kts+3+S4Zd/Xi+rMoT8zuOfcXtDVSnBCA7+fKlQ/J4S1qY7O0RBJvDgY
   qarL9C9Ccgi/hZYP9o7iWuyjdPcgEgak1SEtU9MND+9kjhCn2z2TWOnga
   XHWBfKyTxU/bu3uLdANv/t+wlJyKaF/w5wHjHkVmvfw8ja7Nq2IAdix0C
   Cdnh7GCG1SJVVr0OJkB1p3qYj939MQz/nHTLFmx7j4aNX9xU1n5H2SwZr
   66LlkM6l0aF74vHKMDyae/4f8FbkHknxRnxR6hCo6cl+TH5Bk2BHqYeql
   Cahy9KnoxO437XIi4nEHBAjAx+VGV68NYiiB8LhjNdEhzeTZoRkWvj20M
   w==;
IronPort-SDR: EbS6JJ0ev2+DifeV4vHaqctNTfdm+2fxzhzzEU9LdUFwCVF7nRqvAQQXNefehvDSo/dGE5/6su
 6Q3oKjzV4IWnpMOny8MhSxCNqZL0Rr8uSttw0CMKYZo+yhNgucbry14YDfkZkms43QfWTD5NxM
 mUlCAj9ZEfLtJ2AhYukanF+/JFp5uNNBb9u+mD+N+2a8x+XKJ9HjklzqYx3mYDFiipNZjF2hYS
 oT5GnKnLFQuIxd5GSGzO7ZOaK+BCGZi7W/pv3gH585gkrEdX+DzvT4Z45+SFbvECrs29zcUQct
 M4s=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="266749713"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 19:27:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+yLGqQplQYG2yfbR+7dv6dUQDpopcwEUk8cY9hB/nkarRf7RiitXKbe8+GQYFP2s7x6Xtp3kYFTeedyRFqVim9SCTvcHh8a74ntehquuoWv6INclprC7HsQ2LsS/qLCammwgjXxxVV2XjmKv2FCo0TyS5CHl9mmB20d2FBZUf1MAtKV+ZBcrT6778PZU6X17SsW9eOfi+qnPr+wVxz3MyF54poS6jyqMtjnN6D6d35824cI02YpZbHegA2XqG4oqTTbS8c/m7Tvo+6ARTa+aPZW2nfWvoU9OHBu7r3JzvVz+yrMMA9CylxaxC+VROMNXKOy2cl/7m66lBQ0p9jNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYownkM5vZnTMK2pj8LnR71o1HVaegOWvvuP2vi5Shk=;
 b=dl4+vOM7rtQ8hkZqNBtUFHycbdbn1EpZnOjBc+Rr0V66QgsVnuBYh9+b4vlLEc6gvVhcdCmXfN+ndCJ6wdxS0BcAuQWU8wXF/ycr7W9IXCqIM8UBuvuIOmvZj0XM9yUdFGr4Y3qy/bzN9ad0q35paEnP4fxawTxZzU7qFch9IQftpK7bmFA/Hs6r7kAfLR8p1vDuV+Z+JJ/7SGFuf7Xw4a2TqMOQzpx9Zkn7944kNiLFizNbx9pu6c3o+ddWzoFN8Ml8B1pTJBSMMv+jCdEzH/gdpGzeM3yTqpu6xHokw5WmtuopChpUB+MkRO8KR3Rp6X/6KPhBa6rzIcEaE/qqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYownkM5vZnTMK2pj8LnR71o1HVaegOWvvuP2vi5Shk=;
 b=J3gBrQtf89/XG9rvLkaSkauv1WXvgTWlTBxAWgW3TEkrCk+zc0TxvUawupWidJCf36N/rvuO8Eoh0kpLAbB2XR6t/3J97j85bnhdPVEkQJnIoBinyjoB0l2VHnlxQGw/B/vY+PN55v0CZdfLiTpguIoP+/yhwOMc15m+NwDKCBM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5020.namprd04.prod.outlook.com (2603:10b6:5:13::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Wed, 17 Mar 2021 11:27:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 11:27:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH RESEND V4] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Topic: [PATCH RESEND V4] mmc-utils: let FFU mode use CMD23 and CMD25
Thread-Index: AdcbGibuMOh4v7r0RO6jCsoOYUQWEAABi5Hg
Date:   Wed, 17 Mar 2021 11:27:11 +0000
Message-ID: <DM6PR04MB657581DC8163F06128E561BAFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <MN2PR08MB63973BF8F3C6959487BF5707B86A9@MN2PR08MB6397.namprd08.prod.outlook.com>
In-Reply-To: <MN2PR08MB63973BF8F3C6959487BF5707B86A9@MN2PR08MB6397.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: micron.com; dkim=none (message not signed)
 header.d=none;micron.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0a6c436-24cc-4f25-de67-08d8e9379b95
x-ms-traffictypediagnostic: DM6PR04MB5020:
x-microsoft-antispam-prvs: <DM6PR04MB5020DE03817572D7D9B06144FC6A9@DM6PR04MB5020.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+n/eYRMwK4zy8GVE+uovnZvPTqiB+krEbfln9TfBmlNkGxRTyfq5TvLcTloYintJO24fNfOa9fP9txxMB29JrLJU276zJFEKhRM+cyW1NpjzZRwZXK4ItCMaxALCuMuR5ZZF/zLpqY8XkYYT+iXoPx/Ihxp1hbrMCcSoQ/8mP4+tKKnP6Z03Y4bUT6aiP+RH3gwqqUvKbXxb5xlT+e8vbgze2ZkOXm75OPn9gCRELkR+P2CTqCxCkt6z3W+yXGesaLIDGAZljCmcntebEy5wGszWASs7gPFw5/4QYqSC1dxOnkM+j6Utr4OgPNQwvcUQdedG52mYb8c6bw0B7cgzYn0b2EgVktbFyydPvXGzjAql5nUqRReE1pp4CVrIDayiWaEsKy4UrFQZfNfWT1HiqBm7fHh/LYmxHcz3ANp3RwPZGZniomm+S/n9qZJatVu+RMYcCC4MvikAUwpXcNE5KIVWOxxO+ELzlZNvw54hsfs9BfWlYtDyEL8CIrGPSB+2wCMUIv9BPiijgDyXqlhCWlf6KfpPcQ2dI4dqxl4gIO8rLj/eR0roNROSZ7iQX42
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(186003)(9686003)(26005)(55016002)(8936002)(8676002)(4744005)(478600001)(66946007)(76116006)(66476007)(316002)(6506007)(5660300002)(52536014)(7696005)(110136005)(83380400001)(2906002)(71200400001)(86362001)(64756008)(66446008)(66556008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uEdU3V92gtHpIO+Kz9ObnzRyb5rb8CLf49Xr2evp2cX39teW33awJe8P9Djk?=
 =?us-ascii?Q?XltYd4C+f63f0IQzbBsp28YktfkjuRWyvHWcfO8yGlCRnPzHJ9vCBca97lyO?=
 =?us-ascii?Q?MwBald+/UmlKB9ZSMcQ1j29mkg8Uw9LOcXIqnkBuoOwu2O5/7IMyRlx4Ncck?=
 =?us-ascii?Q?w2flwKe3w0G3mFvWHPFraYPNH+vaBEIwfnrB3XbqtL4cHrHbxzF2BCj1np5z?=
 =?us-ascii?Q?FizVxm0ftMHzp98605wrkpMq37/lo3xIWKEO+XB9K5j1HZOzFVfsNql4Mzjn?=
 =?us-ascii?Q?3bVanX9tEpswcbhrU9lBHxTNhY0N0LRRA5cr0skvmVxbY3K+dw1cKc02HBkd?=
 =?us-ascii?Q?7guk8MORFbm3IKXKd69ws/fNLL+/gn+hb7dqyEia4OQ2rVc83DRLrr9LvTuw?=
 =?us-ascii?Q?qynHgs9o/VcnkZAWPyKuEzHREO+lX/uHf/EamwXVG7i1VnlfddArd5KkQkox?=
 =?us-ascii?Q?yH2spFGLv9UU87Fiwx+idC2XRhQVKMTl85sfkNtaDRCFZOFA1K6xlkfQBELG?=
 =?us-ascii?Q?BcoSBsXkh39fFjJvRHxjLILk4XtGXdagvrHDI/d8EfAPLZtfAptfheXnZL6H?=
 =?us-ascii?Q?5vSLVRoHd7a33vDtYvw/DNV6bhY4Spnq7wtZax+JFr4qFlWLU6LBOF8op7iT?=
 =?us-ascii?Q?E7T1uonb2uE8F7f06CXYc0l6C62IWuE5kVEpgalZLqmOnnruO80SGRsuExtj?=
 =?us-ascii?Q?Wey+Z3c/M4n7Me7X67iaHMQfwk82wGvIwWpr4OraGCEgK65KjGgiMKndpqUG?=
 =?us-ascii?Q?S0Q0jby7AYq/LbR1/0JeUR0NXAxCQfNiSrI+H5reA9boChHNkE95LaDOKahE?=
 =?us-ascii?Q?7sJbDuDe8p6fID5zJB/Z7BYAXjnSX4ECNLjqLLTp/o4KKUFHsFmEmPTJF9Gi?=
 =?us-ascii?Q?1jx1wZuozw5O1Klxo6wn93bX9L7TKPyu/1ynYFTaRvJKuipDP6ONTgMc9R8U?=
 =?us-ascii?Q?nJ16lKZ12dAINx8yXz+DQnD4tw+0/tvCZVEwx35vs+ARzwnUluw3JKN9ExMY?=
 =?us-ascii?Q?AVMhloqpa/9JBKeLy3dd2tmjHKA4JBBjkoN41SzwbqJf7T1AxJtkd+jhkJVe?=
 =?us-ascii?Q?iQxkfenhfqx+n7q7le8vYJdqX8N2NJheVLtzyxKDmSZV/fx+0bU9Cg7pXH1B?=
 =?us-ascii?Q?dTpj2ZKktoqHZwtKnfW6nEcBab2wbh6Ev7SAd6vTue3ZqDPWg9SJEFnMJdyk?=
 =?us-ascii?Q?JKZUtbFa540U/qNdsdVNe1+VneHPkjgjv8+0w77Si6YuDj7uqCmiQZOP/NpX?=
 =?us-ascii?Q?suakg+QMTX4ZJdD3sr2MipAYFpyP9yOYfWva69vgIiwzpPyHRL+hio/lJHwj?=
 =?us-ascii?Q?t/HBSwUcTttYJSXYHxhRvdVc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a6c436-24cc-4f25-de67-08d8e9379b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 11:27:11.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkGGv9uNxrefhyshZHf016TZ6EJiEapptMYMjZDOiDtw39lszu3S5zoAOKIprKt7hs7YqsHok0fEkzP/84N/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5020
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> As per specification, the host can use either CMD24 or CMD25 in
> closed-ended or open-ended way.
> CMD25 is better option as it can flash the firmware image in one go.
>=20
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Tested-by: Bean Huo <beanhuo@micron.com>

Ulf hi,
This patch looks good to me.
Will you consider picking it up?

Thanks,
Avri
