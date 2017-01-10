From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 3/8] mmc-core: Use seq_puts() in mtf_testlist_show()
Date: Tue, 10 Jan 2017 16:41:23 +0800
Message-ID: <07a62dc9-0c46-2dc3-edcf-231d5dc7521c@rock-chips.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
 <5b8afe3b-0dee-0d95-c855-f0b93a95a072@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b8afe3b-0dee-0d95-c855-f0b93a95a072@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: shawn.lin@rock-chips.com, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2017/1/9 5:45, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 19:48:28 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: Prefer seq_puts to seq_printf

it saves some lock time,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Thus fix the affected source code place.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mmc/core/mmc_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 2f838a13a904..848f4f30e343 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3163,7 +3163,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
>
>  	mutex_lock(&mmc_test_lock);
>
> -	seq_printf(sf, "0:\tRun all tests\n");
> +	seq_puts(sf, "0:\tRun all tests\n");
>  	for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++)
>  		seq_printf(sf, "%d:\t%s\n", i+1, mmc_test_cases[i].name);
>
>


-- 
Best Regards
Shawn Lin
