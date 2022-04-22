Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CCCC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Apr 2022 17:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiDVR1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Apr 2022 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDVR1U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2022 13:27:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A508264721;
        Fri, 22 Apr 2022 10:24:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i63so7809262pge.11;
        Fri, 22 Apr 2022 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6OieQ1a/M9OultDvsfpSKXa0nZNyJs1Fl+cVSeFy5w=;
        b=kS7ZLAqHvHKsGr+ihnCkPdu1RGAbui45zP68xN2f28DX2xpm94z+CBxo6l0KthVSVC
         VI806iiYM7oIyqD3O2a0Sw8hzv2N39Q5xCxmxiugbTVlqXP+MIh3fM+2EjtGI4UkqTNs
         jeCHAGYuWpJA0xNB54go/2Iss788LWeiRjIuJJUAjL44NpwXb8HHIup2Se127qZ4TSZ1
         yNdrnVAR6/01jRCYABu9gB7C/sFjsSyM69pLQeGWaW1RwUOwqu0eFrhMHnOYnK6uE6uZ
         j7balkRESciMZCQpkklqRg4fkY8v4WrTpx5LJk26bQCAASWCgAcydlGDdNzIqY+vpMqb
         CAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6OieQ1a/M9OultDvsfpSKXa0nZNyJs1Fl+cVSeFy5w=;
        b=jI9q9dQH23LzLVBZI6Zr2wLEBviRYB5qlQ+YN7l3RWCtpJtwW0a5obSHlTDtLZBtII
         4JdaYCsgY7jvULnMhaiXmzWiNXF0MNXLaGnrrQIOuWQuQsU5hlECZ4KpKnM/ZMd1YrEJ
         8dwkWynjaJ0/qb3gdmxR3HdaRvs8Hsv7AexCAcKET0NPxzCFoYnPBBniLkpsGkpF44aP
         24tayQZ4fZN3BYHShIArx27SFeQkPwMBcKe+OvHZyqpY6xTs1vSfyzWsj02mpDY++55m
         aiOuYkIDClE9HK+NoAOiwDybexMYfo1PIF5Fs5HwcDiHTFKYVU0LGkBQNSIlkcNm67w+
         eDQQ==
X-Gm-Message-State: AOAM530S5r5/+hm1QIFvyyg2bRDiRLlZ3V+g51YedRsnlDSd4hjQoytu
        VAknC4xSC01dTX/Yu83PW1GLxbDp5jw=
X-Google-Smtp-Source: ABdhPJzjxN6Gzu1EVkr5gSMVnc03qQD1qlkbm+Vw10+rWrREeltS1Q0g+raWNg6Y9CzHaXNzqBmSWQ==
X-Received: by 2002:a63:2a0d:0:b0:3aa:8dcc:254c with SMTP id q13-20020a632a0d000000b003aa8dcc254cmr4616421pgq.598.1650647681530;
        Fri, 22 Apr 2022 10:14:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l5-20020a056a0016c500b004f768db4c94sm3265274pfc.212.2022.04.22.10.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:14:41 -0700 (PDT)
Message-ID: <3f2cceba-c8ca-ae51-27c5-07ad987d705f@gmail.com>
Date:   Fri, 22 Apr 2022 10:14:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/5] mmc: sdhci-brcmstb: Re-organize flags
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-3-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220421182803.6495-3-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/21/22 11:28, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> Re-organize the flags by basing the bit names on the flag that they
> apply to. Also change the "flags" member in the "brcmstb_match_priv"
> struct to const.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
