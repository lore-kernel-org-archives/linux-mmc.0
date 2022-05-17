Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF1C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbiEQI6o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243951AbiEQI6m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 04:58:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB448E6E
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2022 01:58:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z2so33348533ejj.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2022 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gcBgbzUrhXlgJMEhbaDgDyZ5SGdnIcnHwbk4ovmn5fc=;
        b=jFTcQLaC9oA7CuCmHEyFM95elDnHd7ZcLwOgBlht+XO/EXFsMuPHTkMF+L7fuWAKJ/
         H8y9t7gKNsc8vkbGE1VMECeKt2tf+wmil6MoPb5gq6Lg3gc5mJJJQeWjbFMTMHFUS+AN
         PWtC6duCb4g6zq8PhxiAyhEeJEhubi4RM1QOhlzQKb4AJJ45r7kMFTfHac9sMtxw9C2a
         ykz7sIXhS1GkjnhBJLm8TYz7P7AZtUaDMiQepiaLsFA+tqpB0b6YSXfhDRVsDRE7I/Tf
         zKOcaHFMXJw6P/BqUg2eWt9++/VCl6bQoYmuVBYyja6jE4UAy3DtQHzgs8D40q3WAlD+
         mKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gcBgbzUrhXlgJMEhbaDgDyZ5SGdnIcnHwbk4ovmn5fc=;
        b=G740nBj1QMiRL6Ug/OXEZ1d+fjFI/TKfxdzI1uSVfXkcMHwszNoHImAdHt13O4BJ8i
         Bh5II28UfxdglmyVid4DLNiwuMVLa3ej518yXsR9Pb50uTLx/fSrHqxSliFPJvp43jCR
         B2EwmrhOmr05G+RHh8raZ3rC5eTR6GkiVAniL+2x8csax/zeFsE1kwYp4CSGyqyGF7CG
         ZPzK8gpDKABv4WYxGrVzGO77VoXOFgqgqWvOxrRnT2urTYOWsY24bM6EufobrBpwn6Rq
         zgh4IkdFKLPaHN/WPrLg24MLmTt+SZgrC+y1NfCkkcomvNOdgvqh80lcT2MbpSXL3iLQ
         iTSA==
X-Gm-Message-State: AOAM532zJgdxaYNJK02qbcvwyCyLegxz5ON7azcjnZJv86jN4ntz4uI5
        mqxKUoUpBXNwaOn7eZ/TxBJo2A==
X-Google-Smtp-Source: ABdhPJzB5IJDtWaSHVhu2zZn9yNB8WW2lrbec0RhASTT4vDP4tCIYa22/maKHFHqtIzJJhw/f7ACAg==
X-Received: by 2002:a17:906:6a29:b0:6f4:3389:9094 with SMTP id qw41-20020a1709066a2900b006f433899094mr19523366ejc.323.1652777919039;
        Tue, 17 May 2022 01:58:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id hg23-20020a1709072cd700b006f3ef214decsm788722ejc.82.2022.05.17.01.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:58:38 -0700 (PDT)
Message-ID: <330d9a4b-063b-6a26-9cae-1143c88c5876@linaro.org>
Date:   Tue, 17 May 2022 10:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add Broadcom optional sdio_freq
 clock
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220513201907.36470-1-kdasu.kdev@gmail.com>
 <20220513201907.36470-2-kdasu.kdev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513201907.36470-2-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/05/2022 22:19, Kamal Dasu wrote:
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz.
> Optional "sdio_freq" clock is used to drive the bus clock if present
> optional property "max-frequency" specifies a base clock frequency
> in Hz that overrides the base clock frequency in the CAPS registers.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
