Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25E1C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Apr 2022 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiDVR2L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Apr 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiDVR2H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2022 13:28:07 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449356174;
        Fri, 22 Apr 2022 10:25:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z2so9764784oic.6;
        Fri, 22 Apr 2022 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lexdz5hngsBhmPhxr+sTw6q5KgJQRlPt5Z2EPIdm99Y=;
        b=Zungingls9hmWdfS+naDCyI78V9iY7Kxhf998yiIEnbKfvh65fB5UCRIm2ZmWkr8w2
         T1Dhsg8BkQoXpFnY4x/6vNroeCzYECnLuVeRWFTVf/ejjUMReASMLojXMqRFB3Mf/OVx
         du6rJG+6BgML4bBFVVLuFhc8Hd3Rh3sXRLqkrouyoMYJNqwTDWdVGqmX1uPguJNvkRF7
         li3P65TV6/0FVU4Q9SkA7FVKpsQQwAGVpczon4b77QPX4wge/3YAoTI8ZH+vP05XiFqy
         jbqy0gdDKI8G0WCIL07AmY44NViEOwuDm7xkxsKIzo5/SDUENVATCrdHgX93ldB4sOnO
         E5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lexdz5hngsBhmPhxr+sTw6q5KgJQRlPt5Z2EPIdm99Y=;
        b=2Yx47Xg7nYEe3ymhxfhv+UZUkuYhswzz9iVhIMiCHXATGuCgOZMLXk3JZ6+9AIlzh9
         dF9TTGxR1jNbqrikBSZDtGfNVjvXI0LM/dGVJwYYHYATDa5EE8wtqokxNWb/XwYi8lOR
         AeUBKJIDwZgsMSo7SGWlueOIxmE8e43s+IjIHNLOyH/tn29xdBl3PTocNB9g3VNRq63Y
         6exeFCveKkQA4QhrZpgfbzVUdrVp0cMKGjxeom3EP+3foeVxtQQtoR7/756czd/xPjC6
         FW6I+z6ai/E0cRSdGq07mVoN+A3yHwfzr8cVRiZHwujUtD2DHrVMnx3CgDNQ87zP6hvY
         oJlw==
X-Gm-Message-State: AOAM532z+tN55npXU6/uv9XmP2ChAmrUvPqBl2YX2le5JUTGruT6w5BF
        G+8vjgaeFLzJiwOXrAbRDufw8mXfZ+Q=
X-Google-Smtp-Source: ABdhPJxMDJKIgmMcJcU/zvtD4vcC/XckcDFIRR7sN1EmVmwCkp085QTP+g0ejuORKvaEYxobPEHqNA==
X-Received: by 2002:a17:90a:a82:b0:1c9:ef95:486 with SMTP id 2-20020a17090a0a8200b001c9ef950486mr17219039pjw.93.1650647702829;
        Fri, 22 Apr 2022 10:15:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d21-20020a056a0010d500b004fd9ee64134sm3166611pfu.74.2022.04.22.10.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:15:02 -0700 (PDT)
Message-ID: <39f813e9-13d8-db15-1fcb-a93b27e46798@gmail.com>
Date:   Fri, 22 Apr 2022 10:14:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] mmc: sdhci-brcmstb: Enable Clock Gating to save power
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-4-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220421182803.6495-4-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/21/22 11:28, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> Enabling this feature will allow the controller to stop the bus
> clock when the bus is idle. The feature is not part of the standard
> and is unique to newer Arasan cores and is enabled with a bit in a
> vendor specific register. This feature will only be enabled for
> non-removable devices because they don't switch the voltage and
> clock gating breaks SD Card volatge switching.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
