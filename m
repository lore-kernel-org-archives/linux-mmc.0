From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH v4] mmc: add Toshiba PCI SD controller driver
Date: Tue, 11 Nov 2014 12:30:30 +0100
Message-ID: <201411111230.30686.linux@rainbow-software.org>
References: <1415638712-18486-1-git-send-email-linux@rainbow-software.org> <CAPDyKFpUS6yG1Fq+dVFn_8AG7-_B-_moo2JCz4AQBKgvp-YaHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpUS6yG1Fq+dVFn_8AG7-_B-_moo2JCz4AQBKgvp-YaHQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 11 November 2014, Ulf Hansson wrote:
> On 10 November 2014 17:58, Ondrej Zary <linux@rainbow-software.org> w=
rote:
> > This patch resurrects an old never-finished driver for Toshiba PCI =
SD
> > controllers found in some older Toshiba laptops (such as Portege R1=
00):
> >
> > 02:0d.0 System peripheral [0880]: Toshiba America Info Systems SD T=
ypA
> > Controller [1179:0805] (rev 05)
> >
> > The code is fixed, cleaned up and successfully tested with SD, SDHC=
, SDXC
> > and MMC cards on Portege R100. (MMC cards don't even work in Window=
s!)
> > SDIO probably does not work (don't have any SDIO card).
> >
> > The hardware is slow (around 2 MB/s - same in Windows) because it d=
oes
> > not support bus mastering (busmaster enable bit cannot be set in PC=
I
> > control reg). Also the card clock is limited to 16MHz (33MHz PCI cl=
ock
> > divided by 2).
> >
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>
> Hi Ondrej,
>
> I get these compiler warning while building for x86. Can you please f=
ix
> them.
>
> ../drivers/mmc/host/toshsd.c: In function =E2=80=98toshsd_init=E2=80=99=
:
> ../drivers/mmc/host/toshsd.c:70:9: warning: large integer implicitly
> truncated to unsigned type [-Woverflow]
>          host->ioaddr + SD_INTMASKCARD);
>          ^

Which GCC version did you use? I get no warnings with 4.7.2 (Debian Sta=
ble).

--=20
Ondrej Zary
