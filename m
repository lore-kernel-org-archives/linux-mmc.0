From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 2/2] mmc: rtsx: add support for sdio card
Date: Mon, 1 Dec 2014 15:37:04 +0300
Message-ID: <20141201123704.GE4994@mwanda>
References: <cover.1417141102.git.micky_ching@realsil.com.cn>
 <544df18ef543c169c93e4c9bd64e94c4ed3c1f9b.1417141102.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <544df18ef543c169c93e4c9bd64e94c4ed3c1f9b.1417141102.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: micky_ching@realsil.com.cn
Cc: ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, lee.jones@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 28, 2014 at 02:31:56PM +0800, micky_ching@realsil.com.cn wrote:
>  #ifdef DEBUG
> -static void sd_print_debug_regs(struct realtek_pci_sdmmc *host)
> +static void dump_reg_range(struct realtek_pci_sdmmc *host, u16 start, u16 end)
>  {
> -	struct rtsx_pcr *pcr = host->pcr;
> -	u16 i;
> -	u8 *ptr;
> +	u16 len = end - start + 1;
> +	int i;
> +	u8 data[8];
>  
> -	/* Print SD host internal registers */
> -	rtsx_pci_init_cmd(pcr);
> -	for (i = 0xFDA0; i <= 0xFDAE; i++)
> -		rtsx_pci_add_cmd(pcr, READ_REG_CMD, i, 0, 0);
> -	for (i = 0xFD52; i <= 0xFD69; i++)
> -		rtsx_pci_add_cmd(pcr, READ_REG_CMD, i, 0, 0);
> -	rtsx_pci_send_cmd(pcr, 100);
> -
> -	ptr = rtsx_pci_get_cmd_data(pcr);
> -	for (i = 0xFDA0; i <= 0xFDAE; i++)
> -		dev_dbg(sdmmc_dev(host), "0x%04X: 0x%02x\n", i, *(ptr++));
> -	for (i = 0xFD52; i <= 0xFD69; i++)
> -		dev_dbg(sdmmc_dev(host), "0x%04X: 0x%02x\n", i, *(ptr++));
> +	if (!data)
> +		return;

Delete this check.  It will cause a static checker warning because
arrays never NULL.

> +
> +	for (i = 0; i < len; i += 8) {
> +		int j;
> +		int n = min(8, len - i);
> +
> +		memset(&data, 0, sizeof(data));
> +		for (j = 0; j < n; j++)
> +			rtsx_pci_read_register(host->pcr, start + i + j,
> +				data + j);
> +		dev_dbg(sdmmc_dev(host), "0x%04X(%d): %8ph\n", start, n, data);

This should be start + i, sorry for not spotting that earlier.

regards,
dan carpenter
