From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Tue, 12 Mar 2013 20:22:11 +0530
Message-ID: <CAK9yfHwT5scTmgRF7dwGf2syyHj=N4ipMfFgcOs=W6Rd1eUU+g@mail.gmail.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
	<8738w0ixc8.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:33757 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab3CLOwM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 10:52:12 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so5873126oag.15
        for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2013 07:52:11 -0700 (PDT)
In-Reply-To: <8738w0ixc8.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

>> -int dw_mci_exynos_probe(struct platform_device *pdev)
>> +static int dw_mci_exynos_probe(struct platform_device *pdev)
>>  {
>>       const struct dw_mci_drv_data *drv_data;
>>       const struct of_device_id *match;
>
> Thanks, pushed to mmc-next for 3.10.

Thanks Chris.

There is also another patch in this series [1] that needs your attention.
[1] https://patchwork.kernel.org/patch/2156621/


-- 
With warm regards,
Sachin
