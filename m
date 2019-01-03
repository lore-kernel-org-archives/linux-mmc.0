From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v5 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Date: Thu, 3 Jan 2019 14:57:40 +0000
Message-ID: <CAK9iUCOSP+UMW0q0jW_SBgF-5sE-YtYEOaVwON6ndwHeOM7VBQ@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-10-okaya@kernel.org>
 <b52d51a4-3310-7873-db3d-bf5d0dffb7f8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b52d51a4-3310-7873-db3d-bf5d0dffb7f8@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Faiz Abbas <faiz_abbas@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Ludovic Barre <ludovic.barre@st.com>, Arnd Bergmann <arnd@arndb.de>, Alex Smith <alex.smith@imgtec.com>, Chris Brandt <chris.brandt@renesas.com>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 3, 2019 at 2:50 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 2/01/19 8:10 PM, Sinan Kaya wrote:
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
> > on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>
> This driver does not rely on IOSF_MBI
>

X86 version does.

select IOSF_MBI if X86


> You wrote on the other email QCOM doesn't use PCI but here you are making
> them depend on it.  Please explain.
>

I matched the behavior before my change. This code wouldn't be
available without PCI and ACPI on previous kernel versions and left
kconfig cleanup as another exercise for some other day.

> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index e26b8145efb3..1b9401fe94c0 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -116,7 +116,7 @@ config MMC_RICOH_MMC
> >
> >  config MMC_SDHCI_ACPI
> >       tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> > -     depends on MMC_SDHCI && ACPI
> > +     depends on MMC_SDHCI && ACPI && PCI
> >       select IOSF_MBI if X86
> >       help
> >         This selects support for ACPI enumerated SDHCI controllers,
> >
>
