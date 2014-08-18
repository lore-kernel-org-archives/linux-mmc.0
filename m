From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: rtsx_usb_sdmmc: fix incorrect last byte in R2
 response
Date: Mon, 18 Aug 2014 11:33:36 +0200
Message-ID: <CAPDyKFpwu_Zas+oBRnrsTzYoNYzn1mrWyBJ_LepgP+US-55h5Q@mail.gmail.com>
References: <1408082761-15333-1-git-send-email-rogerable@realtek.com>
 <1408082761-15333-3-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1408082761-15333-3-git-send-email-rogerable@realtek.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 15 August 2014 08:06,  <rogerable@realtek.com> wrote:
> From: Roger Tseng <rogerable@realtek.com>
>
> Current code erroneously fill the last byte of R2 response with an undefined
> value. In addition, the controller actually 'offloads' the last byte
> (CRC7, end bit) while receiving R2 response and thus it's impossible to get the
> actual value. This could cause mmc stack to obtain inconsistent CID from the
> same card after resume and misidentify it as a different card.
>
> Fix by assigning dummy CRC and end bit: {7'b0, 1} = 0x1 to the last byte of R2.
>
> Cc: <stable@vger.kernel.org> # v3.16+
> Fixes: c7f6558d84af ("mmc: Add realtek USB sdmmc host driver")
> Signed-off-by: Roger Tseng <rogerable@realtek.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 5d3766e792f0..d9153a7d160d 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -435,6 +435,13 @@ static void sd_send_cmd_get_rsp(struct rtsx_usb_sdmmc *host,
>         }
>
>         if (rsp_type == SD_RSP_TYPE_R2) {
> +               /*
> +                * The controller offloads the last byte {CRC-7, end bit 1'b1}
> +                * of response type R2. Assign dummy CRC, 0, and end bit to the
> +                * byte(ptr[16], goes into the LSB of resp[3] later).
> +                */
> +               ptr[16] = 1;
> +
>                 for (i = 0; i < 4; i++) {
>                         cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
>                         dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",
> --
> 1.7.10.4
>
