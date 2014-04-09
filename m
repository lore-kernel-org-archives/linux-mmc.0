From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND] mmc: Convert to use ATTRIBUTE_GROUPS
Date: Wed, 9 Apr 2014 11:47:04 +0200
Message-ID: <CAPDyKFrWvb1nDW7k=b8xo5g_S887Oo8pt9QbrLnhdAN92Ci-3g@mail.gmail.com>
References: <1394262327.3868.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:42241 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772AbaDIJrF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Apr 2014 05:47:05 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so2159170qab.17
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2014 02:47:04 -0700 (PDT)
In-Reply-To: <1394262327.3868.3.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 8 March 2014 08:05, Axel Lin <axel.lin@ingics.com> wrote:
> Use new ATTRIBUTE_GROUPS macro to declare attribute groups.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/mmc.c | 12 ++----------
>  drivers/mmc/core/sd.c  | 12 ++----------
>  2 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f631f5a..db0f250 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -694,18 +694,10 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_rel_sectors.attr,
>         NULL,
>  };
> -
> -static struct attribute_group mmc_std_attr_group = {
> -       .attrs = mmc_std_attrs,
> -};
> -
> -static const struct attribute_group *mmc_attr_groups[] = {
> -       &mmc_std_attr_group,
> -       NULL,
> -};
> +ATTRIBUTE_GROUPS(mmc_std);
>
>  static struct device_type mmc_type = {
> -       .groups = mmc_attr_groups,
> +       .groups = mmc_std_groups,
>  };
>
>  /*
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6f42050..c52cb77 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -700,18 +700,10 @@ static struct attribute *sd_std_attrs[] = {
>         &dev_attr_serial.attr,
>         NULL,
>  };
> -
> -static struct attribute_group sd_std_attr_group = {
> -       .attrs = sd_std_attrs,
> -};
> -
> -static const struct attribute_group *sd_attr_groups[] = {
> -       &sd_std_attr_group,
> -       NULL,
> -};
> +ATTRIBUTE_GROUPS(sd_std);
>
>  struct device_type sd_type = {
> -       .groups = sd_attr_groups,
> +       .groups = sd_std_groups,
>  };
>
>  /*
> --
> 1.8.1.2
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
