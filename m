From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc: Support of PCI mode for the dw_mmc driver This
 Patch adds the support for the scenario where the Synopsys Designware IP is
 present on the PCI bus.The patch adds the minimal modifications necessary for
 the driver to work on PCI pl
Date: Thu, 29 Sep 2011 16:04:24 +0530
Message-ID: <CANYdXnrboFHapGYs=4fcj9BeiM7bxuLwp_OgiNz=VJb=ZzMxKA@mail.gmail.com>
References: <CAFbHwiQ1zKPUjXLinZukbgbz1wqFs9q93W6y_owLiTvn=i-=Bw@mail.gmail.com>
	<CANYdXnr+uHW5kq==tVkYAwY10qmZzxhWz-=bjbRJ3j10jjL+dA@mail.gmail.com>
	<CAFbHwiTXKM+69kQ1x5HfwCjoqLfZ+Eb5Lb1Vp7Um-3xXEekMcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35447 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab1I2KeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 06:34:25 -0400
Received: by iaqq3 with SMTP id q3so541927iaq.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 03:34:24 -0700 (PDT)
In-Reply-To: <CAFbHwiTXKM+69kQ1x5HfwCjoqLfZ+Eb5Lb1Vp7Um-3xXEekMcA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Will,James,
When I looked at few examples of the pci platform support in kernel,I
could find that they have used separate files for pci and platform.I
feel I may not split the driver into 3 files since its not as complex
as sdhci driver.So can I merge the ifdefs and have separate functions
itself for pci and non-pci platforms instead of having ifdef's in each
function ?

On Thu, Sep 29, 2011 at 2:54 PM, Will Newton <will.newton@gmail.com> wr=
ote:
>
> On Thu, Sep 29, 2011 at 5:49 AM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
> >>> + =C2=A0 =C2=A0 =C2=A0 .detect_delay_ms =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 200,
> >>> + =C2=A0 =C2=A0 =C2=A0 .fifo_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 32,
> >>> +};
> >>> +#endif
> >>> +
> >>> =C2=A0static struct workqueue_struct *dw_mci_card_workqueue;
> >>>
> >>> =C2=A0#if defined(CONFIG_DEBUG_FS)
> >>> @@ -682,6 +698,9 @@ static void dw_mci_set_ios(struct mmc_host *m=
mc, struct mmc_ios *ios)
> >>> =C2=A0{
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dw_mci_slot *slot =3D mmc_priv(=
mmc);
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 regs;
> >>> +#ifdef CONFIG_MMC_DW_PCI
> >>> + =C2=A0 =C2=A0 =C2=A0 u32 card_detect;
> >>> +#endif
> >>>
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set default 1 bit mode */
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0slot->ctype =3D SDMMC_CTYPE_1BIT;
> >>> @@ -716,7 +735,15 @@ static void dw_mci_set_ios(struct mmc_host *=
mmc, struct mmc_ios *ios)
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ios->power_mode) {
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0case MMC_POWER_UP:
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(DW=
_MMC_CARD_NEED_INIT, &slot->flags);
> >>> +#ifdef CONFIG_MMC_DW_PCI
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable Powe=
r to the card that has been detected */
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card_detect =3D=
 mci_readl(slot->host, CDETECT);
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slo=
t->host, PWREN, ((~card_detect) & 0x1));
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> >>> + =C2=A0 =C2=A0 =C2=A0 case MMC_POWER_OFF:
> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mci_writel(slo=
t->host, PWREN, 0);
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> >>> +#endif
> >>
> >> It may be safe to not #ifdef this, all the hardware I have uses an
> >> external regulator so the PWREN bits do nothing. I could imagine
> >> hardware that was non-PCI that could use PWREN however.
> > The hardware that I was using required this to be done .else there =
was
> > not power to the card.
>
> I think it is safe to remove the #ifdef from around this block though
> - for devices with external regulators setting PWREN does nothing so
> it should be safe to do it unconditionally.



--
regards,
Shashidhar Hiremath
