Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A0C761A6
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Mar 2023 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjC3AJf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Mar 2023 20:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC3AJd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Mar 2023 20:09:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBC84202
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2023 17:09:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x37so10346163pga.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Mar 2023 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680134971;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/f6kuz/aoEQ4OdZFUZeQhJ2qbcXsJoCNBezisNQzSyA=;
        b=5Kg0RdKhyt1ID55+N/2TYj6ASuDLlE9kRuP0jfiHD4WW7DHikuXWKM2Wa7enwDIIr2
         gHlkiUBISnQXA9MZiTvb2L7nCORsEoGs6XoF+wsbiSQtLp/7J6DseD+18SbWFxpI4biV
         hQqxeFg7tKw1YsyWeuU8P/xbxdpa4pmuQPIoHXo3alTyYmN6tUAtJ7Xt8GHhts7ujCmH
         nmucmTfbtQPVS1TZsAvug12n2oGmAGh4M7rY4dAn9wuJiBRL/PWq59a3lMLkVvET/tI6
         1/jqnqK85F1+ixeZDTcYh4MwV0DmzPcq1a9gFhhYTKq6jpWEoILS9qgt94YioVUj+1wr
         w+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680134971;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/f6kuz/aoEQ4OdZFUZeQhJ2qbcXsJoCNBezisNQzSyA=;
        b=HYHQnBDKBwOZV3pBfRDshvGz81LK+ZzLTkvg5rF3cqXSU6OGmLP69qV8ZDmFdyXsD7
         rPcKduSnvAoEfrQ30vKio0aQW+miU9LQplyqdZxVn6eVaa6IpKc4uQFumqoY3ZLkuhHV
         iP/njxqrYjXY8lyzco3P6wlfNQ9CwrfeYcgryd4Q2kX8CKxlox6fRJbrSvL+m1ZcRB+m
         zVvAhI6UA7jYta8mHBOTDxFrzrWOsW/bTd4yoEc12Fq0M1tDVCl7jdY9rKXRJknv5Sow
         1a++Ua+Ltv4SkXHn4wjVdworiJwL0ojEWoXZ5Sct0NBXOhUwipMtL+nDm+BbY26h566b
         Slmw==
X-Gm-Message-State: AAQBX9cm0dU0QW0lsQScNlJDK2/0GSRjn+k+vQWPVNynZ+supfdASel9
        uisZwRg2YcTuwnw6PJw0rZoYYw==
X-Google-Smtp-Source: AKy350ZqpWfQPvqSLpocQ8IdxE8V92Qac7/wDI/66IsLf2Y5AbMcbw++dG5+dtf9jgtCifCda5nNOg==
X-Received: by 2002:a62:1885:0:b0:623:d058:8661 with SMTP id 127-20020a621885000000b00623d0588661mr17961473pfy.28.1680134971465;
        Wed, 29 Mar 2023 17:09:31 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0062505afff9fsm23574889pff.126.2023.03.29.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 17:09:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 00/17] Improve the MT8365 SoC and EVK board support
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
Date:   Wed, 29 Mar 2023 17:09:30 -0700
Message-ID: <7h8rffyu9x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> This commits are based on the Fabien Parent <fparent@baylibre.com> work.
>
> The purpose of this series is to add the following HWs / IPs support for
> the mt8365-evk board:
> - Watchdog
> - Power Management Integrated Circuit "PMIC" wrapper
>   - MT6357 PMIC
> - MultiMediaCard "MMC" & Secure Digital "SD" controller
> - USB controller
> - Ethernet MAC controller
>
> Add CPU Freq & IDLE support for this board.
>
> This series depends to another one which add support for MT8365 SoC and
> EVK board [1].

It seems to depend on more than that series.  In order to test this, I
tried applying this series on top of Bero's minimal support (now in
linux-next), and it does not apply cleanly.

Could you please list all the dependencies that are not yet upstream.

Thanks,

Kevin
