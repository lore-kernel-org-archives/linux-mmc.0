Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E883C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 16:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D21361101
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhHSQWY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:22:24 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44510
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhHSQWY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 12:22:24 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 8BAE8411F4
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629390106;
        bh=+cZtuR9o2k87pvi0rgBoRi8/bFI7YeJU/qox3v5ZI5U=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=pcRb9JvReJSBc1KYUMrzYYjLBZ0qErR5GBZ/AeJYEQl68pbJ9hTL358hC0QTr5hLm
         Xs4RbJIEckpzQwqL5OAliLhSfh2rZELGniA7N9R8YBz+8aaBpvl2jZIouAaKsja7T6
         7gvT20t24i+T5+ivh93fBXHOXCP3FgJ+M55WJ4mFRjOIrGN33qNAr4Qj4udSD5NlwL
         6YjnlPynMzLo4JDQGNT6QokYwlVjqDcbLPIbRIKvGF0+QksvhBvwEotx4ttxENPnUt
         7vpb4e3zdyvx1I/PJ/LPBJ9l++TJWC5MfIs7ovl4wdKS5RZMSsB3dCtPzn9AM80hxl
         jp/8uGyufjYKw==
Received: by mail-ej1-f71.google.com with SMTP id r21-20020a1709067055b02904be5f536463so2477510ejj.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 09:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cZtuR9o2k87pvi0rgBoRi8/bFI7YeJU/qox3v5ZI5U=;
        b=TXvWuoxbcl9tDWzr+NODZdbGz/x/3bJ3x1SPJ4oY0h+Y0FWDC/rpKBnH04lU9Q7ba2
         cvjoZ8NSPU1xCfkzIJIhbbLOi6pTCJieolKAv8111JQlBEh/GJ/i2oATJTNQ8UKq0W4g
         zBZYfyaNQGIeU8SnF9tiebtIsq2ae8TqhaIwpIE1QD+iwY4w9updnT8rsP33TrlMaVDp
         qpLuluMwPRrNIPi7UrX4zGBe0ktZbFtyrC1yKsCkqqYP0k1fJMZLWqAq+peutWu43G7t
         CC3lhULvMNvBZzHqirTp85JkURWPziAk+XbXdYuc7nxVHcDJyh9eNc1a0E1vDbrXMSw0
         i5WA==
X-Gm-Message-State: AOAM5314dFgtj7aYzI5xhsJQcKAwZ3mOOLZ/FIOZ62fnUdpwtIHJ6zEH
        yxSJR1rT0Gjtp0+7GggXZuThgP9wsNdrYwDqUSr7R2I4VatvLp38lTwROq8oRf+GnT0Zby/3GqG
        e+F1zCW2ET9Mo9uLQ1aH/8owYGMivEqxgySld9w==
X-Received: by 2002:a17:906:87c2:: with SMTP id zb2mr16503220ejb.322.1629390106277;
        Thu, 19 Aug 2021 09:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuaQqSj/y3QMWrvKAdgV8r7CJmiTSZ6zuwkSNkqhhy0AKGNuqM3cQONHkLBZcKm5Sw3vridg==
X-Received: by 2002:a17:906:87c2:: with SMTP id zb2mr16503202ejb.322.1629390106161;
        Thu, 19 Aug 2021 09:21:46 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id j11sm1478832ejy.112.2021.08.19.09.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 09:21:45 -0700 (PDT)
Subject: Re: [PATCH 3/6] riscv: microchip: mpfs: drop duplicated nodes
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-3-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4d0d6290-8341-56d8-7902-5a8c36bc7bb5@canonical.com>
Date:   Thu, 19 Aug 2021 18:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819154436.117798-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/08/2021 17:44, Krzysztof Kozlowski wrote:
> The DTSI file defines soc node and address/size cells, so there is no
> point in duplicating it in DTS file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 5 -----
>  1 file changed, 5 deletions(-)
> 

Now I wonder whether the subject prefix should be "riscv: dts:
microchip:" instead?


Best regards,
Krzysztof
