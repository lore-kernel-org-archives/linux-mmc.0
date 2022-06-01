Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75EEC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352242AbiFAMrd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353085AbiFAMrb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:47:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210E1056C
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:47:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j10so2528878lfe.12
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4li32PBdxnIv+jFKvhCljFF/bYWyWatcYvkg3TZww1s=;
        b=ywX1q/Sp7hV1p86goYqniFRV4cZlbD1R9yXvl2mfzeiuSR3efubHRWaiRdhX8Esqed
         mJ3yGD0RUVPPt1f/R+ouSvoTxOqAtRGGgJUYbilgONCDkx8DOopTBoVTnK1YDUsrdubc
         35isYXnsGcsXSl0mGJFgkq3r3lG7riqq0eSxluKLDD9BSI3Llw6eJre/ph0RCqD4obLC
         i9YXHOcRy9Xt2c5IM1Gz2xlBGmspzRO9AVWXDux0w0p9TMNZeVhk0CUU/AV1ol0ip3mo
         xFYcraKqvM6vRkJcCRd/ukGbYMiT6azPbdbKx0f8zsY59oJZGDh+lFQouG4FfWUAYOmP
         Jukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4li32PBdxnIv+jFKvhCljFF/bYWyWatcYvkg3TZww1s=;
        b=RHexGXfb3gD2vLNokiEAgvXqjznw0kvFVFyc1PvlIrWiEWX/mFaj8OoDAQVtyf8SsJ
         4UPNjTnCzzZbmw2I4YwePB/v/TivGCN4bL4sBVJ2W6CUiF7lEcQ7A4s5+9EZFdMVHG/P
         8RGyj+hxgd1tr++AhJ8HHaqrJ80vuj247kRTGkYiVG+cXiVbJf/WPeM0nh7QHK1fVO9P
         YdXzFUilYvLvKfOsn5smvmYFezY9mBih0nQn9wnsrYCxDab5gccyuZsGxcwphb1OqlMw
         Mt4ui/BzlCdD2ZoWt9cRaPQSb67+Eo2v0PbrckMLFtn4AXPO/ygvsmwi2GXzJu+6ocD0
         onDw==
X-Gm-Message-State: AOAM533HNDRdHTb7+S0r5yN9NuSICoyBy8OQrbQgp2IRbs1YPKn2EGHz
        nnoMflsdwJ1ml+Xi9oopgta2Kq/DqQE7M7kDDWKGbA==
X-Google-Smtp-Source: ABdhPJw8rLYnetAKH4EyHC77hyUUHRF/sLZFy9a2sig6ks5ygw10wco9yqviC0600wPiouO4wz2Lk4I3fuUHalzgJn0=
X-Received: by 2002:a05:6512:308b:b0:478:7ab5:4acd with SMTP id
 z11-20020a056512308b00b004787ab54acdmr34023519lfd.167.1654087647633; Wed, 01
 Jun 2022 05:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:51 +0200
Message-ID: <CAPDyKFqqSdCGV-SGcbEFCA5rXaqUc0btYd9Tig43NouNuHUG5Q@mail.gmail.com>
Subject: Re: [PATCH V8 0/5] mmc: add error statistics for eMMC and SD card
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        adrian.hunter@intel.com
Cc:     wsa+renesas@sang-engineering.com, shawn.lin@rock-chips.com,
        yoshihiro.shimoda.uh@renesas.com, digetx@gmail.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 27 May 2022 at 19:54, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Changes since V7:
>         - Patch set V6 rebased on Ulf's(Ulf Hansson) master branch instead
>           of Ulf's (Ulf Hansson) next branch by mistake. So rebased patch
>           set on Ulf's next branch now as suggested by Adrain Hunter.

Thanks to both of you for moving this forward to become an easy
maintainable piece of code.

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


>
> Changes since V6:
>         - Rebased on Ulf's(Ulf Hansson) next branch as suggested by
>           Adrain Hunter.
>         - Replaced debugfs_create_file() with debugfs_create_file_unsafe()
>           as suggested by Adrain Hunter.
>         - "[V6,5/5] mmc: cqhci: Capture eMMC and SD card errors" not
>           included in this Patch series as we don't have cqhci changes
>           on Ulf's(Ulf Hansson)next branch.
>
> Changes since V5:
>         - Considered all error stats enums to set error state.
>         - Added missed tuning error related code changes which was
>           missed in patch set V5 as Adrain Hunter pointed.
>         - Replaced DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
>           as suggested by Adrain Hunter.
>
> Changes since V4:
>         - Defined new macro to increment err_stats members when error occured
>           as suggested by Adrain Hunter.
>         - Called err_stats members increment function after printing the error
>           as suggested by Adrain Hunter.
>         - Considered INDEX and END_BIT errors same as CRC errors as suggested
>           by Adrain Hunter.
>         - Removed Null check for host in debug fs functions and Reordered
>           err_stats declarationas suggested by Adrain Hunter.
>         - Removed err_state variable stuff and updated err_state debug fs entry
>           based on the err_stats members state as suggested by Adrain Hunter.
>
> Changes since V3:
>         - Dropped error stats feature flag as suggested by Adrain Hunter.
>         - Separated error state related changes in separate patches as
>           suggested by Adrain Hunter.
>           [PATCH V4 4/7] : error state debug fs
>           [PATCH V4 5/7] : error state enable function
>           [PATCH V4 6/7] : error state enable in error case
>         - Note: we are enabling error state before calling sdhci_dumpregs
>           we couldn't add the err state in error stats array as err state
>           is not error type.
>         - Corrected Signed-off-by order as suggested by Bjron Andersson.
>         - Moved error state enable code from sdhci_dumpregs to error
>           conditions as suggested by Adrain Hunter
>
> Changes since V2:
>         - Removed userspace error stats clear debug fs entry as suggested
>           by Adrain Hunter.
>         - Split patch into 4 patches
>           [PATCH V3 1/4] : sdhci driver
>           [PATCH V3 2/4] : debug fs entries
>           [PATCH V3 3/4] : core driver
>           [PATCH V3 4/4] : cqhci driver
>         - Used for loop to print error messages instead of using printf
>           statements for all error messages as suggested by Adrain Hunter.
>         - Introduced one flag to enable error stats feature, if any other
>           client wants to use this feature, they need to enable that flag.
>         - Moved reset command timeout error statement to card init flow
>           as suggested by Adrain Hunter.
>
> Changes since V1:
>         - Removed sysfs entry for eMMC and SD card error statistics and added
>           debugfs entry as suggested by Adrian Hunter and Ulf Hansson.
>
> Shaik Sajida Bhanu (5):
>   mmc: core: Capture eMMC and SD card errors
>   mmc: sdhci: Capture eMMC and SD card errors
>   mmc: debugfs: Add debug fs entry for mmc driver
>   mmc: debugfs: Add debug fs error state entry for mmc driver
>   mmc: cqhci: Capture eMMC and SD card errors
>
>  drivers/mmc/core/core.c       | 10 +++++-
>  drivers/mmc/core/debugfs.c    | 79 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci-core.c |  9 ++++-
>  drivers/mmc/host/sdhci.c      | 59 ++++++++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h      |  3 ++
>  include/linux/mmc/host.h      | 26 ++++++++++++++
>  include/linux/mmc/mmc.h       |  6 ++++
>  7 files changed, 175 insertions(+), 17 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
