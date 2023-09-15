Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B2EE021D
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Sep 2023 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjIOFvz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Sep 2023 01:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIOFvy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Sep 2023 01:51:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D492715
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 22:51:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so2046732a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694757105; x=1695361905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAviJiHnDWn37yrY/+TDS6dv356bJe/3IP+axIRqyaY=;
        b=PrUxW2H8unYtNgDLDeqdFYWFgVpt/4cUd3x7liLJvrutVZVewvdFn8vZQkUsh32tSz
         ZXBIvEDbXswEYTir+wlToCQYaSglOSki/p1hSjqIxrlZ98tevtYKwMSOtX5vCCy7GYZY
         GLjmYY+8I8mOpLIzkBOdpa2o03l82+nU7GBqo0X8pgYRfIOEv20P4M1UAVGCBRjfz/JF
         c10y2w4bDG4IeIpbiqJE7DMu5lXfMzZ1NDVZ7VvZbxENFDgFV0fYMGml8jO4ekkKowBH
         7yXGxICf/yzY1VtbMJOl5ODVZPEH3srPhVkglre8iNFPIkdvwL37gJpAFpjL8ODJBd5m
         e5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694757105; x=1695361905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAviJiHnDWn37yrY/+TDS6dv356bJe/3IP+axIRqyaY=;
        b=SCKHXCVzRHoMaJHDLDxpwUFzbMZyuzGPynMAOzRZ6ha7A7xWWsM45/x07qnzz8rBeF
         0xXXK0Q++Gi86DLHGZzHB7kbiu0i4wXQRkRY8u/wYk/wBSmEl+noP1fv/Kk6utd5S+C7
         H2/vHyd5jw9HY8kHX2rvJ5F9AIwFxUaiV39UfPazBxbjLvlr6Xi4+4vHs/V0rw4x73u1
         HDZ7Zk6rE0kSu/PoPtCj1rvO/D8jsc5i+4tz8Ukkue7cy9/EmZROqFyutu0qTj79ObtU
         TR205N/CrstJOHH/CP5uRIhpZ1zElXMSOupiqhdcvWEOHsQVEkcwr1wa+Tnn0Rm+8DZt
         3uNg==
X-Gm-Message-State: AOJu0YxXVXnU1Ph+VkgX7n2RLjPLG+YrZKGasa/BBJ+iYZcrBJNhaUlU
        grTA8WLmU9M/yhQodDx7g8dUzw==
X-Google-Smtp-Source: AGHT+IF8/RuLa2dvtV/6+atyydlIiT0muAbHJl0SRDscKsAC1bMSvB/A1IkkRbsxTp4mEQITtSGTeA==
X-Received: by 2002:a05:6402:164b:b0:523:2e63:b9b with SMTP id s11-20020a056402164b00b005232e630b9bmr571283edx.24.1694757104741;
        Thu, 14 Sep 2023 22:51:44 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b005231e3d89efsm1747955edx.31.2023.09.14.22.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 22:51:44 -0700 (PDT)
Message-ID: <f0aa7983-0300-ce21-8726-41d033f6afbe@tuxon.dev>
Date:   Fri, 15 Sep 2023 08:51:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 12/37] clk: renesas: rzg2l: reduce the critical area
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-13-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVLx1d-6=5xx_GLAb7LxxRR9FwhAU56fxNc3b=9wj286g@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVLx1d-6=5xx_GLAb7LxxRR9FwhAU56fxNc3b=9wj286g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 14.09.2023 16:12, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
>> to hardware register. There is no need to protect the instructions that set
>> temporary variable which will be then written to register. Thus limit the
>> spinlock only to the hardware register access.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>> @@ -912,13 +912,13 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
>>
>>         dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
>>                 enable ? "ON" : "OFF");
>> -       spin_lock_irqsave(&priv->rmw_lock, flags);
>>
>>         value = bitmask << 16;
>>         if (enable)
>>                 value |= bitmask;
>> -       writel(value, priv->base + CLK_ON_R(reg));
>>
>> +       spin_lock_irqsave(&priv->rmw_lock, flags);
>> +       writel(value, priv->base + CLK_ON_R(reg));
>>         spin_unlock_irqrestore(&priv->rmw_lock, flags);
> 
> After this, it becomes obvious there is nothing to protect at all,
> so the locking can just be removed from this function?

I tend to be paranoid when writing to hardware resources thus I kept it.
Would you prefer to remove it at all?

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
