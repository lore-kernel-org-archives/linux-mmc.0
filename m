Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD218FDCE
	for <linux-mmc@vger.kernel.org>; Fri, 15 Nov 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669410; cv=none; b=d/lwp7W6fHqIUrDdxsmHk5QVgQw0bjNxi7GpsOFTUTYpIoJhSuyZsVNrYpOgdTVYqA2Jf0bXIcMnBxTHZ8MhFeb2VxIohmj+BF0FKDBEoOItw/HmHIxQP8tV+QTpiGQd4rLSmVvN86A7OpgJrSjYvFN6+x2VvqIV22es0YtOqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669410; c=relaxed/simple;
	bh=SwWzIqldCLaysihUO6019zuqKB9GTObOeQD3K0AbwUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXg9FXQsK9tDOsQxqDf9RNKG1i/k1QQppNZz0KBLtXt97xIWZak0bi2t8oh3cavv5sD4bYGXQvYuTioiN3cCEXY24WYUi5ip7pQXxy8BG/pUsxUQeB0JqMijx1Iyonn592/urafntzpfbF6K/fYcQ1pjjgPZF3vw5nCBj6D5pAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T5cDAWm6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5cDAWm6"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so2751821a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Nov 2024 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731669405; x=1732274205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBW55Iflwg72JTtlsIBIwR/vdMLxSGAsNhfY6KX5Wg0=;
        b=T5cDAWm6WsSHfBmsCj5zTaVQswIpNbSgZRGzFD+/9ezO1mQ1L7ignVe76d/yGlOb2O
         eK8P6lZtdFtcdGX4+Mlfv+jeu1U4kzy2IfNxnW8kzrAIDvqlG+FxFwkzz8SuCUlhVeu6
         c1aZ7z3iWY/UhzOzxYR5MYH029OsrFP/NjET66ks1tTx6NvSEoQGtjKLyQY9W8QkFML2
         4T+ueuVsFB3lKVJzk8CFdIGT8Rur/rQTjQAKjEAykVoOcMoCX5m+b7q9gGS8WlFLVhde
         IzZILsHmWMhiBU3pqfHJrzximviOq+4FLfDieutw133/VGZNAFHzGqC0j8+duZXIxeRD
         LIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731669405; x=1732274205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBW55Iflwg72JTtlsIBIwR/vdMLxSGAsNhfY6KX5Wg0=;
        b=gaShad+zvDfrh2I0NS6Nitmy9n6G67TA2folHEK5jLiDfddmaxVmb7hAAxSQgFQosa
         3bXDwxM3bxi3L1neinv9aaaNxRkqZqiptHjwlrlzEJTON77ZcepFPNjRHR2+GquZ/kQt
         7a/PSrFphezfHeMvlzLCuxJjHbbT9oq1IKC3a5dGhuTUe7d5pBpo584IDuxpHbmxi6jO
         p1YMHTQKbBe19lXwpOFM9IDHTrkFjuR3afjgqxD10ThOR7inzxJkVdQPV6Em4RyybQHP
         CgvlcbRrAsFTMMfpr7ChpaSUwCC6QaUwcXW/l/lO0kX+jsons8WtYwKtZOgaZzWsRe4p
         M9gg==
X-Forwarded-Encrypted: i=1; AJvYcCXsyMUjRlm4BotfjuI+aDAugOWSoLDOe3C1VnT6FzAnyIgtO+6Y0i0FrrXmo786uH4km/AwAVNu1Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsM/ZVxRIcqOZ2d+SQDlOiCMnyrwwXrkSqVF/z+O6Om2r1Ea9t
	i+CU8qmsmgmZEzEAqt0A6182hrArltVeA3ug3GjjG2aOhxm13kKT7tEWzG9cDuU593LlipylfM6
	xTAWrmPR/72cER/8lMXGuQpBkSkLesby/rveXjQ==
X-Google-Smtp-Source: AGHT+IGzAOeKh4aP0KrLyOScFsmFGloYqJ/oDkwXDhcYrHFK/Kj8IziJlvm2MOwc0x4hjYK43W0DfP4fzd+Fg3r6HYE=
X-Received: by 2002:a17:906:d54b:b0:a9a:1b32:5aa8 with SMTP id
 a640c23a62f3a-aa4833e8bc9mr182565966b.4.1731669405427; Fri, 15 Nov 2024
 03:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014060130.1162629-1-haibo.chen@nxp.com> <20241014060130.1162629-3-haibo.chen@nxp.com>
 <CAPDyKFr37wLYxdFJ-Lgbq7PbWyiQz+CuwMxwgeeP3QpMvdyjqg@mail.gmail.com>
 <DU0PR04MB949604108991809742E83E5D90402@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <DU0PR04MB9496801A4571142F914BBF4990402@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <CAPDyKFpectKosHEU7cm7uNCNwHZaT0XCSn674dGtu8Y+hmf_Pw@mail.gmail.com> <DU0PR04MB9496E6ED8D3D6EB1FD26B450905C2@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9496E6ED8D3D6EB1FD26B450905C2@DU0PR04MB9496.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Nov 2024 12:16:08 +0100
