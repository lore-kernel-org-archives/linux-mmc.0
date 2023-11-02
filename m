Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82946C4167B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Nov 2023 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjKBVAd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Nov 2023 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBVAc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Nov 2023 17:00:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A918B
        for <linux-mmc@vger.kernel.org>; Thu,  2 Nov 2023 14:00:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso1314384b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Nov 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698958822; x=1699563622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8KFumTag/+mfUr046qXGDZHDIauHHYyGcdwD8EXFRY=;
        b=JZIyIVCwD0ECTxQVk3G1/Ci2yYOqLuqNmMu2KPCbmd4HFX/q2nNzTTZYxyfmFDLYg0
         bgFDBtojDff9NEPVAdbup66Ulfsc/yAOnuKDctVk7jf6dalWD5meSdtrbkSTA7uqjiZK
         3UFg71SQe1vaYzXXRWpxMU9Kz777urhB4z6ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958822; x=1699563622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8KFumTag/+mfUr046qXGDZHDIauHHYyGcdwD8EXFRY=;
        b=FhuMqNVT9vdkC+5lRI3iwGr+vFYoFMIQZIrSJCCUuJ7Q4bvTCR8VIWJdyaQZmOydQA
         ajCoZA6Kfvr7yXrVmyfAffuUcro207F0CFYFlfvQkAhUUa7qFkG1dh43i3ZyMY17UK2n
         muO8U+PiNgS94RCn3eUHcJ+LLAF8pVKkqzNs+HyvO9RUQE7VVbBAuwDQFZ/Ugts2rccN
         jS9yENk6j/XlAXHde8RMcy8Qit0GYXhffbHDR1OxvosO+LDA/D7vbGi1K6taXI76k2OD
         orPqXkl1otsHIlqbu3wliqL/BXTeYXWd1OaYG8JEenrvtMfLB7hOWA60uTYnbOgLkXyZ
         IFaQ==
X-Gm-Message-State: AOJu0YwYWzugq2bGV4pswnfe5vE4O3mh8byACZQjtAllOaoNaHA8Vhwo
        S8otQW8j4U0RQzTTO7pC0MvVog==
X-Google-Smtp-Source: AGHT+IHpWfHMpmZgu3Ki0ANwOyVLt9nZosdSKPzywMjZQkoftSaNFtV+rbheqzdq77GxD/borUX1wg==
X-Received: by 2002:a05:6a21:18a:b0:181:74fe:ba83 with SMTP id le10-20020a056a21018a00b0018174feba83mr5241243pzb.40.1698958822357;
        Thu, 02 Nov 2023 14:00:22 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:a601:95c2:1e12:1936])
        by smtp.gmail.com with UTF8SMTPSA id b7-20020a62cf07000000b0068842ebfd10sm174384pfg.160.2023.11.02.14.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 14:00:20 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:00:17 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Karel Balej <balejk@matfyz.cz>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: mwifiex: add support for the SD8777 chipset
Message-ID: <ZUQN4Ua8byy-Fsy8@google.com>
References: <20231029111807.19261-1-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029111807.19261-1-balejk@matfyz.cz>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Oct 29, 2023 at 12:08:15PM +0100, Karel Balej wrote:
> The driver requires proprietary firmware which is not yet part of
> linux-firmware, but it is packaged in postmarketOS.

You gotta get that done:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver

"have firmware images submitted for linux-firmware with an acceptable
license allowing redistribution"

We can't have a driver requesting a mrvl/sd8777_uapsta.bin firmware that
isn't available for anyone [1].

Until that's done, NAK.

[1] I think you might be referring to this:
https://github.com/xcover3/android_vendor_samsung_xcover3lte/commit/6e324b43b32dc607327d89148dd5d83a14429ee6

But I don't see any license info, so I don't think that's going to be
appropriate for linux-firmware.
