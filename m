Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B86FA3743
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 13:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiJXNmR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiJXNlE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 09:41:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E9BB40C2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 05:37:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d13so5938328qko.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6s8WA+syYl/1soPYugl8PgRcJUKvL8znur65OKyCTY8=;
        b=O4MW5Mz8AyKyDlwQp6prA3grYcTgM+7SDh5ALqtcwq8HOqoXmYnE73w5dRu/Jcqwod
         lK8ED3cOblYtl+6O6Vnj2bd+HIKLhr5SJRZB5w/lliAoR7H/b0lI76cNRWfU8GjNwJ9F
         2jPmL6UWjTjcoHKwSfTQN01OzFd6BL19NZnUlN7a10a8v3n8e+gjgHZqDUUQObYNtKYi
         xV7cxTbLIZYYxIYD3XViMzFKJa9UvhbEiu6MKFcyeYrBoEv8kz2vpZ1NEuvTGstPrV6M
         eSU7fgy0hEmbSa1ho6YiSlY8U5EJNxOeLNms9485OnDOgHcv69wz02CBVp4qC0MFs7r+
         yh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s8WA+syYl/1soPYugl8PgRcJUKvL8znur65OKyCTY8=;
        b=jz3YhQq/OVxOIUphmHQkwi3NiKHlqpvGxmrIGI34rhPmlMpCbWq26Vq14vJnkk7O+P
         Lw4UqQD5oGthLP2ZMmeadYKT15R3QHiyeSJK1tnAwaYK//6P+p/WRtqyf+Z4JhPMGp3w
         1gcQjz+Ums3k9LYGxYgBydp6v9gGhRGhtdWjaGRj3SYbkuZ/qNfXjh18HJ4uoTzCtlQ6
         eDC8FZuQeDNHKlaL2Vm2Sl4892K1inkQoxB44OWfyB9VXoVk70XJxj1qzZfspeDUfs5H
         UUurVRjmBHW7vBeFgkrB0n6Ffx7EfEP4K2s19m1Zcvt/p/rSnGAO4iB+R1hGpIaPqIDx
         p/Xg==
X-Gm-Message-State: ACrzQf23EaVW+GlxjJ3/IX4Iz/yC7s4uu0DV6Eo+2CnC1zztKLDh5a8+
        u3Zy4Ra3mjOT4eg2T98XnGBweg==
X-Google-Smtp-Source: AMsMyM78IBElxH8BgFkoT519PImmXgVVPmXKo+cy//tqAhGj3gFdCsN0VRVhe+sZ5YMuqfvc7mXViw==
X-Received: by 2002:ae9:e8ce:0:b0:6ed:22ee:305e with SMTP id a197-20020ae9e8ce000000b006ed22ee305emr22099101qkg.255.1666614959885;
        Mon, 24 Oct 2022 05:35:59 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id cd15-20020a05622a418f00b0035bafecff78sm12693087qtb.74.2022.10.24.05.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:35:59 -0700 (PDT)
Message-ID: <a896c106-d261-c763-7410-0f2acefebd41@linaro.org>
Date:   Mon, 24 Oct 2022 08:35:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 10/21] mmc: remove s3cmci driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-10-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-10-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform is gone, so this driver can be removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

