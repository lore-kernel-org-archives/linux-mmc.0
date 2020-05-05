Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF313C47247
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4AA20746
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYK94dyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgEELdg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728733AbgEELdg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 07:33:36 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E1CC061A10
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 04:33:36 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b10so1020442vsh.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZtQfMwsau4hXUgC2ytDzDH5vT1ljtwb6OQQ8vXwGtk=;
        b=UYK94dybxNxOkIGP1e32wETlXo600Rs4e6ZrihQU7OIsONVA8ranRfXqvG3T6/40IF
         7YXVaKvmsKja6JJVIBYp/WY4tRj3Z6cHteftQW64ftDI11AJViWNCqapE3AO51CACD4/
         QgTQQvslirVHF5/ZKtu6oWIbCMfnIhIFlwollGVgtB0yXohA9dgCOGu1dIxxvG5NusqA
         mXJZwrdjJH620B9EBuqXiDHRC9mbmxJeTlxB3FTKbZOtiIFhPXFm071PVYR8ZElYUMLn
         fbXdqgeWzWwZ+qUlyGQ/XJeyig2lXH3Rpx1LGnd8i3opPuogmUfW/0MuT2JS7ljOZCD/
         hijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZtQfMwsau4hXUgC2ytDzDH5vT1ljtwb6OQQ8vXwGtk=;
        b=qGY52wqCqReKp7jwEDVIcjhdMM309adAb/1wvKBXAkFC+nm4Rwlo+fqvoJonY7oPe5
         uKKBXZ0foXImJT+9z74c9umdxuymLJx8+s/aD7pXwdQlRsBypTmPla2OqCLL/fMk8gKC
         4n0thpQ9oFhjYEVhBKuJvyFy9a5YeF/jiRJhwJWFHm7G2Zw45gUMPaMbXLCpLDLdWvI8
         8evbU2NKACtX+08+5G3oYo0Ouhop6u+GfkoNX+aRi0ErEoSwTEGqMbcpwvWVMOc0/0SM
         pBl377n7x90/U5+v6GdOMxOYG78IF1+vlVX6NjGS2EDyvMStlk3k5GMngnt1lpPk8lnj
         sl9w==
X-Gm-Message-State: AGi0PuYDvriU9zJEmzc6bJfP3Giot+CSexay6XQKkh95cnW3+tmNu1/S
        SQQswoF/p6vsepWbbV6SHprmsGhfsyLoHYF4gINV0g==
X-Google-Smtp-Source: APiQypLtmJ2Woq0r8nhb32D0SwRppJLteDyUIcJbgHg+8pXZFuenqhZ1ABOFw3HIaMRHpHlUGPbA9t5jsQVoxy6TJzE=
X-Received: by 2002:a67:8b46:: with SMTP id n67mr2293219vsd.35.1588678414754;
 Tue, 05 May 2020 04:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200504063957.6638-1-benchuanggli@gmail.com>
In-Reply-To: <20200504063957.6638-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 13:32:58 +0200
Message-ID: <CAPDyKFr5XJuYyZq_jLGy2Svjn7E+8r+Pcfa_U7SU6W4GdJ-8ZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix can not access GL9750 after
 reboot from Windows 10
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        renius.chen@genesyslogic.com.tw, custos.mentis@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 May 2020 at 08:41, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Need to clear some bits in a vendor-defined register after reboot from
> Windows 10.
>
> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> Reported-by: Grzegorz Kowal <custos.mentis@gmail.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ce15a05f23d4..8170b659f2af 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -26,6 +26,9 @@
>  #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
>  #define   GLI_9750_DRIVING_1_VALUE    0xFFF
>  #define   GLI_9750_DRIVING_2_VALUE    0x3
> +#define   SDHCI_GLI_9750_SEL_1        BIT(29)
> +#define   SDHCI_GLI_9750_SEL_2        BIT(31)
> +#define   SDHCI_GLI_9750_ALL_RST      (BIT(24)|BIT(25)|BIT(28)|BIT(30))
>
>  #define SDHCI_GLI_9750_PLL           0x864
>  #define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
> @@ -122,6 +125,8 @@ static void gli_set_9750(struct sdhci_host *host)
>                                     GLI_9750_DRIVING_1_VALUE);
>         driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
>                                     GLI_9750_DRIVING_2_VALUE);
> +       driving_value &= ~(SDHCI_GLI_9750_SEL_1|SDHCI_GLI_9750_SEL_2|SDHCI_GLI_9750_ALL_RST);
> +       driving_value |= SDHCI_GLI_9750_SEL_2;
>         sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
>
>         sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
> --
> 2.26.2
>
