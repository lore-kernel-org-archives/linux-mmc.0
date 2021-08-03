Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AC2C4338F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Aug 2021 09:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A960F70
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Aug 2021 09:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhHCJBp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbhHCJBo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Aug 2021 05:01:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9F2C0613D5
        for <linux-mmc@vger.kernel.org>; Tue,  3 Aug 2021 02:01:34 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u10so27392573oiw.4
        for <linux-mmc@vger.kernel.org>; Tue, 03 Aug 2021 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xUCQLTJHLMWIwjOk7GbpaIHrEiFMhqmAaVSQLefOhbc=;
        b=GLArkjtdPgvCSnduTwRmjHH0GAo9b6Zfk37Ca+kYmtHHwq4RS5QnDFBfcMeehY9CEL
         L7XvbwO2q0Gfa5/gVbzx+rh51yNdz2hqv2L1nvqrLTQeIttnjUrctF6dWXUx3aQ4fqmv
         hlGdFxf/Ac9K84ELw8cCSCQ4T6mWyzsPFpBLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xUCQLTJHLMWIwjOk7GbpaIHrEiFMhqmAaVSQLefOhbc=;
        b=tueD4CqQ6I9rLxqSwiVEFOaMAxICN2BOxNbFqfHqUSl+i8R9fDJ8LOBt7gbfYmVbNS
         Xzz31i/XhU/LcxDgI4U84bTvw5K9K4YQ+I1BaHcIu7w36/xgk+0lLQUMZp3FcHRN7Zmc
         efsG7YpcUVtr5dCmzfZqpBXlIVCnAXgLKu+skC4TtncekaB3J906IewdJF8Hp6SsOkhM
         iRl2Bq3uVQ49xEqcc8HoCiiFtGpbwO4ZMaRmrWO9GemfAOrmQusfYllBRYnYNXzsDskx
         U8XscRE50Y2+ipBmCmyIwrOnQ7tR53aEA7/pI9sb3TBL4hAoeVNTF7tHON1IFzf9kHnM
         KbRg==
X-Gm-Message-State: AOAM532SbtCektfJLFSuyNSTL06Y6K+5gonJf2LOnM2/VFHTipCyOa5B
        X1/n64wqNTRPthGTqqZrARjA7FeNvh6K270H3AG3Yw==
X-Google-Smtp-Source: ABdhPJzGuEtdB7bf7PJVfXlAaT1Nq8s0bZVsqUmh/GEvGvYp5hC0GqqhWmyijlaI9GXkCG3G08uwk6yRrfKWqP8vaYo=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr13972869oiu.19.1627981292067;
 Tue, 03 Aug 2021 02:01:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Aug 2021 02:01:31 -0700
MIME-Version: 1.0
In-Reply-To: <1626435974-14462-1-git-send-email-sbhanu@codeaurora.org>
References: <1626435974-14462-1-git-send-email-sbhanu@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 3 Aug 2021 02:01:31 -0700
Message-ID: <CAE-0n53tzuU-1Gb+krJKjJ5k=hmeBex1=qmJO+zLZBCL5DBhWw@mail.gmail.com>
Subject: Re: [PATCH V4] mmc: sdhci-msm: Update the software timeout value for sdhc
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, rampraka@codeaurora.org,
        sayalil@codeaurora.org, sartgarg@codeaurora.org,
        rnayak@codeaurora.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Shaik Sajida Bhanu (2021-07-16 04:46:14)
> Whenever SDHC run at clock rate 50MHZ or below, the hardware data
> timeout value will be 21.47secs, which is approx. 22secs and we have
> a current software timeout value as 10secs. We have to set software
> timeout value more than the hardware data timeout value to avioid seeing
> the below register dumps.
>
> [  332.953670] mmc2: Timeout waiting for hardware interrupt.
> [  332.959608] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  332.966450] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00007202
> [  332.973256] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [  332.980054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000027
> [  332.986864] mmc2: sdhci: Present:   0x01f801f6 | Host ctl: 0x0000001f
> [  332.993671] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> [  333.000583] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [  333.007386] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [  333.014182] mmc2: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
> [  333.020976] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [  333.027771] mmc2: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x0000808f
> [  333.034561] mmc2: sdhci: Cmd:       0x0000183a | Max curr: 0x00000000
> [  333.041359] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> [  333.048157] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [  333.054945] mmc2: sdhci: Host ctl2: 0x00000000
> [  333.059657] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> 0x0000000ffffff218
> [  333.067178] mmc2: sdhci_msm: ----------- VENDOR REGISTER DUMP
> -----------
> [  333.074343] mmc2: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> 0x6000642c | DLL cfg2: 0x0020a000
> [  333.083417] mmc2: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> 0x00000000 | DDR cfg: 0x80040873
> [  333.092850] mmc2: sdhci_msm: Vndr func: 0x00008a9c | Vndr func2 :
> 0xf88218a8 Vndr func3: 0x02626040
> [  333.102371] mmc2: sdhci: ============================================
>
> So, set software timeout value more than hardware timeout value.
>

Should this be tagged for stable trees?

> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Changes since V3:
>         - Addressed minor comments from Adrain Hunter and retained his
>           Acked-by Signed-off.
>
> Changes since V2:
>         - Updated 22 with 22LL to avoid compiler warning as
>           suggested by Adrian Hunter.
>         - Added a check to update software data timeout value if its value
>           is less than the calculated hardware data timeout value as suggested
>           by Veerabhadrarao Badiganti.
> Changes since V1:
>         - Moved software data timeout update part to qcom specific file
>           as suggested by Veerabhadrarao Badiganti.
