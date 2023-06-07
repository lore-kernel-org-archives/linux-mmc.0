Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C36C7EE29
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jun 2023 11:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbjFGLJL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jun 2023 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbjFGLJG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jun 2023 07:09:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0601FCD
        for <linux-mmc@vger.kernel.org>; Wed,  7 Jun 2023 04:08:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso43965225e9.2
        for <linux-mmc@vger.kernel.org>; Wed, 07 Jun 2023 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686136112; x=1688728112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXdQfD8VSWsZR3Vi8Y0WmvbNHXZH6Vk6c/6DrYZtkC8=;
        b=QTGW/Vu9XZf4s5MS2p6ojUMV554GSqknEVOpWK5rGAZhbYaLpwTl8/+tjQONBnIaq+
         K5z2TQrCWI6tT7yx3jDljuWe41E4Jg5nbdX4Yea9exFxwTVouVkdpV5zdWrHi6l5W2IK
         yFwXMY//lgwBCYuN5i+RJLudw4GNG9rdqe7DJ4eMM4ygSpbYRfzrx4iIMaWkG2QMw712
         cHOnQKkKpZ0U5OGRfZBYI+pilulQqDFrBrvzbOqBL5EgKFX/mXVH7f8U/qB/eyxuTtMg
         GiTCZZLVG8J5A0SPIZ/uZPAJKab2DTYhNxRWEXS3tIwN/p9sSPvWv0gmfxTki0GS1Cld
         PTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136112; x=1688728112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXdQfD8VSWsZR3Vi8Y0WmvbNHXZH6Vk6c/6DrYZtkC8=;
        b=aDRYPN354Ub/IvGXiwvRC2JUaxaRANH10jr4jQXdj7HOIYeG8xXJkUQdwfXUzdXUvI
         kXXJFHqslAqv5Wpy9eGsW8C35yP7Q54SZXVESgk6I+EZS73k9oeyelOVF+w/Mm8Z3fTS
         Bny0VOAG73dkpre2D628Z8EJdcBbZN6WGEGrmpEayo6TE8wzxgjbIuUlliy7ZkiPDnDJ
         jckWz4MWn6b9s4SDx5f+juKNUIwAKoXoP2KDz7/UQnV1zVzvYuW/VIUpJOj3HX7zquE1
         1tsOPt9UvkbqsNFCADinh+AvEm8zfyhmlN47TGvcEkNXxG0Bj/4vGHfeYIFwplSwJQxp
         K1VQ==
X-Gm-Message-State: AC+VfDzJPCRrFmLKIFwvIH+uTENNLCUbAthHoLirPvOadiioGLfquRwG
        6hsI4oqlzOUUZyZ2/OI2ZyYUWg==
X-Google-Smtp-Source: ACHHUZ5cgp+HJScZGL+i7YPbTv0GsIwRUhE+kDDIAWVzH4PmbSPpPjc3VBa/gfSJIjWg0y/3D8pOUw==
X-Received: by 2002:a5d:63ca:0:b0:30e:41c5:9715 with SMTP id c10-20020a5d63ca000000b0030e41c59715mr6529879wrw.47.1686136112241;
        Wed, 07 Jun 2023 04:08:32 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6a04000000b0030aea925fbesm15020875wru.50.2023.06.07.04.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:08:31 -0700 (PDT)
Message-ID: <ce2737b7-a2fa-b4f2-16f2-09971d5877fb@baylibre.com>
Date:   Wed, 7 Jun 2023 13:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/1] mmc: mtk-sd: reduce CIT for better performance
Content-Language: en-US
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20230606113249.28057-1-wenbin.mei@mediatek.com>
 <20230606113249.28057-2-wenbin.mei@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230606113249.28057-2-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/06/2023 13:32, Wenbin Mei wrote:
> CQHCI_SSC1 indicates to CQE the polling period to use when using periodic
> SEND_QUEUE_STATUS(CMD13) polling.
> Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
> frequency to get the actual time.
> The default value 0x1000 that corresponds to 150us for MediaTek SoCs, let's
> decrease it to 0x40 that corresponds to 2.35us, which can improve the
> performance of some eMMC devices.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

