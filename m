From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix the max_blk_count in IDMAC
Date: Mon, 24 Mar 2014 13:06:55 +0900
Message-ID: <532FAF5F.1020906@samsung.com>
References: <1395633218-23766-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1395633218-23766-1-git-send-email-yuvaraj.cd@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, grundler@chromium.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, sonnyrao@chromium.org, kgene.kim@samsung.com, joshi@samsung.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, t.figa@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Did you know that Seungwon has sent the patch "[PATCH 1/7] mmc: dw_mmc: fix the max_blk_count in IDMAC"?
I think this patch looks like same, isn't it?
Plz check it.

Best Regards,
Jaehoon Chung

On 03/24/2014 12:53 PM, Yuvaraj Kumar C D wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> max_blk_count is currently set incorrectly, and the correct value can
> be determined by looking at the maximum number of bytes which can be
> transferred and the block size.  We use the maximum block size to
> determine the minimum number of blocks that the controller should
> support.  It could probably do more with a smaller block size but this
> value should be sufficient for good performance.
> 
> This improves sequential performance by 82% on write and 6% read on
> one particular device.
> 
> TEST= with this patch
> 	time dd if=/dev/zero of=/usr/local/100 bs=1M count=100 conv=fdatasync
> 	100+0 records in
> 	100+0 records out
> 	104857600 bytes (105 MB) copied, 2.62541 s, 39.9 MB/s
> 
> 	real    0m2.638s
> 	user    0m0.000s
> 	sys     0m0.645s
> 
> 	without this patch:
> 	time dd if=/dev/zero of=/usr/local/100 bs=1M count=100 conv=fdatasync
> 	100+0 records in
> 	100+0 records out
> 	104857600 bytes (105 MB) copied, 3.25873 s, 32.2 MB/s
> 
> 	real    0m3.265s
> 	user    0m0.005s
> 	sys     0m0.690s
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0c56faa..2fc4030 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2213,10 +2213,24 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  		/* Useful defaults if platform data is unset. */
>  #ifdef CONFIG_MMC_DW_IDMAC
>  		mmc->max_segs = host->ring_size;
> +
> +		/* the BLKSIZ register is 16-bits wide */
>  		mmc->max_blk_size = 65536;
> -		mmc->max_blk_count = host->ring_size;
> +
> +		/*
> +		 * This value is calculated by taking the size of the
> +		 * 32-bit BYTCNT (byte count) register and dividing by the
> +		 * BLKSIZ (block size) register.  This is the minimum number
> +		 * of blocks which could be handled.
> +		 */
> +		mmc->max_blk_count = 0xFFFF;
>  		mmc->max_seg_size = 0x1000;
> -		mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
> +		/*
> +		 * Maximum request size should be total number of descriptors
> +		 * times the maximum amount of data each can reference
> +		 */
> +
> +		mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
>  #else
>  		mmc->max_segs = 64;
>  		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
> 
