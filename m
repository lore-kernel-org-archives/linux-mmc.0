Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E8C54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiI0TS0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiI0TSY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 15:18:24 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46EE6A25;
        Tue, 27 Sep 2022 12:18:24 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E6F1A8484A;
        Tue, 27 Sep 2022 21:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1664306302;
        bh=GFpQwFEx3noZVoS5mRJOXFzgRizwUIEKjcVMTs2bkIE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UFBn+o5paRCzQKy0pNoXs+Fz5zCpMY7ZseNrLXQ7XvxncKHpzHTi9wVnqfsDPPpEM
         iiLBQINqVMpBxuTtlyjy+9qLm8tHPkwxumXcAgVAfTru2Ab15hbDUeoJhR/wBT2TeE
         6F6aFh0tH/EvRi8UB6WpOrCosk5yuKhq7kXE4HXzChVWs4uonBx8ox62UW1DNwLtQE
         ezN06zipi06UbQUJzXByx5/kCSVimF0C3anPUXuoS7KGyK6/3P8HVD6dkrxnztus3I
         gvgAjnPcZM29gbLhAvgeUkoEAYepongMzWaeX9+xEmDZv+cY8sh/XnBqcb8UH+BWlU
         tBKTDfCAda6PA==
Message-ID: <cdda3cb1-5772-88f7-aafc-d4ecf51fd050@denx.de>
Date:   Tue, 27 Sep 2022 21:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] dt-bindings: mmc: arm,pl18x: Document interrupt-names
 property
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Yann Gautier <yann.gautier@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220927104138.5924-1-marex@denx.de>
 <CACRpkdaA=3QU+_HQkK6RSe4qQJ28O4BbtT6jHuKeVjKqaqLJaQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CACRpkdaA=3QU+_HQkK6RSe4qQJ28O4BbtT6jHuKeVjKqaqLJaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/27/22 14:18, Linus Walleij wrote:
> On Tue, Sep 27, 2022 at 12:41 PM Marek Vasut <marex@denx.de> wrote:
> 
>> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>> @@ -99,6 +99,9 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>
>> +  interrupt-names:
>> +    const: cmd_irq
> 
> This hardware come in variants with one or two IRQs.
> 
> Either two: "cmd_irq", "data_irq"
> 
> Or one combined IRQ (logic OR between those two!)
> I don't know what that should be called, perhaps
> "cmd_data_irq".
> 
> Since all DTS:es then have to be patched an alternative
> is as Arnd says to just delete the names. We should however
> at the very least patch the bindings description: for the IRQs
> to make the above situation clear.

Done, bindings updated and stm32/qcom DTs cleaned up.
