Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E8CC761AF
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 00:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDDAEO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjDDAEM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 20:04:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8B3AB7
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 17:04:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso32231650pjb.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Apr 2023 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680566649;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISmF8nvjx0ybm2sJtfCgvvFezmys6zwifQtFbY4uoY8=;
        b=MwdHJ64U4y9L9kZbHHfLVw/Yd20B0fWkelqUdVZKhghqkkLvcPVf5B/6AWkmBB4Iix
         +6tiPsqWaXqSXSn8S84GPwhqvDiSgDDTDKeDa2hvLDLi4j/+CCABcLPq8xaRpG0Pt/iR
         m3n/ZBnrLEegJD9Zp4IhyYwIdwet6dag19biR/jtwRQx3RjBfYuWQG3kN4WLeo20GAGh
         s//j38Y0q8steIx9r+nGeDisdVHWCpXQnX2VxW9sXQnriP1zNanKE+3pzzt6D7jTcNcU
         P+OKQEdq0B2mVWPvnZQ8CFsCe6JC6fhVy+6K1pAUcoLK6Sje4zLwkgVCCeqAr9kEdmp3
         SwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680566649;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISmF8nvjx0ybm2sJtfCgvvFezmys6zwifQtFbY4uoY8=;
        b=EsfhTiPqdopqE9NIfGku328DYMN+KwX4Vo1j8J0ntKQx/vTFaNA4AaYrL6N+wXjDOy
         i7YWgi8vWhpWatZEB+Xf7M8CcT3Yh6LZEZVbsGsNj6uGu+SbCKh/vrcnxVmuQKrVS+16
         RbLl3LfR8OjDxH3UdCGnBhCUv+DJhjvsef7jsXnKzDugDUfgAPsqyiqxSy7+fjwxPoCh
         Nk0U+cOrXRLJ7ys5G4w9h6SpKgsEyFRf1Wtk1mRyoZi2V/d6q61+X+cX1RelBcNFMlME
         aQJkagqXj/flyLs/TlH95yU38Tc04KMExNenK303xdyKQ3oejWYAms8GGwXnevWuJjAc
         1x8w==
X-Gm-Message-State: AAQBX9fcCreUIcv2JyragR4Guk8GxSxRvDYvtzxyQt2Jn98nLYZARTtO
        K1rcjab0gfgIb1io47N6doAzHg==
X-Google-Smtp-Source: AKy350ZCXF7QNH2FUbpLyZBKB7LqVlEd3NIT2fIvf/7ilkhxZ2ZkkRksxI97+pH7cPZRyzcqEjxgZA==
X-Received: by 2002:a05:6a20:ba9c:b0:de:807e:620e with SMTP id fb28-20020a056a20ba9c00b000de807e620emr343481pzb.58.1680566649333;
        Mon, 03 Apr 2023 17:04:09 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b005023496e339sm6318991pgl.63.2023.04.03.17.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:04:08 -0700 (PDT)
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
In-Reply-To: <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
 <7hy1ncydtc.fsf@baylibre.com>
 <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
Date:   Mon, 03 Apr 2023 17:04:08 -0700
Message-ID: <7h4jpwy0lj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> You forgot to apply the patches merged by Matthias:

Because they weren't listed as dependencies. :)

Kevin

> Changes in v4:
> - Remove v3 applied patch from the serie:
>   - arm64: dts: mediatek: add ethernet support for mt8365 SoC
>   - arm64: dts: mediatek: add mmc support for mt8365 SoC
>   - arm64: dts: mediatek: add mt6357 device-tree
>   - arm64: dts: mediatek: add pwrap support to mt8365 SoC
>   - arm64: dts: mediatek: Increase the size BL31 reserved memory
>
> ...
>
> Changes in v3:
> - Remove v2 applied patch from the serie:
>   - dt-bindings: mmc: mediatek,mtk-sd: add mt8365
>
> Regards,
> Alex
