Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A16C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiKHQGB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 11:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQGA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 11:06:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841F1EC7F
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 08:05:59 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 136so9917731pga.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2022 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgFgtVEXYZugupjtjPaP9eurIz/cDLoOuNVxDMcWiv0=;
        b=E1fWE6Bf5dBCIpyvZrg75iireacepizk1DahfWSDKuSCWTAMCRbST8IX7sdvzpWKaR
         tXRAT0Na+CY+hUHayEAI/SuMuAkCo3jnC16tpCcyLUx1RxKF7p7h4xWphbzK8nOGrYS6
         sIcUpTDXbYsQffSTIQZNXY2ShexXfQknAH5/iUiXP2B2IZDGHqjYL3ZC2afRBgkG29of
         YFRfsMMDZqg2lSXipePCS9hFXocjBcvu5HG6EdL2kTzRyopRvWSHVaufnkbUSBR1VjJb
         lvx4/LYJrBxMYgc9LHDMC4R9VuLRL8wAGSDeJwn4UQUPGexUcitH2EtRnPVr1qZvLtUE
         Bo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgFgtVEXYZugupjtjPaP9eurIz/cDLoOuNVxDMcWiv0=;
        b=2NpicZ3970471AhsFcAE/dzR7FE3JHS7UMOl/o3+stECLsNKZzqBjs1AAjMt2hrBGH
         jFLl6iSZamwPtnMFpJSUrpF6w+IO3qay4wcxBtRSbTG0VPlBjDW2juVeNj74Yi2jYvOP
         z9+95QUTPWkFdQ3Qieo/CDKc24mKx8HBT+RkBxNj7hyIPU7YUfCT9xnekI2+sbwRm3N6
         ZS3ttAyZWjYrNNcK5xA2X16fDF+s+NOAV8r12W6Ci5qqDiqUChchYgYwuyPYVqgPVHOD
         KHt2ss6dE2zvOOvSKR2qNaeVSPMsnvNoyp2CYOGEUVYCJM9SnqkSCRoxDadYcpjBLWnV
         rt7g==
X-Gm-Message-State: ACrzQf0CgvesmV26KsuxOf8TmvMpDNwzePUGpHPj0PUdaHEuCn5lvOUv
        sqM6awWl9daqbCwvTJpY8gFMODY0QPkaKhMuNO3OWA==
X-Google-Smtp-Source: AMsMyM7Hgp6qsG8zPr+nKIgt3/61Swq/s7eJAainnp0ICZImRQt0nTveslXWe+UHmlKdrE7ii6N9w7LxbjvIIwgmhyo=
X-Received: by 2002:a05:6a00:1823:b0:56b:f348:998f with SMTP id
 y35-20020a056a00182300b0056bf348998fmr56569202pfa.28.1667923559140; Tue, 08
 Nov 2022 08:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20221101063023.1664968-1-yangyingliang@huawei.com>
In-Reply-To: <20221101063023.1664968-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Nov 2022 17:05:22 +0100
Message-ID: <CAPDyKFpjtz=ge2Rw37G7oO3nwHg_x-OytTszHX4nfZDDeAMrVw@mail.gmail.com>
Subject: Re: [PATCH 0/9] mmc: fix return value check of mmc_add_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Nov 2022 at 07:32, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_add_host() may return error, but it was ignored in some drivers, if we
> ignore it, the memory that allocated in mmc_alloc_host() will be leaked and
> it will lead a kernel crash because of deleting not added device in the remove
> path.
>
> So fix this by checking the return value and calling mmc_free_host() in error
> path.
>
> Yang Yingliang (9):
>   mmc: alcor: fix return value check of mmc_add_host()
>   mmc: moxart: fix return value check of mmc_add_host()
>   mmc: mxcmmc: fix return value check of mmc_add_host()
>   mmc: pxamci: fix return value check of mmc_add_host()
>   mmc: rtsx_pci: fix return value check of mmc_add_host()
>   mmc: rtsx_usb_sdmmc: fix return value check of mmc_add_host()
>   mmc: toshsd: fix return value check of mmc_add_host()
>   mmc: vub300: fix return value check of mmc_add_host()
>   mmc: wmt-sdmmc: fix return value check of mmc_add_host()
>
>  drivers/mmc/host/alcor.c          |  5 ++++-
>  drivers/mmc/host/moxart-mmc.c     |  4 +++-
>  drivers/mmc/host/mxcmmc.c         |  4 +++-
>  drivers/mmc/host/pxamci.c         |  7 ++++++-
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  9 ++++++++-
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 11 ++++++++++-
>  drivers/mmc/host/toshsd.c         |  6 +++++-
>  drivers/mmc/host/vub300.c         | 11 ++++++++---
>  drivers/mmc/host/wmt-sdmmc.c      |  6 +++++-
>  9 files changed, 52 insertions(+), 11 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
