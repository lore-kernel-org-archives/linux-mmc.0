Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E266C433DB
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Jan 2021 17:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F562245C
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Jan 2021 17:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAPR4R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:56:17 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35905 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbhAPR4R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2021 12:56:17 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DJ5LP0bwFz1qs3T;
        Sat, 16 Jan 2021 18:55:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DJ5LN740lz1tSQn;
        Sat, 16 Jan 2021 18:55:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1Vo_tbLk7kin; Sat, 16 Jan 2021 18:55:24 +0100 (CET)
X-Auth-Info: 1+mt8bXHCGKA8fBz8vw78glbrDug8q/LrnocHbrrpuU=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 16 Jan 2021 18:55:23 +0100 (CET)
Subject: Re: [PATCH] RFC: mmc: mmci: Convert bindings to DT schema
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org
References: <20210115225313.2616477-1-linus.walleij@linaro.org>
From:   Marek Vasut <marex@denx.de>
Message-ID: <7d5c6875-c10e-e9fd-08ef-65a97e26c127@denx.de>
Date:   Sat, 16 Jan 2021 18:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115225313.2616477-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/15/21 11:53 PM, Linus Walleij wrote:
> This converts the MMCI bindings from simple text to a proper
> schema.
> 
> I can't get this to work when testing the schema and I don't
> know why, possibly my fault. That is why it is RFC.
> 
> /var/linus/linux-nomadik/build-ux500/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /var/linus/linux-nomadik/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> /var/linus/linux-nomadik/build-ux500/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'cd-gpios', 'clock-names', 'clocks', 'max-frequency', 'vmmc-supply', 'vqmmc-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> This appear on my machine despite:
> 
> allOf:
>    - $ref: /schemas/arm/primecell.yaml#
>    - $ref: /schemas/mmc/mmc-controller.yaml#
> 
> No idea why these refs are not reffed. Help.

[...]

> +  st,use-ckin:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: ST Micro-specific property, use CKIN pin from an external
> +      driver to sample the receive data (for example with a voltage switch
> +      transceiver).
> +
> +additionalProperties: false

Set this to "true" and then the validation should work.

[...]
