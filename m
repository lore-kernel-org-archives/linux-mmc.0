Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D4C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295452145D
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 05:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bUk6CXwO";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Hiw+MDDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgKZFA3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 00:00:29 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41704 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgKZFA3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 00:00:29 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AQ4xWpE031649;
        Wed, 25 Nov 2020 21:00:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=ZIfcXLR5hjDzkQzGzCEFqyljE1EOVGDfTAODEu/fO3Y=;
 b=bUk6CXwO8UDu2V081lVDcre+qjUf6D1mVFe65onDJt6W6JVytjY/J7j3w7vYUAkSKnso
 pN2H41tk8m4RBMiKZgqpGJVcTMcCVBmoXybeHnCwxpGE0TKkjVEebRkM5dN6MENd616i
 rLC++qtl/1OU87EjyfCrXhI78XqsY1AwYoCut6IaWLNpUyaPEg1kaOo+oT+f+5f3+oXZ
 1Np5sYuxORCl8t+GcuJXcq4RK2TTlyd6+8zIhAhX/O+sZDRT/QNo509YZHpAYiIGqoVJ
 DcqPYgOyeXoGTheKMPBKLhl2Z2ilSvwX8kOsc8FOWnkxBEFQb9h0JOcrG2tGUy1XqNMD hw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 34y39rgbmp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 21:00:20 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 21:00:19 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 21:00:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 25 Nov 2020 21:00:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGjPyyZPBgrG7Bm8YPIl0Il1sDs5q5aWHM0q5qIpO471IJOOL2y2RhFWuRMh9sZZdk0ncistVfZ3LY0+XaeLaXa/b0Sim2lX/FMwAHzVXAsDDADkH82Vh++2uSrKOe1dpUhov0k8q0GZW2/KqTy2ENy8WJtsBwiCaUO5Aj9oJhSKvAIRSEzqnnPOG2KPqeJoLooGMvDrh5UZ4p+3D3f5vkVMNwTTbxcsypOLHZALIoDizIdPEHwYnrWro1lLpV6zrVghhc+YspbwyFalHLHNwWDmcs6G7MuBgN8l7N55gfViNb9DoPTb1WxYuPEB3jXk/1N5r+NWJkDKTez5Q2fq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIfcXLR5hjDzkQzGzCEFqyljE1EOVGDfTAODEu/fO3Y=;
 b=DyxWcpW1se3KSmvSfs2MSexzHPg4jjzfhv8tVaxEEb5xcPstAUlvPNOJBhp0Zaq2aRpHcZ8jRIZJlyGJgAXAxEDs5svCzVtx+idTgmvSa7xRe7MOkR7UxQgqYEygxpNVbIOEeRVbNyfP0UmCxJMk5a1LbhHGebIRpYj2J3dBZYzDgzHccF2M1lcLRdl1fkwBhvz9oSAGt3ww/7kb/KBZJeu9dfWsNqenwpDPDrk2sOu4YvYMssBOG6nG9YOJNIDkq1Rs7oCaht+613B6V/ybYfmaKXVEy7ympY8iwCfwmuTCmUjOXQdI6efxNq5vy7oQeCFEBJq1p4rTp3RK0LRWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIfcXLR5hjDzkQzGzCEFqyljE1EOVGDfTAODEu/fO3Y=;
 b=Hiw+MDDLKFZNAU1pwiUOzAxeEcRXQrAZcKVFX/TsKo1Bp+CKh05QMz4+Nt/4kSzZSH/7qC2pi0kTLvVGS2wT/k8UJt89FFXd9wTfhjPW9jJff4jl4ljVt+vG1Hp0P649FuYUeknQcnNSxX8Kr0rYjIPK86xGJkwKVynBH9DTCJ0=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1463.namprd18.prod.outlook.com
 (2603:10b6:903:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 05:00:15 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090%7]) with mapi id 15.20.3564.028; Thu, 26 Nov 2020
 05:00:12 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHWuLx9yi13PVc6VE27a/W5N/Q7T6nRDl8AgAQxowCAAHQQAIAAHabQgAGcR4CAABuFgIACXw1Q
Date:   Thu, 26 Nov 2020 05:00:12 +0000
Message-ID: <CY4PR1801MB2070D4B45E08B05F05D195E9DEF90@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201112062422.32212-1-bbudiredla@marvell.com>
 <20201112062422.32212-2-bbudiredla@marvell.com>
 <CAPDyKFqZij1_aZZs3EeEuNob37WsGYN+6N52H2N0nTzM427j3g@mail.gmail.com>
 <CY4PR1801MB20705DF5A12318AB80EDBD45DEFC0@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqBWEdAzz0hjk7LhqX1D8qmOomHSS=Be+_vU=upxMr0aA@mail.gmail.com>
 <CY4PR1801MB2070549B13D3ADD324F4E8EBDEFB0@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqZomrJDgjKWvxeOornENnZFXSX+NWTWEerNHf=zf1L8g@mail.gmail.com>
 <20201124161851.GA10535@lst.de>
