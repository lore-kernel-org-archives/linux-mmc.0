Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BE3C3F2CD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9AB24671
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRNx0e+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgCDPe6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:34:58 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36301 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCDPe6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:34:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id n6so1413596vsc.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGyEJuI0kAg2tW9pvbpX/sZCZp/ZoM/v+2tyXfY92H0=;
        b=QRNx0e+96HXnLEsiEzLvRaxIhEp8noyfUSKTqykgBn4K80pcOPttmsH1jwCIujaUDY
         a/51nZiu/41ENr9DIlhcbzxHxtD9as5ilUaUl47nhn/4Nt9JuZUfZ8aQwuZLek8ugSa6
         +7Fz2L6YYgOqLI9IiRijovjoVgJkyIc/FHHHl+p/v8jjFTSdq3fO7rmsc1hseLYYiO62
         b117TL6aTtnXoxhBk5c6ZprMPRyBuD85M45tLny7zNshwWAXokRAeMsLCoi8Tyg5A45g
         eedaNpwMqRxoYgw7gqyss9Lo76pKi7tlDbFl/GYFaEiBKE83NiULD8PalVTKbZTEiyXR
         Q/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGyEJuI0kAg2tW9pvbpX/sZCZp/ZoM/v+2tyXfY92H0=;
        b=Bdv/f+1AeVZmh2EAj8Guxv2wcURbQhtJLeo9O3+izoyUCp1F/Ukbjjq7IDIT+BGEGP
         caNpR+7QcgpAZoQWAl4/4/K3XBcMzrwvhKx6pmS84oji0kAlQsmzXlH6c887mYSkPXz4
         L7aaXnOT2cT1V+74IJgdgcKL/V+kQnuDW0lHpXfQIHUc9svKjKIrnTdnWEuM6H9qqWwS
         m0q4gm+OQgWDeFiiwqOWLoRTlUmjCaPzU2UexUVztMEmMqTdEmygOMr3wkFNulKtVzKI
         n/ftuEWpTwwyhY82kPP19dvP2US/FKNY3DsCPPKb/KJp6NmTYtUdLLNnJLhUBHgi6VAT
         PPOg==
X-Gm-Message-State: ANhLgQ0Qu7nc4e9CcxXvAsz/GLs0Nr3L5lp7i1Tp+wb7EmdraQ0eLiQ7
        Ss3/oYSGGvhPAK3ZlgjHkKiKWzwkdx5mL0FLsFTlEA==
X-Google-Smtp-Source: ADFU+vtgD8Ah3ULIa6lk8zSoXhcy9aZEC76YLCTNtCNToOoQ/rRhMcBdkTgh2e5jFW/WRn0jRrZOc/Q7JXL1YcouSwk=
X-Received: by 2002:a67:7fd0:: with SMTP id a199mr2128947vsd.200.1583336097623;
 Wed, 04 Mar 2020 07:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20200219092900.9151-1-benchuanggli@gmail.com>
In-Reply-To: <20200219092900.9151-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:21 +0100
Message-ID: <CAPDyKFp1GZDPVLX7i7M7RWaeSYMR07Gaa6r-_sNL6PgxZu-k6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Feb 2020 at 10:29, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Enable MSI interrupt for GL9750/GL9755. Some platforms
> do not support PCI INTx and devices can not work without
> interrupt. Like messages below:
>
> [    4.487132] sdhci-pci 0000:01:00.0: SDHCI controller found [17a0:9755] (rev 0)
> [    4.487198] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.PBR2._PRT.APS2], AE_NOT_FOUND (20190816/psargs-330)
> [    4.487397] ACPI Error: Aborting method \_SB.PCI0.PBR2._PRT due to previous error (AE_NOT_FOUND) (20190816/psparse-529)
> [    4.487707] pcieport 0000:00:01.3: can't derive routing for PCI INT A
> [    4.487709] sdhci-pci 0000:01:00.0: PCI INT A: no GSI
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 5eea8d70a85d..ce15a05f23d4 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -262,10 +262,26 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
>         return 0;
>  }
>
> +static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
> +{
> +       int ret;
> +
> +       ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
> +                                   PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +       if (ret < 0) {
> +               pr_warn("%s: enable PCI MSI failed, error=%d\n",
> +                      mmc_hostname(slot->host->mmc), ret);
> +               return;
> +       }
> +
> +       slot->host->irq = pci_irq_vector(slot->chip->pdev, 0);
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
>
> +       gli_pcie_enable_msi(slot);
>         slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>         sdhci_enable_v4_mode(host);
>
> @@ -276,6 +292,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
>
> +       gli_pcie_enable_msi(slot);
>         slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>         sdhci_enable_v4_mode(host);
>
> --
> 2.25.0
>
