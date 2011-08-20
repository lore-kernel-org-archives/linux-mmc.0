From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Use switch() instead of if/else if in mmc_blk_issue_rq.
Date: Sat, 20 Aug 2011 11:12:26 -0400
Message-ID: <m239gwglr9.fsf@bob.laptop.org>
References: <1313851839-32483-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313851839-32483-1-git-send-email-linkinjeon@gmail.com> (Namjae
	Jeon's message of "Sat, 20 Aug 2011 23:50:39 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-mmc@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, Aug 20 2011, Namjae Jeon wrote:
> This uses a switch statement instead of if/else if statements.
> It will make to improve clarity and scalability, and offer faster execution through compiler optimization than if/else if statements.
>
> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
> ---
>  drivers/mmc/card/block.c |   38 +++++++++++++++++++++++---------------
>  1 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1ff5486..fe9dd89 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1191,23 +1191,31 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  		goto out;
>  	}
>  
> -	if (req && req->cmd_flags & REQ_DISCARD) {
> -		/* complete ongoing async transfer before issuing discard */
> -		if (card->host->areq)
> -			mmc_blk_issue_rw_rq(mq, NULL);
> -		if (req->cmd_flags & REQ_SECURE)
> -			ret = mmc_blk_issue_secdiscard_rq(mq, req);
> -		else
> +	if (req) {
> +		switch(req->cmd_flags) {
> +		case REQ_DISCARD:
> +			/* complete ongoing async transfer before issuing discard */
> +			if (card->host->areq)
> +				mmc_blk_issue_rw_rq(mq, NULL);

But it doesn't work, because you've changed the test for "req->cmd_flags
& REQ_DISCARD" into a test for "req->cmd_flags == REQ_DISCARD".

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
