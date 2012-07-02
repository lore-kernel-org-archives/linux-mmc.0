From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: correct invalid error checking
Date: Mon, 02 Jul 2012 13:17:21 -0400
Message-ID: <87mx3i84m6.fsf@octavius.laptop.org>
References: <20120702175509.10520.24093.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37550 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441Ab2GBRR2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jul 2012 13:17:28 -0400
In-Reply-To: <20120702175509.10520.24093.stgit@bluebook> (Alan Cox's message
	of "Mon, 02 Jul 2012 18:55:13 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Jul 02 2012, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> The effect of the existing code is that we continue blindly when we should
> warn about an invalid allocation unit
>
> Reported-by: dcb314@hotmail.com
> Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=44061
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>
>  drivers/mmc/core/sd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c272c686..c52f12b 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -244,7 +244,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>  	 * bitfield positions accordingly.
>  	 */
>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
> -	if (au > 0 || au <= 9) {
> +	if (au > 0 && au <= 9) {
>  		card->ssr.au = 1 << (au + 4);
>  		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
>  		et = UNSTUFF_BITS(ssr, 402 - 384, 6);

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