In-Reply-To: <20201124161851.GA10535@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [27.59.201.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee2b4920-5fa7-4194-6e8d-08d891c82838
x-ms-traffictypediagnostic: CY4PR18MB1463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1463E666A1BFC414059E394ADEF90@CY4PR18MB1463.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xolnXzP75SD0ytr0hJjIYg5sM3rHOwY0rf7W0Zvx+viX7xq12Cu30qfFDbyrVz5jEqckEaEoOwUGjIk/xnGeziD05fvpfJ+ucZgiHldmmkZ7dmbSaazxKHn3dges4vhNCf1aVo+10tHisJvHYTTROIPeIjEcCXD+SbvsudFntnSWTXco29q04tdKnpnIXfCbBvfeTIx/dTqacBPv6wrpFhasAE4Z3MaJav7TEzJMTaSWnKcQj8RTZfLQ0cBf2dry5UwGtuZIjkc7rCcs8avg8mJvWwiDEfRxyWhPn5dsPSVJNgIMcADhm81GgY6LM5a+KfeXytacxoaYXD67GZnduju+ZWFmuca6pLLYQCTSgsvJ2+5Ean0vbwLFVJb5vFFtr09JcqHbHcW/pRaChwLPMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(7696005)(71200400001)(9686003)(86362001)(5660300002)(4326008)(6506007)(8936002)(52536014)(76116006)(66476007)(64756008)(186003)(316002)(66446008)(2906002)(26005)(8676002)(66556008)(83380400001)(33656002)(54906003)(478600001)(55016002)(110136005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/vdPC89t6XGnbXJ2kZqiuEDiQTSDWck1C3cf42LeGCZS50eRM0JPc43M+AZe?=
 =?us-ascii?Q?gQJSI8LgUGXlMHTH/+pR1oU3OYIah6ad5vT4kxpp9Dnj4JF9h5qBohv1+eNK?=
 =?us-ascii?Q?litCWUbuX+KJEiVq73kOSXheYxVav5v9UX5kNh5MLm3R3v0YD5Ydgr4osqu3?=
 =?us-ascii?Q?vzqL115yJHwzxx3gaOW/zG0WKvaDE22ASZJKJiKoUR1hNWpmNb8RCfmh11nx?=
 =?us-ascii?Q?22xHiDJfI0CKZ7HlaJcx9vNwnIl0TnvWnbcmF00GPibjQM0lP+faDUrNN2ur?=
 =?us-ascii?Q?UqFnwTBaTikE9BdDlhHyWrusvrZbUm/34py51QoU67DGdgllh6JeItgyBZU1?=
 =?us-ascii?Q?9kkClOBa+r3cX7gGgwSXCLwcDDAIZnvEMm4HyyV0j+iSQeyUONoxHgDNl+TI?=
 =?us-ascii?Q?+ai2ICdvky44naDwGMJ8UKbXqVbW9KLDzCVALLbXgG278NAlmCOOaDvSnOwI?=
 =?us-ascii?Q?jV/yfu+Srg/nz+lJBA/SC/NyIioKSD9dioK4OaJr4zKJSkEIGySeVQeMOs5Q?=
 =?us-ascii?Q?ni78VPnVuGXyo0QA6Q0TjAmvYUH+4e24/vv1XIfDg4dxTRLZ19YAlmJOq+0s?=
 =?us-ascii?Q?VCttooR69rx0t5MYVh0MYy8o8sUXmnU4poVOY7tulFsCO+DCGBn8Kd5LezBE?=
 =?us-ascii?Q?uef/q5byrKAsYigmQplkbU4r9J6HoqmTfEC2fMoIRcZmH0+CRpxSgyWpE6JR?=
 =?us-ascii?Q?l29/HsKt/LPpmZIFUvw1ea/pFHqMP/X2OAGnfy4zlncFBTtFMgOjAZeZj+fm?=
 =?us-ascii?Q?Sr3zeW6ro1KNNcJl0UdECWKqfG8LcOqwxn/c4Q7qpKdy0+T14TK14vJyoZ54?=
 =?us-ascii?Q?cx1w5tfSJaEnGU87h1XFiq52z4EqgXF8CHPK1aERcL6gloQUaqbSA5zrkURK?=
 =?us-ascii?Q?r4u1y49ptSfI6Zw47G2i6XC8mtfo82MAvmutj7y+JsKUQTE0pzePhnofZtwQ?=
 =?us-ascii?Q?nOK3vV1SqV0tMSXzk/vTexTDRGqlxuBDZt0M8zPwHJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2b4920-5fa7-4194-6e8d-08d891c82838
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 05:00:12.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wP43In7Ur++gNiI8UwBcmhY6PYQlk2snBRrC9Fysho7reFA+hRU7OUty0/qO55KMsWfV9A9OlsqzAqIfYTD+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1463
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_01:2020-11-25,2020-11-26 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sure, I will tune to those discussions and would wait for that.
- Bhaskara

>-----Original Message-----
>From: Christoph Hellwig <hch@lst.de>
>Sent: Tuesday, November 24, 2020 9:49 PM
>To: Ulf Hansson <ulf.hansson@linaro.org>
>Cc: Bhaskara Budiredla <bbudiredla@marvell.com>; Kees Cook
><keescook@chromium.org>; Colin Cross <ccross@android.com>; Tony Luck
><tony.luck@intel.com>; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
>linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-
>kernel@vger.kernel.org>; Christoph Hellwig <hch@lst.de>
>Subject: Re: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
>pstore/blk
>
>On Tue, Nov 24, 2020 at 03:40:21PM +0100, Ulf Hansson wrote:
>> It looks like Christoph is planning for some rewrite of the pstore
>> code, so let's see what that means in regards to this.
>
>Here is what I posted last month:
>
>https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
>3A__git.infradead.org_users_hch_misc.git_shortlog_refs_heads_pstore&d=3D
>DwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D9P_lSljSO7KnQNkCGsgu9x_Op4ms
>tSdqWN3Olr4bUv0&m=3Dq8IjbcWL5TERE5I_titSsMtZA2l6QrRmBgu0lc8wpko&s=3D
>T6P9lsMAsulOHqb4szJ553K0z2eYB5Tliq7UqFMth-g&e=3D
>
>Kees wanted to chime in with a few thing he'd like to see done differently=
,
>but I've not seen the actual comments yet.
>
>In respect to the eMMC support what I've done should mostly just work, it
>would have to adopt to the slightly different registration interface and j=
ust call
>register_pstore_device() with its own ops.
