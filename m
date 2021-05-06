Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E60C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A94611AE
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhEFIfm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 04:35:42 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:45431 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233374AbhEFIfl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 04:35:41 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2056.outbound.protection.outlook.com [104.47.21.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-_G7CpgtzMbSOE9YBQrOvfQ-1;
 Thu, 06 May 2021 10:34:41 +0200
X-MC-Unique: _G7CpgtzMbSOE9YBQrOvfQ-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB1636.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.27; Thu, 6 May
 2021 08:34:39 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 08:34:39 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Topic: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Index: AQHXN3kp02z8n6vh+UmW3TCHxA6qwqrUvpuAgAAEiK+AAEGXgIABLmmg
Date:   Thu, 6 May 2021 08:34:39 +0000
Message-ID: <CWXP265MB268017F74D102670845901AAC4589@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com>
 <CWXP265MB26802E4E0F1AE7B6FE2836AAC4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFrAS8SP5AMX2fi_ZbsmGm49ZFo4YKcczwYZOmN-AnPn7A@mail.gmail.com>
In-Reply-To: <CAPDyKFrAS8SP5AMX2fi_ZbsmGm49ZFo4YKcczwYZOmN-AnPn7A@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b248aa62-fe20-446b-f965-08d91069c9d9
x-ms-traffictypediagnostic: CWLP265MB1636:
x-microsoft-antispam-prvs: <CWLP265MB16363909C8EFB46A190940D7C4589@CWLP265MB1636.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +Wb10IOBDlTnJP40kBHMgnD07gey4rB+iEnfZfWdSQanRb3C4Mr3ZRGfoHRgqD8YI2puULVnjFUW8t+Ohz4LFmpc7x8x55KkjK5CCTFbCaO98GcCBf76SDIlBJp1lENI1fFiLD1cpNGSc4gsbwdWMkwGUj/VXCZbV+IQRWMD4mOltIXDJFt9D5j2eIR3TWcdRnueoJCNQ8EFqoGsAffeC9hfWpckhNtwcJPIWosrFwCgSF9k0OzPhjmIiX9QGBDWxONUBZlU7cTJftSSToIsCccnYpH7QjiyL4e/nMJDCng5LwBum0ZhckuPWHjAy5LxyxQQ510TMM+UvAtvkG/x/TFB+S3GZ/93hxuMbQREXgna6dnGiP/nalf/cZLPtDh7D1QB9N70itnFvtXk2Wfe0Qqe3czRxssz047Cu3UrGMSStxvHcTsgINKVVMnfGuoh4hSwmvvpnFvnnpRAJL7eqC+yRbJ1D5PPzwGS+iiqWvT5yFJzT7gxUl0MbueMeq1ZoQkjt6Zat9hnoB6N9Dv2M0LrbZdy6btX11ZEhtfpN4e+zjncuf0dTHpGyRN1llT0wwUNpPbbHH1L1ndTj7lECSTdkqbEtpVYRG/IfmwVe2BMDT5Dk06hcb7vMRetcjzpFyXT+GSUbh0dwiX95QuMKpqAwLk87x4GkpJTGuH+kgxB4e5KuB/KRpn8QiBgW++9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39830400003)(366004)(6916009)(186003)(6506007)(53546011)(71200400001)(33656002)(83380400001)(7696005)(2906002)(54906003)(26005)(55016002)(316002)(478600001)(9686003)(5660300002)(66556008)(66946007)(8676002)(66476007)(52536014)(76116006)(8936002)(64756008)(66446008)(86362001)(38100700002)(122000001)(4326008)(91956017)(966005)(66574015);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?0k5a3FHV0vCpK3oowOoFvTpxrCUeuSTzG9fQU0Wg1PSQImad/kTHssHAIK?=
 =?iso-8859-1?Q?ykMnph2dL+ymxULnKcLqnFd+y1GY5hZ6DQzUI+C/AF+6NtzeAM3PZsQnNh?=
 =?iso-8859-1?Q?j89tJdP8YX1RpdljldbNZymwqC2kCZEW3JtCd2I0zaQyWA+vYgDx3Eq6s4?=
 =?iso-8859-1?Q?7UXfvOGl5HYT6Z1j0rOtSZQCD/+C0m5sfCy/1iwqtVgS1JBHw1RycLuDen?=
 =?iso-8859-1?Q?yJ1sWWR2UkclFNEJYeK1DU5NHvq90jUEpXNhFp1qVEgj9Bf56uEX6yvxb0?=
 =?iso-8859-1?Q?ND+nr2bkmkllDSfvJoE/VaYlKlg0fn3esAQr4MYtqUJ340NOC2qOPT6x6q?=
 =?iso-8859-1?Q?s22NTrlmI9Qf0KkLGDlE5eFKC/DrBizGELpVah+Y/Tb0SopmiEtQ7LjGhq?=
 =?iso-8859-1?Q?ljoINxEjBjRMETct+RMqVr17obFnsAnSwxOzDvjvModyYRx5ohOBYGJIn8?=
 =?iso-8859-1?Q?3KM0GxazkZr++muQFPGthsMUSM1BpXhipGCnokmJ31gHBUuPYKwJ7RH4yx?=
 =?iso-8859-1?Q?a/G2zLq4C7O/VFZvLj48lvZOrFoqwwWYDwIVFoZNNE+cHeptQbpLwcHiNo?=
 =?iso-8859-1?Q?vXpi/ZBX9VHA5dszrmlmuzY8l1hFp7fyGUWvjxEAurGvEROusGq3UwWRV+?=
 =?iso-8859-1?Q?i9jHtoO4GlbT+BY001ITfDFJmXdcbUo8q1DmueAhtg4oxjV5T0vir69tRK?=
 =?iso-8859-1?Q?p5oguDoLPbysByta8xwq+Dxde7q48FqF37CzxHh5sPjtLCyVVPK/smxdDm?=
 =?iso-8859-1?Q?aMMCjAjU4toDYdRSJpwCwds1VTwD2WqETT8wAGueps54m/jRuvqChpoogJ?=
 =?iso-8859-1?Q?6yZOZaAJ/AGSO2YTuLbbPRihfJ0OnM0HAuupMxUKaFXVDvTBdVo97Vw9r0?=
 =?iso-8859-1?Q?ILtlNGMfvY/bkoT4jb8JSSmjOW3DjFKsMeQ3VQa8CysnyTO3LJY57IfPAt?=
 =?iso-8859-1?Q?cQp1ccO8XqYzgT8p3ksBRThdMReJgJ923DEr2kTakEKdQvwhj4r3Fv0Uba?=
 =?iso-8859-1?Q?JtInmw116QcpZzNfHnmNRedh8CNExce1mQe2R3kn76dgqdqfhdVOvxqAHy?=
 =?iso-8859-1?Q?ywJEGxX9suJqltY/lKihs1CDnAznGb4OQnAirrWd+KWtymbDySBgtrrqwp?=
 =?iso-8859-1?Q?03l5m9S95/QBosOlrYFKiEKhm9TfLmlZ3rKWizTPvauovW0s0wsynNCF86?=
 =?iso-8859-1?Q?Z2LuK3dpDfHX5kfXK96pllHL7aw1ecGz8PiiP6soWhEtj0cUfF2/FzOIBb?=
 =?iso-8859-1?Q?glbHojE1D6RDklK5N/qA1TqrF4YbfONPABZha3p4xs2Rz4aLvFotS+segh?=
 =?iso-8859-1?Q?J57Q3mkHujm9NZVySZdyYvFem22YR5ml+Pu3Yslk02F6iDI=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b248aa62-fe20-446b-f965-08d91069c9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 08:34:39.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EJYJJ7s42/Exx3RH9vhRLdssm1OKFyvkK/MuUNGlDJyZAKzUHueS9+d47PnFTpLFtevGnNBr9mgZf4JcvOS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1636
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

