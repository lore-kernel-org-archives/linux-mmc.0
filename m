Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8176BC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EFB207CB
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsb+oiHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbgE0OzV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbgE0OzV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2020 10:55:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B24AC05BD1E
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 07:55:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so24311458wrt.5
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nHeMnTXMBv8ga8XlmHgcF2OkT4bwM7qlmR83SxPGZ14=;
        b=tsb+oiHDlnENmn3sre3eKqxzABffOcwAvGjBVT68owcXYXBz6ukqJT03AzaMHhSlZt
         J7fVYkG7LVmTdMyRe3lPNt1/328UgJJchJLomDLsYpXzKRL04VLU4DLrEH4E59AJz+KK
         FMUzmA+Bvfs5CIPwZQs65Ag+nTt2SgXuJs+fuuZq9QM11fJqiAw2/dUiL0QBKo5LpWFZ
         qWrxy19zLH9j2ASLy2GBvg5yrx+nOYnhE5jcNgkarohNS1/nyxt7tQyFHtR44LxhRjif
         2mG5974FKtY3/6L64ftvV+LgwerscHY2TtqcWjwqa8WconTVLnQAcJzmZTy0cHjc+RH+
         n9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nHeMnTXMBv8ga8XlmHgcF2OkT4bwM7qlmR83SxPGZ14=;
        b=kfk/ISuOim2bVxxj0n39n18KtMSfc0E0oGBa1VNz3X/4H4mvSIrMIKAJ1Ppq9lOa/n
         jGGhpPSxODEYjaciMD5oyIWIiMpzT970GTDXTrsvD+WNstxo31aJEjL7Igyhj+kIK5Pn
         qGNOv/X0B60/5E2yn2N6a+/zKxR3hm2c3SvrI3NkQgRWIsiBDLVA++e+v46jLqP6p15Q
         c1WZVv6ZnpzEApHnV6UI8Ch4yjNsnPUVqqJg/TUQ9ZxmIvUYl4ub76sg/Ia/fUNX0kLt
         xBAPz4zRT8mNK3lKtVHSUsS1lhQP4jlTf5swt9MbJ/9RtYlgqWPY14zXt12y5IIN9r1t
         fuZg==
X-Gm-Message-State: AOAM530U5csinXl0wFGhPT6kMGqoDtNkx5mon4skJUcXUMHAO38VhJp6
        hVUTc/iSrIQqEy2U65yAXSg=
X-Google-Smtp-Source: ABdhPJyBBLqlgBC/Q3d8XLiMKQCddaS/Qj91Hj3RW79igUxx2Sv8P/GbyOMpjMtstFRJa0C4nxX3Rg==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr15010053wrs.209.1590591320035;
        Wed, 27 May 2020 07:55:20 -0700 (PDT)
Received: from [192.168.86.31] ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id b187sm1864219wmd.26.2020.05.27.07.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 07:55:18 -0700 (PDT)
Subject: Re: sdhci_msm issues with cold-plugged SD cards
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernelnewbies@kernelnewbies.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sarthak Garg <sartgarg@codeaurora.org>
References: <491cfef4-4a97-b6e8-0f41-d44e1c73eea4@gmail.com>
 <CAPDyKFqAWVPU=mJ=RzMyJsBiMTfSQqFTXw1oLqb=cZCM4e9ebw@mail.gmail.com>
 <d268a70b-a938-ab37-cca1-9a1322ad3cae@codeaurora.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <d3a9b452-beca-6354-e69e-349bc2565e67@gmail.com>
Date:   Wed, 27 May 2020 17:55:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d268a70b-a938-ab37-cca1-9a1322ad3cae@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/26/20 4:01 PM, Veerabhadrarao Badiganti wrote:
> Strange issue. We never encountered this issue internally.
> Please define "post-power-on-delay-ms" dt property with some larger delay value (25ms?)
> and see if that helps you...

I put 25ms, and 100ms, it doesn't seem to make any difference.

> If this doesn't work, let me know the Qcom SoC (name/number) present on that phone.
> And the kernel that you are using.

The device uses a Qcom msm8974-pro. There is SoC dtsi and device dts
(samsung-klte). I used a 5.6-rc6 kernel when I reported this, but now tried on
next-20200526 and the results are the same.

> Thanks
> Veera
>
>

