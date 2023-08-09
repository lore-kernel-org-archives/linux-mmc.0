Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C83C001B0
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Aug 2023 11:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjHILep (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Aug 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjHILem (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2023 07:34:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4D1FD7
        for <linux-mmc@vger.kernel.org>; Wed,  9 Aug 2023 04:34:42 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso6707807276.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Aug 2023 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691580881; x=1692185681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8oqLPV5bc3mGZkHcuIYSHn8as3mR+gQGzva0mC/UVg=;
        b=kHUGlGkwcfF40l7a1GteiC4u275imyDH7zEehH8IGadm6b5vDGu5Z/fiTncMfIzNoc
         Do2cxY8VHV221YodbyAqYG+LdjTgcnZAEAjS0VLlu1wNDAeADHFqDztdOTcI+iBn444C
         8hjHg6V2phBA0Dgk3ztKhxUaIlJ8hsyTafil2FQu7FBbv+aN3TSCy2f88fvOgMH34tcP
         CWamJtizFN8Pu3REQojOVgHkcSseZD786EctOsa6lPXRefT2wt0SfcGfxkQkX79SBVkS
         TsvRPR7tE6Eban45vd43dpoENZ8FOMbrJyDJVsjPuUPvy5tJCRIwqObbo86JpsVcyQIQ
         txfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580881; x=1692185681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8oqLPV5bc3mGZkHcuIYSHn8as3mR+gQGzva0mC/UVg=;
        b=E4DNjTX0KSgyrRjestANbv+TWgnD5sMSHLJIntQ2n31AlB9MMSbKJJHMsAcBRSwsMZ
         +lp40lwA0Q2I5/ISCCarL5ny2xjjvPVefQDE5frJ/4jRYGCH+VSItej8rjkbNpOuBM4H
         HojRL6eYUMCYagzlLYjV6j9a2efEWAMB3rdqXUq21DGl6b8LOBkL6EXwzBU9VkoIsFPA
         FQa2Qn3Otmhq8GWTj2Khv0u7Y8WxEojk1md6zepyBsRN6XngB8liXWm8L1ENg2MC3/28
         4wrFdqHOUiyMNytoHxnf8q03XzfVtpelJEXhqld/hhPRxim7C0tjZgh+HcQi5Qsv62/w
         yQ9A==
X-Gm-Message-State: AOJu0YzIFssczmWQBw5dYpzhKWh2mWB0gaK7xljitjKfXw86xSfgbzae
        npUnZQdD1NuUHm1mmIFpeypOSdIkcNm6/K4n3ncdWg==
X-Google-Smtp-Source: AGHT+IEE8n6xQBKMEBJuDDtNKkzIaOqPA6h31DNQIW3tHC8CWfyb5wZPJ/0gXCJD057Eic9WkzSCBL3pd8uS5dFC6v4=
X-Received: by 2002:a25:db53:0:b0:d47:d770:c953 with SMTP id
 g80-20020a25db53000000b00d47d770c953mr2117839ybf.30.1691580879953; Wed, 09
 Aug 2023 04:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808133714.214914-1-wangzhu9@huawei.com>
In-Reply-To: <20230808133714.214914-1-wangzhu9@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 13:34:03 +0200
Message-ID: <CAPDyKFo=88-KFW89Ud2BYNDim1LuFt7Dcqvuq_CR2aPf4K5Urg@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] mmc: host: remove redundant of_match_ptr()
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     adrian.hunter@intel.com, sugaya.taichi@socionext.com,
        orito.takao@socionext.com, vireshk@kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Aug 2023 at 15:38, Zhu Wang <wangzhu9@huawei.com> wrote:
>
> The driver depends on CONFIG_OF, so it is not necessary to use
> of_match_ptr() here. We remove both CONFIG_OF and of_match_ptr() here.
>
> Zhu Wang (2):
>   mmc: sdhci-spear: remove redundant of_match_ptr()
>   mmc: sdhci: milbeaut: remove redundant of_match_ptr()
>
>  drivers/mmc/host/sdhci-milbeaut.c | 2 +-
>  drivers/mmc/host/sdhci-spear.c    | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
