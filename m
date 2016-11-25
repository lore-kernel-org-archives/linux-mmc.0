From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: add DT binding for CMD23
Date: Fri, 25 Nov 2016 09:19:57 +0100
Message-ID: <CAPDyKFr3CMeqDpQxf13Z1Ae5W_Q3X75if4fK9eYstXaVeTTVwg@mail.gmail.com>
References: <20161125065215.10833-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33467 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbcKYIT7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 03:19:59 -0500
Received: by mail-wm0-f50.google.com with SMTP id c184so25992348wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 00:19:59 -0800 (PST)
In-Reply-To: <20161125065215.10833-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>

On 25 November 2016 at 07:52, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Provide the option to configure one type of multiple block read/wrte
> transatction (CMD23 - it's optional.)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/core/host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 98f25ff..9bdc369 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -321,6 +321,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_NO_SD;
>         if (of_property_read_bool(np, "no-mmc"))
>                 host->caps2 |= MMC_CAP2_NO_MMC;
> +       if (of_property_read_bool(np, "cap-mmc-cmd23"))
> +               host->caps |= MMC_CAP_CMD23;
>
>         host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
>         if (host->dsr_req && (host->dsr & ~0xffff)) {
> --
> 2.10.1
>

I don't think this as HW configuration, but more a SW configuration.
Thus we don't need a DT binding for it, right?

Kind regards
Uffe
