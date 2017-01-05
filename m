From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
Date: Thu, 5 Jan 2017 11:53:39 +0200
Message-ID: <f869a601-38ba-daf7-e6bb-713547041c3c@intel.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 30/12/16 17:24, Stefan Wahren wrote:
> According to the BCM2835 datasheet the maximum block size for the
> eMMC module is restricted to the internal data FIFO which is 1024 byte.
> But this is still an improvement to the default of 512 byte.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-iproc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 30b3fdf..3275d49 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -218,7 +218,9 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
>  
>  static const struct sdhci_iproc_data bcm2835_data = {
>  	.pdata = &sdhci_bcm2835_pltfm_data,
> -	.caps = SDHCI_CAN_VDD_330 |
> +	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
> +			& SDHCI_MAX_BLOCK_MASK) |
> +		SDHCI_CAN_VDD_330 |
>  		SDHCI_CAN_DO_HISPD,
>  	.caps1 = SDHCI_DRIVER_TYPE_A |
>  		 SDHCI_DRIVER_TYPE_C,
> 