Well I am definitely for keeping this bug as a feature
and utilizing UHS with this patch ;)
I have tried all SDSC cards I could get my hands on and
have not seen any 'accidentally' reporting UHS support.

I tested the patch with own custom cards.
(Hyperstone, my employer, develops controllers for flash
storage.)

There you would have to make the same choice, disabling
UHS support reporting for all SDSC cards, but as some
hosts accept UHS (including voltage switch) without checking
CCS, this would throttle performance.
(One such host is e.g.
8564:4000 Transcend Information, Inc. microSD/SD/CF UHS-II Card Reader)

It would be nice to have this in linux-mmc as arguably the most
important SD native host.
I'm sure the other manufacturers either do not disable UHS
support for SDSC cards, or have at least been playing with the idea.

Regards,
Christian

From: Ulf Hansson <ulf.hansson@linaro.org>
Sent: Wednesday, May 5, 2021 4:20 PM
To: Christian Löhle <CLoehle@hyperstone.com>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>; pali@kernel.org <pali@kernel.org>; huyue2@yulong.com <huyue2@yulong.com>; tiantao6@hisilicon.com <tiantao6@hisilicon.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported 
 
On Wed, 5 May 2021 at 14:13, Christian Löhle <CLoehle@hyperstone.com> wrote:
>
> So two cards that advertise UHS:
> https://www.euric.de/de/flash-speicher/sd-microsd/sd/
> Model SDI790
> and
> https://na.industrial.panasonic.com/products/storage-media/industrial-sd-cards/lineup/industrial-grade-2d-nand/series/71695

