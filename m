Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C18C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 14:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349350AbiCOOlA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349339AbiCOOk6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 10:40:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879755757
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 07:39:46 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC60C3F4BC
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647355182;
        bh=nPejALOuOdUqemhzHbmVuYnKHib7XI81pmDxKpjtzkE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=r2NAgkramzO1pG/5j3AZFVTJNRRUi7kpG4C3jKEVQM9DnfmXg1QCMyQNCpTf6BAO6
         hf6z8vGlCob8HaGgy0V5tSkqbxlAYoZdlGaB+4CCbcRO48QDbVU5DvLV+vUyFwO8JB
         3A3rKO0YdRPhqZRHkoDFYSxfY7UM2FfBHf5BN2GmbgskRka76BWRQ2/cpy6n5vln1n
         Tx1beBNUBOG4DMzf8qd2etP9vplAjmcPFZdZ9YG0WK+SSvajG8IOtmLJsA8R7KtPUD
         n2hgLc+PAn/9lVPIzcGUDCxh158l1RnbzMU9N1xty3uipI6ytAoPlhwfBZEnb2HIAf
         +1qJ5jJHgtT3A==
Received: by mail-ed1-f70.google.com with SMTP id l8-20020a056402028800b0041636072ef0so10627229edv.13
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 07:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nPejALOuOdUqemhzHbmVuYnKHib7XI81pmDxKpjtzkE=;
        b=v/HhmGYupjXkW+LzaZYn/MIzy+is/EtR6k+6tqxrk2PlpywcX4D0y8q4Z6qNk+oPlo
         2EkRygeaJcqKPQ3/HEv7GnByoFzyA/S9s9oM6jj997ytCgppeERYF1k3arnOci+OUYST
         556YvnZrFhbcC9wUH3PXbXFUpXP3G3PAfc8hJT4KXDPbzlx5nITW9NrXmr7Hka9ocU8q
         7DF+JLM48HPRSzSLXEfawv7dt2IfP49X4yuTSzlJFOMmaJx5jhfHeg4e9roCrHHl2SIF
         4w0jyy2gfcQ1XZ9cdjH9GuiJDmu0iMAC8c/6+H9F5nqYz6V3SlzylIf4XcF3bbXq5Vca
         AFlA==
X-Gm-Message-State: AOAM530oYBMEYbUJgETlP5IOr/fly0pFDeYg8Dc0NclXcHjnHxzI6Evi
        4MtUJkzvkD8KDsTuWJQjPfA8hFqi9GcHhbCayq47edvtD5Hepl+OqCveHuLZ7gdkvtyUQOFPiRe
        0Oj2ryLzD1BpRgNWW0N8i36gJGS32MbCU+tpvFg==
X-Received: by 2002:aa7:c34d:0:b0:418:c96a:cb58 with SMTP id j13-20020aa7c34d000000b00418c96acb58mr2257785edr.49.1647355182013;
        Tue, 15 Mar 2022 07:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyigKXtRY+yKVzsglw5ybBL5p8Qv91o3EGBORJFXc7hNx9TUa56VJmCYe7gKusief6LkADMqA==
X-Received: by 2002:aa7:c34d:0:b0:418:c96a:cb58 with SMTP id j13-20020aa7c34d000000b00418c96acb58mr2257769edr.49.1647355181845;
        Tue, 15 Mar 2022 07:39:41 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id r23-20020aa7da17000000b00415a1431488sm9739991eds.4.2022.03.15.07.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 07:39:41 -0700 (PDT)
Message-ID: <5d9d99d7-b4da-d794-0d2a-9739bb1f3d66@canonical.com>
Date:   Tue, 15 Mar 2022 15:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/8] pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        huziji@marvell.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        davem@davemloft.net, kuba@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, thomas.petazzoni@bootlin.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-5-chris.packham@alliedtelesis.co.nz>
 <04ed13f1-671f-7416-61d0-0bf452ae862e@canonical.com>
 <YjCj07kxGh8n45GE@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YjCj07kxGh8n45GE@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/03/2022 15:33, Andrew Lunn wrote:
>>> +static struct platform_driver ac5_pinctrl_driver = {
>>> +	.driver = {
>>> +		.name = "ac5-pinctrl",
>>> +		.of_match_table = of_match_ptr(ac5_pinctrl_of_match),
>>
>> of_match_ptr() does not look correct for OF-only platform. This should
>> complain in W=1 compile tests on !OF config.
> 
> The Marvell family of SoC which this embedded SoC borrows HW blocks
> from can boot using ACPI. I doubt anybody would boot this particularly
> SoC using ACPI, but the drivers Chris copied probably do build !OF for
> when ACPI is in us.

What I wanted to say - current setting should cause warnings. Therefore
choose:
1. For ACPI && !OF this should be still without of_match_ptr, to allow
ACPI matching by OF (PRP0001).
2. For !OF with of_match_ptr() (weird setup... how to match then?) the
ac5_pinctrl_of_match should be marked as maybe unused.


Best regards,
Krzysztof
