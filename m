Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638ADC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23DE214D8
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 08:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy5SmFQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgJNIY4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgJNIYd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Oct 2020 04:24:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0DBC051121;
        Wed, 14 Oct 2020 00:44:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d3so1511100wma.4;
        Wed, 14 Oct 2020 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYv6LV+tqsOI+IfXR5MUkRZoCxqVk7n+cV4mcuQRLfc=;
        b=uy5SmFQT3YT48WJaJQg5nXxh6v9v8OMfyrWwyr2p5aEMvrmrmmOXUv1HfBS7BiZf67
         +3JFurLP7Nr/+3weJAil8/WlfAoC8YxJLRf7GZFovqoTjE13L0Fy3/PsKji5TZYaqioS
         5k+MGVkZfOlWcPveeVZO2NU+QoMumqIBCkEu8nM/dsF9HzwYT4um5Abw+Lrtkizj2GKu
         PsYJfQzCkJw097GmQVPnA74/DonU4YPRmXS7YnepV6BxHp3cuAKBf3+uW1XsGq2IRM2a
         n88MlOA6arljnOQrNGvVPAR6i/J8PqgccXwiYR+epE8yOYNMifVQyJO1Q5fThgUveF+v
         d8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYv6LV+tqsOI+IfXR5MUkRZoCxqVk7n+cV4mcuQRLfc=;
        b=kXmi/BkIoFbTXaGBfZABYCA8QhqXaEZ52ArdVSBtpzb9bNEDY6QriSFJfziPOzhsR9
         bH10+9uYYHHstBXgBhsTHWGTzz7k5JQrIU0+GOdsjD3ZD4rIuJAUIhydd8Xv5O8IfZTj
         5k8UhsKoB4VIb7DsA4w4S896vtap7BHWO4pgf76M3Z9fOCjavpbodIHK8R3AVv8sLhdt
         BCL6Hhr61Gb7XQSV3AZYlDqXwRK1eZYRhRhAfKQWVUn9+qZQIAThAvjL5fayLbL/Jym1
         jFoZxx6Gazex/ozlkVM3iA+SMl+LzPjHIPSuAOyB2vJn356maC0sSeFaIV6vlrGXtEFN
         kLIw==
X-Gm-Message-State: AOAM532Mx1d1ewyGlBpnZQ59OHHJwbBqaAqIfEfH2h3yom7bhxtJW1eT
        oz1k+8ckiAeQ9Veg4OHgdNU=
X-Google-Smtp-Source: ABdhPJyGeC6r5z4QmxGH1+GnYnKUJXfFMobiolTqz/z3GvRgTv2ghl9aA8gv/v5l/I04dIwk9SALng==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr2038352wmf.121.1602661479907;
        Wed, 14 Oct 2020 00:44:39 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id b63sm2649805wme.9.2020.10.14.00.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 00:44:39 -0700 (PDT)
Subject: Re: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for MT8192
 msdc
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
 <20201012124547.16649-5-wenbin.mei@mediatek.com>
 <72ae1d89-fe31-4f50-15c0-29119d662ea1@gmail.com>
 <1602642530.11864.3.camel@mhfsdcap03>
 <CANMq1KBe9u25yDxg8UtmOX4vhr8De=5-pJyMRkSBF4O=FpBN9A@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8bcc800b-fa1a-a42c-9fb7-a7546e889694@gmail.com>
Date:   Wed, 14 Oct 2020 09:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KBe9u25yDxg8UtmOX4vhr8De=5-pJyMRkSBF4O=FpBN9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 14/10/2020 05:06, Nicolas Boichat wrote:
> On Wed, Oct 14, 2020 at 10:29 AM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>>
>> On Tue, 2020-10-13 at 17:10 +0200, Matthias Brugger wrote:
>>>
>>> On 12/10/2020 14:45, Wenbin Mei wrote:
>>>> MT8192 msdc is an independent sub system, we need control more bus
>>>> clocks for it.
>>>> Add support for the additional subsys clocks to allow it to be
>>>> configured appropriately.
>>>>
>>>> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
>>>> ---
>>>>    drivers/mmc/host/mtk-sd.c | 74 +++++++++++++++++++++++++++++----------
>>>>    1 file changed, 56 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>>>> index a704745e5882..c7df7510f120 100644
>>>> --- a/drivers/mmc/host/mtk-sd.c
>>>> +++ b/drivers/mmc/host/mtk-sd.c
>>> [...]
>>>> +static int msdc_of_clock_parse(struct platform_device *pdev,
>>>> +                          struct msdc_host *host)
>>>> +{
>>>> +   int ret;
>>>> +
>>>> +   host->src_clk = devm_clk_get(&pdev->dev, "source");
>>>> +   if (IS_ERR(host->src_clk))
>>>> +           return PTR_ERR(host->src_clk);
>>>> +
>>>> +   host->h_clk = devm_clk_get(&pdev->dev, "hclk");
>>>> +   if (IS_ERR(host->h_clk))
>>>> +           return PTR_ERR(host->h_clk);
>>>> +
>>>> +   host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
>>>> +   if (IS_ERR(host->bus_clk))
>>>> +           host->bus_clk = NULL;
>>>> +
>>>> +   /*source clock control gate is optional clock*/
>>>> +   host->src_clk_cg = devm_clk_get_optional(&pdev->dev, "source_cg");
>>>> +   if (IS_ERR(host->src_clk_cg))
>>>> +           host->src_clk_cg = NULL;
>>>> +
>>>> +   host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
>>>> +   if (IS_ERR(host->sys_clk_cg))
>>>> +           host->sys_clk_cg = NULL;
>>>> +
>>>> +   /* If present, always enable for this clock gate */
>>>> +   clk_prepare_enable(host->sys_clk_cg);
>>>> +
>>>> +   host->bulk_clks[0].id = "pclk_cg";
>>>> +   host->bulk_clks[1].id = "axi_cg";
>>>> +   host->bulk_clks[2].id = "ahb_cg";
>>>
>>> That looks at least suspicious. The pointers of id point to some strings defined
>>> in the function. Aren't they out of scope once msdc_of_clock_parse() has returned?
>>>
>> These constants are not in stack range, so they will not be lost.
>> And I have confirmed it after msdc_of_clock_parse() has returned, these
>> ids still exist.
> 
> Yes I guess the constants end up in .rodata (or similar section), but
> I'm not sure if this is absolutely guaranteed.
> 
> In any case, this is a commonly used pattern, so I'd hope it's fine
> (just a sample, there are more):
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pcie-qcom.c#L266
> https://elixir.bootlin.com/linux/latest/source/sound/soc/codecs/wm8994.c#L4638
> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/madera-core.c#L467
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpio-dwapb.c#L675
> 

Alright, then this looks good, sorry for the noise!
Matthias
