From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/8] mmc: sdhci-pxav3: disable clock inversion for HS MMC
 cards
Date: Thu, 8 Oct 2015 19:35:52 +0200
Message-ID: <CAPDyKFrfQJbg9qJmethK2NEzi-crS1vstozYAFR5nRuyM0Hv_Q@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-3-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444094562-31165-3-git-send-email-mw@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, jaz@semihalf.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 6 October 2015 at 03:22, Marcin Wojtas <mw@semihalf.com> wrote:
> From: Nadav Haklai <nadavh@marvell.com>
>
> According to 'FE-2946959' erratum the clock inversion option is
> needed to support slow frequencies when the card input hold time
> requirement is high. This setting is not required for high speed
> MMC and might cause timing violation.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Cc: <stable@vger.kernel.org> # v4.2

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 976cddd..89a9e49 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -291,6 +291,9 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>                     uhs == MMC_TIMING_UHS_DDR50) {
>                         reg_val &= ~SDIO3_CONF_CLK_INV;
>                         reg_val |= SDIO3_CONF_SD_FB_CLK;
> +               } else if (uhs == MMC_TIMING_MMC_HS) {
> +                       reg_val &= ~SDIO3_CONF_CLK_INV;
> +                       reg_val &= ~SDIO3_CONF_SD_FB_CLK;
>                 } else {
>                         reg_val |= SDIO3_CONF_CLK_INV;
>                         reg_val &= ~SDIO3_CONF_SD_FB_CLK;
> --
> 1.8.3.1
>
