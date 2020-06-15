Return-Path: <SRS0=6MuA=74=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3211BC433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Jun 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AE020C56
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Jun 2020 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/H1lS9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgFOXMM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgFOXML (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2020 19:12:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD25C08C5C2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2020 16:12:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so609231pjs.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2020 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=brcjvLKF1tqBCWFby3z+8MOldV/7mW3P5ikqS7XALSA=;
        b=a/H1lS9d3FYn9UhSPXJsrr9Ixza6PpJjH8tSHUvh/CVDtcrK+HwLEfl5AcfQGKk7Yt
         DgkSjxwNcl1kly5pAN0wEFgD8B08fUExsWnorPyLFmvpIBj+R/zkm9nzMFoDzMIv7hC6
         We3UEU2NIbpxqEVOI2R78klemetd7V15D0qk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=brcjvLKF1tqBCWFby3z+8MOldV/7mW3P5ikqS7XALSA=;
        b=lTl3ikxPpqxLXv2vkwLPSrQTudivlr04vELnVFUIGhPxK0rce5+lQ0+NjpAep9vdzq
         JOZW8ztrTFBu+7DE2uNhkiQICsrcuWHnfXnkUW5tkWG31OLX8QS+T5tnqMBPajxQ8fTA
         DW8jizVWdlk5Q3Txbd+X7caPaIp0Ig6614ZL46y5F0JHCkmaqoxYFh6NOVkRTip3xM5T
         EUo5pJEc1LIPXJ0JKwg2yATNpc95qy3Tj9UMymw9FapqXCHY9HsOlxk5iaODHTkCL72h
         GHxSJALP0k2tJO5KbdHH4BL9j497R9qES8VggKdXjrJNhXSS8GLfQKtnAXhIdR1R2D78
         SPQA==
X-Gm-Message-State: AOAM5323Tm4OIFZbsqzywy7KxNfBl1G3RVpX69SyNHe0kP+Z1TjG1y0W
        17K3yrx4s6CnYst1axUcWpSERA==
X-Google-Smtp-Source: ABdhPJyyci+2oQlVyjby51mYZoyBYZiTzI2eRXhAYx5ofJPrOzIloyTJpVXRIiOsGGjwxvfH9O22kg==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr266813pjb.208.1592262729649;
        Mon, 15 Jun 2020 16:12:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h3sm513401pje.28.2020.06.15.16.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 16:12:08 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:12:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc-owner@vger.kernel.org,
        rnayak@codeaurora.org, sibis@codeaurora.org, matthias@chromium.org
Subject: Re: [PATCH V4 1/2] mmc: sdhci-msm: Add interconnect bandwidth
 scaling support
Message-ID: <20200615231207.GX4525@google.com>
References: <1591691846-7578-1-git-send-email-ppvk@codeaurora.org>
 <1591691846-7578-2-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1591691846-7578-2-git-send-email-ppvk@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 09, 2020 at 02:07:25PM +0530, Pradeep P V K wrote:
> Interconnect bandwidth scaling support is now added as a
> part of OPP. So, make sure interconnect driver is ready
> before handling interconnect scaling.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Do you plan to send also patches that add the necessary DT entries?
I'm particularly interested in SC7180.
