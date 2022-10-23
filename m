Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0E4FA373F
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Oct 2022 12:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJWM5s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Oct 2022 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiJWM5d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Oct 2022 08:57:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C165018
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 05:57:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m6so4757010qkm.4
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l76ylH5GQKStXCE5+N4w0FN1gGvZpR+mdU/Dav6ek2g=;
        b=rDq6PKWuQHQO4Rdv+Abeg8LG0aYl97e8yTPMgp9eLn8CSF+01B+go8oJZXQopcV7Qz
         V5NvsUcAbgicOSnC0GA81j0Ea/AGvJV6hTa00m9JkocgV2fh8q/mKLJRK+Ua7F7gsznZ
         7HnKxoCOMk52YNp9H3lWWblItAF4YcTr9w0aRORJrdNSoIBQddaT645FHZEJJvFwG610
         HUJ2bsBYZu/6sURDIWRYI9uuwNdhOfo3RAZd5m2JBnb7gIaYnjVmU/Pzs4oJi/vmV2Uz
         hgVB6OQ8HWmzPhklXWGbHLuK2OHmSjpyjUF5dqYLj3esHbGoIh/72z10F867HsPNn93/
         Shng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l76ylH5GQKStXCE5+N4w0FN1gGvZpR+mdU/Dav6ek2g=;
        b=rwNf8WM7HpEF3h9qVvc/65NposBbmfTQ8Ho/+gmXglf7UA94qmwFxUeGwdufLwEZzb
         xwKMSbqrZ4fzTkn8jVRDFlShBGeh4cWWO39JWNjXFL8AtEPfs9EPPQmzh8vLMnZIEI5s
         S3KGElPCc4g0DcISlgoOEA9uKDmJVZMfymCVBxjhV763U7nIo05DU0Xno1gQO/UPm9iU
         qUQtk8imzg3Mu1NsB03KTvQr8Vb/bVmp1baGHfDE7JD7R6oye9VCOaCwvlyRWvp95Lp9
         NqwYnXQlALQpI1ZaKGlOyH5rTqrkOiwMfisoQSS3RLeCFfzdlG8dLtDlWjzTos42nGGs
         Z4iw==
X-Gm-Message-State: ACrzQf2TUgaJQ/BdFiHlGCJ+jF+IvuIBwax4QA4sNVIzrzg9aryZYi+j
        cduUMedZZYJ0bgmKvy6Yr3hJMg==
X-Google-Smtp-Source: AMsMyM7iTj/q2zHPaO5muCBKpEWDYRLPI/oOPZQq/+1HYrpS0Ua3aH34MqtS+47QydypiO08YmFfcQ==
X-Received: by 2002:a05:620a:44c2:b0:6ee:7a72:50b3 with SMTP id y2-20020a05620a44c200b006ee7a7250b3mr19416101qkp.124.1666529821463;
        Sun, 23 Oct 2022 05:57:01 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u9-20020a05622a198900b0039cbe823f3csm11430021qtc.10.2022.10.23.05.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:57:00 -0700 (PDT)
Message-ID: <a0121e0a-9f62-8630-45c5-d32eaa91d46f@linaro.org>
Date:   Sun, 23 Oct 2022 08:56:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/7] dt-bindings: mmc: mtk-sd: add mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221023091247.70586-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/10/2022 05:12, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SoC specific section for defining clock configuration.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

