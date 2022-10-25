Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B51C38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiJYVpT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiJYVpR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 17:45:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C497365025
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 14:45:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so354857pjk.2
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kK+NVAKYFB6C/U0fnuGpM8AspYJ6lf21/N2Izhrn1vU=;
        b=i7hk6RlLYFhoNdnfaeM3c+PUUfWus8pPN2A+1zjhOq4kL2aJqpLInYimMayujafigH
         duFb79niGCvM1qlTPhk65GW/bCUT2Y7/vEMIu0CFbR5IjBMX9+8GGZtlZMrJ9h2NJTDx
         UjlBbu9Qksxx8OSaYnNQL0hXiQhZ0DkXC5RWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK+NVAKYFB6C/U0fnuGpM8AspYJ6lf21/N2Izhrn1vU=;
        b=6GywYBL1z61jlxJFAUynNjSDksb5Ad9y14D2cBEg+d8EsREN7py6ZJRM8SZ0KADCD3
         cYuvka6bdPfanHRa0c50iFWp1F1E0+SVhvAqZn3iwetTmWqu17gteQNLqsNqt0dDc4bM
         KR7S9Q3WZS9OYo4d0Ie+CC5U0ooaXB43mS/vNUkPPxl4QbEx4IDp7I8rDYI6pVGzjc2V
         FliElNTHKquLXeJ7QZaaeVPzQqQsRqlsIr5ggxTmAc630jjZBePKAwKfrKxnrH4eMyfh
         j5DEUu/fzacvQDzBcYj6cp3n5q/jkEsU+yzZM0GQiKxQKrJCXw8moNIjXvyZ2OwX0nvN
         jsKA==
X-Gm-Message-State: ACrzQf094iUiIBJyZaNjB8tmUy4b42SXhL/HokbS78z9z48N2PVjRV21
        CP/0v18/9fZdB3t+0lWngiNhuQ==
X-Google-Smtp-Source: AMsMyM4QXUCeTzwk/K1scOMPNYxWriXPyjOuHRCp6R/Q8za6/v8YsQcna09gxCbRuqidYLxGoQ6hyg==
X-Received: by 2002:a17:902:cf12:b0:179:fafd:8a1c with SMTP id i18-20020a170902cf1200b00179fafd8a1cmr41527794plg.102.1666734315312;
        Tue, 25 Oct 2022 14:45:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:efef:6660:5e20:5f6b])
        by smtp.gmail.com with ESMTPSA id h29-20020a63531d000000b0046eb1d42a7fsm1686197pgb.55.2022.10.25.14.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 14:45:14 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:45:11 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Message-ID: <Y1hY57vkkOhybwE1@google.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
> On 24/10/22 20:55, Brian Norris wrote:
> > diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> > index 8f1023480e12..6a282c7a221e 100644
> > --- a/drivers/mmc/host/sdhci_am654.c
> > +++ b/drivers/mmc/host/sdhci_am654.c

> > @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> >  
> > -	sdhci_reset(host, mask);
> > +	sdhci_and_cqhci_reset(host, mask);
> >  
> >  	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
> >  		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> 
> What about sdhci_reset in sdhci_am654_ops ?

Oops, I think you caught a big fallacy in some of my patches: I assumed
there was a single reset() implementation in a given driver (an unwise
assumption, I realize). I see at least sdhci-brcmstb.c also has several
variant ops that call sdhci_reset(), and I should probably convert them
too.

I'll take another pass through the series for v4, fixing this and the
other smaller cosmetic issues. I may retain some Acks, depending on
whether I think the changes are substantial.

Thanks,
Brian
