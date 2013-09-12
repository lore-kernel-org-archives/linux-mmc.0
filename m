From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 13:48:05 +0530
Message-ID: <CAK9yfHzORfv84mDrH_KCx79Oi5w9jdtLk3MuOu8Dex1+M3N6EQ@mail.gmail.com>
References: <1378968200-16577-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohponUT5hh=saFcx7riFJB-DbPwhkYz2_7Gc2i--GWC6bYCg@mail.gmail.com>
	<CAK9yfHzpLj6ZAcqikFWkOSWCSpU_NvchETgG0_65sU1Kb_F=kA@mail.gmail.com>
	<CAKohponoo6Kjc6P=e2K0ys6iZ7upB24UGhBNeSbg22M8qqTkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:42813 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757818Ab3ILISF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 04:18:05 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so199894obc.21
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 01:18:05 -0700 (PDT)
In-Reply-To: <CAKohponoo6Kjc6P=e2K0ys6iZ7upB24UGhBNeSbg22M8qqTkWw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, spear-devel <spear-devel@list.st.com>

On 12 September 2013 13:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 September 2013 13:41, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Yes. That was my second option. If we do that we would get something as below:
>>
>>  84         /* If pdata is required */
>>  85         if (cd_gpio != -1) {
>>  86                pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>  87                if (!pdata) {
>>  88                    dev_err(&pdev->dev, "DT: kzalloc failed\n");
>>  89                    goto out;
>>  90                }
>>  91                pdata->card_int_gpio = cd_gpio;
>>  92                return pdata;
>>  93          }
>>  94
>>  95 out:
>>  96      return ERR_PTR(-ENODATA);
>>
>> Does this look OK?
>
> Or this:
>
>>  85         if (cd_gpio != -1) {
>>  86                pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>  87                if (!pdata)
>>  88                    dev_err(&pdev->dev, "DT: kzalloc failed\n");
>                         else
>>  91                    pdata->card_int_gpio = cd_gpio;
>>  93          }
>>  94
>>  96      return ERR_PTR(-ENODATA);

Wouldn't this be unconditional error return whether pdata is null or not?

-- 
With warm regards,
Sachin
