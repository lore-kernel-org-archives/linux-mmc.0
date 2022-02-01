Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F10FC433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Feb 2022 05:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiBAFVo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Feb 2022 00:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiBAFUs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Feb 2022 00:20:48 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C50C06178A
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 21:20:45 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m10so6179338oie.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 21:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gc4d+mJV9MCv7yDWAF73c6XrdPx3pGuNA/L39Cbelk=;
        b=VCTxRN4Dl4Ev68KzOliMDp//TYysmXy6rDK7ijEX+ofZrPY62R+kYV1dwDx+Hwl9Ka
         T2p7cW8n5wMFbwELYwsa+qWFwHaV4INU12dUzT36paFAU0+G5YnLwwHuctEXRSUPNz94
         rHMMViKEI1esVgd2uOIoUcgHh97BvSTc0GEdij8qFHDuQtkgZ2+U4EgXSEw8RceCZXk8
         j8jKi/uhtVEN1Q83017dvGCc/O9xOaoQRzkhrMvO0JhwCRixIYbNIN4ESFo0mjxWXsQT
         LT/TWT8pu5pYdpbh/mE09DFKE3CKfPcZ/1SYnjcyM7zo5OnQznhHLVIgKa18sYurJ5j+
         W6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gc4d+mJV9MCv7yDWAF73c6XrdPx3pGuNA/L39Cbelk=;
        b=BMfwyWJ8xTCxfsENwcQ3x7yCRAP31+OVjWqS8FPF7jvshYLh6uoH+hfcTidvzkKHKe
         6GLR2zRStWKOkHrAXyqjTEsBNG5cLGaK1gB89sqO0ntWn3Kza+GfY0/iH5isKnqeXZSe
         O9cjH9AvXHOKH5/VF8vv+b2/afcgQaKNp32DSXRKT/f3OVCTCUEYcsQ2AdNVksh4bqFe
         kDeVhIo5XD98ukDY2sV222ABhme0GJVuptzfEEumm1w9+u9hIwAqq8J9kk5YDL0EqIed
         JvQl6st1mxaqPRqkuqAKcu591dZou4dNqJtSDvnG79SQWwbS81JPUTKtCy3/tDYSamSy
         GZ6g==
X-Gm-Message-State: AOAM532mnRfGTwb1LXMnOYtHU0FGbsLfwYLrwElki997tK5oSGwizfTx
        0fwesigF+qJ1Tpxk9le+DCxdUg==
X-Google-Smtp-Source: ABdhPJxEy/ZQUv6tV8wHl/M+IhTQ4d7SBK2g4W2+2RLY7rILhOEij+iloYKhfY2X2kLY5B4Mcllmng==
X-Received: by 2002:a05:6808:e85:: with SMTP id k5mr224125oil.238.1643692845088;
        Mon, 31 Jan 2022 21:20:45 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Taniya Das <tdas@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-mmc@vger.kernel.org,
        Jean Thomas <virgule@jeanthomas.me>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: (subset) [PATCH 0/6] msm8994-huawei-angler and msm8992-lg-bullhead sdhc1 fixes
Date:   Mon, 31 Jan 2022 23:19:54 -0600
Message-Id: <164369277345.3095904.15450214704701068210.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113233358.17972-1-petr.vorel@gmail.com>
References: <20220113233358.17972-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Jan 2022 00:33:52 +0100, Petr Vorel wrote:
> Besides fixing sdhc1 for msm8994-huawei-angler and msm8992-lg-bullhead
> I also rebased and reposted Jean's patches (Makefile didn't apply on
> current for-next) and also rename angler's DTS.
> 
> sdhc1 (i.e. mmc0) is working on both, but there are overclocking
> warnings. I suspected issue similar to using clk_rcg2_ops instead of
> clk_rcg2_floor_ops (i.e. 3f905469c8ce ("clk: qcom: gcc: Use floor ops
> for SDCC clocks") or 148ddaa89d4a ("clk: qcom: gcc-sc7180: Use floor ops
> for the correct sdcc1 clk"), but it looks to be correct for gcc-msm8994.c.
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: msm8994: Provide missing "xo_board" and "sleep_clk" to GCC
      commit: 4dd1ad6192748523878463a285346db408b34a02
[4/6] arm64: dts: qcom: msm8994-huawei-angler: Add vendor name huawei
      commit: 8af90d6daa36a7180a2cd6aad874136aade27412

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
