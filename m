Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD68C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 11:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCLLBC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCLLBB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 07:01:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017522F7AB
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:01:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h3so9802771lja.12
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678618858;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jYZfawWjXMVBxW1629eKjPSTUkMUocoPnX/odlKuSj4=;
        b=Fhah255qM8GHKT2kkawArTMoacQ5OYNohajHmawtpxIz/mRI70Po5VPldM+ekieLvZ
         0Mw7r8CYBYLNHh3qKg9TB6TtB7ocxh1UwHDs9JNPK3GgCuehygSFcL4M4TECytQVhuJu
         xUYvakdg/ofwpWAFB0wqNmrlUOAXrlji2j0SSvpGr1Rh4DRr9rHA3An6t4m++A6cx29h
         jV4PiI4qry5n5o3z0SKihIcHz2X7sXOgX660CsXRcgmVafgnkDoMZKUqneBir91LNbkB
         32SkTvW6blWqUpnN/KoWfnLGV+tPH+OCQHEg4BuJ6ExBaddFTa7wL9cpNAcBvLsYaag+
         WPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618858;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYZfawWjXMVBxW1629eKjPSTUkMUocoPnX/odlKuSj4=;
        b=jafCXwTuzBM1IKAbwdu4cC/VODhorLNXwuwgeCZZCNMgUdKxGIgEJeEtRELOUWqFwY
         L7DV+kIFv7veeh7YHzNBOqWsmXnFfb4usXoxXi2Z76/zem/pbjMpsczR1O/gZVcODKE+
         YxZvql+3RuhuOfXqw+CwmS7GSAjyUQVAXu3tleg7LU4TDvVxsx7tpoCuZeM654rSFMqG
         TCfTnfy3kwroZpdJmBz8sBRUOw7zVR4ibGBsEtxHLQ3xyyxyhNxD0kwzvuLI6cQgpZ9O
         MtLuY5D+nz1aQ3wuX7HOOQBU2uOsaGeIQfH9NF+BT09cmxZkbZp8quO9EZ+1xuMklZS1
         sx5g==
X-Gm-Message-State: AO0yUKVOTGGKiGIxy7lGI9HBa5LkskCiPwy5uvfLu8vKCatiEpo9aabf
        kUnsTVfBa76aCQ0tl4kdKpZaT6fWb11wbxMK
X-Google-Smtp-Source: AK7set8oTi1vEvzPncSNIClpt2tAwZbFKi9Prd/MO+r54REhLqdd+G2bn8QzaXjtHTXJmHbYctG3Dg==
X-Received: by 2002:a2e:a995:0:b0:298:591b:582b with SMTP id x21-20020a2ea995000000b00298591b582bmr7951177ljq.14.1678618857906;
        Sun, 12 Mar 2023 04:00:57 -0700 (PDT)
Received: from letter4.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id c10-20020a2e680a000000b002986d306698sm614658lja.95.2023.03.12.04.00.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:00:57 -0700 (PDT)
Message-ID: <640db0e9.2e0a0220.a064f.1653@mx.google.com>
Date:   Sun, 12 Mar 2023 04:00:57 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b65d54e3-b78b-654b-4932-03afefa2e950@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> On 12/03/2023 11:49, Sergey Lisov wrote:
>>>
>>> Anyway, I said last time this looks compatible-specific, so I don't
>>> think we need another property.
>>>
>>> Best regards,
>>> Krzysztof
>> 
>> I agree, but I'm afraid of introducing regressions by enabling this
>> workaround on systems that don't actually need it.
> 
> I don't understand why would you enable it for systems which do not need it?

OK, then how do I find out which boards have the bug? My only idea is
"search for samsung,exynos7-dw-mshc through all devicetrees, find vendor
kernels for each of those boards, and check if they have the workaround".
Is it really that better than enabling it selectively only for
known-affected boards?

