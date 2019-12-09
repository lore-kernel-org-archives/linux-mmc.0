Return-Path: <SRS0=IHUQ=Z7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E33C43603
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9540F207FF
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 14:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XlwlAish"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLIOsF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:48:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39958 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfLIOsE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2019 09:48:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so15946663ljs.7
        for <linux-mmc@vger.kernel.org>; Mon, 09 Dec 2019 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0HvN+3e+7om8qumnXzunxi56S61TczW41AS4hCzUgbE=;
        b=XlwlAisha/IQ7vS/gPNErAprRksj1pwwuHY/qJSvFrQftdWih8AAn/4LDfkagAGmLA
         sZR6bvN2z4ljSMIpTJi/Il6SofvgqRgEX78t/iRPfj2M2D+ks0ropUWEp3cqkqLB+Et2
         sSqnzNYvkMhxhSpfXfdpygzs7CQVB0+tm1fxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HvN+3e+7om8qumnXzunxi56S61TczW41AS4hCzUgbE=;
        b=WTp4wkKNWReuyFLHEoWTc4Hp6P9+7srJcQbTVPvj9NyRZ91B8czsQC+0054OiiTl6Z
         S2vdFyyshLUh8jdjJfiKUoX0m2N4lrYZzTyso3CfAzpFx/Qs8K2LD2GYdL2hwLO0M+L9
         zIJrkCaOxwgCOraAhzQkCYIrAxwONJPGL2C983PV+uaDleO/l4PyFCMQFShRIgvIodjq
         TtjrZxS2OAzwFmENWqrPXW1mnQ69FYaPD2kvnMgcoMtzU8mt2DsevbeUz9Ah5Z68zjzs
         bMEBfGGoI5i0httQ/DBRYpqqyhs0Qy2D/8+V72nwE6GX8Hw+cshS6YrrvSllBj87lKr0
         bVJQ==
X-Gm-Message-State: APjAAAWI91dBCVF53EudLsNuDxY6dJHYCcTQhgMvTa7qnQICDJB1Cwl3
        hHCpnf2U/0+ewFJPozNSVomLIllM3+8lTNyC
X-Google-Smtp-Source: APXvYqwnB1DDe+vJLnMUeAdtaqnv/hdl6VeHTg1Ng86FZHxtqmmJu4heJ3e9QqQCJC7P0kUcC7OWoQ==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr14634556lji.112.1575902882749;
        Mon, 09 Dec 2019 06:48:02 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h24sm21816ljl.80.2019.12.09.06.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:48:01 -0800 (PST)
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
 erratum A-009204 support"
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yinbo Zhu <yinbo.zhu@nxp.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d61ffef-f325-e1f9-7d02-d546f2f3d2cb@rasmusvillemoes.dk>
Date:   Mon, 9 Dec 2019 15:48:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204085447.27491-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ping, any comments on this revert?

On 04/12/2019 09.54, Rasmus Villemoes wrote:
> This reverts commit 5dd195522562542bc6ebe6e7bd47890d8b7ca93c.
> 
> First, the fix seems to be plain wrong, since the erratum suggests
> waiting 5ms before setting setting SYSCTL[RSTD], but this msleep()
> happens after the call of sdhci_reset() which is where that bit gets
> set (if SDHCI_RESET_DATA is in mask).
