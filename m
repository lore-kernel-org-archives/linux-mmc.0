Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26F4C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhLUNDn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbhLUNDm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A95C061401
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k37so29233339lfv.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0Xg3orseU+YFr+9C6yP7N5i5w90bmFHlz28JSF7k/M=;
        b=dS44wMzmgN92SH1GoeY5sHqQjlqo4Bm5r4ZXHFiW+SAkKnuXd93oMfKxWGG2ehBMNa
         AJKSkU9MPdw7C6astpdL+7BbK5YvRjmsFwtv218435gNiSoPeSu+rmHqu5JN04Oq3qd5
         Cdxk1nxVxsLL7ImtKC3iKBauwPQJ7YY3yf+tS0L/57uiX9uyPrCFFMWWxRE0pKFh5Pg2
         6aNXvTN3KW7mc8MW7jpGUevhsWf0feJ9UpozwkfM0OiE6v/ISzGVYdsYATyacJXXtfLI
         8yFvCezNVmOlZcXLmlDbdcxAhy2KckC5RF5jcCjzEiX6QsiiouZYNDmInjY+lEYQr1qZ
         n93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0Xg3orseU+YFr+9C6yP7N5i5w90bmFHlz28JSF7k/M=;
        b=BUaoHkv4bwfNDz0mU7QSXeJxoQf28HN739lVDH/PNL9muq+gW+53fYU+gMPnj+DkVf
         70b2Qncznq4Kn5innADI38lnsPkZisS4C7cl1rzjPyonOf2oq1RG+hVNaGgxzDCVQS3V
         NUnmOqT3yXhV+5GxGOmUUqbaxcpmucDC1FLrBHG8LtlHpMXxjBKLM1zFT8bh2jGYLiID
         j3OGhwWoYtyMxQMRSBIfeTTzNlQg4P5vvNXvWAD4LOi22T3tzYCPM29w0c24xjjPoCmQ
         xD8Si0WWtrGYZpt84xG8peS8CFMNrjHk7qbx39fZoFHIbpNym69V+mgiNFibiSIjBcs0
         376w==
X-Gm-Message-State: AOAM531MCUA+TF7RRYMvQL7mrCipfCynxsl/K3WIMYwjeSvFEfq/xZwu
        wM1cq1ML+u3k8lFBp1XB0RWHeFCwHlWTXRk62Zw0Vg==
X-Google-Smtp-Source: ABdhPJxG3uHqZH08DUdXd3BNJXX2KbKVBHTRtUnPbDdcp5BZXQjy3wBHGptH5UNs341UHXUYM5ZmO8yNCUzrkWzfPD8=
X-Received: by 2002:ac2:5966:: with SMTP id h6mr2989371lfp.358.1640091820496;
 Tue, 21 Dec 2021 05:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20211215161045.38843-1-marcan@marcan.st>
In-Reply-To: <20211215161045.38843-1-marcan@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:03 +0100
Message-ID: <CAPDyKFoGEqBZ3XbGzc5E4QvWFcQN6nM7Envq5cM7Wmdp+jZSvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM platforms
To:     Hector Martin <marcan@marcan.st>
Cc:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Dec 2021 at 17:16, Hector Martin <marcan@marcan.st> wrote:
>
> Hi folks,
>
> This short series adds a few quirks needed to make the card readers in
> Apple M1 Pro/Max MacBook laptops work properly.
>
> The first patch should be straightforward; it just allows configuring
> the CD/WP polarity based on device tree settings. There is already a
> standard DT binding for this.
>
> The second patch works around an issue with 8/16-bit MMIO reads that
> only affects these platforms, for some reason.
>
> Changes since v2:
>  - Style fixes
>
> Hector Martin (2):
>   mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
>     platforms
>   mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit
>     reads.
>
>  drivers/mmc/host/sdhci-pci-gli.c | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
