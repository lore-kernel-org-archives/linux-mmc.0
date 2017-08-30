From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] mmc: mmci: stop building qcom dml as module
Date: Wed, 30 Aug 2017 13:20:30 +0100
Message-ID: <a8fc1458-2295-cdb3-d799-65d97c03ffe7@linaro.org>
References: <20170810145418.4430-1-srinivas.kandagatla@linaro.org>
 <CAPDyKFoVTASsnmx_Dz4MdPxVQOFVL=d6xQHiT3DVRBRJphRamw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35050 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdH3MUd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 08:20:33 -0400
Received: by mail-wm0-f45.google.com with SMTP id a80so8818320wma.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2017 05:20:32 -0700 (PDT)
In-Reply-To: <CAPDyKFoVTASsnmx_Dz4MdPxVQOFVL=d6xQHiT3DVRBRJphRamw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



>> -#ifdef CONFIG_MMC_QCOM_DML
>> +#if IS_ENABLED(CONFIG_MMC_QCOM_DML)
> 
> Because you change CONFIG_MMC_QCOM_DML beeing a bool instead of
> tristate, then I don't think you need to change this to IS_ENABLED().
> 
> Correct!?
Yep, that's correct Will respin the patch without this change


> 
>>   int dml_hw_init(struct mmci_host *host, struct device_node *np);
>>   void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
>>   #else
>> --
>> 2.9.3
>>
> 
> Otherwise this looks good to me.
> 
> Kind regards
> Uffe
> 
