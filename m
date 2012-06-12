From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/1] block: Add eMMC4.5 packed commands unit-tests
Date: Tue, 12 Jun 2012 10:11:16 -0400
Message-ID: <x491ulkk4cb.fsf@segfault.boston.devel.redhat.com>
References: <1339494088-29126-1-git-send-email-merez@codeaurora.org>
	<1339494088-29126-2-git-send-email-merez@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1339494088-29126-2-git-send-email-merez@codeaurora.org> (Maya
	Erez's message of "Tue, 12 Jun 2012 12:41:28 +0300")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Maya Erez <merez@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Lee Susman <lsusman@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Maya Erez <merez@codeaurora.org> writes:

> Expose the following packed commands tests:
> - Test the write packed commands list preparation
> - Simulate a returned error code
> - Send an invalid packed command to the card
>
> Signed-off-by: Lee Susman <lsusman@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
>
> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
> index 3b1f783..bbe8cac 100644
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -67,3 +67,14 @@ config MMC_TEST
>  
>  	  This driver is only of interest to those developing or
>  	  testing a host driver. Most people should say N here.
> +
> +config MMC_BLOCK_TEST
> +	tristate "MMC block test"
> +	depends on MMC_BLOCK && IOSCHED_TEST

Umm, if this depends on your iosched-test patch, then you should make
them both part of a patch series.  It would have answered one of my
questions on that patch.

Cheers,
Jeff
