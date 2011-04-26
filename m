From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] mmc: block: Resume multi-block reads after transient read errors.
Date: Tue, 26 Apr 2011 15:19:26 +0200
Message-ID: <201104261519.26622.arnd@arndb.de>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <1303520502-32171-2-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58808 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1DZNTi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 09:19:38 -0400
In-Reply-To: <1303520502-32171-2-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Adrian Hunter <adrian.hunter@nokia.com>
Cc: linux-mmc@vger.kernel.org, David Ding <david.j.ding@motorola.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>, Bentao Zou <bzou1@motorola.com>, San Mehat <san@google.com>

On Saturday 23 April 2011, John Stultz wrote:
> From: David Ding <david.j.ding@motorola.com>
> 
> CC: Chris Ball <cjb@laptop.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Dima Zavin <dima@android.com>
> Signed-off-by: Bentao Zou <bzou1@motorola.com>
> Signed-off-by: David Ding <david.j.ding@motorola.com>
> Signed-off-by: San Mehat <san@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

The disable_multi logic was introduced in 6a79e391 "mmc_block: ensure
all sectors that do not have errors are read" by Adrian Hunter. Maybe
he can comment on this.

My impression is that the code makes more sense without this
add-on patch, because the flag is set for exactly one request
and makes mmc_blk_issue_rw_rq issue all blocks in that request
one by one up to the first error, while after the patch,
we would read one sector, then read the remaining request at
once, fail, and read the next sector, and so on.

If the problem is transient read errors, a better solution might
be to retry the entire request before doing it one sector at a time.

>  drivers/mmc/card/block.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 61d233a..edac9ac 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -440,6 +440,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>  				continue;
>  			}
>  			status = get_card_status(card, req);
> +		} else if (disable_multi == 1) {
> +			disable_multi = 0;
>  		}
>  
>  		if (brq.cmd.error) {
> -- 
> 1.7.3.2.146.gca209
> 
> 

