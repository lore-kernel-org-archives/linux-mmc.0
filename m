Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E8C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352977AbiFAMqt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353038AbiFAMqr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:46:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADDE5FFB
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:46:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so2566600lfc.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dt3pR+EuZpEYioOZuqVOF4YuDMykJMYYhRifRhjvIjY=;
        b=jHYYyLrfXLmrab7gcaYcnAO0G1V1S5zrZq0OomPtG9+JrTQ/6mTinFQVc6soV+Yj1e
         08LjbTqSlGw4DKQ3601XfC3KIw5PhF53HtfFg6YX2LhWTT1t+oUv8FOyRPhe8IYS0Cwj
         h2UZdiQTzIWjbR8RuhRHAlkOwGqyROUWTN/ZNb1S8UTplkBxX2RBqemn5X7ymVcnRkhX
         0jTUgdungncKCR/h9+0dDdAaybh7SfVRGMlXSPY29VHOP1zQ01SboF8ix+HmcrOCKA6I
         t5+ioTNjME97jrXtV6HxGoveVcsL1vPktbV9y94IX4WdFT8VBtPl8IkdMLLbvEgh5pHY
         A5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dt3pR+EuZpEYioOZuqVOF4YuDMykJMYYhRifRhjvIjY=;
        b=Oj9blTvRBOQyQad8A9FS2283kocuEkqLZABkBq4m09DJFCkX9DmgFwOf7sKEqLvl+i
         oAep88rgNKIcOWH+ImEv+MMS0Wo2vJN1j+iwqtNN2SdVn2tMv9DOuSS20z/wDU5NXWBe
         bsQHbyvPi251RlMylOdt5n/aVQCrShLgauPbGYXd0TtNDnL6taiBFXY+4UwsPQ91X5sR
         TqSfd/3+U/z88hzb/63TR9bG0d3WWoFwopql6sVEUyAYi2C64KzyLqgS/lDpHJuaNrv4
         Izf1bDnlekdWQW5LzJuRgxAuZwRoqvte2YrSpEUVddQT2U2oo0cAgMZV8jBvecMA0VZW
         0Asw==
X-Gm-Message-State: AOAM533YjID/xo7hTRAVukqt4KuMrqSCaKtjDIiAtu0GWeBDnyjCJOhA
        SBwTWfTwz/JsvENI3SD4HyaxRpqflrF2lGnmpQtfkA==
X-Google-Smtp-Source: ABdhPJwWID4gw3LiSMK7IbU++l/6doq6lZF+9ZfhbHlGNFmjxMEcwDnhR/Hgu0Zbry9/34wZlP+UppzC1nTuZHVIEjk=
X-Received: by 2002:a05:6512:70b:b0:477:a832:7d07 with SMTP id
 b11-20020a056512070b00b00477a8327d07mr46909371lfs.71.1654087604181; Wed, 01
 Jun 2022 05:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220520183108.47358-1-kdasu.kdev@gmail.com>
In-Reply-To: <20220520183108.47358-1-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:07 +0200
Message-ID: <CAPDyKFqzEbijYDGd7vWrWu66m2L-yVnqsDRny7N0c=49R44mLg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-brcmstb: Add support for optional
 sdio_freq clock
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 20 May 2022 at 20:31, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> v3 changes:
> - PATCH 1/2 v3
>  - Based on review comments reverted to using the 'clock-frequency' field
>    in sdhci-brcmstb controller node for the sdio_freq clock
> - PATCH 2/2 v3
>   - use devm_clk_get_optional() to get sdio_freq clock
>   - look for clock-frequency value if set in the sdhci-brcmstb dt node
>   - Added pmops to unprepare, prepare sdio_freq clock on suspend/resume
>     in addition to the sdhci_pltfm_suspend/resume()
>
> v2 changes :
> - Added Reviewed-by tag to PATCH v2 1/2
> - In PATCH v2 2/2 Used host->mmc->f_max instead of parsing the device
>   tree again, /s/clock-frequency/max-frequency in commit message
>
> v1 Changes :
> Sending the remaining 2 patches separately after implementing review comments
> for the patches 3/4 and 4/4 as part of the following:
> "mmc: sdhci-brcmstb: host controller clock enhancements"
> https://lore.kernel.org/linux-arm-kernel/96fd3054-17b1-db42-9a44-a60485243807@linaro.org/t/
> changes are rebased over
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git refs/heads/next
>
> tested brcm,sdhci-brcmstb.yaml and driver with and without sdio_freq clock.
>
>
> Kamal Dasu (2):
>   dt-bindings: mmc: Add Broadcom optional sdio_freq clock
>   mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 32 +++++++--
>  drivers/mmc/host/sdhci-brcmstb.c              | 69 ++++++++++++++++++-
>  2 files changed, 94 insertions(+), 7 deletions(-)
>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe
