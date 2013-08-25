From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sd: fix the maximum au_size for SD3.0
Date: Sat, 24 Aug 2013 23:08:34 -0400
Message-ID: <87sixysc0d.fsf@octavius.laptop.org>
References: <51E77061.2030308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46556 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150Ab3HYDIn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:08:43 -0400
In-Reply-To: <51E77061.2030308@samsung.com> (Jaehoon Chung's message of "Thu,
	18 Jul 2013 13:34:41 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Philip Rakity <prakity@marvell.com>, Johan Rudholm <jrudholm@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Hi Jaehoon,

Pushed to mmc-next for 3.12 with the following minor change, let me
know if you disagree:

On Thu, Jul 18 2013, Jaehoon Chung wrote:
> Since SD Physical Layer specification V3.0, AU_SIZE is supported up to 0xf.
> So If SD-card is supported v3.0, then max_au should be 0xf.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/sd.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 176d125..aa5013f 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -215,7 +215,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>  static int mmc_read_ssr(struct mmc_card *card)
>  {
>  	unsigned int au, es, et, eo;
> -	int err, i;
> +	int err, i, max_au;
>  	u32 *ssr;
>  
>  	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
> @@ -239,12 +239,18 @@ static int mmc_read_ssr(struct mmc_card *card)
>  	for (i = 0; i < 16; i++)
>  		ssr[i] = be32_to_cpu(ssr[i]);
>  
> +	/* The value of maximum au_size is supported 0xF since SD3.0 */
> +	if (card->scr.sda_spec3)
> +		max_au = 0xf;
> +	else
> +		max_au = 9;
> +

/* SD3.0 increases max AU size to 64MB (0xF) from 4MB (0x9) */
max_au = card->scr.sda_spec3 ? 0xF : 0x9;

>  	/*
>  	 * UNSTUFF_BITS only works with four u32s so we have to offset the
>  	 * bitfield positions accordingly.
>  	 */
>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
> -	if (au > 0 && au <= 9) {
> +	if (au > 0 && au <= max_au) {
>  		card->ssr.au = 1 << (au + 4);
>  		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
>  		et = UNSTUFF_BITS(ssr, 402 - 384, 6);

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
