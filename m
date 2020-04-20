Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2614C3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 19:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25E721744
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkUCF9b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgDTTPX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728103AbgDTTPX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 15:15:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713FC061A0F
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 12:15:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o15so4985136pgi.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4hrruIEfeHbnCer3L7xymo3BPcqZk1wOgCil6L4gXc=;
        b=jkUCF9b3xkKwajGHRP14VA5YPuTR0uv9ThYOOWUiuSrrcX8fguG/qXV/ZrUEnsXGQ0
         ve3D9RcEwHxcP8Rds85FUEIPAZPk/ZJ4MA3JL1eWCckkp9eUNXyoHxJAzOCLC0l7hJU4
         tjDvPbpkU78tKvlJsgegIpmgqf0kxXn83VDBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4hrruIEfeHbnCer3L7xymo3BPcqZk1wOgCil6L4gXc=;
        b=jBIndYffvoKr1TaTbZY/5ULic8cxgIUEbpS527uyg1/Zvk4mYrP4ST/vqasS+C3Y2M
         LCRfvLYCfA3ybhRb5qa6IG8HI6H6UpSQLH0fXOhkvnXJJYOnmaI6K5w5tyqooMW0DfuD
         KVZ5heIBOdSfH76v1yuK+sU5W96YfYbzrxM/jL27ICeufsUmOTVwdJqNxf/GcG5ZBG8g
         2DtvuK+24kbGPEpdFWY4d8bh4MM6DlMKfdH5fAWKBF8HIvsMtiz8Wvn9g0DMGTV5sSOx
         37WCr0s00tUM2vmS479XudxVJ1WX+q6ytenRX8DwPdpnRV0FuiwxTNZeq6vGhK2mfurd
         A/7Q==
X-Gm-Message-State: AGi0PubS95+Bde0oTdN6AmPXZ+pCqN6Yq9IrjXMPbbeuKdDqessZDGB4
        qS9/7zcMXWZMXsi/tGoJ+Inr4g==
X-Google-Smtp-Source: APiQypJCgAQPRawkGIDVIK1DeGjLm/plSOv3ZpQojggeG3wLIJkbLMEB6AvcO7FMJg7kHrvwF6uHlg==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr17745526pgg.158.1587410121447;
        Mon, 20 Apr 2020 12:15:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id l15sm96958pgk.59.2020.04.20.12.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:15:20 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:15:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 1/3] mmc: core: need do mmc_power_cycle in
 mmc_sdio_resend_if_cond
Message-ID: <20200420191518.GG199755@google.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
 <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 14, 2020 at 11:40:09AM +0800, Yong Mao wrote:
> From: yong mao <yong.mao@mediatek.com>
> 
> When mmc_sdio_resned_if_cond is invoked, it indicates the SDIO
> device is not in the right state. In this condition, the previous
> implementation of mmc_sdio_resend_if_cond can't make sure SDIO
> device be back to idle state. mmc_power_cycle can reset the SDIO
> device by HW and also make sure SDIO device enter to idle state
> correctly.
> 
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  drivers/mmc/core/sdio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ebb387a..ada0a80 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -546,6 +546,7 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>  static void mmc_sdio_resend_if_cond(struct mmc_host *host,
>  				    struct mmc_card *card)
>  {
> +	mmc_power_cycle(host, host->card->ocr);

My MMC/SDIO background is limited, but it seems this isn't needed for the
vast majority of SDIO devices, otherwise it probably would have been added
earlier. I wonder if it would make sense to make the power cycle
conditional through a quirk, to limit it to the devices that need it.

>  	sdio_reset(host);
>  	mmc_go_idle(host);
>  	mmc_send_if_cond(host, host->ocr_avail);
> -- 
> 1.9.1
