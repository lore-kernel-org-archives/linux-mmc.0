From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 10/15] mmc: core: Remove unused struct _mmc_csd from
 public mmc.h header
Date: Mon, 16 Jan 2017 11:07:36 +0800
Message-ID: <0757437b-77ca-134a-8844-9c003e184ced@rock-chips.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-11-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:41927 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAPDI0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 22:08:26 -0500
In-Reply-To: <1484313256-25993-11-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 2017/1/13 21:14, Ulf Hansson wrote:
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/mmc/mmc.h | 44 --------------------------------------------
>  1 file changed, 44 deletions(-)
>

Looks quite strightforward, but it will be better if adding a
commit msg body here. Anyway,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 8f78543..7406d9b 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -184,50 +184,6 @@ static inline bool mmc_op_multi(u32 opcode)
>  #define R2_SPI_OUT_OF_RANGE	(1 << 15)	/* or CSD overwrite */
>  #define R2_SPI_CSD_OVERWRITE	R2_SPI_OUT_OF_RANGE
>
> -/* These are unpacked versions of the actual responses */
> -
> -struct _mmc_csd {
> -	u8  csd_structure;
> -	u8  spec_vers;
> -	u8  taac;
> -	u8  nsac;
> -	u8  tran_speed;
> -	u16 ccc;
> -	u8  read_bl_len;
> -	u8  read_bl_partial;
> -	u8  write_blk_misalign;
> -	u8  read_blk_misalign;
> -	u8  dsr_imp;
> -	u16 c_size;
> -	u8  vdd_r_curr_min;
> -	u8  vdd_r_curr_max;
> -	u8  vdd_w_curr_min;
> -	u8  vdd_w_curr_max;
> -	u8  c_size_mult;
> -	union {
> -		struct { /* MMC system specification version 3.1 */
> -			u8  erase_grp_size;
> -			u8  erase_grp_mult;
> -		} v31;
> -		struct { /* MMC system specification version 2.2 */
> -			u8  sector_size;
> -			u8  erase_grp_size;
> -		} v22;
> -	} erase;
> -	u8  wp_grp_size;
> -	u8  wp_grp_enable;
> -	u8  default_ecc;
> -	u8  r2w_factor;
> -	u8  write_bl_len;
> -	u8  write_bl_partial;
> -	u8  file_format_grp;
> -	u8  copy;
> -	u8  perm_write_protect;
> -	u8  tmp_write_protect;
> -	u8  file_format;
> -	u8  ecc;
> -};
> -
>  /*
>   * OCR bits are mostly in host.h
>   */
>


-- 
Best Regards
Shawn Lin

