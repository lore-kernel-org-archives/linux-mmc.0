Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3DC64E69
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2251222E8
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PACBM1QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKQLuo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKQLun (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:43 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84638C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:43 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id p12so6409806uam.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfroypJl3R2fpj2b0G0IswtRCrcTtn8/jYlHEIZineU=;
        b=PACBM1QVGZiTknW8K3MEjs8d472QS3m8E5G0tfEoqeHb3aLhZx2NzqRaXdesTDoEsx
         DXw/jwQ0Zfh0RoBYxYwacuJBjZ9BI5IxWunJKtKRSyBmnMjGIGzd3R2z70t7AtIFWGON
         L9QJQoHDfuSI4Rytn8I2+S4RjRN0Ax0UMhwg+taqE6iUR7mnw8PPPMNAwfsRQ3ETU0EO
         3L5IbB2N8W8m5mCruw6isDxj3Gq8WMcwrogRXJCS6T28SDGI9RZ9q/9UxRlZGA1gsMKW
         lMqwyLJRzsqXBakB3tFUDlj+I+jvmXBoLNdeFE4cNE0vINzclW6+3IVbP1QYHEp1OHFQ
         DBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfroypJl3R2fpj2b0G0IswtRCrcTtn8/jYlHEIZineU=;
        b=C4L2lL3I1tTKNWR3QZm9JTk0EJ+FqorlDIgX7JtPVWMHzpQWofkIRY7yQI3DxPeobB
         SCu16Yv/OGVKu/DEz00Q22XkgjbyEIbvCJLioT4Skg9rQTo64ih79cbG9L+MyLnRbARu
         LPcHKa5bT7MKo5VVKLVsm4XssRGmNDb3XnE1oRacm+pBJrJrvLMuChDihbeLAb8v3Whx
         hTvReUiIoZfT/57y3mWsIiBo681HjzmncbU9il9MJB6gJ7VjenkUG1O7xQSKy1Fc3gct
         c5rvOREQnfPmhZtq8TfU5562ZrdOr4WSPIIfwR1nzd17iOjbCAt207alwxKuwOj7906G
         ljyw==
X-Gm-Message-State: AOAM5316o1PyAwoePs/3PO4i71au0fpP9bMAEfYPaKiCkx84Os7hNyqZ
        YtI5oU04RaA/K0PHwUpyiflk01iNH85EnsH33Ac28A==
X-Google-Smtp-Source: ABdhPJwz9Ena8joChwbHYWvfBmyFhe6iOgScEwBkOyjyj+5lbfIPs932xzr5zVGdL9BA1VPForksVwfWJANIgBtzAJQ=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr5178988uak.19.1605613842799;
 Tue, 17 Nov 2020 03:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20201112092530.32446-1-zhengliang6@huawei.com>
In-Reply-To: <20201112092530.32446-1-zhengliang6@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:06 +0100
Message-ID: <CAPDyKFpSFhgGY19Ud=DpMTKC+mP=hedEGDOmF5i4Mysw4ta0ZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix mem leak in msdc_drv_probe
To:     Zheng Liang <zhengliang6@huawei.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wangli74@huawei.com,
        fangwei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Nov 2020 at 09:27, Zheng Liang <zhengliang6@huawei.com> wrote:
>
> It should use mmc_free_host to free mem in error patch of
> msdc_drv_probe.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Liang <zhengliang6@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fc5ee5df91ad..eac7838e2dac 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2504,8 +2504,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
>
>         host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
>                                                                 "hrst");
> -       if (IS_ERR(host->reset))
> -               return PTR_ERR(host->reset);
> +       if (IS_ERR(host->reset)) {
> +               ret = PTR_ERR(host->reset);
> +               goto host_free;
> +       }
>
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq < 0) {
> --
> 2.17.1
>
