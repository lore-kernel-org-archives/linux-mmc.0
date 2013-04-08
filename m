From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: pio hang on block errors
Date: Mon, 8 Apr 2013 18:02:24 +0200
Message-ID: <15090.1651396$1365448029@news.gmane.org>
References: <1363771946-8931-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1363771946-8931-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org
Cc: terry@beam.ltd.uk, nicolas.ferre@atmel.com
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Could you take this fix? If there are no objections of course.

Regards

Ludovic

On Wed, Mar 20, 2013 at 10:32:26AM +0100, ludovic.desroches@atmel.com wrote:
> From: Terry Barnaby <terry@beam.ltd.uk>
> 
> The driver is doing, by default, multi-block reads. When a block error occurs
> card/block.c instigates a single block read: "mmcblk0: retrying using single
> block read".
> It leaves the sg chain intact and just changes the length attribute for the
> first sg entry and the overall sg_len parameter. When atmci_read_data_pio is
> called to read the single block of data it ignores the sg_len and expects to
> read more than 512 bytes as it sees there are multiple items in the sg list. No
> more data comes as the controller has only been commanded to get one block.
> 
> Signed-off-by: Terry Barnaby <terry@beam.ltd.uk>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable <stable@vger.kernel.org> # 3.2+
> ---
>  drivers/mmc/host/atmel-mci.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 0932024..d98e68e 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -163,6 +163,7 @@ struct atmel_mci {
>  	void __iomem		*regs;
>  
>  	struct scatterlist	*sg;
> +	unsigned int		sg_len;
>  	unsigned int		pio_offset;
>  
>  	struct atmel_mci_slot	*cur_slot;
> @@ -751,6 +752,7 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
>  	data->error = -EINPROGRESS;
>  
>  	host->sg = data->sg;
> +	host->sg_len = data->sg_len;
>  	host->data = data;
>  	host->data_chan = NULL;
>  
> @@ -1573,7 +1575,8 @@ static void atmci_read_data_pio(struct atmel_mci *host)
>  			if (offset == sg->length) {
>  				flush_dcache_page(sg_page(sg));
>  				host->sg = sg = sg_next(sg);
> -				if (!sg)
> +				host->sg_len--;
> +				if (!sg || !host->sg_len)
>  					goto done;
>  
>  				offset = 0;
> @@ -1586,7 +1589,8 @@ static void atmci_read_data_pio(struct atmel_mci *host)
>  
>  			flush_dcache_page(sg_page(sg));
>  			host->sg = sg = sg_next(sg);
> -			if (!sg)
> +			host->sg_len--;
> +			if (!sg || !host->sg_len)
>  				goto done;
>  
>  			offset = 4 - remaining;
> @@ -1640,7 +1644,8 @@ static void atmci_write_data_pio(struct atmel_mci *host)
>  			nbytes += 4;
>  			if (offset == sg->length) {
>  				host->sg = sg = sg_next(sg);
> -				if (!sg)
> +				host->sg_len--;
> +				if (!sg || !host->sg_len)
>  					goto done;
>  
>  				offset = 0;
> @@ -1654,7 +1659,8 @@ static void atmci_write_data_pio(struct atmel_mci *host)
>  			nbytes += remaining;
>  
>  			host->sg = sg = sg_next(sg);
> -			if (!sg) {
> +			host->sg_len--;
> +			if (!sg || !host->sg_len) {
>  				atmci_writel(host, ATMCI_TDR, value);
>  				goto done;
>  			}
> -- 
> 1.7.11.3
> 
