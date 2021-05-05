Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F308C433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 12:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD06E61222
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhEEMVG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 May 2021 08:21:06 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:32839 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhEEMVE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2021 08:21:04 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 May 2021 08:21:04 EDT
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2056.outbound.protection.outlook.com [104.47.21.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-yvW-DvvtOlSYiuaccWmj_g-1;
 Wed, 05 May 2021 14:13:00 +0200
X-MC-Unique: yvW-DvvtOlSYiuaccWmj_g-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2726.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 12:12:59 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 12:12:59 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Topic: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Index: AQHXN3kp02z8n6vh+UmW3TCHxA6qwqrUvpuAgAAEiK8=
Date:   Wed, 5 May 2021 12:12:59 +0000
Message-ID: <CWXP265MB26802E4E0F1AE7B6FE2836AAC4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com>
In-Reply-To: <CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e65e37-a5fc-47d4-da8b-08d90fbf1f9d
x-ms-traffictypediagnostic: CWXP265MB2726:
x-microsoft-antispam-prvs: <CWXP265MB2726790C5148CE6EE3DBD953C4599@CWXP265MB2726.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: qzv+sexz7ibTJO3jcAf4Rh7uj6+7Je7cJLgi+6iXlyhpIrezGBjlzEUKBtBBhskXB2vdP09FARABfCvNuXMjFrK6KZXgiNW5bU/b7kXXIpPCg4pbZrNkIHQWkW/4JTkyjHLboEM3TcRv7EeiGtvrg2fiXKc8vbzqBIKKBLv4N5NHU5R2IyWiLvZAE3y6n79WjHhT+YC5XyBg0iq8ESVxdtxEO84ProRpGBBiR1zL9f+CNtZxZY16B4e3ieJfL/OgBmsUP8EgIT7QoNo7u1v33CGRdQqwOjLuYxcxMGpRGc7AoypVveGbqzjToGYLGlz+vXeTWQui2CwkfhRO1a8QjC8bAL706yTL+Mlgc3lBhueOd85FJbBnpOQb7qFmchka2bGlXyzO414FaXJIwWVsJYHYMoUOJhZKuHqatJ+EAWB1HN3CBFC5udLySWbBZTKTtKqtEhyEZS1WJFdzsoTMUKjYx3imSSZ/O3fUCGSc5n6X2VM+kPRvJEndx3LdVYDS9dktF+S15pXUcF8qQOK7RiotSR48xFNzZSY0N15SuHe6PVdVFkvcXlftTigC/6AFvrWYttjEG9bhboFXr1SHns8Ij3w6/rmcRWuP9ZKtP6+tWp9gmHNItIZr1z/0PBEGue4WYEvpspWIOQyFG+m8N/Zt/uuZK35QU25z5EhK43fQaR1NJGTIjYdWGFUL36N+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(376002)(136003)(346002)(366004)(396003)(966005)(6506007)(53546011)(91956017)(76116006)(52536014)(66946007)(66476007)(66574015)(86362001)(66556008)(66446008)(186003)(6916009)(26005)(5660300002)(83380400001)(64756008)(8676002)(8936002)(38100700002)(122000001)(55016002)(9686003)(7696005)(316002)(4326008)(54906003)(2906002)(71200400001)(33656002)(478600001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?EZ6iz7dqrppr8ksv5yPODVVeQXMNTDNRqf4IUHGCce3U4UPlKPO8fBNNee?=
 =?iso-8859-1?Q?yGrJ3RkTJj9Sb/CMBO9IPwMi3MyGtl9r6SQTkGvAL34G/Ut7pui0Uz7OKH?=
 =?iso-8859-1?Q?excZu7+GCaOZTr5Z/1qUaxVhthf/AG6cCXJdJpGTOONof7HyRFNiQ+i67A?=
 =?iso-8859-1?Q?WxTLZJVtMNGiTh3JrB/c6ybwgf2qPOiEZjm9YrTLu/SDeW4bbd2nSFt1dM?=
 =?iso-8859-1?Q?oHaZAaEz0/ZD1T8MWkCtIZVODqhLJvwaImcJd7Yb0wIJqBYNK+ec15Y3nw?=
 =?iso-8859-1?Q?ab2oizMDXQ/wP0t96o7OtMYKHo99L1XWM0N3xUuiC7i9a8Ay7aM8UY04mE?=
 =?iso-8859-1?Q?e01RvaZSZj/4ykvuyo59GocIG182ecnuQ5sZMvtcGDofr8Ku+oi5MK7dQp?=
 =?iso-8859-1?Q?uqX2g7b4IQGWp11HyIR7O2vutSv+ulKzqIW6heEz+7kSbFeNewpB5ToDop?=
 =?iso-8859-1?Q?IbpNUan152/38R56pKIwy1F5jzNYg/GuUZf0WonGbU4SnuBeeXGKM5el07?=
 =?iso-8859-1?Q?Psr0oOPXbc4gticl53nHNjdlUcfCwjTRE30S8iUJTUJv5drfe6XMrDEcOX?=
 =?iso-8859-1?Q?IXC5Q0sd/hGaCejVwc649/JWRqa8eQjPwC9BQayjsbPQe/sjkuM9MQm6zJ?=
 =?iso-8859-1?Q?ialo+mmCCcEuKYWr/RGQskDeA/AR0oF5vkxBJnbZZv070+lqDmmTpbjO3a?=
 =?iso-8859-1?Q?uDKXr1VNobEdSS/4tnb6hdvqKK/zXuCo89gkHrShkhMWSnqqln30vWYJhW?=
 =?iso-8859-1?Q?qX0yAJo0so1wlXg/FAlHSylwTW2SUyZFKRLIeKMmXXJ7tjOgXSgGfg0JsG?=
 =?iso-8859-1?Q?707FG+4GyIx5wju6frb/agBU5aHzBWs6h0q77CXu2xS5+Pag8221sNUmT6?=
 =?iso-8859-1?Q?lodCB+vNeEo0y8lEjtfCYLsIfdpbBSCmfvliPUok3hS8G/Gx0xXkNKi7tO?=
 =?iso-8859-1?Q?L//drjj+V0F37ku+0Ylc5xC2YcnCz6AgUOcHRa926fwUX5ZcVYLmgGjcdv?=
 =?iso-8859-1?Q?809o/Rj61ZCO9sWuFP9iRZJbOM20sg1UPv4IGpGRT0QLBQWJA6s8gYD5OA?=
 =?iso-8859-1?Q?ejhKCKeu2OOC23BlAJWeR54OBE+/UO2QO82oOoNR3vSCTqn4/AmvPaMKpZ?=
 =?iso-8859-1?Q?HcDwH79S9dt7mZOBfeZI2v98YdnO90cfWcqJssKVKToZqD08jtrlLldEbd?=
 =?iso-8859-1?Q?ZFchp3/9Kgt3RcRcUF0MS8Mbed9683WW29/z5SYpqDPBV94ny8ukR4Aruh?=
 =?iso-8859-1?Q?cez0qZOEykq0Cge8y4F9j+PV16ODxBq7Eb4r4m13EbJJs3KB3DicinvbX2?=
 =?iso-8859-1?Q?SRhf8rLYnQiLYLmMnqhFjIUfxl7Me00IsCnrm46qvkSLXnk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e65e37-a5fc-47d4-da8b-08d90fbf1f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 12:12:59.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YAo7wzSKJULI40eZh0PzuDhBCfv3RvlyWuKRtsaneG3GOJLRDfpBB0hoGVrf3tz9+9twUhfA+LCK59kA3UO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2726
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

So two cards that advertise UHS:
https://www.euric.de/de/flash-speicher/sd-microsd/sd/
Model SDI790
and
https://na.industrial.panasonic.com/products/storage-media/industrial-sd-cards/lineup/industrial-grade-2d-nand/series/71695
Hopefully that suffices as a couple, otherwise I would buy some
that do not advertise it and actually check if they support it anyway.
But 2GB SLC listings are kind of rare these days, so it's not as
easy to find many that are still sold and available.

My point about deviating from the standard was that these cards
are already initialized as UHS, they just don't do the voltage switch.
So anything reserved for UHS-I (e.g. CMD23 )is already being done
by the host with the current linux-mmc,
so the standard deviation is already there.
Just the voltage switch is missing.

Regards,
Christian


From: Ulf Hansson <ulf.hansson@linaro.org>
Sent: Wednesday, May 5, 2021 12:09 PM
To: Christian Löhle <CLoehle@hyperstone.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported 
 
On Thu, 22 Apr 2021 at 15:18, Christian Löhle <CLoehle@hyperstone.com> wrote:
>
> Ignore the reported capacity if the card otherwise reports UHS support.
>
> Currently SDSC cards reporting UHS support except for the CCS do not run
> through the voltage switch.
> While strictly speaking a SDSC card cannot support UHS in compliance
> with the standard, there is no good reason to throttle them that way.

Maybe not, but I think the code just tries to conform to the SD spec.

> Especially for pSLCs in practice such cards benefit greatly by this patch,
> as they can be new and UHS supporting, but must not lie about their CCS.

Can you provide some concrete examples of SDSC cards that support UHS-I?

> The behaviour of linux-mmc for SDSC is deviating from the standard anyway
> in such a case, as the card is treated as UHS card not supporting the
> voltage switch in general.
> Such a card will come up as
> mmc0: new ultra high speed SDR25 SD card at address 0001.
> Thus the subsystem will support CMD23 and others to the card.
> But if we deviate from the standard anyway, then we might as well
> not throttle SDSC to 25MB/s.

Not sure I understand this correctly? Can you elaborate a bit more, so
I understand how we deviate from the SD spec here?

As far as I understand the spec, SDSC cards shouldn't support UHS-I.
If we decide to deviate from the spec to support this anyway, at least
we need to know about a couple of cards that actually supports this.

Kind regards
Uffe

>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/sd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6fa51a6ed058..281ca2da8e0b 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>                 return err;
>
>         /*
> -        * In case CCS and S18A in the response is set, start Signal Voltage
> -        * Switch procedure. SPI mode doesn't support CMD11.
> +        * In case S18A in the response is set, start Signal Voltage Switch
> +        * procedure. SPI mode doesn't support CMD11.
>          */
> -       if (!mmc_host_is_spi(host) && rocr &&
> -          ((*rocr & 0x41000000) == 0x41000000)) {
> +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>                 err = mmc_set_uhs_voltage(host, pocr);
>                 if (err == -EAGAIN) {
>                         retries--;
> --
> 2.31.1
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

