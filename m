From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: fix
 SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD handling
Date: Tue, 9 Jan 2018 14:34:35 +0200
Message-ID: <d92c4e02-577a-dcbf-87e5-2a40be006cc5@intel.com>
References: <20171228095913.3944-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228095913.3944-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuxiang.wan@bayhubtech.com, xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

On 28/12/17 11:59, ernest.zhang wrote:
> SD controller with SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD quirk
> will clear SD host transfer mode register for non-data commands. But in
> eMMC HS200 hardware tuning case, the hardware tuning process need to
> transfer mode register has properly value. So don't clear transfer
> mode register when opcode equals to MMC_SEND_TUNING_BLOCK_HS200.

As I wrote last time, you send MMC_SEND_TUNING_BLOCK_HS200 with data != NULL
so this code path is not used.

Also please use version numbers in the subject.

> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0d5fcca18c9e..d5b19fc9ea56 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -918,7 +918,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	if (data == NULL) {
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> -			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +			/* cannot clear transfer mode register when tuning */
> +			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
> +				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */
>  			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> 
