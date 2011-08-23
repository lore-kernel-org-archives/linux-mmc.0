From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 12:31:55 -0400
Message-ID: <m27h643x8k.fsf@bob.laptop.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
	<1314114363-6767-3-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49767 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1HWQcC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Aug 2011 12:32:02 -0400
In-Reply-To: <1314114363-6767-3-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Tue, 23 Aug 2011 21:16:03 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org

Hi,

[Adding linux-sparse@ to CC]

On Tue, Aug 23 2011, Venkatraman S wrote:
> Fix the sparse warning output
> "warning: Using plain integer as NULL pointer"
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/card/block.c    |    4 ++--
>  drivers/mmc/core/core.c     |    2 +-
>  drivers/mmc/core/mmc_ops.c  |    4 ++--
>  drivers/mmc/core/sdio_ops.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1ff5486..e702c61 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -291,7 +291,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>  	struct mmc_card *card;
>  	struct mmc_command cmd = {0};
>  	struct mmc_data data = {0};
> -	struct mmc_request mrq = {0};
> +	struct mmc_request mrq = {NULL};
>  	struct scatterlist sg;
>  	int err;
> [...]

The sparse warning is mistaken.  Or I'm mistaken.  But I suspect it's
the sparse warning.

The {0} syntax is covered by:

   [6.7.8.21] If there are fewer initializers in a brace-enclosed list
   than there are elements or members of an aggregate, or fewer
   characters in a string literal used to initialize an array of known
   size than there are elements in the array, the remainder of the
   aggregate shall be initialized implicitly the same as objects that
   have static storage duration.

So we're not assigning 0 to a pointer, or whatever sparse thinks we're
doing -- we're initializing every member of the struct with 0, which is
a good and safe way to initialize it.

Sparse folks, any comment?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
