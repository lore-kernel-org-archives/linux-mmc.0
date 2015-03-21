From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 33/35 linux-next] mmc: constify of_device_id array
Date: Sat, 21 Mar 2015 21:09:05 +0100 (CET)
Message-ID: <1374583183.180918.1426968545752.open-xchange@webmail.nmp.proximus.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426535949-26107-1-git-send-email-fabf@skynet.be> <1426535949-26107-2-git-send-email-fabf@skynet.be> <CAPDyKFodW1zgrQ-sd5TPO_rCa_-tm95JkwCWiGX4BCUSFqPHdg@mail.gmail.com> <CAPDyKFoWoQhSat9vAfTGy_exdubcknySMPjoSXp5ox_YB+M6ZQ@mail.gmail.com>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailsec101.isp.belgacom.be ([195.238.20.97]:55127 "EHLO
	mailsec101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675AbbCUUJ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 21 Mar 2015 16:09:27 -0400
In-Reply-To: <CAPDyKFoWoQhSat9vAfTGy_exdubcknySMPjoSXp5ox_YB+M6ZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Tony Prisk <linux@prisktech.co.nz>



> On 20 March 2015 at 09:56 Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>
> On 17 March 2015 at 10:49, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> > On 16 March 2015 at 20:59, Fabian Frederick <fabf@skynet.be> wrote:
> >> of_device_id is always used as const.
> >> (See driver.of_match_table and open firmware functions)
> >>
> >> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> I realized that you might wanted me to pick this up and queue it
> through my mmc tree? Just tell me if that's what you want.
>
> Kind regards
> Uffe

Hi Ulf,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 Yes of course :) (it has not been added to =
linux-next yet).

Thanks,
=46abian
>
> >
> >> ---
> >>=C2=A0 drivers/mmc/host/mmc_spi.c=C2=A0 =C2=A0| 2 +-
> >>=C2=A0 drivers/mmc/host/wmt-sdmmc.c | 2 +-
> >>=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi=
=2Ec
> >> index e4a0754..ae19d83 100644
> >> --- a/drivers/mmc/host/mmc_spi.c
> >> +++ b/drivers/mmc/host/mmc_spi.c
> >> @@ -1507,7 +1507,7 @@ static int mmc_spi_remove(struct spi_device =
*spi)
> >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> >>=C2=A0 }
> >>
> >> -static struct of_device_id mmc_spi_of_match_table[] =3D {
> >> +static const struct of_device_id mmc_spi_of_match_table[] =3D {
> >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "mmc-spi-slot",=
 },
> >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{},
> >>=C2=A0 };
> >> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-s=
dmmc.c
> >> index dd2e1aa..5af0055 100644
> >> --- a/drivers/mmc/host/wmt-sdmmc.c
> >> +++ b/drivers/mmc/host/wmt-sdmmc.c
> >> @@ -744,7 +744,7 @@ static struct wmt_mci_caps wm8505_caps =3D {
> >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_blk_size =3D 2048,
> >>=C2=A0 };
> >>
> >> -static struct of_device_id wmt_mci_dt_ids[] =3D {
> >> +static const struct of_device_id wmt_mci_dt_ids[] =3D {
> >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "wm,wm8505-sdhc=
", .data =3D &wm8505_caps },
> >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ /* Sentinel */ },
> >>=C2=A0 };
> >> --
> >> 2.1.0
> >>
