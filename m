Return-Path: <SRS0=1u/W=32=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A931C352A2
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A4F218AC
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1hIVtb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgBFRfD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:35:03 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44179 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFRfC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2020 12:35:02 -0500
Received: by mail-vk1-f193.google.com with SMTP id y184so1832228vkc.11
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2020 09:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD8/qkuwt6LetOV2+TvRx1GvlGnrWoVaVJ700TQjzcc=;
        b=h1hIVtb+dkWZUdmP5MsV8jMAf70S6skb34ohOf69BoclXPHSrw3ebHN2ulJyDKiVbj
         kSo0lxu/HxdnHtBwL/2ZznDpawz/i6Dh6hB52kR3e2eqz6yERxcyFsCBtk1vkjx+FrkZ
         vsTpz7STKW7Tlx5nHiJu3A+HS0bZjqg6fqVUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD8/qkuwt6LetOV2+TvRx1GvlGnrWoVaVJ700TQjzcc=;
        b=B88hTwfFat6IWtmNkIZWH1DloqmlG8YiMhyITSInTxZH8PdvLIaAIxmWb3vXbZKVpm
         /c9dEVsgdKsMx5o8eKS2ZbCHuSrpzALiazkHnGZJCM+5ZxriJlQ3WeAUy/roxBjCUFqv
         LKjmSKirWh5wArHcHpVT/oM8rksFePrat5i27SgCXkGaGgRhDTtXebbaKJfvVHN8yD+c
         oHUtNo5F3ICuhu2qHFbzDZHApHq56ufsJAYByCKTPwySMgH6GiS5WO8pXFcKHbHi3cpG
         z4K54/JWd2vObkL9U7MfjFkYi0no4r07ex2AaT7rDG2Rt86ClJqhEC4VLWE9pg7++jhl
         JbpQ==
X-Gm-Message-State: APjAAAXB1mSv5eIJvZ94uT4BVrDAZ5CbEJSFfQHdKnHyEQNrp9HHN4I0
        wXBg4KcDF/gitVoQ/+jJnmiLVImTwyU=
X-Google-Smtp-Source: APXvYqz+Qph5KUEsEu9jOC3eNqigQ9gRNuwUTFiZMeR35AcIHlSVSOwSowcpmpZb4qz7GIc8qhMiaA==
X-Received: by 2002:a1f:72c3:: with SMTP id n186mr2387287vkc.12.1581010500653;
        Thu, 06 Feb 2020 09:35:00 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id b20sm8250vsq.20.2020.02.06.09.34.59
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 09:34:59 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id n27so4333507vsa.0
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2020 09:34:59 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr2552856vsd.106.1581010499276;
 Thu, 06 Feb 2020 09:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20200206162124.201195-1-swboyd@chromium.org>
In-Reply-To: <20200206162124.201195-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Feb 2020 09:34:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrT1aSqqjm7Lm55+Hr5FQMVz0iFpbDDpnk95A1iBZeSg@mail.gmail.com>
Message-ID: <CAD=FV=WrT1aSqqjm7Lm55+Hr5FQMVz0iFpbDDpnk95A1iBZeSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Feb 6, 2020 at 8:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This function is not exported and only used in this file. Mark it
> static.
>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 87a8df0dce6a ("mmc: sdhci-msm: Add CQHCI support for sdhci-msm")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
