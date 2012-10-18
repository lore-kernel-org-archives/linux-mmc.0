From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/6] mmc: core: sdio_io.c: Fixed lines with > 80 chars
Date: Thu, 18 Oct 2012 09:47:29 -0700
Message-ID: <1350578849.3072.74.camel@joe-AO722>
References: <n> <1350577919-2750-1-git-send-email-antiroot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:42114 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756287Ab2JRQrb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 12:47:31 -0400
In-Reply-To: <1350577919-2750-1-git-send-email-antiroot@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sangho Yi <antiroot@gmail.com>
Cc: paul.gortmaker@windriver.com, stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, rjw@sisk.pl, girish.shivananjappa@linaro.org, cjb@laptop.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Fri, 2012-10-19 at 01:31 +0900, Sangho Yi wrote:
> I fixed lines over 80 characters per line.

If you really must do these things, please use
checkpatch.pl --strict for guidance on how to align
function arguments.

> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
[]
> @@ -664,7 +665,8 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
>  
>  	BUG_ON(!func);
>  
> -	if ((addr < 0xF0 || addr > 0xFF) && (!mmc_card_lenient_fn0(func->card))) {
> +	if ((addr < 0xF0 || addr > 0xFF) &&
> +			(!mmc_card_lenient_fn0(func->card))) {

ugly alignment and unnecessary parenthesis too.


