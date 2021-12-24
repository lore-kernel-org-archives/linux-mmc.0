Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA5CC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Dec 2021 22:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhLXWId (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Dec 2021 17:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhLXWIc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Dec 2021 17:08:32 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D3C061401
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 14:08:31 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c2so8600594pfc.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 14:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s2ZFIGLcJqatLpJ7uBBi394Yhb2wj9JQle6cIwKvLbI=;
        b=KaEVlFxiuhwvwNK+k76a093IvWET4JiPNvHrcTPcTeh05v0+dw76Om7I18vR9bFp1h
         CKMaMo3TY78YYjFY0uCvMBmMVv/KWgVPYhItXZz/BSSojIHzIz/fFpKYzL9PSaIyYQ28
         xY/cvOgKFOjxrvBbF+o7IY63M33KLHW61dNikqUHRO5JR6sxbdnBsQc7A/XR8z5XXD9r
         3jrXBwkpo79BbX+iJxdAN23Q0QWD9PUgxqFKV4OTmuym5Km+cxy6QK5AkWNYakmZJclo
         +QNyE5wawI22YEBNxCijszAkg0/UNoynem9zJ0Exe76lWM3Qb4E06+7x6CHIQGJUcAps
         mF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s2ZFIGLcJqatLpJ7uBBi394Yhb2wj9JQle6cIwKvLbI=;
        b=Ub2yBSe3fwuNoOL/Vx4c3FYvR9yA9SZJNXQzpxy7bpdvgqDa9KkWmvEzUc3MTK6qNg
         JcfEdO9ERM0p+KetfMzLnmdqz8GVBTgg6oJm/TzpA4+eXgTQ4WWdbpkUyT/lJWT3p+Ao
         tm63qdXR1hDhEYMTIB5mNiEMk5lFhY7AaadI+04/ii5oNCxC1h/GR7wxm7CpH2DpBRKT
         kQojRH/f91JfCxfHP6nFECCeXWVjibfArUaEXaPDBvX4W4x7Rr21jfGfZn3mcu1g03y4
         yvtIny4YLCEyA0N3xhZQoF0fNgVPHFpkiNRYrM0LKqv3jkm1TbTqqPB7h3egGo8H9XKp
         BOow==
X-Gm-Message-State: AOAM532uXBsLaw/5lOiwe5R8qyx/5ANTU7m+8zZ7C3pgFR4smKqNr72n
        mVUiWAJtacBZZsNTenjXqS/aa4jlMiM=
X-Google-Smtp-Source: ABdhPJzR8IT5Lrcm9KeGv3dcJ1IE0nDym4bvKX6NWC6S+nAJF/EdpRDhcs/kL87oOylo039tuCn6NQ==
X-Received: by 2002:a62:6dc4:0:b0:4ac:fd66:b746 with SMTP id i187-20020a626dc4000000b004acfd66b746mr8308892pfc.17.1640383710842;
        Fri, 24 Dec 2021 14:08:30 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n34sm9404456pfv.129.2021.12.24.14.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 14:08:30 -0800 (PST)
Message-ID: <7cefe4e2-ce54-5d69-67ef-10cec8f15d8f@gmail.com>
Date:   Fri, 24 Dec 2021 14:08:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH RFC 01/13] mmc: bcm2835: fix deferred probing
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-2-s.shtylyov@omp.ru>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211223171202.8224-2-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 12/23/2021 9:11 AM, Sergey Shtylyov wrote:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
