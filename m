From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: implement Driver Stage Register handling
Date: Thu, 14 Aug 2014 12:29:04 +0200
Message-ID: <CAPDyKFrbx1BdE6Fw1iDz9Z_Gn7WJe=B6F-4DG==uEDxPWPP5Jw@mail.gmail.com>
References: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<CAPDyKFqKVvwFi+JoOG-O1jznOB1UyhQW_ovb_N=+G_FtoqXQXA@mail.gmail.com>
	<20140814094950.GX5134@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:53678 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291AbaHNK3F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 06:29:05 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so829937qga.36
        for <linux-mmc@vger.kernel.org>; Thu, 14 Aug 2014 03:29:04 -0700 (PDT)
In-Reply-To: <20140814094950.GX5134@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Niebel <Markus.Niebel@tq-group.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

On 14 August 2014 11:49, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Ulf,
>
> On Thu, Aug 14, 2014 at 11:26:28AM +0200, Ulf Hansson wrote:
>> On 13 August 2014 17:44, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > From: Sascha Hauer <s.hauer@pengutronix.de>
>> >
>> > Some (e)MMC and SD cards implement a DSR register that allows to t=
une
>> > raise/fall times and drive strength of the CMD and DATA outputs.
>> > The values to use depend on the card in use and the host.
>> > It might be needed to reduce the drive strength to prevent voltage=
 peaks
>> > above the host's specification.
>> >
>> > Implement a 'dsr' devicetree property that allows to specify the v=
alue
>> > to set the DSR to. For non-dt setups the new members of mmc_host c=
an be
>> > set by board code.
>> >
>> > This patch was initially authored by Sascha Hauer. It contains
>> > improvements authored by Markus Niebel and Uwe Kleine-K=C3=B6nig.
>> >
>> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> > Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
>> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.=
de>
>> > ---
>> > Hello,
>> >
>> > earlier incarnations of this patch can be found at
>> >
>> >         http://lists.infradead.org/pipermail/linux-arm-kernel/2014=
-July/272983.html
>> >         http://lists.infradead.org/pipermail/linux-arm-kernel/2014=
-May/259281.html
>> >
>> > I need this functionallity on a machine where the default driver s=
trength of
>> > the eMMC chip is too big for the SoC. It seems to work without ada=
pting the
>> > drive strength, but the vendor reports that the DSR should be set =
to a certain
>> > value to prevent poor signal integrity and increased wearout.
>> >
>> > Best regards
>> > Uwe
>> >
>> >  Documentation/devicetree/bindings/mmc/mmc.txt |  2 ++
>> >  drivers/mmc/core/host.c                       |  8 ++++++++
>> >  drivers/mmc/core/mmc.c                        |  8 ++++++++
>> >  drivers/mmc/core/mmc_ops.c                    | 21 ++++++++++++++=
+++++++
>> >  drivers/mmc/core/mmc_ops.h                    |  1 +
>> >  drivers/mmc/core/sd.c                         |  8 ++++++++
>> >  include/linux/mmc/card.h                      |  3 ++-
>> >  include/linux/mmc/host.h                      |  3 +++
>> >  8 files changed, 53 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Docum=
entation/devicetree/bindings/mmc/mmc.txt
>> > index 3c18001dfd5d..05bac770b4d0 100644
>> > --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> > +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> > @@ -40,6 +40,8 @@ Optional properties:
>> >  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>> >  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
>> >  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
>> > +- dsr: Value the card's (optional) Driver Stage Register (DSR) sh=
ould be
>> > +  programmed with.
>>
>> Let's clarify that this is a 16 bit value.
> ok.
>
>> >  *NOTE* on CD and WP polarity. To use common for all SD/MMC host c=
ontrollers line
>> >  polarity properties, we have to fix the meaning of the "normal" a=
nd "inverted"
>> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> > index 95cceae96944..52e83f389428 100644
>> > --- a/drivers/mmc/core/host.c
>> > +++ b/drivers/mmc/core/host.c
>> > @@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
>> >         if (of_find_property(np, "mmc-hs400-1_2v", &len))
>> >                 host->caps2 |=3D MMC_CAP2_HS400_1_2V | MMC_CAP2_HS=
200_1_2V_SDR;
>> >
>> > +       if (of_find_property(np, "dsr", &len)) {
>> > +               u32 tmp;
>> > +
>> > +               of_property_read_u32(np, "dsr", &tmp);
>> > +               host->dsr_req =3D 1;
>> > +               host->dsr =3D (u16)tmp;
>> > +       }
>> > +
>>
>> Let's simplify the above with just:
>> of_property_read_u16(np, "dsr", &host->dsr);
> ok.
>
>> >         return 0;
>> >
>> >  out:
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 793c6f7ddb04..fdc1ac1360c4 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -162,6 +162,7 @@ static int mmc_decode_csd(struct mmc_card *car=
d)
>> >         csd->read_partial =3D UNSTUFF_BITS(resp, 79, 1);
>> >         csd->write_misalign =3D UNSTUFF_BITS(resp, 78, 1);
>> >         csd->read_misalign =3D UNSTUFF_BITS(resp, 77, 1);
>> > +       csd->dsr_imp =3D UNSTUFF_BITS(resp, 76, 1);
>> >         csd->r2w_factor =3D UNSTUFF_BITS(resp, 26, 3);
>> >         csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
>> >         csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
>> > @@ -1273,6 +1274,13 @@ static int mmc_init_card(struct mmc_host *h=
ost, u32 ocr,
>> >         }
>> >
>> >         /*
>> > +        * handling only for cards supporting DSR and hosts reques=
ting
>> > +        * DSR configuration
>> > +        */
>> > +       if (card->csd.dsr_imp && host->dsr_req)
>>
>> We don't need host->dsr_req. Instead just check host->dsr.
> I think this doesn't work. What is your actual suggestion?
>
>         if (card->csd.dsr_imp && host->dsr)
>
> ? The intended semantic is that if the device tree has:
>
>         dsr =3D <$somevalue>;
>
> the DSR is written, and if there is no such property, DSR is unhandle=
d.
> If you just check for host->dsr being !=3D 0, how to differenciate be=
tween
>
>         dsr =3D <0>;

I didn't think that was a valid mask? If so, you right!

Kind regards
Uffe
