Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3DDC433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3CB61263
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhDZJlV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZJlU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 05:41:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB5C061574;
        Mon, 26 Apr 2021 02:40:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q6so5648494edr.3;
        Mon, 26 Apr 2021 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lK6pxNkpo2twryNe4h5MAz/WVzYOC+jJ6g2f1GxTXmE=;
        b=DifyPrGhlygo1qDS/yq34JdRssrVJR4mhVIi6cxJK/ZAX8pl7YYR0ngUp+WfOfJD1A
         1JDzed1QQ8ro7G6DtCQR2gFtQwNSmKam/sxjqy9NDkJ63bDIqvDV8mdQUBnrhZzHPLvF
         IEVNbEVb4eOok5QuxFjF32PozH/dLFZeiP2rsXCrpCftTMXJt9EB0/72tmlTKqwHF1EL
         +gvJKGj2669DDlX/RaUsGTkzaNhYsM3mbhKgYvetnkFT2ZQN74HXf7rszBm5QAvB4J0i
         ImsUEQwwD3eSz3y95NTOY1ug41TiXqh6ws8qZOVLN52sjypcxxErxMTdwBVif5LqcwOh
         a8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lK6pxNkpo2twryNe4h5MAz/WVzYOC+jJ6g2f1GxTXmE=;
        b=g+gpKHrh8bsKF/9y0eyKuNDMYbCG9rD+ORZd1LM2kEr6qd2wRlwnfa1kiexfaBT0vp
         h9I5ij4HSMv9HVLDQor17YcAkNMrd98s/hGWpQm7kU/4OZ2kzEVpjIMxH/k5CrGUV9Jw
         I7iSHvhwvA7aqbtSeXBIXedb50so4SK92CKWj4ZX6Zw2ajwknTPPpab7jBWq6BQ/iCgJ
         aEzevZD3WwL10OOfbXEkHDsIg+YNFd7uXZtNcBHuA9FXiKD8Yf8w68Spgd0qsamhCuLc
         ZXeod66pfDuOSHF1qSUbWTByw+6rkyFvlwdi2cYBer+hWUKokz39rj0qq1QYiybGKMZQ
         1BJA==
X-Gm-Message-State: AOAM531n1tsockLNgYDG/DK3CAnoMC5OpByrIx2ptc6L+4XiEkKivBFG
        1jVl8JmlbnJMXeuyKi8tTk4/mQRDGC1RCw==
X-Google-Smtp-Source: ABdhPJxatRv2twXiuxffPMs3uUgWHZhJgz0DurhqanxxWCrtQ3XxpT6WViPtnE1/Srqe4a0bYeQktw==
X-Received: by 2002:a05:6402:6da:: with SMTP id n26mr19561888edy.203.1619430038265;
        Mon, 26 Apr 2021 02:40:38 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.googlemail.com with ESMTPSA id s18sm6261207ejx.10.2021.04.26.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 02:40:38 -0700 (PDT)
Message-ID: <ce3adbd6f546fd43eb0db75c3895b1d664afee61.camel@gmail.com>
Subject: Re: [External] : RE: [PATCH RESEND v3] mmc-utils: Re-submit of the
 erase command addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase.
 Re-committing the change per request by Avir.
From:   Bean Huo <huobean@gmail.com>
To:     kimito.sakata@oracle.com, Avri Altman <Avri.Altman@wdc.com>,
        "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Date:   Mon, 26 Apr 2021 11:40:37 +0200
In-Reply-To: <08442250-bc20-eaea-f383-cb36f4370102@oracle.com>
References: <20210422161255.4610-1-luserhker@gmail.com>
         <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
         <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
         <08442250-bc20-eaea-f383-cb36f4370102@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-04-23 at 08:27 -0600, kimito.sakata@oracle.com wrote:
> Its basically the same changes. Bean was coaching me on how to send
> the 
> 
> changes.
> 
> The only difference between Bean's submit and my last one is Ulf 
> 
> requested me to make a change in my changes to remove the 
> 
> MMC_IOC_MULTI_CMD #ifndef segments.
> 
> 
> 
> Thanks
> 
> Kimito

Kimito,

I just saw your last email. we need to re-submit this patch because the
format is not correct. If you need me to resubmit it on behalf of you.
let me know.

Bean

