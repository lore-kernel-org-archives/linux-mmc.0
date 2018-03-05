From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: Export host capabilities to debugfs.
Date: Mon, 5 Mar 2018 15:51:54 +0800
Message-ID: <40000048-4f64-792d-ba38-25a15be8569a@rock-chips.com>
References: <1520223870-3471-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520223870-3471-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>, ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, avri.altman@wdc.com, andriy.shevchenko@linux.intel.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir_Zapolskiy@mentor.com
List-Id: linux-mmc@vger.kernel.org

On 2018/3/5 12:24, Harish Jenny K N wrote:
> From: Abbas Raza <Abbas_Raza@mentor.com>
> 
> This patch exports the host capabilities to debugfs
> 
> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
> 
> Changes in v2:
> - Changed Author
> 
>   drivers/mmc/core/debugfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c51e0c0..fa2df7f 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>   
>   	card->debugfs_root = root;
>   
> +	if (!debugfs_create_x32("host_caps", S_IRUSR, root, (u32 *)&host->caps))

Perhaps you don't need cast, and '&host->caps' should be fine?
And you don't need to export host->caps2?

> +		goto err;
> +
>   	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
>   		goto err;
>   
> 
