Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957FCC4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D185610A6
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 07:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhHZHoG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Aug 2021 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbhHZHoE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2021 03:44:04 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA5C061757
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2021 00:43:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 6so3295411oiy.8
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2021 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=LEECzjw9cAEfzX4h9vkbRwWXNoxUMF+O32+9m96eguo=;
        b=iWJt3xiTwRlWDaxE/vdGSwl89PVd5QpSpCA9MGyYLGMM9tLlH8gFtyC7T1rKacZGGn
         Ejnl1HqQWQMuTUTDascCNn7wR5qkbCDLcww1J0O6UhN6ln6QzKRDtLQLKYZ9+EeqDfhL
         EG4UgIGmhaFXfhiiN6ojNTuLrCPnwoNsTcQOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=LEECzjw9cAEfzX4h9vkbRwWXNoxUMF+O32+9m96eguo=;
        b=gXqIwL5Phda28CFjKGZxC45wp3AQQkzsA2+GuNXt8Mr9Gcrabb5y+ujO5OcC5utG4m
         NK5CkZ8+xlm6qxvy5Sweh+AdJFOtQnLcyPWMLMoa0kB1jwTGvBvtTbEsu6+963LLl5iH
         ZnwXFmNqda2QyavXM9ZKwlwe8KDvJ81fEBDbzBBl4ZubNV9RKYzuk0EXKFfgrhfLvnOj
         3nS8CInF1My/AjuFgZEncJfup3QnZTjP3WWeQI7DCGc8Y9ypC+jg2tt54NnxQZW3MiKJ
         CpE+QCk1rNzCH9YaPROxLE3Pfw4l9Y35UXygy5Wj/DeMOGtXopZ4x4lUo8kO1GjYlTlz
         RQmg==
X-Gm-Message-State: AOAM531tC02GH/qE1YtmZ3LGrlJY9mgsimMxKB7s+6ILCjUsVcpvimf/
        Qt2unXS37SOZMLXBnyVECrGRSsuQ+RoDqRhlCVmgEw==
X-Google-Smtp-Source: ABdhPJw6LeRszszYvlKT8BPrwfjzgPVcCpjequieRxS7/W04iTvrhITxDPd/lv7OUWv+AtbMDaSEl2H9lkGW+RMcH9Y=
X-Received: by 2002:a05:6808:180e:: with SMTP id bh14mr1464661oib.19.1629963792627;
 Thu, 26 Aug 2021 00:43:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 07:43:11 +0000
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp0O-N79QzHtoaC0+yWvYbTy1mGCjn7wivLvFvJ7_oNiA@mail.gmail.com>
References: <1626435974-14462-1-git-send-email-sbhanu@codeaurora.org>
 <d95ea0583c39b8e73f391502adb39b09@codeaurora.org> <CAPDyKFp0O-N79QzHtoaC0+yWvYbTy1mGCjn7wivLvFvJ7_oNiA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 07:43:11 +0000
Message-ID: <CAE-0n53vxtDSh66+XxzMX38ccD6++E8v2ixYRonoihNG=ggqpQ@mail.gmail.com>
Subject: Re: [PATCH V4] mmc: sdhci-msm: Update the software timeout value for sdhc
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, cang@codeaurora.org,
        Pradeep P V K <pragalla@codeaurora.org>,
        nitirawa@codeaurora.org, linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Ulf Hansson (2021-08-04 04:34:52)
> + Stephen
>
> On Mon, 2 Aug 2021 at 12:41, <sbhanu@codeaurora.org> wrote:
> >
> > Gentle Reminder
> >
> > Thanks,
> > Sajida
> >
> > On 2021-07-16 17:16, Shaik Sajida Bhanu wrote:
> > > Whenever SDHC run at clock rate 50MHZ or below, the hardware data
> > > timeout value will be 21.47secs, which is approx. 22secs and we have
> > > a current software timeout value as 10secs. We have to set software
> > > timeout value more than the hardware data timeout value to avioid
> > > seeing
> > > the below register dumps.
> > >
> > > [  332.953670] mmc2: Timeout waiting for hardware interrupt.
> > > [  332.959608] mmc2: sdhci: ============ SDHCI REGISTER DUMP
> > > ===========
> > > [  332.966450] mmc2: sdhci: Sys addr:  0x00000000 | Version:
> > > 0x00007202
> > > [  332.973256] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:
> > > 0x00000001
> > > [  332.980054] mmc2: sdhci: Argument:  0x00000000 | Trn mode:
> > > 0x00000027
> > > [  332.986864] mmc2: sdhci: Present:   0x01f801f6 | Host ctl:
> > > 0x0000001f
> > > [  332.993671] mmc2: sdhci: Power:     0x00000001 | Blk gap:
> > > 0x00000000
> > > [  333.000583] mmc2: sdhci: Wake-up:   0x00000000 | Clock:
> > > 0x00000007
> > > [  333.007386] mmc2: sdhci: Timeout:   0x0000000e | Int stat:
> > > 0x00000000
> > > [  333.014182] mmc2: sdhci: Int enab:  0x03ff100b | Sig enab:
> > > 0x03ff100b
> > > [  333.020976] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int:
> > > 0x00000000
> > > [  333.027771] mmc2: sdhci: Caps:      0x322dc8b2 | Caps_1:
> > > 0x0000808f
> > > [  333.034561] mmc2: sdhci: Cmd:       0x0000183a | Max curr:
> > > 0x00000000
> > > [  333.041359] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:
> > > 0x00000000
> > > [  333.048157] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:
> > > 0x00000000
> > > [  333.054945] mmc2: sdhci: Host ctl2: 0x00000000
> > > [  333.059657] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> > > 0x0000000ffffff218
> > > [  333.067178] mmc2: sdhci_msm: ----------- VENDOR REGISTER DUMP
> > > -----------
> > > [  333.074343] mmc2: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
> > > 0x6000642c | DLL cfg2: 0x0020a000
> > > [  333.083417] mmc2: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
> > > 0x00000000 | DDR cfg: 0x80040873
> > > [  333.092850] mmc2: sdhci_msm: Vndr func: 0x00008a9c | Vndr func2 :
> > > 0xf88218a8 Vndr func3: 0x02626040
> > > [  333.102371] mmc2: sdhci:
> > > ============================================
> > >
> > > So, set software timeout value more than hardware timeout value.
> > >
> > > Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Applied for fixes and by adding a stable tag, thanks!
>

Thanks. Looks like none of the stable trees could apply it though :(
