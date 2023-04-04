Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17DEC77B62
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 14:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjDDO7K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjDDO6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 10:58:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65359D2
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 07:58:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ix20so31545489plb.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680620283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9uYwVcXo7cBUUBOTLZ2J2lrgVJ/xfkFZclj3HBehK8=;
        b=UAETlx+9wQOEYw9NkD5esQ22zJR9CYzlPJFuuru/zG8A7bcoHUo5CXJ9VMeQYHfVj4
         a6KAda1lEkoabUz13lUVXFC0HOTYZxNrY28ZtkJwknBw2NpS4RPwtznfSXXUrdnZI0T7
         QmwkjqpQrUKWOZC3HtGUeObmFnSzFFtkmfJSqhp40MV8d2URnW6nb/8H83pnqsLUpNCo
         9E4Ebl0P7KOXfKbvh46S7fB2ewb8ceCDSz600lMgQ4Jr1IKVVBcoP4jovOaIi2xfINbo
         ZiZlIOrHGJNGygni7UnfXlF+ipe0cAdJEAT54EvufshEYUUh8gD6sHYaV/jSusLemeot
         wXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620283;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9uYwVcXo7cBUUBOTLZ2J2lrgVJ/xfkFZclj3HBehK8=;
        b=BWwgABQPUO3JV9haf2VZZ+7GdPjkK332x5B2LW/Kw9woZY0Ww7u83zJkrtFLWdoeNS
         Qr0DeRvPoT+kodXKbY7IY7ykTbepwHtzEegm1RN2XT5x3jFPlPdel9VvIWmvCJpRopmW
         ZKsRS4559AIn1Ba7aMbDB4UWWA2GjsfdtEXYVtcFe1JW4YPRzVSFFxXCOcdMGONjDKv/
         VcAsjQhIaZyKSJCS2FNejxu3+EtJcqBUMlh7h7wLF3flpUJ31PHkpGxJk184yTANH7I9
         j+gXDFSM/kZFrYgqKANkC3zL1AeOUP2Pbuo7lisZUBzVyDRcLtUMhSCjVw4K6bu58rMg
         oFFg==
X-Gm-Message-State: AAQBX9cSo3zY/jcQHwHMjRSXtMl5+VPqsObQToPr4jHcW6xkq81c7pYa
        aacSfsvRfyzdp26FGS/2ypynVg==
X-Google-Smtp-Source: AKy350YdY2blg+WDMTITRqonrmBC853Tqawrwror3LCdLvv5uZ3X8E8eImt5a/UgDnCMC9oeW3hnfg==
X-Received: by 2002:a17:902:ec92:b0:1a2:87a2:c91a with SMTP id x18-20020a170902ec9200b001a287a2c91amr3262702plg.34.1680620283196;
        Tue, 04 Apr 2023 07:58:03 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902761100b0019ef86c2574sm8381272pll.270.2023.04.04.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:58:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <bero@baylibre.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
In-Reply-To: <7h1ql0y0j7.fsf@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
 <7hy1ncydtc.fsf@baylibre.com>
 <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
 <CAFGrd9qLzcDJO_Fk_-B6XYuuxQzQoYLXmdp0Qj1Tszr0-sqNgw@mail.gmail.com>
 <7h1ql0y0j7.fsf@baylibre.com>
Date:   Tue, 04 Apr 2023 07:58:01 -0700
Message-ID: <7hy1n7wv7q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Alexandre Mergnat <amergnat@baylibre.com> writes:
>
>> Here a build-able & working branch with dependencies:
>> https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/amergnat/i350-evk-board-support
>
> This branch doesn't compile.

I'm wrong, it compiles fine.  I was on the wrong branch.

Sorry for the noise,

Kevin
