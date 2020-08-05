Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14CEC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE9D204EA
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfxnniAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHEGfF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgHEGfE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:35:04 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40BC061756
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:35:04 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id o25so13555313uar.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thLd5vrBCF5P811qdhS5FGqyyjmv+p/jdT9ome4aBi8=;
        b=SfxnniAa129b0crE1YIs3dMuOw1J3LmTLgMWqZEDtKroig4aaXS3lR2zXg8R9aXbOe
         XOHmMzpTAa16Scwu8P+q6ELMY6fbQh7+3XFku/PNMUflM4yonPA8RzIz0zSVDZnO24C+
         nm5eob0piBsXhHqpPAMWHcmLMRPJffWtadAOJ1YoF69GKcdPKlP+75g+ooRSxSmC3YPj
         oFcaV1ij8aaDSl9BdW+cIxtboZRlJem4xhJCWhVRnKz33pEvPx2su7JClAveIbvjWbmm
         /qKUgd0Gc3gG/v10HEZT04AfgPbURs5jdKYlgeG67azWJNtowg1uBztDBzW193xSGjsM
         mUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thLd5vrBCF5P811qdhS5FGqyyjmv+p/jdT9ome4aBi8=;
        b=gN04UYqokB0Mqd4UYdvbdT1taaMahwgup5UdLpndglBzXk0XwRwg043iTF8Qd4/tNd
         HyNmBFMFwqYn4F46kSMfG69+3QzzY06vGCSET0lI6RMjXXXNgKECVNGFBrM1SDBnxQT2
         vsIGlv1NTpjWXZ4Rgf9AsVCoJKr9Qlhh+fQoy2tzDobw2Hu0FpE7liHfxPUAL+oukzwh
         WCsrR7WGBgAPJxjYbiBTHva25HFvYBaRLArQpdGlkwBN44pCzxl2Bb5vgIjd0rD9yMyB
         +YEudAm6G53nLwWCsR2JoIo/Pu/A1AyQ6YgiaTKQKGGDeQ37jjcHXgQcsim9DrP78phT
         a71w==
X-Gm-Message-State: AOAM533hlBefH2j9Kvi59oHq+Yg4iNPtBu+/+kk8pYkuOHagjL3kHbnr
        2vBSSh3RgZe7WnY3WPZKlBiMYG1G0mhXc33eFz+fveBL9RKcgQ==
X-Google-Smtp-Source: ABdhPJy8ojrQUZrccFBTduwq6pfZs56aMVCn+bFtsYmIcwR60XVGesaJV3i//CCOA2ED8/cqabMhiyiaSZz9CeZPcPI=
X-Received: by 2002:ab0:6049:: with SMTP id o9mr993076ual.19.1596609303400;
 Tue, 04 Aug 2020 23:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200721011733.8416-1-shirley.her@bayhubtech.com>
In-Reply-To: <20200721011733.8416-1-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:34:26 +0200
Message-ID: <CAPDyKFq9moAmkz3RuCNgxB-jEW=-SkqWu_TmvinVcDOKVQQuBw@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: Bug fix for O2 host
 controller Seabird1
To:     shirley her <shirley.her@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jul 2020 at 03:18, shirley her <shirley.her@bayhubtech.com> wrote:
>
> Add bug fix for O2 host controller Seabird1
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>

Applied for next (a while ago), thanks!

> ---
> change in V1:
> 1. Add quriks2 and mmc->caps2 for Seabird1
> 2. Add get_cd support for Seabird1

Future wise, I wouldn't mind that you fold some of this information
into the commit message. It's always good to have a good description
of the change.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index e2a846885902..ed3c605fcf0c 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -561,6 +561,12 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>                         slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
>                 }
>
> +               if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD1) {
> +                       slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
> +                       host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +                       host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +               }
> +
>                 host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
>
>                 if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
> --
> 2.25.1
>
