From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH v2 1/2] mmc: rtsx: add R1-no-CRC mmc command type handle
Date: Mon, 28 Apr 2014 19:30:52 +0800
Message-ID: <535E3BEC.9040100@realsil.com.cn>
References: <cover.1395824147.git.micky_ching@realsil.com.cn>
 <afbc1328fb8a89fda3da23f1e9c755311450e1f6.1395824147.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <afbc1328fb8a89fda3da23f1e9c755311450e1f6.1395824147.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: chris@printf.net, sameo@linux.intel.com
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

Hi Chris and Ulf,

This patch should be applied to 3.15(rc), 3.14, 3.13.
without this patch the MMC card can not identified.

Best Regards.
micky.
On 03/27/2014 01:35 PM, micky_ching@realsil.com.cn wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> commit a27fbf2f067b0cd6f172c8b696b9a44c58bfaa7a
> <mmc: add ignorance case for CMD13 CRC error>
> produced a cmd.flags unhandled in realtek pci host driver.
> This will make MMC card failed initialize, this patch is
> used to handle the new cmd.flags condition and MMC card can be used.
>
> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> ---
>   drivers/mmc/host/rtsx_pci_sdmmc.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 5fb994f..0d8904a 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -346,6 +346,9 @@ static void sd_send_cmd(struct realtek_pci_sdmmc *host, struct mmc_command *cmd)
>   	case MMC_RSP_R1:
>   		rsp_type = SD_RSP_TYPE_R1;
>   		break;
> +	case MMC_RSP_R1 & ~MMC_RSP_CRC:
> +		rsp_type = SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
> +		break;
>   	case MMC_RSP_R1B:
>   		rsp_type = SD_RSP_TYPE_R1b;
>   		break;
