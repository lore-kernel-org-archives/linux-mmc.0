Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD6AC433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CD86100A
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhDSMrB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:47:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17612 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhDSMrA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Apr 2021 08:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618836410; x=1650372410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E5v4fYfZDJ2W73UpgFgKR7hPu3xCAXx4qEKgBz5CGqs=;
  b=roS1R+1Fg0MszyHToVGlD7M/r0h/Q4XGDxi6r92s0aWm6Wne+8wcuDEv
   e4TDZtrJqRwabMt2FFVslEdaxDeDnsJsrmyKuIAQrIpBBypJFL2kr8v2I
   9Mu1mG8Age6OxsdSARKjFtuTFIt2Ply3ruhHCyVmYmFnnsJ921lecaCzj
   FIBa3kdb/XAiAcvYncyPnMoL1LHELsjWpzf3ry521q1a0TE372R+qw9J8
   oI1gKXDZb8HHyqEEIRf+d/f5YbhakYISd206je5bnNLZeheZvRZeHbzfd
   k6NfBrF2cFSu2M6rUdnsNtFSiR7CeBKNsTItg5guBCZc1bQqWa1Xwnsaj
   A==;
IronPort-SDR: 5Eya6vv+lUNoREQ7DQ97o9lQxWaozEGqvEEGIcr7r080SdXGrx/Pg/0i/yxNOlMOeRxnBrppz6
 pbgR7BZREKBxuaU3XLWC7gCUvOtr72w+F2FV+SLnbvBGqoJVRjeQDeaHUpKRpl+kSpOm0CYE6/
 LnherVIKWRkURq0pzKIfu7CVoWPA5V0X7Q7t3QYx1QrGtoQJ+mwHqRam8yyEmZ6e4I8a/cU63j
 ZonfRlfpCWsHzh+YmmSsmhcGXMAYMeYKER1t1bbd7GR0M49eyykNVLB3LsAZ36vkGKTMrsuJRv
 zd0=
