From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
Date: Wed, 26 Dec 2018 10:40:48 +0100
Message-ID: <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181223232521.11320-10-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, faiz_abbas@ti.com, chunyan.zhang@unisoc.com, Jisheng.Zhang@synaptics.com, ludovic.barre@st.com, Arnd Bergmann <arnd@arndb.de>, alex.smith@imgtec.com, chris.brandt@renesas.com, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Select IOSF_MBI only when PCI is set.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..4c5f037b246d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
>  config MMC_SDHCI_ACPI
>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>         depends on MMC_SDHCI && ACPI

It should depend on PCI as well, shouldn't it?

As it stands with the patch applied, randconfig can still select it if
PCI is unset AFAICS, can't it?

> -       select IOSF_MBI if X86
> +       select IOSF_MBI if (X86 && PCI)
>         help
>           This selects support for ACPI enumerated SDHCI controllers,
>           identified by ACPI Compatibility ID PNP0D40 or specific
> --
