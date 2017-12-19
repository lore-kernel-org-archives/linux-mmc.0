From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: Modify sdhci o2 quirk for eMMC HS200
 tuning case
Date: Tue, 19 Dec 2017 10:37:13 +0200
Message-ID: <381dcaa4-49ed-9145-58bf-4e28ba077041@intel.com>
References: <BN1PR04MB4543C8987923D893F407934893C0@BN1PR04MB454.namprd04.prod.outlook.com>
 <CY4PR04MB047345A73648C7A212D505D7ED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CY4PR04MB047345A73648C7A212D505D7ED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Shirley Her (SC)" <shirley.her@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 04/12/17 12:10, LinuxPatchCommit wrote:
> Dear all,
> 
> Don't clear transfer mode register in sdhci_set_transfer_mode().
> 
> In sdhci_set_transfer_mode(), clear transfer mode quirk2 will clear SD host transfer mode register for non-data commands. This quirk is used for the bug of O2micro/Bayhubtech devices. In eMMC HS200 tuning case, the tuning process uses hardware tuning and it needs to set transfer mode register for tuning command.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index 0d5fcca18c9e..d5b19fc9ea56 100644
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

In the HS200 case you are sending the tuning command with data, so I do not
understand why you need this i.e. you will never get here

>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */
>  			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> --
> 2.14.1
> 
