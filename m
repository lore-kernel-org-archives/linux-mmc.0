Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E622C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Nov 2021 15:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbhK2QAY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Nov 2021 11:00:24 -0500
Received: from mx0a-003b2802.pphosted.com ([205.220.168.83]:59654 "EHLO
        mx0a-003b2802.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232009AbhK2P6X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Nov 2021 10:58:23 -0500
X-Greylist: delayed 2933 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 10:58:23 EST
Received: from pps.filterd (m0278965.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATEjhGp020732;
        Mon, 29 Nov 2021 08:06:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2lnrVP3Q5qY6pbUJn/llcuJ3iQVzaitHoxCGlewX8bw=;
 b=S+Evmq7oGq/qO+Fi15jA1P+Ru8DGdQdqa/G1klubLuUV4CQUvCHpd+uiVf92nSPWDOxL
 7Sjq5jyGFk/vW0QM0RcMExo36YjKzyMcGplHymTNAB6XiUwDIdk1N/OOFY+S7ABWSJ5K
 gQnjx9rzTZiGVHlUlRUkt+gOulay3P6o7hl452AQeqRVoxi6fHOTGqKv8PqrfFbvp+Dc
 8zUjP7Zh1dxnai+Jg+yqoC8vkwvQYDp9uwbIDupiUqTA6cGAsiLM60d1GlFZa9GipUMy
 /k0DsemZFPXyWYIB58TCfEEd5WNjIKAE3iK48RutsGc7yz60O62DU78LJXg2net2W5r7 Vw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-003b2802.pphosted.com with ESMTP id 3ckgkhc1tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 08:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgSRwtphoJ+/Op0XGMffSOZSZWV7r6DzKxm+q1CmgQ85oGFfNK1ATl2V7ouyv1GbFWkRyrCoacx+0j03VUgKurXg5BjM/EnhIpjhj3dN4Z9UNVmW+6hLfkxwgKB1gl10/AiWfiKTVnZlSmsnf7r82HqWe9RADsDQsId9L6zw6fqmD4AYQLh7woJU7aLkoaA06lW8GtN40QJ5zsSSpaOHkIYLvFtqibgm6ND9cFTt+Oz11YBeL1msO5zbt+bgWxyA78HdPVJZt/6JnoHLgxxxLJYhE/EZJyUCp0TlY9biwOJeEyYBJzJ8o4FYt0kGqrVZpqyQ5IXPCi77aNGTuAMrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lnrVP3Q5qY6pbUJn/llcuJ3iQVzaitHoxCGlewX8bw=;
 b=V2s8Sn8osHEhkkOZKWIPGLCm2+e9kELYWKyzZ5zf1NUxtZaw+GbHkDhIKS2Hh28Gp/aPZ9qMiSUJ4hdZy6RtkI9kGiYHfHoNjW3rx45CiceXVG6wfvw3zWokSvz4VXHMnORpR6BfqI/fvGUhr8FKGVuvjbmWZEl62cMy2Xh0XQ8oZPPgtBiqKjJkmFIOFItvJBvas0K9HP0GtYGPaqbwhBPVSudkjD09ZHiQPgew9E1pHCr4Y0S7BDCJ80AjdhPzFCS9mhnB/CCoWxjdRBDw+tjqU8DFxkh6dUE7Qdil92cI53xvBN4P0yNp5oYl2+3XedDkxQSD66hYUPUswrpenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from PH0PR08MB7889.namprd08.prod.outlook.com (2603:10b6:510:114::11)
 by PH0PR08MB7746.namprd08.prod.outlook.com (2603:10b6:510:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 15:05:03 +0000
Received: from PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::ed29:24bd:ba23:d5d8]) by PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::ed29:24bd:ba23:d5d8%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 15:05:03 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Oleh Kravchenko <oleg@kaa.org.ua>,
        Avri Altman <avri.altman@wdc.com>,
        Chris Ball <chrisball@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>
Subject: RE: [EXT] [PATCH v3] Use printf() to extract and print fw version
Thread-Topic: [EXT] [PATCH v3] Use printf() to extract and print fw version
Thread-Index: AQHX5R7PudZouS/6lEWOzbRjrYGvAawamGgg
Date:   Mon, 29 Nov 2021 15:05:02 +0000
Message-ID: <PH0PR08MB788953AAE68B7136B52F1A9CDB669@PH0PR08MB7889.namprd08.prod.outlook.com>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
 <20211129124142.15012-1-oleg@kaa.org.ua>
In-Reply-To: <20211129124142.15012-1-oleg@kaa.org.ua>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-11-29T14:56:45Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=25ae3188-1676-4e07-86dc-2b9231efa833;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
msip_label_37874100-6000-43b6-a204-2d77792600b9_enabled: true
msip_label_37874100-6000-43b6-a204-2d77792600b9_setdate: 2021-11-29T15:04:58Z
msip_label_37874100-6000-43b6-a204-2d77792600b9_method: Standard
msip_label_37874100-6000-43b6-a204-2d77792600b9_name: Confidential
msip_label_37874100-6000-43b6-a204-2d77792600b9_siteid: f38a5ecd-2813-4862-b11b-ac1d563c806f
msip_label_37874100-6000-43b6-a204-2d77792600b9_actionid: a7131126-8fde-41de-a949-a48f15aee812
msip_label_37874100-6000-43b6-a204-2d77792600b9_contentbits: 0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b011452a-47ec-4d8f-dd2d-08d9b3499ef4
x-ms-traffictypediagnostic: PH0PR08MB7746:
x-microsoft-antispam-prvs: <PH0PR08MB77465531CF63D60DC2AB5D4ADB669@PH0PR08MB7746.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KO95e6toges95JjHIO0owsLwALpUbcerkRYJCam3e/PV5P7BrE0eKkSnkSFvUK3EYqyzbKGxXkWutTKXTBjDP1/s1Uia4cN1de/A8BH0j4PzBx1BvDA54JR3Cu0QCKx+wH9WrRka9Cd3j3dhSbpEJle8n7Sw9v9IwPE326UbVyw0Gt1YkMk39a4We/mCZmDG+RFdYyKbId6njoWOXkH+t3ikVXrEZNq/1Z0yuS8ZU7zMTLgMRhbRrRlb9FkhqbCGtC2zEb5MkW9pxRbk6HTprHmRU/2XKMKG1SrHqdEzuVUoDMiicNY0VPb6GyPNqq/8M2ihYnRapI4OO2tefYLuLi5HhmTEeEuiZ1AuhnqsxufJtzQ87O+ytCR9H8bhqijBDtB3geGS0HmCZMCyz5BRSEkd0oYa/ojLOXXIoS02RwbtLkAxh7UaRdTNK2yj15iRd05EOzpFyZG1aXwyn1wKEx/vCjZMSjp/lvXoLX4zGc/XQgjVNyuwy+MVazd9f4T9SDX0t/WaiTzH7y00hq6h0ZiDTFl1P49EaOtwPzmXGu50TJcXjnhXIo7pLcqHmBzjUvl4zTLRMgusZOjSyGph59LJl6DLu1BGf1HX3TQREa3dCFRTpuCHjftvmNcTk+9y/xHrTf3161K/qPl7OVKyKLMkusjBfbMrnKVskyjjqu3kIoYxG2ldM848RR5FgQzir3xng3uww81To+rgrmKFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7889.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(6506007)(38100700002)(9686003)(86362001)(83380400001)(33656002)(316002)(71200400001)(186003)(38070700005)(8676002)(508600001)(8936002)(26005)(2906002)(4744005)(52536014)(55016003)(5660300002)(7696005)(66476007)(66946007)(76116006)(66556008)(110136005)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yr3qh4d15u7uo2LUMGxfD1FcH80STdi1RzcxZVNSo+iack78Z9+i0soxHTsW?=
 =?us-ascii?Q?6hZNzhDrqvFrrc6J8DcmueMHIeqW6nXemoe9nZf/Y72gZpOyO8LfR9rer+wn?=
 =?us-ascii?Q?rp6luPdmG84uakJXOKjwZskyEA/X7dPXOMtPwS+IBaFcNO853RPOv1/OpduR?=
 =?us-ascii?Q?YT/X+++6qECFSEZU0rWH2XluvGv6bg7M2gAHAs7DcgJsFe9EeEDa6p4QUEmK?=
 =?us-ascii?Q?kArky0s+o+vrIp7mMDU4Kj32duZWqpktKRMWlUzjFR/BWuBPU8A8OQKyiJKS?=
 =?us-ascii?Q?xhlRUCqgEdPrxGrguhnjH7lGp3gU8ywH4oQucfD0DVAM9AIDU7QqOb8i38jV?=
 =?us-ascii?Q?3jrXOjrBGiCVCTmehWQuL6JYrRDvBDGoTnOsbEPADTxWn/49CAAcYX5n2mB9?=
 =?us-ascii?Q?ORTJrCtT8uG5LGNCz59yxyuZZdi45bmtfTExOycOVuyDjjekio3t41+93n7z?=
 =?us-ascii?Q?7D20OYpdSV1RvNfBaKkHitUHp87WANefCp7DdGpQBrlzhsEaJp2nheKpMwEr?=
 =?us-ascii?Q?yCny7Tv7NNG0wkcRrGFHttksn/cjfJHL/f8ntD2K9j7lfi9dO0BgsmSvQX/p?=
 =?us-ascii?Q?69CtcRaJc4emkRG3vZy/CvieqI1lsUAuDTdKexCizxztp0mS8a6JU8tQCBI4?=
 =?us-ascii?Q?Rxp6Te8QzXzWI7ZUdxoxVmPzoHVT1rt/0wsDtELQrZkfBk+z5VZ275U4h+le?=
 =?us-ascii?Q?VJzMuCSoW1YIMMVU8O1hodg2XHkyC0Zv7dmOJe2KWXVSadLPltq+KFyvW05A?=
 =?us-ascii?Q?8hQJMTXMflYvlRj0RJPggZnjKzhD44LmkongXkl/UypjXNlRTaAdoU5X9i/C?=
 =?us-ascii?Q?jAXsHcbtN3xHi6333YMGI7M13XX29cDUzkrbW+VrP2A0EaX3eegH/W1G6fUn?=
 =?us-ascii?Q?WZ99uav5fb/J9JrwDKmoK1HHeTROVd1rlpDkfupPdVKoqcDPzFCXeyczHej/?=
 =?us-ascii?Q?P7u4pFSV1x9o2xNj38RWQQ9j5ia6EOZ3wy1z28SapgGBCZGZmYbSbIogobF7?=
 =?us-ascii?Q?YlwkDKWyy+1/CprPgDU6rlY3M6/CBtQKISwBhqxrxXbuGj1kZKbhyyCEv8pa?=
 =?us-ascii?Q?y64yl8AYMB6QScbL2lEWposJDY2x5hHAMWSOVXXIaCkh4EbVf8tyKwj8rVjV?=
 =?us-ascii?Q?iYM3fCJj+ESRea1Ro1UWRRybLBZa9yIUL6d7+Rr1HyaACWbbAv/Z6S1/B9r+?=
 =?us-ascii?Q?pkr8SbJqJJAWYFWDRUPcmn7PG9JpHOTwsXpytw6a/t8sbqVCj6Zkogz2MvQE?=
 =?us-ascii?Q?4uceG3ASB9tRWqCgUVRJB5wC/IuPqai9S0vMhz1pDZeZBXwZBuOC0qLENbSs?=
 =?us-ascii?Q?wF2t4rZH+4LuLMeu4anmnHRBVvGw4geu4r/++xf/KZmBzPGAGpaRDuHExqGr?=
 =?us-ascii?Q?gCYHH4s6/lsiKGzFhIxDTe16cocv5RUkcVZ6iF7mvuDMJoCONRblpQf55aLv?=
 =?us-ascii?Q?TdnL3t/+r5sP4jQpcJJbJf77NpGgxEe8gN/uVs/CpDSV3bxdsvyHawmBLTA7?=
 =?us-ascii?Q?zQ5fWb+BKyZJucehR4y3XTFjDaxNAEYnAk3BIBQAH7+yjIfBPUXbQIsfBjHT?=
 =?us-ascii?Q?Pw9n03nVOPFvunJwMsWYdTlVHlRtXHRctD+Qd6FukABp8MIKEIMrB+aeUIWH?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7889.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b011452a-47ec-4d8f-dd2d-08d9b3499ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 15:05:02.8845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgvH56hvlAd0GNwbwSOh/cZwKmeMy21V3Zfh6NXNBKLYn9j10NRXPxW5RORFZN9gWz37lPSVcd1grJl0yVME9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7746
X-Proofpoint-ORIG-GUID: n2GglrEvVZ_kRmpiE2ynNSDqbHTcdEEi
X-Proofpoint-GUID: n2GglrEvVZ_kRmpiE2ynNSDqbHTcdEEi
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Micron Confidential

> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Subject: [EXT] [PATCH v3] Use printf() to extract and print fw version
>=20
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless yo=
u
> recognize the sender and were expecting this message.
>=20
>=20
> This patch also fixes a compile error with a newer version of GCC:
> error: '__builtin_strncpy' output may be truncated copying 8 bytes from a=
 string
> of length 511 [-Werror=3Dstringop-truncation]
>=20
> Signed-off-by: Oleh Kravchenko <oleg@kaa.org.ua>

Hi Oleh,

It is better to add the prefix "mmc-utils:" in the Commit subject to distin=
guish it from Linux kernel changes


Reviewed-by: Bean Huo <beanhuo@micron.com>



Micron Confidential
