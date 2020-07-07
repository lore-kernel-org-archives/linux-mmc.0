Return-Path: <SRS0=aSBx=AS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C635C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jul 2020 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E362075B
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jul 2020 13:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWoja15v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGGNNk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGGNNj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2020 09:13:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830FC08C5E0
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jul 2020 06:13:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a17so11579684vsq.6
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2020 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWUSZnUDWdgy+WbtH//6FxaifNRqqUrFryqs84wcO9M=;
        b=IWoja15vEMKFg9nMsDxOz7rWuRLc3gLY9xgARmtxPUOXqcCUQSN3UNjAhvQjdzGpxx
         4EG8Exl+bHRxg9Tx6XEvOYwP5oh79CbLuVkqLCOiuFMxWmAifI/w7CD+dqJl252+LWqz
         PmeE2fv1qWLclaMekp9fiA+6I9jjk/wkA2hsvbUWKrZC1eSG1pmVUUnwanTJ5BRof8/n
         NANxbEqAcl5/yGs76DVrQMj6AybY8Bnj4w8kmp4F7p/FgADwhMvHkrYWIar/mlopmF/n
         bC/OEIjS2Zk3xuHk40pF6RgAcZuFfJa4jFFL6e//vTRR9GYhhM5u2r9h9p0YsnHQvj3T
         dBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWUSZnUDWdgy+WbtH//6FxaifNRqqUrFryqs84wcO9M=;
        b=IppisrBwc/nrvHECq0D/1kR4vrO35eguU8KPd7/c+6gwvJaQVdUhLKyhn4Fipqaeot
         QEYKCl2dyOrqt7nSz4Vt43gRB2ig5aPxy+00Tq3lK2CTGpX3PB3dXreR2mVMhKkXOsgc
         vKhE5YjFbrE2o9SBHyTd8Rz8l87Hvqg5uo+/QVaBv8NgVYN1lQaZOcB3YEUNLLtJR06S
         zVG5fAwtvRtSd9NPKAHsuA2zDG1dl5GLGhMeQofF5qpOkJNgnoa+JMtQdWLbOBdTBLkf
         5iWujAZOeYb9OS2ZcXhYNWQlpvLasIDn6sPb7Tgj+9o6fxVE2+7cUtUr8rAMllHrC/Er
         +1/w==
X-Gm-Message-State: AOAM533VQaysXKdVNLOz5QVRA5CamwILH0gw2du212KM2daTePkeaEVI
        5wfwqOnzF+WfN8hMhflvE55100c5UuYHCza5y4exMQ==
X-Google-Smtp-Source: ABdhPJx73evnNdVzt40tTug92o2sAFXLbpdL1bXynKIobqaoH6USTfBvhuEJ78yBmQUPPC6h5eElIikgj2pDQaYkrY8=
X-Received: by 2002:a05:6102:22f3:: with SMTP id b19mr21412441vsh.191.1594127618469;
 Tue, 07 Jul 2020 06:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <1594123122-13156-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1594123122-13156-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 15:13:02 +0200
Message-ID: <CAPDyKFrGBO=0_yiFHQQqbBHSUdPFHR6snn85cJb9Sedga_e6PQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] mmc: core: add a new property/caps2
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Jul 2020 at 13:59, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Some environment (like r8a77951-salvator-xs) is possible
> to perform a full power cycle of the card in suspend via firmware
> (PSCI on arm-trusted-firmware). However, the current MMC core
> cannot issue Power Off Notification. This patch series can do it.
>
> We discussed on the v3 email thread [1].
>
> [1]
> https://lore.kernel.org/linux-renesas-soc/1592792699-24638-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/T/#m9c25f35d7126b1c14ea431a773757652ad094341
>
>
> Changes from v4:
>  - Just add a new property/caps2 flag of MMC bindings to fix the issue.
>  https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=308795
>
> Changes from v3:
>  - Modify regulator subsytem and regulator/fixed driver.
>  - Use regulator_is_enabled() instead of firmware API.
>  - Update R-Car Gen3 related dts files for the reference.
>    But, I have only tested on r8a779{5,61}-salvaltor-xs.dts.
>  https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=306281
>
> Changes from v2:
>  - Fix typo of function name in patch2.
>  - Remove RFC.
>  https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=305523
>
> Changes from v1:
>  - Use pm_suspend_via_firmware() API instead of pm_suspend_target_state.
>  - Modify the psci driver to call pm_set_suspend_via_firmware.
>  https://patchwork.kernel.org/patch/11557505/
>
>
> *** BLURB HERE ***
>
> Yoshihiro Shimoda (2):
>   dt-bindings: mmc: Add full-pwr-cycle-in-suspend property
>   mmc: core: Add MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND
>
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  drivers/mmc/core/host.c                                   | 2 ++
>  drivers/mmc/core/mmc.c                                    | 3 ++-
>  include/linux/mmc/host.h                                  | 1 +
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>

The series looks good to me. However, I am awaiting Rob to comment on
the DT binding for a while, before I queue this up.

Kind regards
Uffe
