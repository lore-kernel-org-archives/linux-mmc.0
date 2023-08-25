Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D400C3DA6F
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Aug 2023 10:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjHYKBM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Aug 2023 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbjHYKAm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2023 06:00:42 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8544F2107
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 03:00:39 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5924093a9b2so8836737b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2023 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692957638; x=1693562438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6If5EjcjNWDZstp6qFU/ATLLg3ICZt1fdKDrO8/tZ0=;
        b=nbI/JwabJN9ZeZcmPE1O5VxauB1CWuioWf0xlXmfRufq0VO3/lR9taNtbLp71Mo1Eq
         LCPu2Q6/tKcUD5LOSfWA761HbbLtlft/M0+ealNEIfYz1k0BK4hAZyTyi/kSGcfN8oqL
         jLuBCJgu1lUGE3pkoPoIT/djjNreJza1CLIk/Qcd+B0m7Crc4WLTwgLM5PURPuJ3MOWr
         gXgnlU4rap4rN4SW+Nt14jYykzpQwLv3ny7wFIk2oUNRxm5eJXAW1uRYCdOBseanqCxI
         Q1eqzg86L0Cr0/Osd242hgru665hz0xFd7yd+VhXEir/DYIKdMaGKyeZhqo8UG9ljpfy
         PH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692957638; x=1693562438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6If5EjcjNWDZstp6qFU/ATLLg3ICZt1fdKDrO8/tZ0=;
        b=CQ8CwRUo1E8FDqww4RJqMwyRCXKE+Jz7r8J/6zAWYUBX4Lukd+r1EzpP/tjZGSX6Fr
         JbaIvIAz+8MxSv4kX/91MYHtHQf+iI3RK3bvBwTZOrh/soSnWzDv4UHHvVIMBbzzuYlk
         cfxaC/3meNMAxfYUrgeMozYNVEpDqp63U06FEBK037xXEjqNAGYDA/Cd9h7xUAk9D9O/
         5bMkQTGItMLMNJaWVu4JbVTR+IlnEqWqVkqwOtLMMWJnwP6le+2hFxCvugw1xTzQI5nr
         eS6zcKSmHvbxZDLKgUdaPrINvDfSyIoQvk9o+q6b9j0i2nX/aHIACjCgrHR8NH8uzNyD
         himg==
X-Gm-Message-State: AOJu0YzLTc0e4taM1rMNiN9IsC06V3Z0boykVB7pWOkgfAYmYQNDSETG
        s9olX5FdKNyisaFhyUfBlH0m3jwWMkf2kbnzIEfJ1To5gJl0ECoMfLs=
X-Google-Smtp-Source: AGHT+IEOsbOy+RYASkcI/UnK7YnLgMYNKZ1ts7Vx3xLDADc2hk/6VG4xLAk6rgwHyCF+46GXcaoPiyniIDPGrmQbRdk=
X-Received: by 2002:a25:f81b:0:b0:d15:7402:f7cd with SMTP id
 u27-20020a25f81b000000b00d157402f7cdmr18874314ybd.27.1692957638523; Fri, 25
 Aug 2023 03:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230825091743.15613-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230825091743.15613-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 12:00:02 +0200
Message-ID: <CAPDyKFoBnZCF7MMfou=mY0xqVtCcCOMMtZGv=KpxhKxFFjkqiw@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Aug 2023 at 11:18, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Change in v3:
> - Move changes in include/linux/mmc/host.h and drivers/mmc/core/sd_ops.c into patch1
> - The callback is executed when timing is equal to MMC_TIMING_SD_HS
> - Rename prepare_hs_tuning to prepare_sd_hs_tuning
> - Rename execute_hs_tuning to execute_sd_hs_tuning
>
> Change in v2:
> - add mmc_sd_switch() and mmc_send_status() to the header file
> - split up core changes from host driver changes
> - Use pr_debug instead of dev_info and dev_dbg
> - Optimize the best sampled value algorithm
>
> Wenchao Chen (2):
>   mmc: core: Add host specific tuning support for SD HS mode
>   mmc: sdhci-sprd: Add SD HS mode online tuning
>
>  drivers/mmc/core/sd.c         |  14 ++++
>  drivers/mmc/core/sd_ops.c     |   1 +
>  drivers/mmc/host/sdhci-sprd.c | 149 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h      |   8 ++
>  4 files changed, 172 insertions(+)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
