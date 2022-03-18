Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A5C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Mar 2022 13:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiCRNSs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCRNSq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2022 09:18:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C38220306
        for <linux-mmc@vger.kernel.org>; Fri, 18 Mar 2022 06:17:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a25so670148lfm.10
        for <linux-mmc@vger.kernel.org>; Fri, 18 Mar 2022 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBHSwVCUi6XmU1RLTEzkVQTJcpLHZUtugc0slc2X+4s=;
        b=CZKQe6LR1SLfDh3DsxCO3CnBLHXHCCt6mn1hab7jtmcY2BXYOXHoAxIXaiWbR4P5qj
         HfybsfjLaeo8fvndRlh7Mvrbv7hasVrSvDPcqzNsPbKEa/2aay4fqgWofJHb7CAmJ2wG
         KiCLtjtnlwh7qNvAeOPQnlxDbF1tDEJEnWF1FcNpygS9dfdrWOAwfcTq/Kgir5dAt/NY
         ldQ48fhbksMBnRBp1JdGKsQ2XSI6iLxOCC4J2ilcgioc2G10klfhuCK/kt+rEx+TeLQG
         l1ChWMD62u3ce2Rsz4uj1gLeLuOCBQNvwlIrFLBGlxq0qleBmcitvdbdwDlsfDar2wcX
         r9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBHSwVCUi6XmU1RLTEzkVQTJcpLHZUtugc0slc2X+4s=;
        b=Syn9sOfFB9iLv/wcdzTgZ5MoRtjw1+YfcDcanRB0L5ClBVyox2IyCPf3EBs3PyzIwL
         28A3I8nheWZln1z90vPJlMf1dD7n4FLuKbYh4VGy0xvNihssq6siAObMuX/5oGrfFvZq
         Gqw4J+xibpxUkuk6iZzfD8PWu/cl2ntNORVHxEiBIRByphxK3mkY1CxuSlgobKXjpcR9
         yPb7AxAMCN727TN3b9yrhpLwzSb+xQQ4MdMRvjtUfBCAinGfGIgMf4cWH2bNIpZ2i6Cy
         8oRtYPCn8XUvWgVzd2KvZIXZw+lKpomVG/65Oh47qyqBuiNI4MupBbL3rEZ77rgvoDPJ
         gpgQ==
X-Gm-Message-State: AOAM533cjc7qDz5FXshGVAQggUDYOXjhc8YbsRFeRhmg9JW3KVpvflwt
        ZH5af06R4pkuNb2/9Qln6/ePcCHAcJSP1913Mftl3Q==
X-Google-Smtp-Source: ABdhPJwqGVF8uctGqH18zS4Qn99ZV+vwmIGZTl4t27NkKwsvtkccoYT+dUYLunCYXYBswxoOyjBLSJrSvCOSVyrL0r4=
X-Received: by 2002:a05:6512:260b:b0:445:c54c:4157 with SMTP id
 bt11-20020a056512260b00b00445c54c4157mr5952207lfb.254.1647609445214; Fri, 18
 Mar 2022 06:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Mar 2022 14:16:49 +0100
Message-ID: <CAPDyKFo95H+AjoD5Z4TgYwALt1akSbv=E0i_QbKr3tdARMCdtg@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] Preparations to support SD UHS-II cards
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     takahiro.akashi@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Jason.Lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jason,

On Tue, 22 Feb 2022 at 04:39, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> Series [1] that has been posted by Ulf Hansson which provided some guidance
> and an overall structure.
>
> Series [2] focused on UHS-II card control side to address Ulf's intention
> regarding to "modularising" sd_uhs2.c.
>
> Series [3] is based on series [2] and adopt most of Ulf's comments.
>
> This series is the successor version of post [3], which is base on Ulf's "next" branch 2022/02/14):
> 1. Modify settings in uhs2_config_write().
> 2. Fix some compilation errors.
> 3. Fix some warnings and errors when executing checkpatch.pl.
>
> Kind regards
> Jason Lai
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=438509
>
> [2]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=589827
>
> [3]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=606241
>
> Jason Lai (3):
>   mmc: add UHS-II related definitions in headers
>   mmc: Implement content of UHS-II card initialization functions
>   mmc: core: Support UHS-II card access
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
>  drivers/mmc/core/Makefile    |    2 +-
>  drivers/mmc/core/bus.c       |   38 +-
>  drivers/mmc/core/core.c      |   43 +-
>  drivers/mmc/core/core.h      |    1 +
>  drivers/mmc/core/host.h      |    4 +
>  drivers/mmc/core/regulator.c |   34 ++
>  drivers/mmc/core/sd_uhs2.c   | 1088 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/sd_uhs2.h   |   16 +
>  include/linux/mmc/card.h     |   35 ++
>  include/linux/mmc/core.h     |    6 +
>  include/linux/mmc/host.h     |   69 +++
>  include/linux/mmc/sd_uhs2.h  |  198 +++++++
>  12 files changed, 1514 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>  create mode 100644 drivers/mmc/core/sd_uhs2.h
>  create mode 100644 include/linux/mmc/sd_uhs2.h
>

I decided to help out a bit and are working on some improvements to
some of the patches from this series.

Although, rather than me reposting new versions of these patches, I
will share a public branch via my mmc git tree within a few days. It
will be based upon the v3 series, but incorporating some new changes
from my side. The changes will be explained as a part of the commit
messages. I will let you know as soon as the branch is available and I
am also reviewing your series, so will provide you with some comments
soon.

Kind regards
Uffe