Message-ID: <CAPDyKFp_YmAc-f5vcju+Zg39OKzo1GYgefTgQriazumjk+5gVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the system PM logic
To: Bough Chen <haibo.chen@nxp.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-S32 <S32@nxp.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 at 10:20, Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: 2024=E5=B9=B410=E6=9C=8822=E6=97=A5 16:29
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; imx@lists.linux=
.dev;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-S32 <S32@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the syste=
m PM
> > logic
> >
> > On Fri, 18 Oct 2024 at 05:20, Bough Chen <haibo.chen@nxp.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Bough Chen
> > > > Sent: 2024=E5=B9=B410=E6=9C=8818=E6=97=A5 9:23
> > > > To: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org;
> > > > imx@lists.linux.dev; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > kernel@pengutronix.de; festevam@gmail.com; dl-S32 <S32@nxp.com>;
> > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: RE: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the
> > > > system PM logic
> > > >
> > > > > -----Original Message-----
> > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Sent: 2024=E5=B9=B410=E6=9C=8817=E6=97=A5 21:07
> > > > > To: Bough Chen <haibo.chen@nxp.com>
> > > > > Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org;
> > > > > imx@lists.linux.dev; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > > kernel@pengutronix.de; festevam@gmail.com; dl-S32 <S32@nxp.com>;
> > > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.or=
g
> > > > > Subject: Re: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the
> > > > > system PM logic
> > > > >
> > > > > On Mon, 14 Oct 2024 at 08:00, <haibo.chen@nxp.com> wrote:
> > > > > >
> > > > > > From: Haibo Chen <haibo.chen@nxp.com>
> > > > > >
> > > > > > Current suspend/resume logic has one issue. in suspend, will
> > > > > > config register when call sdhci_suspend_host(), but at this
> > > > > > time, can't guarantee host in runtime resume state. if not, the
> > > > > > per clock is gate off, access register will hung.
> > > > > >
> > > > > > Now use pm_runtime_force_suspend/resume() in
> > > > NOIRQ_SYSTEM_SLEEP_PM,
> > > > > > add in NOIRQ stage can cover SDIO wakeup feature, because in
> > > > > > interrupt handler, there is register access, need the per clock=
 on.
> > > > > >
> > > > > > In sdhci_esdhc_suspend/sdhci_esdhc_resume, remove
> > > > > > sdhci_suspend_host() and sdhci_resume_host(), all are handled i=
n
> > > > > > runtime PM callbacks except the wakeup irq setting.
> > > > > >
> > > > > > Remove pinctrl_pm_select_default_state() in sdhci_esdhc_resume,
> > > > > > because
> > > > > > pm_runtime_force_resume() already config the pinctrl state
> > > > > > according to ios timing, and here config the default pinctrl
> > > > > > state again is wrong for
> > > > > > SDIO3.0 device if it keep power in suspend.
> > > > >
> > > > > I had a look at the code - and yes, there are certainly several
> > > > > problems with PM support in this driver.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > > > > ---
> > > > > >  drivers/mmc/host/sdhci-esdhc-imx.c | 39
> > > > > > +++++++++++++++---------------
> > > > > >  1 file changed, 19 insertions(+), 20 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > > > index c7582ad45123..18febfeb60cf 100644
> > > > > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > > > > @@ -1871,11 +1871,13 @@ static int sdhci_esdhc_suspend(struct
> > > > > > device
> > > > > *dev)
> > > > > >         struct pltfm_imx_data *imx_data =3D
> > sdhci_pltfm_priv(pltfm_host);
> > > > > >         int ret;
> > > > > >
> > > > > > -       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > > > > > -               ret =3D cqhci_suspend(host->mmc);
> > > > > > -               if (ret)
> > > > > > -                       return ret;
> > > > > > -       }
> > > > > > +       /*
> > > > > > +        * Switch to runtime resume for two reasons:
> > > > > > +        * 1, there is register access, so need to make sure
> > > > > > + gate on ipg
> > > > clock.
> > > > >
> > > > > You are right that we need to call pm_runtime_get_sync() for this=
 reason.
> > > > >
> > > > > However, the real question is rather; Under what circumstances do
> > > > > we really need to make a register access beyond this point?
> > > > >
> > > > > If the device is already runtime suspended, I am sure we could
> > > > > just leave it in that state without having to touch any of its re=
gisters.
> > > > >
> > > > > As I understand it, there are mainly two reasons why the device
> > > > > may be runtime resumed at this point:
> > > > > *) The runtime PM usage count has been bumped in
> > > > > sdhci_enable_sdio_irq(), since the SDIO irqs are enabled and it's
> > > > > likely that we will configure them for system wakeup too.
> > > > > *) The device has been used, but nothing really prevents it from
> > > > > being put into a low power state via the ->runtime_suspend() call=
back.
> > > > >
> > > > > > +        * 2, make sure the pm_runtime_force_suspend() in NOIRQ
> > > > > > + stage
> > > > > really
> > > > > > +        *    invoke its ->runtime_suspend callback.
> > > > > > +        */
> > > > >
> > > > > Rather than using the *noirq-callbacks, we should be able to call
> > > > > pm_runtime_force_suspend() from sdhci_esdhc_suspend(). And vice
> > > > > versa for sdhci_esdhc_resume().
> > > > >
> > > > > Although, according to my earlier comment above, we also need to
> > > > > take into account the SDIO irq. If it's being enabled for system
> > > > > wakeup, we must not put the controller into low power mode by
> > > > > calling pm_runtime_force_suspend(), otherwise we will not be able
> > > > > to deliver the
> > > > wakeup, right?
> > > >
> > > > Thanks for your careful review!
> > > > Yes, I agree.
> > >
> > > Hi Ulf,
> > >
> > > Sorry, I maybe give the wrong answer.
> > >
> > > I double check the IP, usdhc can support sdio irq wakeup even when us=
dhc
> > clock gate off.
> >
> > Okay, so there is some out-band logic that can manage the SDIO irq, eve=
n when
> > the controller has been runtime suspended?
>
> Hi Ulf,
>
> Sorry for the late reply.
>
> Seems not out-band logic, refer to SD Host Controller Standard Specificat=
ion Version 3.00, 2.2.13 Wakeup Control Register (Offset 02Bh), P45
> Or refer to static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)=
 in sdhci.c

