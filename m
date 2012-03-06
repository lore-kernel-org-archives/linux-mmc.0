From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v1 1/1] mmc: core: hs200 fixes
Date: Tue, 6 Mar 2012 17:25:57 +0530
Message-ID: <000301ccfb90$194311b0$4bc93510$@codeaurora.org>
References: <1331018695-13150-1-git-send-email-subhashj@codeaurora.org> <CAGxe1ZFrUPWyYXQJgG6rjVmEA39c38U5gNQ1oSpaFV7dRQ+hfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:9177 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030402Ab2CFL4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 06:56:01 -0500
In-Reply-To: <CAGxe1ZFrUPWyYXQJgG6rjVmEA39c38U5gNQ1oSpaFV7dRQ+hfQ@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org

Hi Girish,

> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Girish K S
> Sent: Tuesday, March 06, 2012 3:30 PM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> cjb@laptop.org
> Subject: Re: [PATCH v1 1/1] mmc: core: hs200 fixes
>=20
> On 6 March 2012 12:54, Subhash Jadavani <subhashj@codeaurora.org>
> wrote:
> > This patch fixes following issues when HS200 is enabled:
> >
> > 1. If executing_tuning() host ops is called without
> > mmc_host_clk_hold(),
> > =A0 card clocks might get turned off (if MMC_CLK_GATING is enabled)
> > =A0 while execute_tuning() is in progress. So this patch makes sure
> > =A0 that execute_tuning() is called with mmc_host_clk_hold().
> >
> > 2. If host timing mode is set to HS200 mode, there should not be
> > =A0 any communication with the card until execute_tuning() is compl=
eted.
> > =A0 But there is a chance that CMD6 might be sent to enable set HPI=
_EN
> > =A0 (of HPI_MGMT field in EXT_CSD) before execute_tuning() is calle=
d.
> > =A0 So this patch moves this operation after execute_tuning() is
completed.
> >
> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > ---
> > =A0drivers/mmc/core/mmc.c | =A0 37 ++++++++++++++++++++------------=
-----
> > =A01 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > a480663..08574ae 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1030,22 +1030,6 @@ static int mmc_init_card(struct mmc_host *ho=
st,
> > u32 ocr,
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0/*
> > - =A0 =A0 =A0 =A0* Enable HPI feature (if supported)
> > - =A0 =A0 =A0 =A0*/
> > - =A0 =A0 =A0 if (card->ext_csd.hpi) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_=
SET_NORMAL,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_HPI_MGMT, 1, =
0);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enabl=
ing HPI failed\n",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(card->host));
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =
=3D 1;
> > - =A0 =A0 =A0 }
> > -
> > - =A0 =A0 =A0 /*
> > =A0 =A0 =A0 =A0 * Compute bus speed.
> > =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0max_dtr =3D (unsigned int)-1;
> > @@ -1094,9 +1078,12 @@ static int mmc_init_card(struct mmc_host *ho=
st,
> > u32 ocr,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 4. execute tuning for HS200
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((host->caps2 & MMC_CAP2_HS200) &=
&
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tuni=
ng)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tuni=
ng) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_hold(car=
d->host);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D
> > card->host->ops->execute_tuning(card->host,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_=
SEND_TUNING_BLOCK_HS200);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_release(=
card->host);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: tuni=
ng execution failed\n",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mmc_hostname(card->host)); @@
> > -1216,6 +1203,22 @@ static int mmc_init_card(struct mmc_host *host,
> > u32 ocr,
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0/*
> > + =A0 =A0 =A0 =A0* Enable HPI feature (if supported)
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (card->ext_csd.hpi) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_=
SET_NORMAL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_HPI_MGMT, 1, =
0);

> i think timeout value should be generic timeout value. Rest all looks
fine.

This is not introduced in this patch as I just moved this mmc_switch() =
as it
is. Do you still want me to fix this timeout value as part of this patc=
h?

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enabl=
ing HPI failed\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(card->host));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =
=3D 1;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > =A0 =A0 =A0 =A0 * If cache size is higher than 0, this indicates
> > =A0 =A0 =A0 =A0 * the existence of cache and it can be turned on.
> > =A0 =A0 =A0 =A0 */
> > --
> > 1.7.1.1
> >
> > --
> > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-m=
sm"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