X-IronPort-AV: E=Sophos;i="5.82,234,1613404800"; 
   d="scan'208";a="269363963"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 20:46:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxQQ7GgzohkC6I5WnHZR50Jk06Zubw7S2A2fYIEtO4kcGI6Yk9GOHAAZHutkC6Cbwsr/B4ZgzOMz48EqxVeXagRgRc7/IH1GcevDjyj5SRxjpiwWOagGNRLS4nULSUOTD2O/WqL8kRXIsterzbEjymHMmjsK0TNSwicPxRvcLpVA84/yrmxbSJmbsm2mkMzylYXLzxmumQdbpC03BId3D9hsTzkRPb7wkb73K0BK/5nLHyZSr4NJUPhfijnUOa6fmz1+eI9dIr6w5oPE5Hdn4AiLNY8PB/G6eumUwZJS8EtB2WdHFjUuj16XKYz7cGBorBQE0ssvPye4DAofzgWwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5v4fYfZDJ2W73UpgFgKR7hPu3xCAXx4qEKgBz5CGqs=;
 b=iZ3Aqpct5y8teL0j1Cp4dsmDvesbmmjabwTrdEondWuFeVs2ZagxduMlu/kTjLZbxD2egLLfTXXuht1vPeON06Tnz+Qt7V11TmWnwmk33wuXAkAeypoOfW8+C4R5cOeE3CI4eWoo1tCvDCihvwM3QUnlhV0AXZmEqZWjTbyHM0lyzpex1HMUfWMcWdZYIvOX3NOLd668wjLLeJz+P9Uqtb8tqSafOUoF/rVxD7qUIh0meIZQsIkzhHFY0GAyjTtSgGSrL/CcnpEuBvrFSZCUIgL2tELIYtDxN6mj2e4ZkTc4z5qkVhojuyZa89MnKT6rlPYtZv3E/GfOzQwzjlD3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5v4fYfZDJ2W73UpgFgKR7hPu3xCAXx4qEKgBz5CGqs=;
 b=MSCDUZhciOoyWUVFkbAPm7VvxNvDZ5yMagtiGVL1IqK9KFbBdSUgbDpeotNOKtpHAnMJWlTBvcmopW/2bN8VaGOVCZyv7T3sH91bOkcdShtw848x1h6qfNQyRGvoUR1FZiaJIpQGKf7APRpL6pLn1un1ag2VI6QLqYcFUz3FE5I=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5084.namprd04.prod.outlook.com (2603:10b6:5:16::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 12:46:27 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 12:46:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Move eMMC cache flushing to a new bus_ops
 callback
Thread-Topic: [PATCH] mmc: core: Move eMMC cache flushing to a new bus_ops
 callback
Thread-Index: AQHXNRe01xLgAUuS+EqswYYPpuMV96q7yaSw
Date:   Mon, 19 Apr 2021 12:46:27 +0000
Message-ID: <DM6PR04MB65755248E394D37512288DACFC499@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210419122943.68234-1-ulf.hansson@linaro.org>
In-Reply-To: <20210419122943.68234-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74edc1f3-a980-409f-7c5f-08d903312606
x-ms-traffictypediagnostic: DM6PR04MB5084:
x-microsoft-antispam-prvs: <DM6PR04MB5084339F7053E084B1162977FC499@DM6PR04MB5084.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMSQzKnKAyuNNBStetEtyLqEtaLulZhc27StL+r/pcrJWlRu8xRln2vwbom0nO7EWa4PSm5ocvGxMM9zO0IgdyxFAKDWrtLq5xex3YmF34AwwuxBIwjt9pS0p8Ytq6lVh5d0pkOGbN6gPQ/Nd9RWfwC5kxVpPSN4av+I5aVviQ6w4/JQu2wXDyJNpn+JRWpgjYLJKwDqHlr8k6eXFt7ojHnKdYSjlM1GMxEfrh/rYRzmHRFDdK6wwcrDxlUsaKOPpzTjX4RWF/w5bUbFXBJugpiQU5yYF0iyt8uT4X2s7oyB54LtH4UdswIbsnmFjLjwMlwa6bQdNE7PNR6Yr9zxxEc8xBEKSoEclwqhhPdXmk3x08Y1wb4ZE4d1O1fXp80ByUyZxsNjR+t3hgaCE4h20Xv4wtX3s//AwH+xiaP8+WlvO/hR2dzI1RK9mSWUxCbQVTgRAWqK8iehnxKsb5Bqanf35qXZF3utjNqhU9lVLLT/f/vZcviOvownH5qrJA8L98IiWgnFXSzhTxVt1XoTaoKOhG1yYpjR3aHAHQj5DS0E95Fo1vAvQauTeDAzRBmtEOhobPxum/9YkWPBCb+4fIo/e3I4xzj8LPJ0fIZoWdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(26005)(2906002)(8936002)(4744005)(33656002)(38100700002)(71200400001)(316002)(122000001)(186003)(66446008)(52536014)(478600001)(66476007)(55016002)(76116006)(110136005)(54906003)(7696005)(8676002)(9686003)(86362001)(66556008)(5660300002)(66946007)(6506007)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PmWtUtZxp3gfpanXav50rKTBCyIR56x5xK1QnX34zNZ3zNiEVGIKaqI7GH3Z?=
 =?us-ascii?Q?rv8drkNO8Xn0ugoU9fBArWaYy384EWr4CdNCC5OeQ+zhDwDjOktRwu9GRk+S?=
 =?us-ascii?Q?scove2bwJGXJjlKe/26mBeK9Aiw1FPzqFl1KoJsgKM2ip1oMRYS1IuuvnGXN?=
 =?us-ascii?Q?DFthnwn3kCG+cqhKwp9n0MvwIEWEUjJTk04iqNpF+Nxqb9OCRHQDc2Ig1VnY?=
 =?us-ascii?Q?A5ir26fSqy9N5OsHgR8m0vkJpLowUcCY763u7jqX0Sfn5W8JMZep2nJVN8nU?=
 =?us-ascii?Q?UZXA5jHvwS4aYfpHgOY09PQQwulwaxCk9lCKu6hg4I5tvkCvnReypJ+2wds3?=
 =?us-ascii?Q?Ux8Xpmf/X3Oa2NHHKE6FuDMLfmoOPyEq6MmmU7iMoWY3bEk90Il7r327+jSm?=
 =?us-ascii?Q?Mjua7z7B7+VNJkwBAjtm27/9+PSYdjPrjT02H3rrCaG+un932igY8ey8N0eZ?=
 =?us-ascii?Q?Nnkbozl130yl7xfuMKkWmN0sIg6TOBhLWXZ30DwKH30M8DVdp9P+U+M+Wv/+?=
 =?us-ascii?Q?v3Gzijk7E2xtZOrUni1mYaAA8Lyy2AV596xvDtXoOw6zQnw6gDtJczwkrOrv?=
 =?us-ascii?Q?y4h5q1ggs4m2T3a42EerMT96givMyJk6cAdfgvjmTFLJw4OnWRe1WeBhzz6z?=
 =?us-ascii?Q?buHyA8EbCnQ7/3hoZF7qcuVIC9XqsPhkTNh1UdTJNUhRe1LMxR86tZaHm4yc?=
 =?us-ascii?Q?nC86bKHAzjCzJw04JwAXw1tDs9IeFpLghgxvUedjI03TwKDKyt4MQ0MGG7zN?=
 =?us-ascii?Q?LFPodntk7kQphdDallZCB5Me3WLyrLnN4bz2pX+LH0MwRGpZVTm1w7YzzWTW?=
 =?us-ascii?Q?Yjm3w56tU9irdphcjhIuCq/ac7sNTUonqK3sbrjSMPP3cv82JTsn7BLJ+kKE?=
 =?us-ascii?Q?zr/jkX74HNnyhN1uykEeKcaQu9O5DbhO/ygGRBkvfoaujbIdebUxTijBy7DI?=
 =?us-ascii?Q?YC/V7YeucWQ/jG/OEetcIPOWlSREDZVTKY3zZePyjk38gmAKTG+D2guk5JSt?=
 =?us-ascii?Q?jnPMYsO0QuEHMLKawsL+SdZK/kvByUOaBr6Sirn32tSndp/JrHWhOQbyDcuS?=
 =?us-ascii?Q?k1nFwkKLNuaHPqxxxKAaXNZtwb7oddQzMgC+wT8RMCRr8K2f/mP7UTufD2sr?=
 =?us-ascii?Q?WtmlTexyZfwCoUOoJnFivyg/P6Li+8pF8ABuEXLQ+QSUSBVeEWwQFINRqHZ5?=
 =?us-ascii?Q?BdlP2EmWF/cTg/rQ1s+x6bk4l9ozH/IPG3nmFq620VxWPIbXnWMEACcmfv6/?=
 =?us-ascii?Q?QtSzojGXFG9p6puUg9udPXhWiMqGGyP1trR9E1WeezO+EPjIb9RzJP9yK+4G?=
 =?us-ascii?Q?PJb58egCwTb2d2KciHgm3QGX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74edc1f3-a980-409f-7c5f-08d903312606
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 12:46:27.4492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L++G54NvmDclZZXQEb2kngsOTBCtDVDRAICoFccfB405V5/2MFYJaD9JvISxRjJX1yzU5p9bZ7G1HGSTMwu/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5084
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> To prepare to add internal cache management for SD cards, let's start by
> moving the eMMC specific code into a new ->flush_cache() bus_ops callback=
.
>=20
> In this way, it becomes more straight-forward to add the SD specific part=
s,
> as subsequent changes are about to show.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