Right, those handle the in-band wakups.

If the platform doesn't support some out-band logic to deliver wakups,
we simply need to keep the controller always powered on, when SDIO
irqs are enabled.

In other words, call a pm_runtime_get_noresume() when SDIO irq gets
enabled and pm_runtime_put_noidle() when they become disabled.

>
> >
> > In these cases, we use dev_pm_set_dedicated_wake_irq* to manage that
> > wake-irq. There are other mmc host drivers that implement support for t=
his too.
> >
> > If you are referring to solely clock gating, that is not going to work.=
 A runtime
> > suspended controller is not supposed to deliver in-band irqs.
>
> In sdhci_irq(), it will check host->runtime_suspended, if in runtime susp=
end state, directly return. But for SDIO wakeup irq, here will meet irq sto=
rm, because no place to clear the interrupt status register.
> This is why I involve noirq pm, force runtime resume before system handle=
 sdio wakeup irq.

That check is indeed to prevent us from accessing the controller when
there are spurious irqs.

Again, if there is no out-band logic you must keep the controller
runtime resumed, when SDIO irqs are enabled.

>
> Or to support in-band SDIO wakeup, add some changes in common sdhic.c, ju=
st like following, which do you prefer? Or any thought?
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0b46b50aa28b..8928af3e62d3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3532,7 +3532,10 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id=
)
>         spin_lock(&host->lock);
>
>         if (host->runtime_suspended) {
> +               disable_irq_nosync(host->irq);
> +               host->wakeup_pending =3D true;

No, this isn't the way to fix it. See above.

>                 spin_unlock(&host->lock);
>                 return IRQ_NONE;
>         }
>
> @@ -3878,6 +3881,10 @@ int sdhci_runtime_resume_host(struct sdhci_host *h=
ost, int soft_reset)
>         spin_lock_irqsave(&host->lock, flags);
>
>         host->runtime_suspended =3D false;
> +       if (host->wakeup_pending) {
> +               host->wakeup_pending =3D false;
> +               enable_irq(host->irq);
> +       }
>
>         /* Enable SDIO IRQ */
>         if (sdio_irq_claimed(mmc))
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e62f483ff3b8..ce6f750cc4dc 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -536,6 +536,7 @@ struct sdhci_host {
>         bool reinit_uhs;        /* Force UHS-related re-initialization */
>
>         bool runtime_suspended; /* Host is runtime suspended */
> +       bool wakeup_pending;
>         bool bus_on;            /* Bus power prevents runtime suspend */
>         bool preset_enabled;    /* Preset is enabled */
>         bool pending_reset;     /* Cmd/data reset is pending
>
>
> Best Regards
> Haibo Chen
> >
> > > So to save power, need to call pm_runtime_force_suspend() to gate off=
 the
> > clock when enable sdio irq for system wakeup.
> > > This is the main reason I involve pm_runtime_force_suspend in noirq s=
tage,
> > because in sdhci_irq, there is register access, need gate on clock.
> >
> > In summary, to support the out-band irq as a wakeup for runtime and sys=
tem
> > suspend, dev_pm_set_dedicated_wake_irq* should be used.
> >
> > To move things forward, I suggest you start simple and add support for =
the
> > out-band irq as a step on top.
> >
> > [...]

Kind regards
Uffe
