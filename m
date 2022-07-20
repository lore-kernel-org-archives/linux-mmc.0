Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EEBCCA488
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jul 2022 13:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiGTNNF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiGTNND (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2022 09:13:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DD5B056
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 06:13:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso742522wmq.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LgN/S0aDXYI9VGCuWlvvgvQnGpuTnnqHsiuzMd2wxQ=;
        b=hZDBwVWDP5UPXoM/26p/r+j251hc2vAqDOCERxSqp1n7sS06JhTWTNUFrAn/iDVTDd
         sk1s9gAeT8g6iMlidLoC2ByWsp6jDzKjyGiwTrHFM+kSqmhnpOGy27aGmIOCRSPQXtjU
         iuHcWvpuEBu/GQL3HjFfyH38HWdcfRwpw/QCs8xRs37MzT7Ik+pcHBHS4PQz7Y7kmEGs
         2zEZT/L22GV5s5xGf/GZOt2FikEOhhfo8etSuo2R+s9KR06g6oLOKoKJ9cp2Devph4aN
         HYnuH9yadQ7mkeUaGKIxYyw+FFFXzGLODhmRa8DXLmg2/yBLqQ88/ndcWxmAnabBH3H2
         gPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LgN/S0aDXYI9VGCuWlvvgvQnGpuTnnqHsiuzMd2wxQ=;
        b=PsxNUBlyHo4dC7VM0hpFmDdvI0tajaEdGYNK0LKG+qCCE1hQ8gUnaM/vhBv4Bfvtki
         foxjbLFw9KELeXjofO/C3dC8RLbh6qavZHvuwT9kVSdnf3uu59IIY+S3WtExr/txSP3Y
         rSir3fnfijPOuGnlrWKKgJppF9nOjF/RfjEzi5ZOqHV8UjCI/Ee4qE70DbHVUahNh03Q
         kjjIN2eX2NXpPNPC/k+Yji4NyrqwZ9HItnB1U+2s8r2dom+VVTFmTxwYj1AZeJu7sya+
         4+CAFi07CgWhRfLH6Z2hYS5yN8UeMxyg3u0OiH1S6SygqKJJUqiRZfJIa8F4HLK73XC5
         KxGw==
X-Gm-Message-State: AJIora+0OYv+UXrGHNRF82za+f4bv1pXqAH7xsP1zUzfJ7qgfClDiYwF
        9AkdyhLXrw/XY4bvPqTxpEITXg==
X-Google-Smtp-Source: AGRyM1tHJE+D+NzsNowU+goDfK+LE01p5AmV4nGBMM9nPZVjT15IP9nJaaafPk1bF4qVs2pE8TNv1A==
X-Received: by 2002:a05:600c:3b91:b0:3a3:1cbe:d531 with SMTP id n17-20020a05600c3b9100b003a31cbed531mr3812400wms.159.1658322779330;
        Wed, 20 Jul 2022 06:12:59 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id y11-20020adfc7cb000000b0021d6924b777sm16853316wrg.115.2022.07.20.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:12:58 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     fparent@baylibre.com
Cc:     broonie@kernel.org, chaotian.jing@mediatek.com,
        chunfeng.yun@mediatek.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net,
        matthias.bgg@gmail.com, qii.wang@mediatek.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, ulf.hansson@linaro.org,
        vkoul@kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 16/17] arm64: dts: mediatek: add mt8365 device-tree
Date:   Wed, 20 Jul 2022 15:12:57 +0200
Message-Id: <20220720131257.530168-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220531135026.238475-17-fparent@baylibre.com>
References: <20220531135026.238475-17-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Fabien,

> +		tzts4: tzts4-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&thermal 4>;
> +			trips {};
> +			cooling-maps {};
> +		};

AFAIK mt8365 has only 3 thermal sensors, therefore tzts4 should not be
added.

Regards,
Amjad
