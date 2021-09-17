Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC96C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F5761248
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 15:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhIQP4T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbhIQP4R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 11:56:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EE9C061767
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:54:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m21-20020a17090a859500b00197688449c4so7743350pjn.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GW1WgRF6SuqTQcN6bjavSevOnivv0wMVUH9HZeNVmaQ=;
        b=kQRB0qqQHop4GG36R07plFb7axL/C9zQw2hxoXCMkt8M/uUXLv+Ms+Ynh0uOyRyA4u
         p8PmstiTAHiZPMYLXQiCx23gFCnU04gp4sxwJFSbm3CEqjrz02chT7gPpZN87AWer8aU
         Ro4752jjV1COVmPQUIiXt1EwH0X4Ijxltlyog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GW1WgRF6SuqTQcN6bjavSevOnivv0wMVUH9HZeNVmaQ=;
        b=uNd8zOKzRwWJKAFr8nnrfWjqOUmiNG3ifXd3BHbIiQ/Dxhe6gioOmWSsH559UWPjDx
         DXMvKTjNL/fRFGWn6Lr2CSubMSBiCXY01gSaZdVf67+Ia+Uv71tqPTFhvshvRg9a3SzV
         TiwRujYVY7D3ZHiJq6p5Wf9nbqz2S4dSpsyKXJvYTTzS+xPfrjZOPI0An+LLel6BlQFT
         QXyOy77Ihvg+Lh6nWoWicl3D/mXXoyf9egi6TTbWlvRayy9dmNZb5X42a2te7fEiC6zf
         UnKoavKwoq9YVFmXNWk0OiQ2V0XtgRG/70guhetlPW5apxlKHlMaWYOnUcmDMG8xb4ya
         1/sg==
X-Gm-Message-State: AOAM53140o4jM/GjpsHg+CfhH2Iuv+Ug74+H8jNG472zSd+994v2xQmH
        8E9sRMgrU8Ei5xyFWyG/ruxGNA==
X-Google-Smtp-Source: ABdhPJzFEnqJQEZhad7EFB5rcTtr5hs+gXwoICQuYe1e+Cip9gwcACVraZFrVhrtRAjqoF8WHL7mJg==
X-Received: by 2002:a17:903:246:b0:13a:22d1:88b with SMTP id j6-20020a170903024600b0013a22d1088bmr10319454plh.16.1631894092540;
        Fri, 17 Sep 2021 08:54:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k25sm6282982pfa.213.2021.09.17.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:54:51 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:54:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        rafael@kernel.org, jic23@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 3/6] device property: build kunit tests without
 structleak plugin
Message-ID: <202109170854.7ACE94F0@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-4-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917061104.2680133-4-brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 16, 2021 at 11:11:01PM -0700, Brendan Higgins wrote:
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit:
> 
> ../drivers/base/test/property-entry-test.c:492:1: warning: the frame size of 2832 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ../drivers/base/test/property-entry-test.c:322:1: warning: the frame size of 2080 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ../drivers/base/test/property-entry-test.c:250:1: warning: the frame size of 4976 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ../drivers/base/test/property-entry-test.c:115:1: warning: the frame size of 3280 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Turn it off in this file.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
