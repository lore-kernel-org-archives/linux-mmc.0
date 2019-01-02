From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
Date: Wed, 2 Jan 2019 14:15:29 +0000
Message-ID: <CAK9iUCOce2x9NPGs9aryU8eqdWroPdjM0SP6LohhDjsCmdERAA@mail.gmail.com>
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
 <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
 <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
 <CAJZ5v0hw_=Odpok=6qWVWAfJ0wG7Z8NjwzMCpaFgxYnEAreKcg@mail.gmail.com> <21e732e8-84e4-72f9-4142-8e6af54f1346@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21e732e8-84e4-72f9-4142-8e6af54f1346@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, faiz_abbas@ti.com, chunyan.zhang@unisoc.com, Jisheng.Zhang@synaptics.com, ludovic.barre@st.com, Arnd Bergmann <arnd@arndb.de>, alex.smith@imgtec.com, chris.brandt@renesas.com, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 2, 2019 at 2:04 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 31/12/18 11:40 AM, Rafael J. Wysocki wrote:
> > On Sun, Dec 30, 2018 at 7:57 PM Sinan Kaya <Okaya@kernel.org> wrote:
> >>
> >> On Wed, Dec 26, 2018 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>
> >>> On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
> >>>>
> >>>> Select IOSF_MBI only when PCI is set.
> >>>>
> >>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> >>>> ---
> >>>>  drivers/mmc/host/Kconfig | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>>> index e26b8145efb3..4c5f037b246d 100644
> >>>> --- a/drivers/mmc/host/Kconfig
> >>>> +++ b/drivers/mmc/host/Kconfig
> >>>> @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
> >>>>  config MMC_SDHCI_ACPI
> >>>>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> >>>>         depends on MMC_SDHCI && ACPI
> >>>
> >>> It should depend on PCI as well, shouldn't it?
> >>>
> >>
> >> I don't think so. The PCI dependency is at IOSF_MBI code so code
> >> should select IOSF_MBI only when x86 and pci is defined as below.
> >>
> >> This driver does not depend on PCI.
> >
> > Are you sure?
> >
> > Do you know any systems in which to use it without PCI?
> >
>
> Qualcomm use it and I don't know if those systems have PCI.
> AMD use it but probably also have PCI.  And yes Intel systems (just BYT and
> CHT IIRC) that use this driver will always have PCI.

QCOM doesn't use PCI for SDHC.
