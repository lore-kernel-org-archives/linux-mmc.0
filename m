Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7413C2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 03:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC352072D
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 03:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rELjr7hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391011AbgDPDjM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729245AbgDPDjJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 23:39:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039E5C061A0F
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 20:39:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so865163pll.6
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 20:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ikFwhPaP79T559zXpru/+/ouMSYVfHSoq/3hZixqzjk=;
        b=rELjr7hj8EKHQiYaYK1IU2P2BPiXRsZmHANqUmszzCENVJLrBS8ORau/NpfkGkRAYj
         0677MH8s7Ea5F1MZFTA7JxWxnYmVpaNqOO1YLJMPiDpVWLXhdL+axZUfwFwdZo89ORmL
         Qn7xyYDCigu/v+eigluK3Yjz1BsOPUQn1PPr1bXEPEOaQ4wfFol8oCs+WptIzXuWDWsI
         8y0i8v5Au8P29j+A93oa1g78Zk+vmrGU0MKaJCj+rpAxPKXNn9KoiaTVwGTsqv4wklNg
         56fX4J4UtZcjntrXM5I9u/t3dqMkspqOaGAC+X603Hlj96hdHOMOud3Und8pSqeYbJa9
         0HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ikFwhPaP79T559zXpru/+/ouMSYVfHSoq/3hZixqzjk=;
        b=iDCzPao38br3LEFNwpMr7HWkajDUPvU3gjDL6HO1LbJ8ZYkgYvtikBadS0wBZ31Z0I
         ueSG5kmVdjAlH1nlqx0nHFLl8xxh0caXx7oCF9ahogLmUEij2W0FELeabhXVhIQG9a/g
         du5HXOKwS7qG4XPwLa2VTlpWND+NCrv4Zbnuy0FTk5f9sFu27b+3JphOK0waPLFHDwry
         C+q4A6ONJRXuPIo7AHQApeJ7EZNoZHu+6fhBNkUMSmua4wxS1GD9ee+DnjrHVFh/NJ23
         b2ktWFbiPa3GR4m2myhHRvnCBYx2Wa8H4HU2YW84Ib69oeq7z1sSsNVFoS+0LfGQByt3
         aDww==
X-Gm-Message-State: AGi0PuaE7gZ85VmkybWwZ9JtvjE0VTip8is2Dd4qFzryrjVMEGbBwlML
        P/imVWwRUPTW3j2D3lZlfZ0BMQ==
X-Google-Smtp-Source: APiQypLFQgaZGTgMw6vrQn+ueEyckHIfUhJ7MAN891TBxNssOn223MpKhK7aKqJdnTQzM8FZCBuvpg==
X-Received: by 2002:a17:90a:d14d:: with SMTP id t13mr2644607pjw.175.1587008348455;
        Wed, 15 Apr 2020 20:39:08 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id 135sm12813584pfx.58.2020.04.15.20.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 20:39:07 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:09:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep P V K <ppvk@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 13/21] mmc: sdhci-msm: Use OPP API to set clk/perf state
Message-ID: <20200416033906.cl2v6wgbz3ch3clg@vireshk-i7>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-14-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrOFOLCWHu8nE4i5t=d+Ei-kcJ15_42Ft3ROSUDe5jkpw@mail.gmail.com>
 <3e5f8e78-7cd1-30fb-e005-78c1e7111794@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5f8e78-7cd1-30fb-e005-78c1e7111794@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15-04-20, 22:13, Rajendra Nayak wrote:
> As for the dependencies, its only PATCH 01/21 in this series and that's
> already been queued by Viresh [2]

It must be part of v5.7-rc2

-- 
viresh
