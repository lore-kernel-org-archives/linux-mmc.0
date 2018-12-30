From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
Date: Sun, 30 Dec 2018 21:56:53 +0300
Message-ID: <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
 <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, faiz_abbas@ti.com, chunyan.zhang@unisoc.com, Jisheng.Zhang@synaptics.com, ludovic.barre@st.com, Arnd Bergmann <arnd@arndb.de>, alex.smith@imgtec.com, chris.brandt@renesas.com, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 26, 2018 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Select IOSF_MBI only when PCI is set.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index e26b8145efb3..4c5f037b246d 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
> >  config MMC_SDHCI_ACPI
> >         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> >         depends on MMC_SDHCI && ACPI
>
> It should depend on PCI as well, shouldn't it?
>

I don't think so. The PCI dependency is at IOSF_MBI code so code
should select IOSF_MBI only when x86 and pci is defined as below.

This driver does not depend on PCI.

> As it stands with the patch applied, randconfig can still select it if
> PCI is unset AFAICS, can't it?

True, we also should be careful about separating ACPI from PCI.
Someone should be able to define a sdhci acpi object without PCI.

What do you think about this?

>
> > -       select IOSF_MBI if X86
> > +       select IOSF_MBI if (X86 && PCI)
> >         help
> >           This selects support for ACPI enumerated SDHCI controllers,
> >           identified by ACPI Compatibility ID PNP0D40 or specific
> > --
