Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B11CC6FD1D
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Mar 2023 20:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjC3U4S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Mar 2023 16:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjC3U4O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2023 16:56:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB65CC39
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2023 13:56:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kq3so19291486plb.13
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2023 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680209768;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk3AJcU0Vx2dUlJVSwRSD2rFIMPkaNP8pt8iHwIyw/I=;
        b=DxOkvfgyGlyZIdctyMoucrRwTgAvwdnFKYHtd6iQSv64o0bLznsU+3yzLh4wHENo5c
         12ynOk18zhZ0y95L2CbIDmbZ8i1k1/QpkV5T+HTRG1mTjVQe4JbSFYLZJjc4p0aK4gNA
         E6eS/ma0+SXAXwlAZkZYsYt325r2yj3PyANVjP+xrTTGesU5N/N0pB5EAtDYO2wU0vL7
         3ZjsPG/j9FxQp/xq1Hd1rrY8bdlANwqVnbNEmgU8g5yzpN0E54kxWlPi8scFowwBX/y+
         s6uKf6ztIucMnzTvdHXCrArvCd40ZLKLpCVtN72XC/258aNlybIufSvn1PhRRkWj1QHP
         tfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209768;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bk3AJcU0Vx2dUlJVSwRSD2rFIMPkaNP8pt8iHwIyw/I=;
        b=1pm7lhZK6aLOFAuYQ39fXqeU5bEmevroMmSqva4mKVGoqCnDhHEOOrKytVUV8U8l4N
         T6ZtADayEregkrTusTztpKaY0QZgUZJdueKvzvonI3mhaaE8ZGOa8AOZLVPtwGbVbHmT
         wuHsdtCiDdd0RosYYr85TmygFc+lGTcz1Gm57EDESDfJpSfK8XM5TmCjmNGxGQa55BH3
         NwIGboiEDTHkm0DflZh0nqtTSUqX5Yera+3SCSOfJoCFMy3nF4PvFH71/ZkEZeivBTdj
         IihrEoggi++vByNXImkXhfGNkCQJVWA9C3GsK5xxre0BjkwBC0/e3s7Jx+7xHFiph1o5
         rMvw==
X-Gm-Message-State: AAQBX9dZOyzOEdxHM1+53rEp1cuG2IFjEWsJhSDy/PwOQFtDhihtngWj
        sMzg4Zq62RrWyy0D/Vxq2HtuGw==
X-Google-Smtp-Source: AKy350YUmLiSO/0zx78yxuNvIBq/d2XMWROc3sNsblZMXAHe6u6xTxhKGFofc2ryyJ1Tl2KTks3vBw==
X-Received: by 2002:a17:903:708:b0:1a1:bfe8:4fae with SMTP id kk8-20020a170903070800b001a1bfe84faemr22003294plb.43.1680209768644;
        Thu, 30 Mar 2023 13:56:08 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b00198d7b52eefsm128062pls.257.2023.03.30.13.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:56:08 -0700 (PDT)
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
Subject: Re: [PATCH v3 00/17] Improve the MT8365 SoC and EVK board support
In-Reply-To: <CAFGrd9p7oPvhZ8KL40XYfNi2CAdEd8BZWrXPqfcqu7DTSSg4Kw@mail.gmail.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <7h8rffyu9x.fsf@baylibre.com>
 <CAFGrd9p7oPvhZ8KL40XYfNi2CAdEd8BZWrXPqfcqu7DTSSg4Kw@mail.gmail.com>
Date:   Thu, 30 Mar 2023 13:56:07 -0700
Message-ID: <7h1ql6yn4o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> Le jeu. 30 mars 2023 =C3=A0 02:09, Kevin Hilman <khilman@baylibre.com> a =
=C3=A9crit :
>>
>> Alexandre Mergnat <amergnat@baylibre.com> writes:
>>
>> > This commits are based on the Fabien Parent <fparent@baylibre.com> wor=
k.
>> >
>> > The purpose of this series is to add the following HWs / IPs support f=
or
>> > the mt8365-evk board:
>> > - Watchdog
>> > - Power Management Integrated Circuit "PMIC" wrapper
>> >   - MT6357 PMIC
>> > - MultiMediaCard "MMC" & Secure Digital "SD" controller
>> > - USB controller
>> > - Ethernet MAC controller
>> >
>> > Add CPU Freq & IDLE support for this board.
>> >
>> > This series depends to another one which add support for MT8365 SoC and
>> > EVK board [1].
>>
>> It seems to depend on more than that series.  In order to test this, I
>> tried applying this series on top of Bero's minimal support (now in
>> linux-next), and it does not apply cleanly.
>>
>> Could you please list all the dependencies that are not yet upstream.
>
> Hi Kevin,
> You're right, it also depend to
> https://lore.kernel.org/all/20221122-mt8365-i2c-support-v6-0-e1009c8afd53=
@baylibre.com/

Nope. Something else is missing too.  I tried this series on top of
Bero's series + i2c series and still doesn't apply cleanly.  Look like
some pinctrl stuff is also missing[1].

Kevin

[1]
 Link: https://lore.kernel.org/r/20230203-evk-board-support-v3-0-0003e80e00=
95@baylibre.com
 Base: base-commit 555b3a55823ec063129de4403899203febb58788 not known, igno=
ring
 Base: not specified
       git am /ssd/work/tmp/b4.mbx
Applying: dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365
Applying: dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add drive strength=
 property
error: Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.ya=
ml: does not exist in index
Patch failed at 0002 dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add dri=
ve strength property


