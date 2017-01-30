From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Mon, 30 Jan 2017 23:12:10 +0800
Message-ID: <ed6e5125-85ef-5644-e589-bd5b4be4c84a@marvell.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
 <461fd409-81e8-2c3f-3674-ec593e1c7383@marvell.com>
 <CAPDyKFoERET6Fzc7qEGWJ95t6GZir=XJWfTEoRSEROjPgJ95hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoERET6Fzc7qEGWJ95t6GZir=XJWfTEoRSEROjPgJ95hg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2017/1/30 16:41, Ulf Hansson wrote:
> [...]
> 
>>>> + */
>>>> +static int xenon_child_node_of_parse(struct platform_device *pdev)
>>>> +{
>>>> +       struct device_node *np = pdev->dev.of_node;
>>>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>>>> +       struct mmc_host *mmc = host->mmc;
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>> +       struct device_node *child;
>>>> +       int nr_child;
>>>> +
>>>> +       priv->init_card_type = XENON_CARD_TYPE_UNKNOWN;
>>>> +
>>>> +       nr_child = of_get_child_count(np);
>>>> +       if (!nr_child)
>>>> +               return 0;
>>>> +
>>>> +       for_each_child_of_node(np, child) {
>>>> +               if (of_device_is_compatible(child, "mmc-card")) {
>>>
>>> To avoid code from being duplicated, I would rather see the DT parsing
>>> of the child nodes for "mmc-card", to be done by the mmc core.
>>>
>>> As a matter of fact it is already being done, but perhaps we need to
>>> change that a bit as to fit your case.
>>>
>>> I suggest you have a look and see how to update this in the core,
>>> instead of doing it here in the host driver.
>>>
>>
>>     I understand your concern.
>>
>>     It seems that so far "mmc-card" is only used in our Xenon driver.
> 
> git grep "mmc-card" tells you more about where it's being parsed by
> the mmc core.
> 
>>     Besides, we set Xenon specific parameters and attributions when
>>     parsing "mmc-card" property.
> 
> I don't see any Xenon specific properties.
> 
> Instead I think it would make sense to update the generic
> interpretation of the binding for mmc-card, as you have done here.
> 

   OK. I will merge it into core layer.
 
   Our Xenon driver requires to determine whether current SDHC is
   for eMMC before card init. Thus I would like to implement a specific
   function for mmc-card parsing in mmc.c and let mmc_of_parse() in host.c
   to call it.
   But there are some detailed issues then.
   1. mmc_decode_ext_csd() also parses mmc-card to check broken-hpi.
      So mmc-card parse will still be duplicated.
      Shall we merge broken-hpi check into mmc-card parse?
      It might require a new flag to indicate broken-hpi attribution in
      mmc_host structure.

   2. Structure mmc_card is not ready while parsing mmc-card.
      Thus we are not able to indicate card type in mmc_card.
      As a result, our Xenon specific parse function still has to
      parse mmc-card again to check if eMMC card is in used.

   Could you please help suggest any better place in core layer to
   parse mmc-card?

   Thank you.

Best regards,
Hu Ziji

>>
>>     May I keep current implementation?
> 
> Rather not. Let's try to make the parsing of the child node for
> mmc-card generic.
> 
>>     In my very own opinion, moving it into core layer should be another
>>     independent patch.
> 
> Absolutely an independent patch. Whether it can be done as a part of
> mmc_of_parse() or whether we need yet another new mmc_of* API, we can
> discuss.
> 
> My point is that, I don't this to be specific for Xenon (unless there
> are specific reason, which I don't see here).
> 
>>     And it will also cost some more time. To be honest, it is difficult
>>     for me to bring up a generic core layer implementation to parse
>>     "mmc-card", since I'm not clear about other vendor's requirement.
> 
> Well, then you need to learn more about how the mmc core works. In
> this case, it shouldn't be too hard to implement.
> 
> [...]
> 
>>
>>>
>>>> +                                     MMC_CAP2_NO_SD |
>>>> +                                     MMC_CAP2_NO_SDIO;
>>>
>>> I think we need to update the DT documentation for mmc-card.
>>> Typically, we should explicitly state what kind of other existing mmc
>>> DT properties that will be automatically selected, when the mmc-card
>>> is specified.
>>>
>>> Can you please look into updating this DT doc as well.
>>>
>>
>>   Similar to above, may I keep it now and bring up another patch later
>>   to update mmc-card DT and parsing?
> 
> Please, no.
> 
> [...]
> 
> Kind regards
> Uffe
> 