Thanks for the links!

Are these the ones that you have been using for testing?

> Hopefully that suffices as a couple, otherwise I would buy some
> that do not advertise it and actually check if they support it anyway.
> But 2GB SLC listings are kind of rare these days, so it's not as
> easy to find many that are still sold and available.

Right. I have a whole bunch of old SD cards that I can test. I will
let you know when I have got some time to test some of them.

The main worry (but I may be wrong) I have with the patch is that it
could cause problems for other older SDSC cards, which happens to
incorrectly set the S18A bit. I mean, before UHS-I was introduced in
the SD spec, this bit was just being reserved and potentially it could
have *any* value by the card manufacturer. As I said, let me do some
tests of my older SD cards.

>
> My point about deviating from the standard was that these cards
> are already initialized as UHS, they just don't do the voltage switch.
> So anything reserved for UHS-I (e.g. CMD23 )is already being done
> by the host with the current linux-mmc,
> so the standard deviation is already there.
> Just the voltage switch is missing.

Ah, yes you are right!

We call mmc_sd_init_uhs_card() no matter whether the CCS bit is set.
Certainly this is a bug. Both the card and host aren't designed to
work under these conditions/timings.

>
> Regards,
> Christian
>

Kind regards
Uffe

>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, May 5, 2021 12:09 PM
> To: Christian Löhle <CLoehle@hyperstone.com>
> Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
>
> On Thu, 22 Apr 2021 at 15:18, Christian Löhle <CLoehle@hyperstone.com> wrote:
> >
> > Ignore the reported capacity if the card otherwise reports UHS support.
> >
> > Currently SDSC cards reporting UHS support except for the CCS do not run
> > through the voltage switch.
> > While strictly speaking a SDSC card cannot support UHS in compliance
> > with the standard, there is no good reason to throttle them that way.
>
> Maybe not, but I think the code just tries to conform to the SD spec.
>
> > Especially for pSLCs in practice such cards benefit greatly by this patch,
> > as they can be new and UHS supporting, but must not lie about their CCS.
>
> Can you provide some concrete examples of SDSC cards that support UHS-I?
>
> > The behaviour of linux-mmc for SDSC is deviating from the standard anyway
> > in such a case, as the card is treated as UHS card not supporting the
> > voltage switch in general.
> > Such a card will come up as
> > mmc0: new ultra high speed SDR25 SD card at address 0001.
> > Thus the subsystem will support CMD23 and others to the card.
> > But if we deviate from the standard anyway, then we might as well
> > not throttle SDSC to 25MB/s.
>
> Not sure I understand this correctly? Can you elaborate a bit more, so
> I understand how we deviate from the SD spec here?
>
> As far as I understand the spec, SDSC cards shouldn't support UHS-I.
> If we decide to deviate from the spec to support this anyway, at least
> we need to know about a couple of cards that actually supports this.
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> > ---
> >  drivers/mmc/core/sd.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 6fa51a6ed058..281ca2da8e0b 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
> >                 return err;
> >
> >         /*
> > -        * In case CCS and S18A in the response is set, start Signal Voltage
> > -        * Switch procedure. SPI mode doesn't support CMD11.
> > +        * In case S18A in the response is set, start Signal Voltage Switch
> > +        * procedure. SPI mode doesn't support CMD11.
> >          */
> > -       if (!mmc_host_is_spi(host) && rocr &&
> > -          ((*rocr & 0x41000000) == 0x41000000)) {
> > +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
> >                 err = mmc_set_uhs_voltage(host, pocr);
> >                 if (err == -EAGAIN) {
> >                         retries--;
> > --
> > 2.31.1
> >
> > Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> > Managing Directors: Dr. Jan Peter Berns.
> > Commercial register of local courts: Freiburg HRB381782
> >
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

