Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC28AC433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946E920709
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1kMa/o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgIBJEd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIBJDn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 05:03:43 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10141C061245
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 02:03:43 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id e5so1051187vkm.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9P3wsxqoze0W6a0mrHELuT43xJEcIHDEYNF+C7OQKQI=;
        b=z1kMa/o0lJ6db7VFFIgX3zwfAI3PmRBK61copltiv3/W6UyGC0jBl0o+igdv9c8GkH
         UYk+TgkbK+5vVE8zuHUoCye4snKHrvvPIjR58Ic/SbcepnSePDacs1cnh8rcWwXCq+Nz
         XEfXUiZGZujy7lMtuoZ5GTuTH61E1HGGzcBO4AQ7Ff2nc7HKbIiVB4pD744A3stRBPEi
         UcDCz0ghGSxSSOkK2GsP8dK6M6dQ9rvqO7I354sQXM3JuuJ+Q/BKF0B+gC+dd93rU/ef
         3OKlMbQuxQlvb7lLssullWsaVdxEnqynj76LNwQ1IGdl9i03TMatIb/iy16J61LvlmaX
         2qAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9P3wsxqoze0W6a0mrHELuT43xJEcIHDEYNF+C7OQKQI=;
        b=R6HP8oKMW1L7oitcXHVTnBnhT00/jDD8ZNCgaX1Ggr2UfNIC7VVFC5B51BmYWh4qYQ
         HvKidJ1WFKFLE/Gd+rUKqsTgCbOhzpGAXq9laxcFVNfAV4KeHBwyE4i/88tRY7TtbdYo
         3unOAl7czuCg1tsnOz4Aj2ZQ8Ixjzdpjm0OmkuDj6Gwh9iiCqno/Y5iuDPHLmtrW33vW
         U0dXSBkgFZtIsBMloz3M84JZyAP+rbpfXIoa1e4NlmHFnNThG0rjf8HJYc1huk2apL/4
         01HomCQtYRCH/KrW+e84l/LWMQ3nKG8g07+iMyO0zAlfTtNq611uzv1sMkdaves0PGeB
         VV2Q==
X-Gm-Message-State: AOAM533uMRJDFsDy+FQa289lfOkX3Jt+xC+PPrQlnIWJhsMBzlthYlWm
        hQkF4h1RT+lh1OfQzORlagi1ev6lMlYyeyfEPD1bMQ==
X-Google-Smtp-Source: ABdhPJxhX7kHXjegHwdXoUHpCkNbNv05kzwJYOYliiMwlfVGeUdqGLLERRCiX7ZP53djUoDsW4aIcGPFyOzxlmc6Gj4=
X-Received: by 2002:a1f:16d1:: with SMTP id 200mr4453490vkw.31.1599037422215;
 Wed, 02 Sep 2020 02:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <1598651234-29826-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1598651234-29826-1-git-send-email-stefan.wahren@i2se.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:06 +0200
Message-ID: <CAPDyKFq35cgC5Cp3=kFnBaghz9r6Sjkzb8CDaCB8395avMnYKw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-iproc: Enable eMMC DDR 3.3V support for bcm2711
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Aug 2020 at 23:48, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> The emmc2 interface on the bcm2711 supports DDR modes for eMMC devices
> running at 3.3V. This allows to run eMMC module with 3.3V signaling voltage
> at DDR52 mode on the Raspberry Pi 4 using a SD adapter:
>
>   clock: 52000000 Hz
>   actual clock: 50000000 Hz
>   vdd: 21 (3.3 ~ 3.4 V)
>   bus mode: 2 (push-pull)
>   chip select: 0 (don't care)
>   power mode: 2 (on)
>   bus width: 2 (4 bits)
>   timing spec: 8 (mmc DDR52)
>   signal voltage: 0 (3.30 V)
>   driver type: 0 (driver type B)
>
> Link: https://github.com/raspberrypi/linux/issues/3802
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index e2d8dfe..b540aa6 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -283,6 +283,7 @@ static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
>
>  static const struct sdhci_iproc_data bcm2711_data = {
>         .pdata = &sdhci_bcm2711_pltfm_data,
> +       .mmc_caps = MMC_CAP_3_3V_DDR,
>  };
>
>  static const struct of_device_id sdhci_iproc_of_match[] = {
> --
> 2.7.4
>
