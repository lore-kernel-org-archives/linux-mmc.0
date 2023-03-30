Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463D5C6FD1D
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Mar 2023 09:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC3Jyq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Mar 2023 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjC3Jyn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2023 05:54:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE36A63
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2023 02:54:40 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m16so2383522ybk.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2023 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680170079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbyws3H75gB+yatcu0+FBMyILwRxUxSpq4AefwZkLKg=;
        b=mZsCUYHtWVu0vKKEGZmsGvkF+uy4o1aUwHzHWz89XldmLe8AQt/HxwPKXCnk93KRbH
         V8UAN9+MMCbN5JvfzvF+7noo3B3ZC1SlListXXAlyAe/Si2dth9gBK0ZYJ1pNZjq9WpB
         iNKgAFfirtS5iYb0r3mNi+HVpohWdyNPRun52UqeTAcSf+8ut/tE0fXdPt8xlgEB0Xiy
         Rj4pHSlWP9szJ+wDfC+QfLt2W4ckBGmT2H86xnDFs4tatnn3zZjeDGcEbbnYNyzNRnHm
         anAKm5idqzYX1EilwXDVQL2PFUkUsY4u2ooCexDw3QuTQhI2n1gfk4TR7i0W9tXx8lZp
         mHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pbyws3H75gB+yatcu0+FBMyILwRxUxSpq4AefwZkLKg=;
        b=kLpBmJByRIOaX0XXpvnBjDfKfnxrM6KnwTLwTHiSwW8pbyof7ahJRMWw1ObVFkZIU7
         Qell/PbriteHKuXgBPTxvV96iypyRUx8SdVpgNRWMpSCuR1AswOj9+2RcSHMXb64NcO0
         lnBf3bAxYrdZ2bszroyuU3auz/mjuOI/bljEixXuz+QqNd/0ctWHu1jDvPJIW3//bBs0
         8aqqJnuh6EaEL8dCoHmOPwGw3mjW9CoQJIHt46azEm24kzW7GIxIVk441tgyMJCbUxIy
         MN1hj3uUAGIY/9AXWJ5EZE7HQXvfEOTvDJUJx62/y4UbzPhSVmMrSK665TZVUBTZoZOl
         y2Xw==
X-Gm-Message-State: AAQBX9cqcvBETYqVoKh+J7EylAsmlYdlCsGlsLicv9R+KjnlHTI38+pe
        bPlKeam8Iy6n1QOmpsFhiyYm3q1+RP/yPYdmq0lM4g==
X-Google-Smtp-Source: AKy350bEejlHh/La/ICbG+v0y62RclEvzaIlO/L71B6Mcr7xujU2ePyASX64lF1cgA+JnYGg8IIpcjjXYY2L1pzN96g=
X-Received: by 2002:a05:6902:1501:b0:b6d:80ab:8bb6 with SMTP id
 q1-20020a056902150100b00b6d80ab8bb6mr15155725ybu.1.1680170079704; Thu, 30 Mar
 2023 02:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com> <7h8rffyu9x.fsf@baylibre.com>
In-Reply-To: <7h8rffyu9x.fsf@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 30 Mar 2023 11:54:27 +0200
Message-ID: <CAFGrd9p7oPvhZ8KL40XYfNi2CAdEd8BZWrXPqfcqu7DTSSg4Kw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] Improve the MT8365 SoC and EVK board support
To:     Kevin Hilman <khilman@baylibre.com>
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
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le jeu. 30 mars 2023 =C3=A0 02:09, Kevin Hilman <khilman@baylibre.com> a =
=C3=A9crit :
>
> Alexandre Mergnat <amergnat@baylibre.com> writes:
>
> > This commits are based on the Fabien Parent <fparent@baylibre.com> work=
.
> >
> > The purpose of this series is to add the following HWs / IPs support fo=
r
> > the mt8365-evk board:
> > - Watchdog
> > - Power Management Integrated Circuit "PMIC" wrapper
> >   - MT6357 PMIC
> > - MultiMediaCard "MMC" & Secure Digital "SD" controller
> > - USB controller
> > - Ethernet MAC controller
> >
> > Add CPU Freq & IDLE support for this board.
> >
> > This series depends to another one which add support for MT8365 SoC and
> > EVK board [1].
>
> It seems to depend on more than that series.  In order to test this, I
> tried applying this series on top of Bero's minimal support (now in
> linux-next), and it does not apply cleanly.
>
> Could you please list all the dependencies that are not yet upstream.

Hi Kevin,
You're right, it also depend to
https://lore.kernel.org/all/20221122-mt8365-i2c-support-v6-0-e1009c8afd53@b=
aylibre.com/

Regards,
Alex
