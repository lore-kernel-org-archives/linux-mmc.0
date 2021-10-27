Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B04C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7CF60F6F
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhJ0NgV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJ0NgU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2021 09:36:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A80C061570
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2021 06:33:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 188so4758152ljj.4
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2021 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SF3TuLDwjCSTuZKZbIAlHelYHC/Il4xa/tsPH6DiGEk=;
        b=StFhjxBA3IYeh9xk7RxqepC2BTyp6miu58c8IkRnymFpoS65OAATRBs7/kyVTuxoGw
         gu/PqDKU65tuETTCV7BjhfDevG+pkJFpVNaRwfjzs3g1oQR3HXznUf7LGudjcpuOjea1
         p4cSk9qhmET+0GBnNbq2t0+UR83tD//Q8k5H5MppGhwBLdLyMNYxz2J8v0pye1w6UBXf
         uNLYDPTBI6AtB92nh+JyboY5Bd4wjk0OCPWJr5vsktR5/ugKhipEXjTdyO6nPO29IET/
         0UFJ4Gsj/mrHYibEAq580ICfQxLt1PwnbkxeVasgzNRRvxcdLnweWv8kODSF7FTvGMAs
         jQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SF3TuLDwjCSTuZKZbIAlHelYHC/Il4xa/tsPH6DiGEk=;
        b=gZdsymPaV+Vaqz4ZiDmR2umI7tb0lW93e7U8AxTN8PcoLJAj2smrMZWyOJS6CIC40R
         ETHIpmccejCcJTFPZpNhACMm4DkOBcyEo8mtZTeIbagMyyJhSQj/JC0CUJ+Szqnwytp0
         PH24RsMEiTF5aMeuu0+Wewvu+iyG4PzRAU8TZa8b4eUTi1xIO3IF/QGbtRFdNfYN1BRC
         uRH5BeKOL6s/CHNHNOdBU9NBl4aXq4Lkh6zcrdl3cID2jt7TkSwNeSt25TuaJblfCOb1
         f8BdQDL6oZjhl/puHaguPzI0UQz3ol7FdUQsXI+66AEPinT2/8vIQqX1BkAQw+9v/UQN
         nBHA==
X-Gm-Message-State: AOAM532gS0AYFdl+qjwiC4lDlCOzDV/WWPbUJGDE9vuGRsizCiRc+BDw
        Dz4H4gJwvBczpAgf9M316vo10aT7E/G4J+o3sLJwTQ==
X-Google-Smtp-Source: ABdhPJw4Hz0qU7pk4QAD1ecXWuVM1EJf2LFlyX+ruH5szvN19acgbbYV2uu01lA95rFJu0mT5Vax7MFwL0q2NXqqy2Q=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr33373312ljj.4.1635341633803;
 Wed, 27 Oct 2021 06:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211027115516.4475-1-rashmi.a@intel.com>
In-Reply-To: <20211027115516.4475-1-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Oct 2021 15:33:17 +0200
Message-ID: <CAPDyKFq=_Me6CwrsM+ESP+mw0Yb-anmKzqOX+Y8R0_n5U8OtuQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder
To:     rashmi.a@intel.com
Cc:     michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com,
        kris.pan@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Oct 2021 at 13:55, <rashmi.a@intel.com> wrote:
>
> From: Rashmi A <rashmi.a@intel.com>
>
> This patch set enables the support for eMMC PHY on the Intel Thunder
> Bay SoC. eMMC PHY is based on arasan phy.
>
> Patch 1 Adds arasan sdhci support for eMMC in Intel Thunder Bay.
> Patch 2 Adds arasan sdhci dt bindings.
> Patch 3 Holds the device tree binding documentation for eMMC PHY
>         and listings of new files in MAINTAINERS file.
> Patch 4 Holds the eMMC PHY driver.
>
> Reseding V2 patchset to get the dt-binding patches reviewed.

I have already queued patch1 and patch2, so there is no need to resend
them anymore.

Kind regards
Uffe

>
> Changes from v1:
> Add arasan sdhci dt bindings
>
> Rashmi A (4):
>   mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan
>     eMMC driver
>   dt-bindings: mmc: Add bindings for Intel Thunder Bay SoC
>   dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
>   phy: intel: Add Thunder Bay eMMC PHY support
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |  25 +
>  .../phy/intel,phy-thunderbay-emmc.yaml        |  46 ++
>  MAINTAINERS                                   |   7 +
>  drivers/mmc/host/sdhci-of-arasan.c            |  29 +-
>  drivers/phy/intel/Kconfig                     |  10 +
>  drivers/phy/intel/Makefile                    |   1 +
>  drivers/phy/intel/phy-intel-thunderbay-emmc.c | 511 ++++++++++++++++++
>  7 files changed, 628 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
>  create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c
>
> --
> 2.17.1
>
