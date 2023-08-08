Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2ECC04E69
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 17:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjHHRXp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjHHRXW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 13:23:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337AE1E5B4
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:09:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7656652da3cso410823085a.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510955; x=1692115755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPSF8lgC2wI5az/29egclIKupqcJsxYM3YhRjRXWT2o=;
        b=dLrTppEGfFjigCcEljMfcjzsoxAlqaTU9xZ+PYNOpyrc+wAT+HXI4Z6gITuZDn5Isb
         a1HJSa6oUnXy76OO7JNfuViMbVlGG5MjhwUTYwaaAs1sKTcf/A+Zg3jXnR00TVoc3MJW
         wrP9+rVDT99rpk+nWb7cD3rdqzDXAkU3CqJ3n36E/Ct8gWNPNwMIl+wHIjfy6jAAzuhH
         MQI4ETUa5wBnKvTy+enb9eCpEy/MUvy3RwshEtjGuoNXNY1bW8w1OUzf+ilxOAyWGgGm
         5dyv9c9jbBjq5tkB3iVXzC0u/k0M63F4xLlxvYyO8MVjZJq5eslHi4RBCf5IlLR6zbx9
         pxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510955; x=1692115755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPSF8lgC2wI5az/29egclIKupqcJsxYM3YhRjRXWT2o=;
        b=dhZM5fdIk9fBwYS+B7RBmg35kAGmI/DPQj0BTex4gVRMsGEexsd/dEyoxbj3jlna0p
         JXQVISHlZBn7sSzf/LD6nRTwPLycLV0eBHcfmlpgXQtjwP3lm2U0tiuNmnBARGbNqU5f
         APxAQy8L29K72RbZcaYHOIGfhGknCjru/RC6ZSjL3su883HoUHwENjetWJCtYWl64w9z
         vux/rUFxbIUpxaCwHhbmMRsXQvh0XS9rV44EgISIetYARffvsNdKqLOBCeDHyWMtSMtW
         oSXgqq9t/hJsAUBcsJVkKBDNQmR0JWwWEJbB6lqIy94Rp4igLXdWs1zrvp3LGFo/6H4c
         3ZuQ==
X-Gm-Message-State: AOJu0YxNw1iT8NO+H5qAcAXqSyTqSNoBFLq4aj/CVa2hqmWcC7oVoGRR
        S+22YzPbf1CAygHHEWp5Fj31h9Z3ywEGdNZJQSgjGOeN3EXTPPOE
X-Google-Smtp-Source: AGHT+IGtoa5wPDW5N6WXGTe1nzXATE3mfxEonkvdAbpiEC2xZ9WCEviVTNR8MXsMHWnlPlvBt1eOrosazlzvoaf++r4=
X-Received: by 2002:a25:6806:0:b0:d17:6abc:4695 with SMTP id
 d6-20020a256806000000b00d176abc4695mr14411930ybc.62.1691492524111; Tue, 08
 Aug 2023 04:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230807141704.3486854-1-yangyingliang@huawei.com>
In-Reply-To: <20230807141704.3486854-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 13:01:28 +0200
Message-ID: <CAPDyKFpqZOSvZQ=8jLcsn3DHzo=i_-RugSdZOgos057gErc59Q@mail.gmail.com>
Subject: Re: [PATCH -next 0/4] mmc: remove unnecessary set_drvdata() function
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Aug 2023 at 16:20, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> The driver data will be set to NULL in device_unbind_cleanup() in driver
> core code. So the set_drvdata(..., NULL) called in remove and error path
> in probe can be removed.
>
> Yang Yingliang (4):
>   mmc: via-sdmmc: remove unnecessary dev_set_drvdata()
>   mmc: block: remove unnecessary dev_set_drvdata()
>   mmc: moxart: remove unnecessary dev_set_drvdata()
>   mmc: sunplus: remove unnecessary platform_set_drvdata()
>
>  drivers/mmc/core/block.c       | 1 -
>  drivers/mmc/host/moxart-mmc.c  | 2 --
>  drivers/mmc/host/sunplus-mmc.c | 1 -
>  drivers/mmc/host/via-sdmmc.c   | 2 --
>  4 files changed, 6 deletions(-)

Can you please squash these trivial patches into one patch for mmc?

Kind regards
Uffe
