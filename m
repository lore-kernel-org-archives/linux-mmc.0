Return-Path: <SRS0=F8Hu=5Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71396C2D0EA
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330A320692
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KTj0IrJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgDHOnJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:43:09 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:36038 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgDHOnJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2020 10:43:09 -0400
Received: by mail-vs1-f53.google.com with SMTP id 184so4806167vsu.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2020 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pDvcotqin9MFYotH20Ddvllc4oEen5KJQtcAktMMZs=;
        b=KTj0IrJ2HYAK/59HA7DR7goXWRl3VWt+FPwtTBivhZGMOp5zfVeZ5FfDBBCByd5HJF
         8y3lJWN/RC/xvlHZ4yDlKm3DAfqcRmuaryIa+n/7T4TZfvcTl/rjq3WRQ21OFXlh8HZ1
         ALUtiRUJPWuVq7rJHIiMWgZCPemzlXjOqYQhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pDvcotqin9MFYotH20Ddvllc4oEen5KJQtcAktMMZs=;
        b=ODVFzacgNBS8hFn0lJKF9/YH5iAIU7583kVaTJJm86oh3WBaw87jxSV6zTsvm22Phr
         yz3AlA2se+rIK1fglZdMjQ4LUN5NEioY2O4z0CX11BWj9vYi65dv6EZSjiEvGUj5lpM1
         ViXF67+WMIZnRqO/4QT48mDQXzOCdTUA2CLAdKB074efGlSlfdBSRdY6QAUPMvdY5AHY
         PdEKVz+qwrFi/Pa2fvB7UeNTR0zCT7V6+JCrCESDAHwM3c5K9Sbhaqb4STvU3Tx0SB5x
         2Ye30zjsNB35PTujMCxK8D1vHAKdNyxl8JpvWWk7pakMk3kZRetqJ9+DF0WdwlJFlZCr
         VNpw==
X-Gm-Message-State: AGi0Pubg6oB32Dx5h55bXU6id1vr+zemrLVTaDdT/heXWey/8kbXHUb0
        4OHTP1Z2x3+0DN+SrEaSfvXtYi/2CcE=
X-Google-Smtp-Source: APiQypIWPkPKSk6OCkF6U3Tt3vlyAIezvItWdcJzah7cCSrNrRD77Skw516fZ7IoPMhWrL1nxi6zXA==
X-Received: by 2002:a05:6102:1c8:: with SMTP id s8mr5901216vsq.11.1586356984738;
        Wed, 08 Apr 2020 07:43:04 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id h1sm6401798vke.7.2020.04.08.07.43.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 07:43:04 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id n128so1880181vke.5
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2020 07:43:04 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr6540930vsr.169.1586356481775;
 Wed, 08 Apr 2020 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org>
 <1573220319-4287-3-git-send-email-ppvk@codeaurora.org> <CAD=FV=WGUasS=UZxFeSS0Cg=9WxHPMWVFyYae7CFmOxV2_yhJw@mail.gmail.com>
 <001601d60da5$630168d0$29043a70$@codeaurora.org>
In-Reply-To: <001601d60da5$630168d0$29043a70$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Apr 2020 07:34:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WR0YBp7ah82Kg7RzxHdO8Agf5uGNb=58iApShXqbum=A@mail.gmail.com>
Message-ID: <CAD=FV=WR0YBp7ah82Kg7RzxHdO8Agf5uGNb=58iApShXqbum=A@mail.gmail.com>
Subject: Re: [RFC-v2 2/2] mmc: sdhci-msm: Add support for bus bandwidth voting
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        linux-mmc-owner@vger.kernel.org, sbhanu@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Apr 8, 2020 at 5:58 AM <ppvk@codeaurora.org> wrote:
>
> Hi Doug,
>
> You no longer seeing this warning stack with the latest patch set.
> https://lkml.org/lkml/2020/3/23/407
>
> The latest patch set is based on OPP framework and no workqueue's used to queue the work.
> Can you give a try with the latest patch and check if this helps ?

I was only analyzing an error log provided by someone else.  I will
let them know that they should make sure they're on the latest patch
series.

-Doug
