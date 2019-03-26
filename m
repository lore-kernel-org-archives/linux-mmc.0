From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BACKPORT 4.4.y 17/25] mmc: core: don't try to switch block size
 for dual rate mode
Date: Tue, 26 Mar 2019 10:27:31 +0900
Message-ID: <20190326012731.GA30723@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-18-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-18-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Avri Altman <avri.altman@wdc.com>, Ritesh Harjani <riteshh@codeaurora.org>, Jiong Wu <lohengrin1024@gmail.com>, Martin Hicks <mort@bork.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:08PM +0100, Arnd Bergmann wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
> 
> Per spec, block size should always be 512 bytes for dual rate mode,
> so any attempts to switch the block size under dual rate mode should
> be neglected.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit 1712c9373f98ae8ed41599a8d7841a6fba29c264)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/core/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index df074f8c7cb7..3e17268b9994 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2406,7 +2406,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
>  {
>  	struct mmc_command cmd = {0};
>  
> -	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
> +	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
> +	    mmc_card_hs400(card) || mmc_card_hs400es(card))

This breaks the build, there is no mmc_card_hs400es() call in 4.4.y.

How did this build for you?

greg k-h
