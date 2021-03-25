Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7211C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Mar 2021 22:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7A061A3A
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Mar 2021 22:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhCYWej (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Mar 2021 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCYWec (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Mar 2021 18:34:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13898C06174A;
        Thu, 25 Mar 2021 15:34:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 11so3511612pfn.9;
        Thu, 25 Mar 2021 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3pI3wTYnfce9h5pWOGPoILRK7UaH+G2udckcHEub78=;
        b=swIEOgu95QCf9KedaX4yebvnrTZZGdBVpIzFChRQI1+PDRhRc8qNWJ0rsN55FErMs/
         aGEz2YRI6HAYgD56wlV8BxeL18ERak8ArONscIHBhrE101A6ls8PbTY8bhzm6lN3hwNQ
         pDFicK8np9QJDCtC1fSDSotZ+wt7z1HDrl4zKes6lycrqaxquEyHSPdzTxmWh5HGHPxy
         c0dcz/1ddgTJRgbGPA3/0ZY/Q+oNLk7KtJbq5PWs40mN3M/fxOsdV0VahEZ9a4b50BR6
         YBX2+hOSYMZwGtFx2osqj+YQf7dI4TOZSZJaukpLcN/70CGrzLxSJiwCZbCcLHjvUp3b
         2ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3pI3wTYnfce9h5pWOGPoILRK7UaH+G2udckcHEub78=;
        b=sEY9mLXF30ju+Iej/qc4GUTmp6pq191zuaWU5K4Rodbqrp1oePExZgAsQYb2WeXHqT
         J4vJunT6wbMUvZ07m3UufM80Xa6/x/GnB7aIt6t1D+QY64ddaqk+ZceUbvdpNK9cEvKh
         BVx4wd1xdmDW3elZj1YNjKH729jy9QQaJgq2PdrdUWkxMsczirWj/TY3CIPfP0Lk0mpd
         GHgs2V0BE6PRuW+utbnGW0B4dtS+51WfzwOiCXXD+ackDicK0W0DDQtzGntOCFW93ulU
         pFrmMDVVMi2yrg/RqjnWNhIaeTNjdnJFIRO5VT0jNyNWo6PJJrX1qcHogkCPG3waox4E
         F4Lg==
X-Gm-Message-State: AOAM5313pLvbFzwK7kFwYl/wfMoxXJ2P6ykEPpvUMotQp3hXQmpQv3xK
        IhzU0CIIQia6TCRuoS4wCek=
X-Google-Smtp-Source: ABdhPJzSOVWrd0ZUTVMt0ZJVpx/V91m8aCUSh+Plu+or3dSadNjlWXEUd9ymA+N2OtQFNRJZCgjooQ==
X-Received: by 2002:a17:903:228d:b029:e7:1f01:bab0 with SMTP id b13-20020a170903228db02900e71f01bab0mr173917plh.80.1616711671394;
        Thu, 25 Mar 2021 15:34:31 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f19sm7297452pgl.49.2021.03.25.15.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 15:34:30 -0700 (PDT)
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Remove CQE quirk
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20210325192834.42955-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8736770f-69e9-579b-0762-83884c8cb4d9@gmail.com>
Date:   Thu, 25 Mar 2021 15:34:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325192834.42955-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 3/25/2021 12:28 PM, Al Cooper wrote:
> Remove the CQHCI_QUIRK_SHORT_TXFR_DESC_SZ quirk because the
> latest chips have this fixed and earlier chips have other
> CQE problems that prevent the feature from being enabled.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
