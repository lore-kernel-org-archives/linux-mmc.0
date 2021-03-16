Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF55C433E6
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Mar 2021 22:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D897964F96
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Mar 2021 22:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCPWHc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:07:32 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:39041 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCPWHK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Mar 2021 18:07:10 -0400
Received: by mail-il1-f178.google.com with SMTP id d5so14196877iln.6;
        Tue, 16 Mar 2021 15:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c7PiDBTH7M3rD94WrweiGEydSkQAgo6g3DUgMc8MiXo=;
        b=AwU7+IaXhr0n6koUMzajuE2yQPpWWXOnnSI9ZJkXl5yRjV+BuQeqml2hXiDBsc6puD
         UDWKxBhkwuARTdFFkAXKIklqiEQUDc9n4b57IITqtmZsYJCmM25S1iShbl6KWksm/Q85
         RDm8LA3foZ0KKFot+eDMCKNhSwVlvNSwOTkO/VmGF2m7bx7AUgL6xK3KoJCluJyXfTXs
         Y2ZE4E0m1MSnYViF9gCSl9+NDXp+4ZB3lk9b7O44ymLTRfAwEaMDtqk/vkXqFx2Q1dFN
         MB+E8GsAP235jO+YC5h8gP2FQFtosuxU2+IS6dZ6LfnM+PZsp1fCtBGzkQkbtikOB/Ey
         P14w==
X-Gm-Message-State: AOAM531gIMUN+4jp76P6krCPXDyziL7yhOGq0lJhW6FtuVXCL/M4s7vh
        zOuynX8Fu7RB635fhO8+fw==
X-Google-Smtp-Source: ABdhPJzRxK/0AogAZXl7YXNMtbCnlmB6+Cie+xr/Yd5aXirMYSX+ma7l1UMS9sm3iwMWVypDrn70oQ==
X-Received: by 2002:a05:6e02:ca1:: with SMTP id 1mr5192128ilg.242.1615932418900;
        Tue, 16 Mar 2021 15:06:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v7sm4526639ilu.72.2021.03.16.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:06:58 -0700 (PDT)
Received: (nullmailer pid 3764195 invoked by uid 1000);
        Tue, 16 Mar 2021 22:06:56 -0000
Date:   Tue, 16 Mar 2021 16:06:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        devicetree@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Wulin Li <wulin.li@mediatek.com>
Subject: Re: [PATCH v2 4/4] dt-bingdings: mmc: Mediatek: add ICE clock
Message-ID: <20210316220656.GA3764131@robh.at.kernel.org>
References: <20210309020649.582-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309020649.582-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 09 Mar 2021 10:06:50 +0800, Peng Zhou wrote:
> Document the binding for crypto clock of the Inline Crypto Engine (ICE)
> on Mediatek SoCs.
> 
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
