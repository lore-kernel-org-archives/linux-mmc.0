From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH] mmc: core: debugfs: Add signal_voltage to ios dump
Date: Fri, 26 Oct 2012 11:44:36 +0200
Message-ID: <C5E82048-310E-414C-A772-F05862041AD5@nvidia.com>
References: <1351243915-30190-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:2982 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab2JZJoo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 05:44:44 -0400
In-Reply-To: <1351243915-30190-1-git-send-email-johan.rudholm@stericsson.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>


On Oct 26, 2012, at 11:31 AM, Johan Rudholm <johan.rudholm@stericsson.com> wrote:

> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
> drivers/mmc/core/debugfs.c |   16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index d96c643..35c2f85 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -144,6 +144,22 @@ static int mmc_ios_show(struct seq_file *s, void *data)
> 	}
> 	seq_printf(s, "timing spec:\t%u (%s)\n", ios->timing, str);
> 
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		str = "3.30 V";
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		str = "1.80 V";
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_120:
> +		str = "1.20 V";
> +		break;
> +	default:
> +		str = "invalid";

would "is unknown"  be a better str ?
> +		break;
> +	}
> +	seq_printf(s, "signal voltage:\t%u (%s)\n", ios->chip_select, str);
> +
> 	return 0;
> }
> 
Reviewed-by: Philip Rakity <prakity@nvidia.com>
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
