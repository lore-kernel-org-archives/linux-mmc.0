From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 03/13] mmc: mmci: Add Qualcomm Id to amba id table
Date: Tue, 27 May 2014 14:49:24 +0100
Message-ID: <538497E4.1070202@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849474-7177-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFqfqhnCKA-dMqAfkhQ+cLLhN0vMtwTxB6t+MUju_04O-g@mail.gmail.com> <53837317.9000203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:52114 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaE0Nth (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 May 2014 09:49:37 -0400
Received: by mail-la0-f53.google.com with SMTP id ty20so4897041lab.40
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2014 06:49:35 -0700 (PDT)
In-Reply-To: <53837317.9000203@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>



On 26/05/14 18:00, Srinivas Kandagatla wrote:
> Hi Ulf,
>
> On 26/05/14 10:10, Ulf Hansson wrote:
>> Hi Srinivas,
>>
>>>
>>> +static struct variant_data variant_qcom = {
>>> +       .fifosize               = 16 * 4,
>>> +       .fifohalfsize           = 8 * 4,
>>> +       .clkreg                 = MCI_CLK_ENABLE,
>>> +       .datalength_bits        = 24,
>>> +       .blksz_datactrl4        = true,
>>
>> You get compile error here.
> yes, You are right, I will reorder this patch after the "mmc: mmci: Add
> Qcom datactrl register variant"

Actually, blksz_datactrl4 should not be in this patch. it is part of 
"mmc: mmci: Add Qcom datactrl register variant"  will remove it from 
this patch in next version.

--srini
>
>
> Thanks,
> srini
>>
>> Kind regards
>> Ulf Hansson
>>
