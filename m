From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Sat, 18 Mar 2017 02:22:43 +0900
Message-ID: <CAK7LNARu=ozunUudPpcPokScR6rAFNkh24+rwd3UVeFR4p+oEA@mail.gmail.com>
References: <1488807587-5375-1-git-send-email-piotrs@cadence.com>
 <CAK7LNATAa7svo_DrotgM0XKMhLbZ2Qum8qe6fJxxf4Z+ouH_wA@mail.gmail.com>
 <DM5PR07MB308240E2DC885342BA477D04DD2F0@DM5PR07MB3082.namprd07.prod.outlook.com>
 <CAK7LNAT_ATrohuDx0sCaPp+5GUc-hLvrUGKX921U2OKcqcCUZQ@mail.gmail.com> <MWHPR07MB3088821EDD127BD6BF1A1EDFDD250@MWHPR07MB3088.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:64883 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQRXE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 13:23:04 -0400
In-Reply-To: <MWHPR07MB3088821EDD127BD6BF1A1EDFDD250@MWHPR07MB3088.namprd07.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Piotr,

Sorry for my late reply.


2017-03-13 16:57 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Hi Masahiro
>
>> -----Original Message-----
>> From: Masahiro Yamada [mailto:yamada.masahiro@socionext.com]
>> Sent: 09 March, 2017 3:37 AM
>> Subject: Re: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay configuration
>>
>> Hi Piotr,
>>
>> 2017-03-07 20:00 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
>> > Hi Masahiro,
>> >
>> >> -----Original Message-----
>> >> Sent: 07 March, 2017 9:03 AM
>> >> To: Piotr Sroka
>> >> Subject: Re: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay
>> >> configuration
>> >>
>> >>
>> >> With this patch, we will have two groups for PHY parameters.
>> >>
>> >> (A) specified via a data array associated with a compatible string
>> >>
>> >> (B) specified with DT property
>> >>
>> >> I am confused.
>> >> What is the difference between (A) and (B)?
>> >
>> > The first group of delays are input delays. These delays are set in current version of sdhci-cadence driver in sdhci_cdns_phy_init
>> function.
>> > Following by spec:
>> > They are provided to help in meeting timings relations between data window and sampling clock.
>> > The clock is fixed position in respect to the SDCLK. And the idea of sampling is to delay and align the data to the data window.
>> > If the default values of the delays are not sufficient/correct for the
>> > chip/board implementation those can be adjusted
>> >
>> > The second group are DLL delays.
>> > There are three delays
>> > SDHCI_CDNS_PHY_DLY_SDCLK  - sdclk delay line use to delay outgoing
>> > sdclk signal SDHCI_CDNS_PHY_DLY_HSMMC - sdclk delay line use to delay
>> > outgoing sdclk signal for for HS200, HS400 and HS400ES
>> > SDHCI_CDNS_PHY_DLY_STROBE - DLL strobe delay for HS400ES Following by spec:
>> > They allows to setup basic DLL parameters. In general the default values are sufficient to start working in any speed mode. The
>> default values of delays and phase detect select can be adjusted depending on the chip/board implementation.
>>
>>
>>
>> It was not clear what makes one group different from the other.
>>
>> After all, parameters from both groups
>> should be adjusted depending on chip/board implementation.
>>
>>
>> > In general all PHY delays values either should be properly hardcoded in HW or they should be properly set  by FW depending on the
>> chip/board.
>> > So PHY driver should do not touch PHY delays at all or should set values which are proper for specific chip/board.
>> >
>> > I am not sure where exactly they should be placed in dts file or in compatible data.
>>
>> I am not quite sure, either.
>> (comments are appreciated.)
>>
>>
>> FWIW:
>> The first group (data associated with compatible) allows per-chip adjustment,
>> but not per-board.   Pros are, we will not break DT compatibility,
>> and we can avoid a list of properties difficult to understand.
>> Cons are, we can not make fine-grained adjustment for each board.
>>
>>
>> The second group (DT property) gives more flexibility for per-chip and per-board adjustment.
>> A bad thing is we will end up with specifying a bunch of mysterious properties from DT.
>>
>>
>
> It looks that "input delays" and "DLL sdclk delays" should be defined in dts file because they depend on a chip and a board implementation. On the other hand the less dts properties the better.
>
> There is one more way to handle input delays. It can be achieved by PHY training. PHY training is similar to the tuning and it should be done when proper timing mode is selected and clock frequency is set.
> To make it possible the sdhci_set_ios function need to be global. Then I could create sdhci_cdns_set_ios function as follows:
> void sdhci_cdns_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> {
>         . . .
>
>         sdhci_set_ios(mmc, ios);
>         /* execute PHY training if needed */
>         sdhci_cdns_exec_phy_training(host);
> }
>
> The mmc framework configures timing and frequency separately so PHY training should be executed every time if timing or clock frequency is changed. I am not sure If I can change sdhci_set_ios to global function.


I am OK with this, but I hope Adrian can advise us.




> So maybe put all delays to dts file would be a better solution? What do you think?

I am OK with DT approach too
because this way seems simpler, after all.

(My suggestion for data array approach was misleading, sorry.)





-- 
Best Regards
Masahiro Yamada
