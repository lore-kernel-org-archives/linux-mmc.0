From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/1] mmc: debugfs: Set frequency to maximum possible on
 higher request
Date: Mon, 3 Sep 2012 14:36:33 +0300
Message-ID: <CAHp75VeZ3Vknz84Hyy7c8qsegkfOPz8X6gVMG0FQUhwqZdRkpw@mail.gmail.com>
References: <1346670519-13097-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46553 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314Ab2ICLge (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Sep 2012 07:36:34 -0400
Received: by eaac11 with SMTP id c11so1564186eaa.19
        for <linux-mmc@vger.kernel.org>; Mon, 03 Sep 2012 04:36:33 -0700 (PDT)
In-Reply-To: <1346670519-13097-1-git-send-email-vinit.shenoy@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinit Shenoy <vinit.shenoy@st.com>
Cc: cjb@laptop.org, per.forlin@linaro.org, viresh.kumar@linaro.org, linux-mmc@vger.kernel.org, spear-devel@list.st.com

On Mon, Sep 3, 2012 at 2:08 PM, Vinit Shenoy <vinit.shenoy@st.com> wrote:
> Currently if we enter a frequency greater than maximum supported,
> -EINVAL is returned. Due to this clock is not switched to maximum
> supported frequency.
>
> For example consider the max supported frequency to be 48MHz
>
> echo 20000000 > /sys/kernel/debug/mmc0/clock Here clock is switched to 20Mhz.
>
> echo 80000000 > /sys/kernel/debug/mmc0/clock
> Ideally clock should be set back to 48MHz, but it is still set to 20MHz.
>
> This patch sets value to f_max when the requested frequency is greater
> than f_max
>
> Signed-off-by: Vinit Shenoy <vinit.shenoy@st.com>
> ---
>  drivers/mmc/core/debugfs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 9ab5b17..c71d3eb 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -174,7 +174,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
>
>         /* We need this check due to input value is u64 */
>         if (val > host->f_max)
> -               return -EINVAL;
> +               val = host->f_max;
It's a matter of taste. However, I think it's time to start
Documentation/mmc/debugfs.txt
and describe the file there.

-- 
With Best Regards,
Andy Shevchenko
