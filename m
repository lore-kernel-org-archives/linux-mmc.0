Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83435C6FD1A
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Mar 2023 09:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCFJRa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Mar 2023 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCFJR3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2023 04:17:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03750211C7
        for <linux-mmc@vger.kernel.org>; Mon,  6 Mar 2023 01:17:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so8015960wrz.7
        for <linux-mmc@vger.kernel.org>; Mon, 06 Mar 2023 01:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678094243;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fpTAGmKjYnXHgPn/6xv3IbFtnqRgDalc7dH55K8iLHQ=;
        b=zeWUmLbLKttdjBAG5tsk+a/h8WCkuQQLbmMPuLAo+Xi+V4u1S+vdAMDUthDr8oZnwO
         gpZ7C2DTQ/aigtkdk2RYFzUGpiKyiIrlZ+9iTFYhrv/WmQowjD+QueqY2yrVP5RJQ8hD
         hT4MY4D0vsU9Qur7e0NL1TnO5llzwVkOrl/JcnNeo2fu5wMbpM6RI+t80MiaEaIlxo6z
         JWRx2jF6lndIL4Uxh6UOXXp3E5dC2H7QjNLNsVWIX3dzI6myiLfFQPi+s0ffsk04Z2VS
         TLy2yFSDr9Dws1jlbOTPpOOozNANM/OFTw+KkW9cp63WsR6OPtLEZwY7YT+zGyve4ji9
         kr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094243;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpTAGmKjYnXHgPn/6xv3IbFtnqRgDalc7dH55K8iLHQ=;
        b=RghuDTqwtLCWofk3mR4ZWDkOUCEDwoArn/oUn6Qq5Xv2kw+dY7L2JxODPtqLr2bvd8
         RK40REA8uGGcAZg5At9P7dq+9kbIviN4mYLcfV0rTzoWDRyglBjin37TIpwdgr47obAd
         nO7yd4nQlbI1qk+MwsiwavLVd0OCaN9R3k0wlxdvVgbQa0WPn9VVzz6tx6/ohJX4+tWp
         38Nwz+FAw9Cumv7XA3tohQ5Vd0DWErRODAQdBaIPampakHesD/Vq5NHgrzTyfQsMjcDI
         hn0AI6iUf3e8BCSR5PmZ2lkVbCveQPfV6zbe/2QcWtuF8XXr/Q47UVCUxNigyVpgsE/K
         Nk9A==
X-Gm-Message-State: AO0yUKXdkuxOtyhNnl+5nvMs+Ef20bpH33vlwaUVt/y1DRDlArnfQJ2V
        cFAXfdRLHV7fma1Znmui/UUTlA==
X-Google-Smtp-Source: AK7set9uoqNTzYvFyRGiT60AnI53z1pW5Hm7qll3aqsyCgi3MeRz1fHkDbXj/iDBVU5klVUCbV4RIA==
X-Received: by 2002:a5d:4404:0:b0:2c7:107c:e172 with SMTP id z4-20020a5d4404000000b002c7107ce172mr5642251wrq.41.1678094243500;
        Mon, 06 Mar 2023 01:17:23 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d61c9000000b002c54911f50bsm9294134wrv.84.2023.03.06.01.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:17:23 -0800 (PST)
Message-ID: <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
Date:   Mon, 6 Mar 2023 10:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: Unsupported WiFi adapter on S905X2 board
Content-Language: en-US
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
Organization: Linaro Developer Services
In-Reply-To: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Mark,

On 03/03/2023 19:19, Marc Gonzalez wrote:
> Hello,
> 
> I think there's an unsupported device in this system:
> 
> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
> OF_NAME=wifi
> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
> OF_COMPATIBLE_0=brcm,bcm4329-fmac
> OF_COMPATIBLE_N=1
> SDIO_CLASS=00
> SDIO_ID=02D0:AAE7
> SDIO_REVISION=0.0
> MODALIAS=sdio:c00v02D0dAAE7
> 
> 0xaae7 = 43751
> 
> Isn't there some overlap between
> include/linux/mmc/sdio_ids.h
> and
> drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> ?
> 
> (Relevant commit: d2587c57ffd8dc)
> 
> Looking at all the occurrences of 43752 to insert a 43751,
> could someone comment whether this looks reasonable?
> 

<snip>


I think you should send this as a patch as RFC to trigger a review.

Neil

