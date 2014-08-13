From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: fix incorrect last byte in R2 response
Date: Wed, 13 Aug 2014 17:09:37 +0200
Message-ID: <CAPDyKFrTbiHxYgW5YCR48DKX8arxuxK3rz7k_H-waGEMiPFjSg@mail.gmail.com>
References: <1407745936-18513-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1407745936-18513-1-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger <rogerable@realtek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

On 11 August 2014 10:32,  <rogerable@realtek.com> wrote:
> From: Roger Tseng <rogerable@realtek.com>
>
> Current code erroneously fill the last byte of R2 response with an undefined
> value. In addition, it is impossible to obtain the real values since the
> controller actually 'offloads' the last byte(CRC7, end bit) while receiving R2
> response. This could cause mmc stack to obtain inconsistent CID from the same
> card after resume and misidentify it as a different card.
>
> Fix by assigning a dummy value 0x01 to the last byte of R2 response.
>
> Signed-off-by: Roger Tseng <rogerable@realtek.com>

Thanks! Queued for 3.18.

I guess this should go for stable as well?

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c |    1 +
>  drivers/mmc/host/rtsx_usb_sdmmc.c |    1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index dfde4a2..54849d8 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -412,6 +412,7 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
>         }
>
>         if (rsp_type == SD_RSP_TYPE_R2) {
> +               ptr[16] = 1;
>                 for (i = 0; i < 4; i++) {
>                         cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
>                         dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 5d3766e..ca08df1 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -435,6 +435,7 @@ static void sd_send_cmd_get_rsp(struct rtsx_usb_sdmmc *host,
>         }
>
>         if (rsp_type == SD_RSP_TYPE_R2) {
> +               ptr[16] = 1;
>                 for (i = 0; i < 4; i++) {
>                         cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
>                         dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",
> --
> 1.7.10.4
>
