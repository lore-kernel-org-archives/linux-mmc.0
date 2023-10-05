Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6060E92703
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Oct 2023 14:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjJEOWe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjJEOUc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Oct 2023 10:20:32 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38424EAF
        for <linux-mmc@vger.kernel.org>; Thu,  5 Oct 2023 04:39:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81b42a3108so973868276.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Oct 2023 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696505945; x=1697110745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naZTOLgodXSRWT4LwUJ1kL94FBBp5L5BUMYnXCMGCqU=;
        b=x7U/RhmkBZjrf1zvnD1trRt2eOLLMC18PzHYFzNSviiAgvLXEQGmPP1qD+C2ykUgJH
         np6dOOLQwC1QkdksHQC2+jkK4ISG80C2XBmLDrIeQn4LUb+NtNxbwyWqpLcUWCSYtukj
         S84slw9NdCr4beYAmZTANWYrLqWP5rC6FAGVxhdCtFUK//jTUEv6FZpjvzJZQwlIV2S+
         1IMUcrItX1gnh8vue22FvlzzXY2fkF5nTCHTXgXGOZyVmYppO5yN8whUOVrUNWnSe0wO
         CT4jBBYzjxwVcRxN7v9ILGlMSKZBPxzy+wHaKgeXGn926IXZLbUhKAdLcK6uog21dC2W
         9Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696505945; x=1697110745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naZTOLgodXSRWT4LwUJ1kL94FBBp5L5BUMYnXCMGCqU=;
        b=r/zMZo6AePLks2uF8vW59axpngVbHL3h1hBeHhIC6ql4/VGC1doRyg9qFoCSZ3aBxd
         qvMNzwe4Iysr/0GyMl7pbWu8bBxRxLpAooYnKYzFLd1wkAfj+SP8fxi8eVI3WMWqZfgI
         GO3ifAlKEPju4Ku+eZdOzA86W7eu03VgVceI2iws0nNF8EWm/lkN4Ago5P5kPRkolskv
         maULcKIPFqCB5xoGaCLjIqnNEtWSW3v8fCDsMLAPQ4uhmTPzirUOMoHs192OecxxiOuW
         AZeP5l4TWynWSol358pZyz2d4wjWSOe2eO2bIAGJSmfqMCPMPLRK0oJYtInSq6EVaFHk
         9tcg==
X-Gm-Message-State: AOJu0YySU6wnOp7Hj6x1aQ47SiPJ6n3HR5ppn0e70BogMmgrBpZv4u+l
        X+gVVng8M+eOL62ziGeJ9iCyGyyMykLxKbZSfioaTg==
X-Google-Smtp-Source: AGHT+IExB3S3qMjm2rkhevtVVDJ/UHiNEYen1x7GrpFYvWusu8nA3zn+4WyE6zXOAlDMLW0ENeclKXjd/dARivISx7E=
X-Received: by 2002:a25:aac8:0:b0:d85:b07d:e2f8 with SMTP id
 t66-20020a25aac8000000b00d85b07de2f8mr4797738ybi.15.1696505945569; Thu, 05
 Oct 2023 04:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-21-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-21-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Oct 2023 13:38:29 +0200
Message-ID: <CAPDyKFr4C8woRLzzz9FnhDvL0n8RObHNWCTP3WYxvraVYWYWXA@mail.gmail.com>
Subject: Re: [PATCH V12 20/23] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a UHS-II version of sdhci's add_host/remove_host operation.
> Any sdhci drivers which are capable of handling UHS-II cards must
> call those functions instead of the corresponding sdhci's.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

[...]

Just a few nitpicks, see below.

> +static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
> +{
> +       struct mmc_host *mmc;
> +       u32 max_current_caps2;
> +
> +       mmc = host->mmc;
> +
> +       /* Support UHS2 */
> +       if (caps1 & SDHCI_SUPPORT_UHS2)
> +               mmc->caps2 |= MMC_CAP2_SD_UHS2;
> +
> +       max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> +
> +       if ((caps1 & SDHCI_CAN_VDD2_180) &&
> +           !max_current_caps2 &&
> +           !IS_ERR(mmc->supply.vmmc2)) {
> +               /* UHS2 - VDD2 */
> +               int curr = regulator_get_current_limit(mmc->supply.vmmc2);

As I also stated in another reply, please use vqmmc2 instead, which we
added in patch4.

> +
> +               if (curr > 0) {
> +                       /* convert to SDHCI_MAX_CURRENT format */
> +                       curr = curr / 1000;  /* convert to mA */
> +                       curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> +                       curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
> +                       max_current_caps2 = curr;
> +               }
> +       }
> +
> +       if (!(caps1 & SDHCI_CAN_VDD2_180))
> +               mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +}
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);

Please try to re-order the code so this declaration isn't needed.

> +
> +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> +{
> +       if (!sdhci_uhs2_mode(host))
> +               return;
> +
> +       if (!dead)
> +               sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> +}
> +

[...]

Kind regards
Uffe
