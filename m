From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v3 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Tue, 21 Mar 2017 10:50:24 +0900
Message-ID: <CAK7LNAR_i0Q0jymENMSxu-hn4S3KQ3kEwbPmju1H5K2pmMranw@mail.gmail.com>
References: <1489754302-10996-1-git-send-email-piotrs@cadence.com>
 <1489754503-16559-1-git-send-email-piotrs@cadence.com> <CAK7LNAQGOeZVqvc=6Agq2xN5B5cBMtaCAkS8-V6uBoO1ziSSuw@mail.gmail.com>
 <DM5PR07MB308222A445B7A39CBFE4896ADD3A0@DM5PR07MB3082.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from condef-07.nifty.com ([202.248.20.72]:32012 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbdCUBzc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 21:55:32 -0400
In-Reply-To: <DM5PR07MB308222A445B7A39CBFE4896ADD3A0@DM5PR07MB3082.namprd07.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Piotr,

2017-03-20 17:47 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
>
>>
>> > @@ -227,6 +267,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>> >         struct sdhci_cdns_priv *priv;
>> >         struct clk *clk;
>> >         int ret;
>> > +       struct device *dev = &pdev->dev;
>> >
>> >         clk = devm_clk_get(&pdev->dev, NULL);
>>
>>
>> If you add "dev", please use it for devm_clk_get, too.
>>
> I did on the first patch version but Ulf pointed that this is unrelated change and should be removed.
> Therefore I remove it.

Ah, OK.

Could you consider to send a separate patch for this?




-- 
Best Regards
Masahiro Yamada
