From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: propagate correct returned value in
 mmc_rpmb_ioctl
Date: Thu, 17 May 2018 10:45:07 +0800
Message-ID: <316ca15c-86f2-f052-c307-ba12eea7b579@rock-chips.com>
References: <20180516192022.23541-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516192022.23541-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 2018/5/17 3:20, Mathieu Malaterre wrote:
> In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device") a
> new function `mmc_rpmb_ioctl` was added. The final return is simply
> returning a value of `0` instead of propagating the correct return code.
> 
> Discovered during a compilation with W=1, silence the following gcc warning
> 
>    drivers/mmc/core/block.c:2470:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 

Good catch! But hey, which gcc are you using now? Mine, gcc-linaro-
6.3.1-2017.05-x86_64_aarch64-linux-gnu, with W=1 doesn't warn about
this. And it's worth backporting to stable.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   drivers/mmc/core/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9e923cd1d80e..38a7586b00cc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2485,7 +2485,7 @@ static long mmc_rpmb_ioctl(struct file *filp, unsigned int cmd,
>   		break;
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   #ifdef CONFIG_COMPAT
> 
