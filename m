Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D19C2D0A8
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A261206F4
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 10:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yk69XaUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1Ke3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Ke3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 06:34:29 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2EC061755
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:29 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id f15so2000800uaq.9
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sQW1HUOunmbKPB18wQEeOgvroegKy9HPkbYg+JXmnw=;
        b=Yk69XaUhn97ETU43S5BSUq3Cke/3pXyBufwltBiK0o8Ar5zK8tEaDI6EM3NFqEDa35
         lq/TBv5V6s2Hpxm6zB6a0zEiLsTSCyVO4XngoYqlr83f6YNAJciqcRkh3G6SpRRz4thg
         /IEFzGTy9ZgOhJXfYmwqRNDpJa+D7BGnHkaf3HGDQDf9i8RaG3Uq6yPL8zt1OGwuZ8T2
         JoKh6j2OLvBYLUiPXqXffsxrG8Ew3lQqL1grdVcY30gd35sJt/Zu0A5WErpzzKqz0awo
         sh3LbqtXqPnvQs10E+J6A6CRIomG8zgdFurusyIH2994yQK7mYUkcQjiESPrXvpN0/hX
         YfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sQW1HUOunmbKPB18wQEeOgvroegKy9HPkbYg+JXmnw=;
        b=FNw+8zOcYdx1t+dtn+GM3fkp6LLfhyNERhkyZYS11htN4lmhdr0fYfyLzc0xLixpjf
         /AsMhd+ClM5gfkORZp1ot4Bydkj51H6oufXm6xjgclhwLdOMfKIT5jnHf59gzkTabDpn
         zF0MGDoEkbKgZOQYhPE6Z+qJOTCmrHlDZ0Mz6eY/5FsshTGT4ybCTOF6eJ1uPFE68Lpy
         BADEZya7MnSAA85FvewCtX6hXAfpYrhLJGwYCO7uMUj615lyvgiBhC8NLIwYF+5PGfZQ
         hwkyYpG9WU75URkrUsShUrU60GmWyDuvByAkZNXFQBGx++2Bh0Ow+31AEOYq7msbrRPa
         CPdA==
X-Gm-Message-State: AOAM533wpHuJrIuWc0Tu8LGa/gQzuhHPpdswURnvJlSMWKtCQDsZtWpX
        NFPMf8MbNorhurFRjAB+e6Zwilc/BLGCW7w59OsTSCWAP20mZw==
X-Google-Smtp-Source: ABdhPJzCzJoMIXrevdJ3Il/z22DKFLjZ7LEY5ae0LawwEeOjiTNjdIahlC/UDTD2eJq0VMZAE0fA0dAdBjRQ6ST+zeE=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr236564uae.100.1601289267589;
 Mon, 28 Sep 2020 03:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200927104821.5676-1-hdegoede@redhat.com>
In-Reply-To: <20200927104821.5676-1-hdegoede@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 12:33:51 +0200
Message-ID: <CAPDyKFo8309qtoE7xqTWvRczNRim9WW0wcU3D7wSajCpuU=MMg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Workaround broken command queuing on Intel
 GLK based IRBIS models
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        RussianNeuroMancer <russianneuromancer@ya.ru>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 27 Sep 2020 at 12:48, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on
> Intel GLK"), disabled command-queuing on Intel GLK based LENOVO models
> because of it being broken due to what is believed to be a bug in
> the BIOS.
>
> It seems that the BIOS of some IRBIS models, including the IRBIS NB111
> model has the same issue, so disable command queuing there too.
>
> Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on Intel GLK")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209397
> Reported-and-tested-by: RussianNeuroMancer <russianneuromancer@ya.ru>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index af413805bbf1..914f5184295f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -794,7 +794,8 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
>  {
>         return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
> -              dmi_match(DMI_BIOS_VENDOR, "LENOVO");
> +              (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> +               dmi_match(DMI_SYS_VENDOR, "IRBIS"));
>  }
>
>  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> --
> 2.28.0
>
