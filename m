Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB3BC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 18:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbiEQScG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 14:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiEQSb4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 14:31:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B61381BB;
        Tue, 17 May 2022 11:31:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n8so18111019plh.1;
        Tue, 17 May 2022 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2BlNjd9CAoC52vv1NpViW3j0LOH8CyDQbmV+zNI9trs=;
        b=jsv9Hyjyg47Q8SwmgSZdRGcmVwNcw0cPilFXHjVAK+VY+dv71rZW7/EgcHLJFKzfdX
         IYClPoPpqqiHx5Obl/kNHjLSo95OEhPJ9o8hi4+N2zoDHznDJoEOdrJuuMOhQbYmalH2
         TBwMoIuo44vBSmJJe5zexyr4Ud2yfqFG4t8WJqi07GlCQLwjTJdWreoREhkCqT7kIx0x
         l1hunvCnZkTnNVHqlthMiF12t112O5/jPaRmx8BGZXmnC9j71aJQ6ji7/DjVkeWQaQFq
         Zf+bkqp2pDDe5cnwe8Q4TiPb6ugGnqT9boaZGNDxr59vObJ6OP/hextqDmYq17sJJhnn
         dFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2BlNjd9CAoC52vv1NpViW3j0LOH8CyDQbmV+zNI9trs=;
        b=6XUxlcM2ylsFcXqHir1sSsoPBWNI6NhqKJeqPvhKQyKb31AibIDseWo3TwZHU7P++j
         UoMAXSxr6xcN+8LxUvlNhhasEGfcxXge6pdVJ17rPeeFTLVPIWIj68gvr5FWrTGUKrFd
         JYfy8Z5GYvi7DWMK8IKyNAXMrZF+nU86N+eJiQ1zVsnRy+VMTy7F1EfMit2Qhpwr7/4r
         /pXeY67y4W2pEpLYc1nkazMoAZB+LIjxfJV0YfZMZcwEqYI7KrP+wLddaUwqxhNFt+uL
         NjqUSjBLizUashUfG3p1cptSyF56wGrydqrKH9lcXLG4ugC1by4GdBOr7aiVtsfLZ6RN
         WqpQ==
X-Gm-Message-State: AOAM531VI+tBxsNg/IOyeZfBFi68ZbT2SVV6GM2TBotkBWMj1wNIJv2O
        1g/zs5exmnfzPViGGtaf5Tw=
X-Google-Smtp-Source: ABdhPJwgtUKlhLdu/MQBoCn3YzFQZD/uRm7Y18I4FmOu02UXRKbIZXBFPA4pyb4sMySs8+um16QFYg==
X-Received: by 2002:a17:90a:5b03:b0:1df:86d4:ba27 with SMTP id o3-20020a17090a5b0300b001df86d4ba27mr4919253pji.124.1652812313250;
        Tue, 17 May 2022 11:31:53 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y23-20020a170902d65700b0015ed3a112c9sm9372718plh.280.2022.05.17.11.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 11:31:52 -0700 (PDT)
Message-ID: <71d595d7-625c-3feb-b1d0-fb745faf394d@gmail.com>
Date:   Tue, 17 May 2022 11:31:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Add Broadcom optional sdio_freq
 clock
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220517180435.29940-1-kdasu.kdev@gmail.com>
 <20220517180435.29940-2-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220517180435.29940-2-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 5/17/2022 11:04 AM, Kamal Dasu wrote:
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz.
> Optional "sdio_freq" clock is used to drive the bus clock if present
> optional property "max-frequency" specifies a base clock frequency
> in Hz that overrides the base clock frequency in the CAPS registers.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
