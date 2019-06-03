From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/3] Fix issues with phy configurations in am65x MMC driver
Date: Mon, 3 Jun 2019 15:48:14 +0200
Message-ID: <CAPDyKFr8LUqpdHGKDj2fK_XXHCSwJWS2=-G4EUhK3nqsDSeW+Q@mail.gmail.com>
References: <20190528095928.26452-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528095928.26452-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 28 May 2019 at 11:59, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following patches fix issues with phy configurations for
> sdhci_am654 driver.
>
> v3:
> Changed order of patches so that the first one can be applied easily to
> stable tree.
>
> v2:
> 1. Split patch 1 into 2 separate patches.
> 2. Improved patch descriptions.
>
> Faiz Abbas (3):
>   mmc: sdhci_am654: Fix SLOTTYPE write
>   mmc: sdhci_am654: Improve whitespace utilisation with regmap_*() calls
>   mmc: sdhci_am654: Print error message if the DLL fails to lock
>
>  drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>

Patch 1 applied for fixes and by adding a fixes tag. Patch 2+3 applied
for next, thanks!

Kind regards
Uffe
