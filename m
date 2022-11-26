Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C9FC4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 26 Nov 2022 08:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKZIBs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 26 Nov 2022 03:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZIBr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Nov 2022 03:01:47 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3552FC04;
        Sat, 26 Nov 2022 00:01:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so9645568wrs.10;
        Sat, 26 Nov 2022 00:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkDoPI2qppXdUMCCitjLF1bJwbWxWY0TUJNT5sQs//E=;
        b=OsNWBa0YmqRqWOewSfmuPDMZUu+z2EWjGfWx7PRj6KUNTDgZboE9hRS8d1eeWR6rDU
         ncx2x40zzvxJA5NMz5xR5R+BBGQMQsF75a1qXCE1L+ATAMPUkh81EXmpPAG7loMkPHGM
         xVB+C/88ZfKONsDvINFXplog2Y5973eaZaVBNagEAz3JjwLXXNDdRMSrajzn/H6ScNoc
         vhbPEMsa3gCu8VnWcg2lSm4Wfq2h+3asxIp519OPvXCp/B0rTjX0aOfivirni8c2gBaY
         y7wy/aHXGASQWrpegyuilCyLh2jbsJ2PEyuyw0U47P5h4KSHIwwBgk16BD9wzGd2FZyz
         7WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkDoPI2qppXdUMCCitjLF1bJwbWxWY0TUJNT5sQs//E=;
        b=reP2AT4KeVhvwbvNxk/fBW74yUE4Jd/zuA6TqB4oXeJg+yqdoddUkTHbQEAcN5LwFF
         byN1PFrmkrpMPCWZBEsHAdFtrO8UEr5nsYH/LBrkkcECdZ7pclqCuXKHatd83pBvQ2Vk
         bAon8+wMNk8+QEf+2ZvLj5W6EU8xttqpZuTV3vH0wmnJnR4KK2PMnIhuwa1zBai32YxF
         elHT3ia1tNx5l08Kg2HR0kxaF4/KcYGyQ3fTpNVaw8llMkJiULghVgjQYJtJ2qn1if+L
         /PBzo86YsYf43YPhSVFgBDQF1vpPPWCyPEpvB0c+XcCyK0TEJOTsIelCXtxn+W3vzy4j
         DvjA==
X-Gm-Message-State: ANoB5pkWIXsfZZcfyiCMQhsHwsMlGO4Ztr3UEIAhGBQ7nNyRbzl6gkDZ
        EEa/r285HEvIq7lx3I2cB9I=
X-Google-Smtp-Source: AA0mqf6DUS/FOQFOwVCX1YRN6SsaA7FgSoFL2xhJoIbqxdY//mdmWHgy8mG0vhBwkmQaIoCBvLqCbQ==
X-Received: by 2002:a05:6000:110e:b0:22e:41e:29fe with SMTP id z14-20020a056000110e00b0022e041e29femr4951311wrw.83.1669449704559;
        Sat, 26 Nov 2022 00:01:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003c70191f267sm13181607wmp.39.2022.11.26.00.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 00:01:43 -0800 (PST)
Date:   Sat, 26 Nov 2022 11:01:40 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        christophe.jaillet@wanadoo.fr, axboe@kernel.dk, hare@suse.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memstick/ms_block: Add check for
 alloc_ordered_workqueue
Message-ID: <Y4HH5Ch1ABrRzN5/@kadam>
References: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Nov 26, 2022 at 09:25:58AM +0800, Jiasheng Jiang wrote:
> As the alloc_ordered_workqueue may return NULL pointer,
> it should be better to add check for the return
> value.
> Moreover, the msb->io_queue should be freed if error occurs later.
> 
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Assign error number to rc if alloc_ordered_workqueue fails.
> 2. Free msb->io_queue if error occurs later.
> ---

My other question about this driver, not really directed to you but to
anyone on the list is where the final destroy_workqueue(msb->io_queue)
is when we unload the driver.

regards,
dan carpenter

