From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 13:43:31 +0530
Message-ID: <CAKohponoo6Kjc6P=e2K0ys6iZ7upB24UGhBNeSbg22M8qqTkWw@mail.gmail.com>
References: <1378968200-16577-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohponUT5hh=saFcx7riFJB-DbPwhkYz2_7Gc2i--GWC6bYCg@mail.gmail.com>
	<CAK9yfHzpLj6ZAcqikFWkOSWCSpU_NvchETgG0_65sU1Kb_F=kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40165 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3ILINc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 04:13:32 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so10384230oag.8
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 01:13:31 -0700 (PDT)
In-Reply-To: <CAK9yfHzpLj6ZAcqikFWkOSWCSpU_NvchETgG0_65sU1Kb_F=kA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, spear-devel <spear-devel@list.st.com>

On 12 September 2013 13:41, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Yes. That was my second option. If we do that we would get something as below:
>
>  84         /* If pdata is required */
>  85         if (cd_gpio != -1) {
>  86                pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>  87                if (!pdata) {
>  88                    dev_err(&pdev->dev, "DT: kzalloc failed\n");
>  89                    goto out;
>  90                }
>  91                pdata->card_int_gpio = cd_gpio;
>  92                return pdata;
>  93          }
>  94
>  95 out:
>  96      return ERR_PTR(-ENODATA);
>
> Does this look OK?

Or this:

>  85         if (cd_gpio != -1) {
>  86                pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>  87                if (!pdata)
>  88                    dev_err(&pdev->dev, "DT: kzalloc failed\n");
                        else
>  91                    pdata->card_int_gpio = cd_gpio;
>  93          }
>  94
>  96      return ERR_PTR(-ENODATA);
