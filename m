From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 5/8] mmc/core/mmc_test: Combine substrings for 5 messages
Date: Tue, 10 Jan 2017 16:34:17 +0800
Message-ID: <2cbc7cac-ac3c-e6ee-7a96-827b4df0adb9@rock-chips.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
 <2841f26b-325f-bf13-a91c-5bbc125b0f8c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2841f26b-325f-bf13-a91c-5bbc125b0f8c@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: shawn.lin@rock-chips.com, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2017/1/9 5:47, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 20:56:48 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: quoted string split across lines
>

yup, the print shouldn't blindly split itself to shut up
"WARNING: line over 80 characters" . FWIW,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Thus fix affected source code places.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mmc/core/mmc_test.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 42aefd3df09b..bb9f569a5dd5 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -277,8 +277,7 @@ static int mmc_test_wait_busy(struct mmc_test_card *test)
>  		if (!busy && mmc_test_busy(&cmd)) {
>  			busy = 1;
>  			if (test->card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -				pr_info("%s: Warning: Host did not "
> -					"wait for busy state to end.\n",
> +				pr_info("%s: Warning: Host did not wait for busy state to end.\n",
>  					mmc_hostname(test->card->host));
>  		}
>  	} while (mmc_test_busy(&cmd));
> @@ -2967,8 +2966,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>  		if (mmc_test_cases[i].prepare) {
>  			ret = mmc_test_cases[i].prepare(test);
>  			if (ret) {
> -				pr_info("%s: Result: Prepare "
> -					"stage failed! (%d)\n",
> +				pr_info("%s: Result: Prepare stage failed! (%d)\n",
>  					mmc_hostname(test->card->host),
>  					ret);
>  				continue;
> @@ -3005,13 +3003,11 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>  				mmc_hostname(test->card->host));
>  			break;
>  		case RESULT_UNSUP_HOST:
> -			pr_info("%s: Result: UNSUPPORTED "
> -				"(by host)\n",
> +			pr_info("%s: Result: UNSUPPORTED (by host)\n",
>  				mmc_hostname(test->card->host));
>  			break;
>  		case RESULT_UNSUP_CARD:
> -			pr_info("%s: Result: UNSUPPORTED "
> -				"(by card)\n",
> +			pr_info("%s: Result: UNSUPPORTED (by card)\n",
>  				mmc_hostname(test->card->host));
>  			break;
>  		default:
> @@ -3026,8 +3022,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>  		if (mmc_test_cases[i].cleanup) {
>  			ret = mmc_test_cases[i].cleanup(test);
>  			if (ret) {
> -				pr_info("%s: Warning: Cleanup "
> -					"stage failed! (%d)\n",
> +				pr_info("%s: Warning: Cleanup stage failed! (%d)\n",
>  					mmc_hostname(test->card->host),
>  					ret);
>  			}
>


-- 
Best Regards
Shawn Lin
