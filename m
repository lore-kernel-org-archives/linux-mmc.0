Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D5C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C27720767
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzlC8dEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBT6f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIBT6d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 15:58:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A065DC061244;
        Wed,  2 Sep 2020 12:58:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m5so200460pgj.9;
        Wed, 02 Sep 2020 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d+WdgVBE+L/woTERvR0p8b6tQx5/pd39kVl8oSrdHVs=;
        b=YzlC8dECJqJOjLLs2YKQmuohtpWmQk+W/RgohjefJ4o7Aum+uzfTLLoq87rr0RfFzv
         hagR5zptSSAwqVNl9ljQrexXAhAtNNF2a6xLEW2LvNF+ZZp7EylrMYCvb18IT8rEctE+
         wSYEtQ2D8AhKNC+aFBi9bS5yqBJ3DiQRLb1YdVxckFNTDylaqFy7zqk+FFvpmtMJufK+
         ScBJw2tfa27ngWimOxV0/umWO1Xr/UW1PtU8f7y5El6xmPtSnOsvyu7tjgbPNyGh02jV
         Ek02Bz9L9SLWH9rxyMfdX9PXr5LrW9LoxI+4GqJWH2fQV0CfhMQc2jO3JOFkk2ZVksqk
         ZPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+WdgVBE+L/woTERvR0p8b6tQx5/pd39kVl8oSrdHVs=;
        b=ipIyyFUNNr1CoQLFLwYrxZD6pZquaOoxcFMMQUq7srqrjnKPtiZfQAAMIY6n/SzcMp
         9Ed9nvCcIRNhCTADJ/IZr0FqGEBo8P9ZD/b+8TTwhd1XnO8XBlq7vv3K0iRYYzWUmwed
         X/E2F1vIrZnjYzQdCo+m5J5qGtVnazjej7lj8WmK4pD5NbPa/jGCQV9mmKZUMYE0AeUu
         HAvtwKCdB+xD4WgO/AIAUra+VrXsoHDSXpuZMyXyWkHFsqss1Bc5o0XP2aIi8vInwmCD
         V0Twbq/0XSDNCKGCQtRbDKqgyEgK5ui2UJl9Hlg846SV+0JVFYTn/+KWexwn99aF3Ldi
         cggw==
X-Gm-Message-State: AOAM531LlRTCqeirMOB7X5kn5+v6b9f4vj8cKW33gTK0nSSy7BCSjOi+
        aTaBOdchNpuwI0HRhcr9TouTOtsQsag=
X-Google-Smtp-Source: ABdhPJz3ZUmZlx9FkrlG3QEblvQfbKk0RI98pTqO+CIB7JBEZc5AFqQkvFssp7Rw0LROy2Nln0RVXw==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr3244798pgl.235.1599076712745;
        Wed, 02 Sep 2020 12:58:32 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2sm163845pgs.90.2020.09.02.12.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 12:58:31 -0700 (PDT)
Subject: Re: [RFT 06/11] mmc: sdhci-brcmstb: Simplify with optional clock and
 dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20200902193658.20539-1-krzk@kernel.org>
 <20200902193658.20539-7-krzk@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d98f6b67-c0d0-f701-af24-b01f61c4580d@gmail.com>
Date:   Wed, 2 Sep 2020 12:58:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200902193658.20539-7-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 9/2/2020 12:36 PM, Krzysztof Kozlowski wrote:
> Only -ENOENT from devm_clk_get() means that clock is not present in
> device tree.  Other errors have their own meaning and should not be
> ignored.
> 
> Simplify getting the clock which is in fact optional and also use
> dev_err_probe() for handling deferred.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

This is actually an open coded version of devm_clk_get_optional(), so 
this is fine:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
