Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B380C49361
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Jun 2021 00:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3537961246
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Jun 2021 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFPAKs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhFPAKr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jun 2021 20:10:47 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C0C061767
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jun 2021 17:08:41 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l12so544213oig.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jun 2021 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qCmyEQVqii6LsyuSPV+QSKBL2P0pCYgAFr/Ibzjgluw=;
        b=IMEhVAfO1aDyFd07H+YfV/YIDMH7VDz8G6IhfkgxvLbPEPtIGMoBmPDGZFzt2E2PRD
         T+V8PIwDsUUlu6m8w1v02VT/9yCRR1Ll5POzI9ow0w/lj67tU+MeqHkGogIaZ63OH9/P
         PD9VkyGBzZ4tdDSLqQLhXUAr61MMfkAHVmQWV3i6ym0TuGX2u+bamT5QtCTNwXe3pUI4
         cYGL+0HgRhDmvWsw/+JaAOet7sxZeRH/0G5smCEhnM10id/AUz/hIjLR7XZv/+tDaHVs
         Gl8g2UJg8CO4HJc+iydXoI84eYtLaln49Sr/EcwiONaYpDP8qddAE1HBG8QTDjR2qQ78
         pRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qCmyEQVqii6LsyuSPV+QSKBL2P0pCYgAFr/Ibzjgluw=;
        b=W4Em4i4NI1TW4ToaDR2/yj+qU4ZiSpUFY2VIKqlcmUarfilO2vvwlIvp2TDs0lRJDk
         P26cOW1nOoKZkw8AWpasNKiLgZF+cV7eCBhmGqhhn215PWVbTit0Zaw9fURg6xxBuB1N
         Tj1rpFWK3togN5JLPHzW80FwlOoTKkHOd3bq12gSBGDlG1tQA1CroxtoWm1SmMzGOeHI
         u2/KFhqjIQP8VfV/Ux6fHvIpg+5eYzFnEys4iFoL+fLidfLDKRknjENI5UnMiu6Pcrqi
         +AdqbWcYDF1PSfysHpJ57YWVFhdBBwjdCk5Rx+3SjrTG3uecTSmk/tSIr+0lyhTepC53
         H8Hg==
X-Gm-Message-State: AOAM5339RDiCg/xWQxFBqVFr/dh5rGkcY6TKRsfVup/Ipkj0UctSjmJK
        /SlgNixmU2niX3bPS/RVGlVNvg==
X-Google-Smtp-Source: ABdhPJy0fdhDuyBoO6v1WeQRUNwSbxlbhglg+X31disSsmVH0VXlYLbR2W0TGiw/QG0R+gKqyxay5g==
X-Received: by 2002:aca:530f:: with SMTP id h15mr1175785oib.128.1623802120548;
        Tue, 15 Jun 2021 17:08:40 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b22sm108948oov.31.2021.06.15.17.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 17:08:40 -0700 (PDT)
Date:   Tue, 15 Jun 2021 19:08:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sbhanu@codeaurora.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        okukatla@codeaurora.org, djakov@kernel.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org
Subject: Re: [PATCH V3] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD
 card
Message-ID: <YMlBBeT1VK5snsM7@builder.lan>
References: <1623252028-20467-1-git-send-email-sbhanu@codeaurora.org>
 <YMLbsZUojmYjM/j0@builder.lan>
 <64166450ddc927d10ad4b37dadf218b6@codeaurora.org>
 <0ce40daf1f8146f47b1877fb2c83cd95@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce40daf1f8146f47b1877fb2c83cd95@codeaurora.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue 15 Jun 03:56 CDT 2021, sbhanu@codeaurora.org wrote:

> On 2021-06-14 17:00, sbhanu@codeaurora.org wrote:
> > On 2021-06-11 09:12, Bjorn Andersson wrote:
> > > On Wed 09 Jun 10:20 CDT 2021, Shaik Sajida Bhanu wrote:
[..]
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
[..]
> > > > +		sdhc_1: sdhci@7c4000 {
[..]
> > > > +			sdhc1_opp_table: sdhc1-opp-table {
> > > 
> > > No need for "sdhc1-" in the node name.
> > ok
> Hi,
> 
> For Sd card also we have opp-table info so if we remove "sdhc1-" here and
> "sdhc2-" in Sd crad opp table we may have dublicate nodes so,
> it is better to keep sdhc1 and sdhc2 in node numbers right.
> 

Are you saying that /soc/sdhci@7c4000/opp-table needs to have a unique
name to not collide with /soc/sdhci@8804000/opp-table?

Regards,
Bjorn
