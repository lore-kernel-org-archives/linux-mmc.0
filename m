From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 0/8] Fix coding style in sdhci.c
Date: Mon, 12 Nov 2012 10:08:08 +0530
Message-ID: <50A07D30.4030705@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org> <50A05DE9.8070907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:59759 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab2KLEhk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Nov 2012 23:37:40 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2562010dak.19
        for <linux-mmc@vger.kernel.org>; Sun, 11 Nov 2012 20:37:40 -0800 (PST)
In-Reply-To: <50A05DE9.8070907@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On 11/12/2012 07:54 AM, Jaehoon Chung wrote:
> Hi Tushar,
> 
> Could you make one patch? Why do you separate patches?
> 

Yes, I can do that. I did split it specifically so that we could drop
any patches if required.

I will wait for a word from Chris regarding what he prefers.


> Best Regards,
> Jaehoon Chung
> 
> On 11/09/2012 08:39 PM, Tushar Behera wrote:
>> Documents/CodingStyle Chapter 3 recommends usage of braces for both
>> if and else statements if any of the branches contains multiple
>> statements.
>>
>> Cleaning up drivers/mmc/host/sdhci.c for all these occurrences.
>>
>> Tushar Behera (8):
>>   mmc: sdhci: fix coding style in sdhci_calc_timeout
>>   mmc: sdhci: fix coding style in sdhci_set_transfer_mode
>>   mmc: sdhci: fix coding style in sdhci_finish_data
>>   mmc: sdhci: fix coding style in sdhci_set_clock
>>   mmc: sdhci: fix coding style in sdhci_do_set_ios
>>   mmc: sdhci: fix coding style in sdhci_execute_tuning
>>   mmc: sdhci: fix coding style in sdhci_data_irq
>>   mmc: sdhci: fix coding style in sdhci_add_host
>>
>>  drivers/mmc/host/sdhci.c |   58 +++++++++++++++++++++++++--------------------
>>  1 files changed, 32 insertions(+), 26 deletions(-)
>>
> 


-- 
Tushar Behera
