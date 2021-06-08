Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112BFC47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E725660C40
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 07:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFHHw6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:52:58 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:59152 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHHw6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 03:52:58 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2055.outbound.protection.outlook.com [104.47.20.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-pMPlSma5MJCITL6A722SWA-1; Tue, 08 Jun 2021 09:51:03 +0200
X-MC-Unique: pMPlSma5MJCITL6A722SWA-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB2769.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 07:51:02 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 07:51:02 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Use .card_busy() to detect busy state in
 card_busy_detect
Thread-Topic: [PATCH] mmc: block: Use .card_busy() to detect busy state in
 card_busy_detect
Thread-Index: AQHXW34/muF5H+lRqEqNA/AV0O+EyKsJptlpgAAJpQCAAAyTLg==
Date:   Tue, 8 Jun 2021 07:51:02 +0000
Message-ID: <CWXP265MB2680B44ED6B4490987EC7EFEC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <1623057495-63363-1-git-send-email-shawn.lin@rock-chips.com>
 <CWXP265MB2680A140D951939931D1729BC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<73d27461-ba9f-1a90-0401-4ce0cf59ac30@rock-chips.com>
In-Reply-To: <73d27461-ba9f-1a90-0401-4ce0cf59ac30@rock-chips.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85c10d9d-9a29-48b4-0506-08d92a5229cb
x-ms-traffictypediagnostic: CWLP265MB2769:
x-microsoft-antispam-prvs: <CWLP265MB27698050EE7157E2B905D020C4379@CWLP265MB2769.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:215
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 9RTBS/oRIcfRlSSE9qkIg/5+LE4H+64QipyR4jKWzACHchD+w7D10Dt++X8CHvFr51c/X/AsQvI26MPi00ArUhr15Wlz7vnWUBLvQ77EZWVvQlWxA2qVAZ1vH0kEB0saB5w7UIX23e4dUMQIOEN2FA5SP/MDs4xlPx+BvBkvPcnbVs639I022NGuGOlDWIUyVWZlRkzvrH+IufQ5Zr17LPvuZVR1cNBw/M6NvMaCEOoUSjpMbTTLMXK2Bl9z9x60svDABrP1CJ0BvrdjFA0kioBgo05H6KC3PNdb4/JWZoWuJvsURYX3QGa9wGOdAr2s4QYbifH7sly1Bordwgyu6VLN9zpXmrCP6asK0y4L/g+uay+BulPjfg1VvBZO5l+ijzeUveycxeYLAzT0ywNfxKHVxy9zk/pYk5tYht4XIsWKKiafOjHdjIqHh73LleiwQcLuP+ZuxCgeLcjevL0zxYqu7LsDL+95Ug/SZ38RNiGl/cIPKYso7i4o9netVRBXF8LkVGu9C/dASW3TpmFpGJy1+TCq3hAodEUxdFyF0SlBw3rHAJ1Q2vGv1pnaUUj0vNPvw0bh6cF+eQ2CVS7bdWiVi1wI6F2fWDa4sRemdFWekpOgZWJgg0BbKLOBv2SBby7WvN9jbsnxNx2NewEklT5F4fr73qpVUMWmrQeqt/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39830400003)(376002)(110136005)(316002)(2906002)(478600001)(66476007)(55016002)(66446008)(64756008)(122000001)(7696005)(186003)(6506007)(38100700002)(8936002)(66946007)(71200400001)(86362001)(8676002)(52536014)(91956017)(5660300002)(9686003)(33656002)(83380400001)(66556008)(76116006)(26005)(142923001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ywIi51W5FoS04853SptECGTaYxCsF87KazGsjjRwXbMx802LoY/hTSKOck?=
 =?iso-8859-1?Q?B7PTvyHGbZS3DX1/0GF5xdMkJTtG4s2dluIYnQzscUL/1XK2l6cxvTujCq?=
 =?iso-8859-1?Q?xjoDSgHmUFMx+ZuWBADVFVc+qkRhrq1Je1/rmL18WtgbEN+4LLN8bAIauq?=
 =?iso-8859-1?Q?4TSRbwfcrArBQozMsehkrBMwaIm4Ixi5nuekkZFPHBAtCgp5jZT5NBIyvy?=
 =?iso-8859-1?Q?8ghb4K5ydIOuuw9Wo6G/aL+OM1ewR8imNja0+C4Lf/6kjiw3qRl84X3lys?=
 =?iso-8859-1?Q?g7E/NT7y/e6/R78lVbZbxoFOh8LvDedWeEBVXKrSTDA3zTjriNFeJGZM+S?=
 =?iso-8859-1?Q?G9CO3mOe+JFPpw9vvC8n3WcZufTk/5zV3pqoALxC6va1TpkcMm85Z/KY3v?=
 =?iso-8859-1?Q?etfJTwwSmw+7T/5+BF1VZs6ZJILOGG1gYtf94zVFaNcsAI7grohllzjY+5?=
 =?iso-8859-1?Q?/nDmfSYQLQFJlWYAlmrk8QldfSopbLazhL/y/rOAvdM8+qO7Sq/GHuDGDh?=
 =?iso-8859-1?Q?3CO6jw7DIxhB/DN3dOCiblYGg7QGV96/A9W5cSX/nLw8adr6JiGuawdWXR?=
 =?iso-8859-1?Q?+6fISRspg+vTOYa9ranyPCSpV434m3rp8YsWjWOJlZhOBLLXZz1WhpnO85?=
 =?iso-8859-1?Q?2MGIy9WGJB03gxgF8JecsTw+Q95tbbo4FVN3HVGaqYSvqsjlzpUBmHb3gS?=
 =?iso-8859-1?Q?Awpp9EglnD9PdEiV54bcDJWQ8ijizXSEJy7sA+JjJqXzHgFbuiko5yODC8?=
 =?iso-8859-1?Q?evRxhvkh49V3PlkHugE3bTZOhvEUnyKpfV6Rt8IVpBrzcQuIRA64rpfKN7?=
 =?iso-8859-1?Q?FZiM8sNnj9IUSTRlQwmntvHayoGrxyDxCm4QzE/hb3OaG6JacKrm9L9lpC?=
 =?iso-8859-1?Q?DUPKjqp3GtWRlb0mFnBZWYjRn4GQEEp5KexFkkyh6r6xVfMdgjfu8y0O5j?=
 =?iso-8859-1?Q?w0FeZuBmWjfC9Tn588HeNXHAjem88XFqQUYbQyKrrKh20gK6ed8L9LCObT?=
 =?iso-8859-1?Q?7g/2Tu8Qoe9gp/2aTt7XuHfZBAaRcGIBky44IPj+kJU3pM0OgqVbsN+NBP?=
 =?iso-8859-1?Q?e/uFH2E8FbcVzLkfB55TRt7hVLJ9704rjPhj9Dq976YcklGm/hot0IfTbY?=
 =?iso-8859-1?Q?56GiAx8vZ9xS2tovfca5HjwQDl3fnsP6ExCxlRy5hE4rTMMEq/Ha04h1Uo?=
 =?iso-8859-1?Q?PdrYB1mluqhOM6oKFJr6592Y89lVfhTLVdim4fSZ1lVJWwvAkJvRpqx1Ur?=
 =?iso-8859-1?Q?fn3H5/M9k68pphk13RVqt9/CbnwKAuY9US2VXiquiSbmct+ZdNe7yNBk/N?=
 =?iso-8859-1?Q?S1qprIS3V32ZfK/B/iuFpdZADHLZMTEJdfuUwiolCqFUKzY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c10d9d-9a29-48b4-0506-08d92a5229cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 07:51:02.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVN/hsausyHF8k4WfyEQfByWJRoPU5tA6xVfR8POGvGcAH3nZW4zlwlTVIMY4oNhU8ovhpOjZTNUQrJMC1ZkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2769
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org




From: Shawn Lin <shawn.lin@rock-chips.com>
Sent: Tuesday, June 8, 2021 8:58 AM

>>You're assuming a card not signalling busy indicates TRAN state, and 
>>set the state manually, but a card might not be pulling DAT lines in PROG state
>>
>Refer to JESD84-B51 for emmc spec, section 6.5.13 clearly says that. And
>SD spec V4 also has a similar statement in section 4.3.4.
>
>So I guess if that was the case you point out, most of all operations in
>mmc_ops.c would suffer from this.

Im not sure what youre referring to as 6.5.13 is inside of 6.5 (no further subsections)
in JESD84-B51 and 4.3.4 in the SD spec is "4.3.4. Data Write"

The patch itself is fine, i just think that card_busy_detect should not actually
be a busy detect but rather a TRAN detect. I will send a patch now, but if anyone
wants to check this out, a full SDSC card that receives CMD16->CMD42 Lock -> CMD42 Force Erase
-> CMD16 (Reset to 512) -> Read like CMD17 will hit this race condition
pretty consistently as the CMD42 Force Erase will be in PROG for a while on
most cards. If the commands are sent through ioctl in a batch that is.
If card_busy_detect is changed to card_tran_detect then using .card_busy no
longer makes sense.

Regards,
Christian

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

