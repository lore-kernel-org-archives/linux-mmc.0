From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Wed, 29 Mar 2017 14:59:05 +0300
Message-ID: <040f3ee3-d715-3696-4f35-6f5b77b6b984@intel.com>
References: <1488807587-5375-1-git-send-email-piotrs@cadence.com>
 <CAK7LNATAa7svo_DrotgM0XKMhLbZ2Qum8qe6fJxxf4Z+ouH_wA@mail.gmail.com>
 <DM5PR07MB308240E2DC885342BA477D04DD2F0@DM5PR07MB3082.namprd07.prod.outlook.com>
 <CAK7LNAT_ATrohuDx0sCaPp+5GUc-hLvrUGKX921U2OKcqcCUZQ@mail.gmail.com>
 <MWHPR07MB3088821EDD127BD6BF1A1EDFDD250@MWHPR07MB3088.namprd07.prod.outlook.com>
 <CAK7LNARu=ozunUudPpcPokScR6rAFNkh24+rwd3UVeFR4p+oEA@mail.gmail.com>
 <DM5PR07MB308228CF27D659686132429EDD3A0@DM5PR07MB3082.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR07MB308228CF27D659686132429EDD3A0@DM5PR07MB3082.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20/03/17 10:38, Piotr Sroka wrote:
> 
> 
>> -----Original Message-----
>> From: Masahiro Yamada [mailto:yamada.masahiro@socionext.com]
>> Sent: 17 March, 2017 6:23 PM
>> Subject: Re: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay configuration
>>
>> Hi Piotr,
>>
>> Sorry for my late reply.
>>
>>
>>>
>>> It looks that "input delays" and "DLL sdclk delays" should be defined in dts file because they depend on a chip and a board
>> implementation. On the other hand the less dts properties the better.
>>>
>>> There is one more way to handle input delays. It can be achieved by PHY training. PHY training is similar to the tuning and it should be
>> done when proper timing mode is selected and clock frequency is set.
>>> To make it possible the sdhci_set_ios function need to be global. Then I could create sdhci_cdns_set_ios function as follows:
>>> void sdhci_cdns_set_ios(struct mmc_host *mmc, struct mmc_ios *ios) {
>>>         . . .
>>>
>>>         sdhci_set_ios(mmc, ios);
>>>         /* execute PHY training if needed */
>>>         sdhci_cdns_exec_phy_training(host);
>>> }
>>>
>>> The mmc framework configures timing and frequency separately so PHY training should be executed every time if timing or clock
>> frequency is changed. I am not sure If I can change sdhci_set_ios to global function.
>>
>>
>> I am OK with this, but I hope Adrian can advise us.

There is no problem exporting sdhci_set_ios()

>>
>>
>>
>>
>>> So maybe put all delays to dts file would be a better solution? What do you think?
>>
>> I am OK with DT approach too
>> because this way seems simpler, after all.
>>
>> (My suggestion for data array approach was misleading, sorry.)
>>
> Thanks for review anyway it was useful. Now decision between DTS and data array is more clear for me. 
> 
> Regards 
> Piotr Sroka
> 
