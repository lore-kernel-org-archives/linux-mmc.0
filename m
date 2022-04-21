Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2820C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388119AbiDUN6B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388150AbiDUN6A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF532B279
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d6so8824445lfv.9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8/6RZqsX4Y8+GGfu5DCF/d/CPa1fdMxenVOZRfdbms=;
        b=RPzzSjxZ+IEPH+YESnInHMnITKVYgu4Rz1224lkumOcc9SGPCe1fiirPUcvX5OEyFy
         ce+ePo5sdn0zcfd0ezGV7Ij7vk3FjhkTiQHl5zxJ7GEbtx1xUgyTCijOMgFOmR6CvdIB
         ZuKRAwlRvwyhVpCuFbL8URRdvt6lXVGY59rYqF2AlPhTtCaJFZzbOfLrWMUjDPUnFesR
         ZQcl87Puuw9tYPWTuEh6FBUK+RfEsLZRBA6AXdYB3/yH9o7ew8DSpK9cg3KTmbaBLlUa
         6+mURszP5Wm2pxm7r9TX+zNNZC8rWZ7FR6XdpBeFFk0/jwRTwgGLuLP+dy1Vvfw+LrXi
         ec8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8/6RZqsX4Y8+GGfu5DCF/d/CPa1fdMxenVOZRfdbms=;
        b=z3U6ocIbma6Ql3acfS3QWnCzML97p6vA6+7skMDcQe2KsiZ+r1sk3EWWqBY+3uS4k/
         6Zz94giVejoZu4po3TKcVJAG/wmJz2AhtwpLb2F9Eg81uZs8Eldwl6F2xFM1WGH6YWPt
         fqAHMqRZU/b/qLecLQRMmDwAWsW8c2A98MnAV9bBLXJ44cehQMovZCZHqigZaT2DGbBh
         TXfdZb1RebRhhXmX2zz0adqbyuKaHrMq2UKsEauCapV3y82oY2nXdWlZI0a22oj2/RXT
         6lnL5KbzWcXf2osvL9DiMyHsUSmMtWr3SMZBXpJjjq5mUM8nP5LRTCMDC8H+VucjjhY8
         gK/w==
X-Gm-Message-State: AOAM531aDsPfdJleBrkt1tqCTP6MqlZF2U5gJDRusscHoWsA0Na/1smS
        n5LdmRpJlfM0/47Pom6rk9I79d5JX4jIhsqj79qTaQ==
X-Google-Smtp-Source: ABdhPJxaQO00sbSc9Z1q44R2oZf6HOTaPfoLxj1RpODCpWNNiJ5tJPp2kYh7SFP2PIAWNe7MGxvMZdYNlBaAUXea6uM=
X-Received: by 2002:a19:e007:0:b0:44a:a22d:2d49 with SMTP id
 x7-20020a19e007000000b0044aa22d2d49mr18478310lfg.254.1650549308344; Thu, 21
 Apr 2022 06:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220414094945.457500-1-benchuanggli@gmail.com>
In-Reply-To: <20220414094945.457500-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:31 +0200
Message-ID: <CAPDyKFo2YhqgEStGcQb0ZWcuhrUcGeamgHk1Hov6_DzS=TNe3A@mail.gmail.com>
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: A workaround to allow GL9755
 to enter ASPM L1.2
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, SeanHY.Chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Apr 2022 at 11:49, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> When GL9755 enters ASPM L1 sub-states, it will stay at L1.1 and will not
> enter L1.2. The workaround is to toggle PM state to allow GL9755 to enter
> ASPM L1.2.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This didn't apply cleanly, I fixed it up this time. So, applied for
next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..52230857388f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -137,6 +137,9 @@
>  #define PCI_GLI_9755_SerDes  0x70
>  #define PCI_GLI_9755_SCP_DIS   BIT(19)
>
> +#define PCI_GLI_9755_PM_CTRL     0xFC
> +#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -597,6 +600,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>                             GLI_9755_CFG2_L1DLY_VALUE);
>         pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
>
> +       /* toggle PM state to allow GL9755 to enter ASPM L1.2 */
> +       pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
> +       value |= PCI_GLI_9755_PM_STATE;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> +       value &= ~PCI_GLI_9755_PM_STATE;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> --
> 2.35.1
>
