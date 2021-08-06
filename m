Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A131C432BE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E469561206
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 08:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243826AbhHFIP0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbhHFIPK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 04:15:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB07C06179F;
        Fri,  6 Aug 2021 01:14:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso16310438pjf.4;
        Fri, 06 Aug 2021 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EA8/NMEQ1/xPrB1n9sMj1XYF0fWKh0U0LaqEd2bvscI=;
        b=IVThQKyvn2gxNJXnpFLRy2/6zL46SUnW9e68RZRuqE0OJSSzaeKQCfdAaCrcwSefTV
         9mXe3B/Hsky78FMQ7M5DXshJVKO176KLEh2fqyi72GPa3f0qvamAIdR5IlxaBbVuuosz
         yOTQthryqUIGVGGXuVGZGAlRp2iPuXSGySJcw+JD+3FoeQiBgVQf5j5fnuOD+b4OUZsU
         XZ3kgOlzGypYT8bCQ7giTdHs+DjDCWTZEX+TV0pgVYkrDi6+iqz69fwXmtvgEA/kyded
         RnqD6PtrgKyOheu/asqpIq4ddrKVzakkLAeVe0SiCc3qSlde04Orp4+i/yXSWjU9rRmh
         naxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EA8/NMEQ1/xPrB1n9sMj1XYF0fWKh0U0LaqEd2bvscI=;
        b=Soncf3bWIGQWwCkqnXOP6zUwG8xyZ0jYm8KYIwfMzogPMiJT5XeSix+00NTMtqM/SF
         joOeZvCQFqLuYVK4ZAb32d8tKwb3j6SCPMbBEuZ0Lk0oMOV590jdUH/cEd3D51A/GWIW
         u9oM+tum1WAxZvaWgqmC5KR8cwB2bBkfSzd23VJVdW63DOUCzm0FoXkMnzM+OQbG8whx
         1bklcy0hO2El9icNvti4utwY4AMO56H6WdXeo6+V1LQhW6u2kE5nXPtOqBcm6TTTPKSE
         MJY7GN8bQ5cuTh6SNZFTG3WCWmxTp9ATgmii1+st/N5cEQ63d7vb/8G4dyRklwAV1QJt
         oPsQ==
X-Gm-Message-State: AOAM532oxNlQGiTzKk8JHk6uX9X0k37z1Al0NoTYAZqzYozRWdLIw7JP
        bKoTxChKzZbbSr8j5BmZiBFVMGfOrQApo8Dg
X-Google-Smtp-Source: ABdhPJydzGuINtfzjJ4rc0aYtY1YDr0eByVPskQaH4/Cy/8RSUEwiYmxXRgr1K8xjCX86Q9WHlu6Og==
X-Received: by 2002:a62:b414:0:b029:317:52d:7fd5 with SMTP id h20-20020a62b4140000b0290317052d7fd5mr9568253pfn.30.1628237690428;
        Fri, 06 Aug 2021 01:14:50 -0700 (PDT)
Received: from [192.168.0.104] ([122.187.88.150])
        by smtp.gmail.com with ESMTPSA id k200sm9829958pfd.46.2021.08.06.01.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 01:14:50 -0700 (PDT)
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
To:     Mark Brown <broonie@kernel.org>, Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
 <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
 <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
 <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
 <20210805124650.GM26252@sirena.org.uk>
 <CAMdYzYpR6br7s1RD2ze92WzJjtEDZwy9qS6YhghgXy7F91keFg@mail.gmail.com>
 <20210805130842.GO26252@sirena.org.uk>
From:   Ravikumar Kattekola <callmerk1986@gmail.com>
Message-ID: <81006771-99bf-a5f9-4001-2cf3dc84f69d@gmail.com>
Date:   Fri, 6 Aug 2021 13:44:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805130842.GO26252@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
Resending my reply as my Mail client settings prevented delivery

On 05/08/21 6:38 pm, Mark Brown wrote:
> On Thu, Aug 05, 2021 at 08:58:58AM -0400, Peter Geis wrote:
>> On Thu, Aug 5, 2021 at 8:47 AM Mark Brown <broonie@kernel.org> wrote:
> 
>>> One thing to watch out for with this approach is if there's things that
>>> really need a specific voltage to be set then you'll have to stop those
>>> things happening if you've got a voltage regulator that can't deliver a
>>> voltage in the required range.  I don't know if this affects MMC or not,
>>> if it's just a case of being less efficient it's not such an issue.
> 
>> Yeah, but if this is a fixed regulator and it's a problem, then the
>> hardware is screwed anyways.
> 
> Well, the fact that the voltage is being changed at runtime indicates
> that we're changing something from whatever was in the fixed setup - it
> can sometimes be that we don't have access to some higher performance or
> lower power features for example.  That's not ideal but works perfectly
> safely.
> 
Suggested approach of checking "mmc->ocr_avail" might work.

But, IMO mmc core should check if the voltage can be changed or not

before trying to do regulator_set_voltage() in mmc_regulator_set_ocr().

Wouldn't that be better and solve this issue for other hosts as well.

Something like below in mmc_regulator_set_ocr ():

+               result = regulator_check_voltage_constraints(supply,
+                       min_uV, max_uV);
+               if(!result) {
+                       result = regulator_set_voltage(supply, min_uV, 
max_uV);
+                       if (result != -EINVAL && !mmc->regulator_enabled) {
+                               result = regulator_enable(supply);
+                               if (!result)
+                                       mmc->regulator_enabled = true;
+                       }

We could wrap the existing check_voltage function

+/* Check voltage constraints helper function */
+int regulator_check_voltage_constraints(struct regulator *regulator,
+                                       int min_uV, int max_uV)
+{
+       return regulator_check_voltage(regulator->rdev, &min_uV, &max_uV);
+}
+EXPORT_SYMBOL_GPL(regulator_check_voltage_constraints);

I hope this makes sense.

Regards,
RK
