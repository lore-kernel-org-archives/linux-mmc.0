From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-cadence: add suspend / resume support
Date: Tue, 15 Aug 2017 00:28:07 +0900
Message-ID: <CAK7LNAQ344PnS9e21E8yzhorKxKjH74P5Znkewz3c39gc1zBVg@mail.gmail.com>
References: <1501724656-12435-1-git-send-email-yamada.masahiro@socionext.com>
 <1501724656-12435-5-git-send-email-yamada.masahiro@socionext.com> <91131416-055e-71f8-d0f9-7784776e454d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <91131416-055e-71f8-d0f9-7784776e454d@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Piotr Sroka <piotrs@cadence.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,


2017-08-14 19:53 GMT+09:00 Adrian Hunter <adrian.hunter@intel.com>:

>> @@ -353,6 +390,28 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>       return ret;
>>  }
>>
>> +static int __maybe_unused sdhci_cdns_resume(struct device *dev)
>
> We don't use __maybe_unused in this case, we use #ifdef CONFIG_PM_SLEEP


Could you tell me the reason
why #ifdef CONFIG_PM_SLEEP is preferable?

I see lots of __maybe_unused for suspend/resume hooks in drivers.


-- 
Best Regards
Masahiro Yamada
