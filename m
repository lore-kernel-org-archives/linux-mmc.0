From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-cadence: add suspend / resume support
Date: Tue, 15 Aug 2017 09:46:38 +0300
Message-ID: <bfa3213f-8322-ca9c-8170-122f268f3ce3@intel.com>
References: <1501724656-12435-1-git-send-email-yamada.masahiro@socionext.com>
 <1501724656-12435-5-git-send-email-yamada.masahiro@socionext.com>
 <91131416-055e-71f8-d0f9-7784776e454d@intel.com>
 <CAK7LNAQ344PnS9e21E8yzhorKxKjH74P5Znkewz3c39gc1zBVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15889 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752494AbdHOGxG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Aug 2017 02:53:06 -0400
In-Reply-To: <CAK7LNAQ344PnS9e21E8yzhorKxKjH74P5Znkewz3c39gc1zBVg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Piotr Sroka <piotrs@cadence.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 14/08/17 18:28, Masahiro Yamada wrote:
> Hi Adrian,
> 
> 
> 2017-08-14 19:53 GMT+09:00 Adrian Hunter <adrian.hunter@intel.com>:
> 
>>> @@ -353,6 +390,28 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>>       return ret;
>>>  }
>>>
>>> +static int __maybe_unused sdhci_cdns_resume(struct device *dev)
>>
>> We don't use __maybe_unused in this case, we use #ifdef CONFIG_PM_SLEEP
> 
> 
> Could you tell me the reason
> why #ifdef CONFIG_PM_SLEEP is preferable?
> 
> I see lots of __maybe_unused for suspend/resume hooks in drivers.

Not in sdhci drivers.  It is easier for the maintainer to have consistency
across the code they maintain.

