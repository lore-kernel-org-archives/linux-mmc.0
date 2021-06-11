Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11027C48BD1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 03:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8B66139A
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 03:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFKDci (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Jun 2021 23:32:38 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40748 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFKDch (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2021 23:32:37 -0400
Received: by mail-ot1-f41.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so1837249otr.7
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2021 20:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1hLzClEPWcc9T3rZaPsiaM+hZWd7ywljr1mqjlpKVTE=;
        b=sWO79oaAXt8x6S+Sc43eMIvB/4r1u38J21m1vDtkqS8PAN/jWs9esddfmS26EBaSuj
         SPwuc/0cSz06OGSa0hULBp8+rpvguNIIhDa+JnCAT/kib/THSyOFW4gFbcSbFsx2m4QU
         yafjlhu5r73lDLTC6Fza+8jWXi9n+JkarPOOdnWiWxNabM6Ila/i4sjGd9gm/GYuV5rI
         sNPJDeTcvqUClsq23EX940vHEeMVWfmfRBvtNxyAHcbNtU60BKeLspSw25uADkgiWWwJ
         halhdGv8ZTdpq0MgBbBDk6BRsaTDm0/F+ij9LPB3Wh8UMn8JoG9/8mZ9aMjc4KTp7ODL
         pWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hLzClEPWcc9T3rZaPsiaM+hZWd7ywljr1mqjlpKVTE=;
        b=SBtiChohCrFbC0o35JXADS8H2wpoYDGC3GtRtWVW9MENCuciAUeKjGmmbwDrQSORO/
         mg2WG4XKVzc9AM2gZtUyodJIA0arKwvLX2/f5TdRIRM86RoKXfNATuc22U38p0Ott98K
         VbSXNp1t8BHoEcYTDNKTF1HhMmaBe3b+/oWH5cw6mG4bUTGc8M1G2/JcBm7/LyUTeFk0
         I1ZNvzJH5CTPfVybchuaaPOVIxmymFGum5b2pWuB2QQ2FwBegqUiPMYA5u2/2DxRlxL6
         Qy0z7+AitJ3pj26pljoaXUT7j+wEXQjV6RuPr6NO8zJcb4wk6Eaj35XrLb/Bk7bFO9FE
         nyFg==
X-Gm-Message-State: AOAM530U9YKvIVsaRy4mvbq6WeUX8XpxD4in246bMRH5yrxNMAl9/fdi
        QsIdi8ULC0GC6iCPYPrND8FHHw==
X-Google-Smtp-Source: ABdhPJw5J7t7bSClrb6lWwgJ8az5i6kqEZymqSBfImxUoo0Pqavlib0JbL7bl+Rawc2sq/Dx380OMg==
X-Received: by 2002:a9d:344b:: with SMTP id v69mr1219764otb.41.1623382180014;
        Thu, 10 Jun 2021 20:29:40 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l24sm940271oii.45.2021.06.10.20.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:29:39 -0700 (PDT)
Date:   Thu, 10 Jun 2021 22:29:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
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
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: Added xo clock for eMMC and
 Sd card
Message-ID: <YMLYob1Qup4wHZqg@builder.lan>
References: <1623309107-27833-1-git-send-email-sbhanu@codeaurora.org>
 <dd685abc-c332-cd0c-af6a-d2f1116cef05@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd685abc-c332-cd0c-af6a-d2f1116cef05@somainline.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu 10 Jun 02:54 CDT 2021, Konrad Dybcio wrote:

> Hi,
> 
> 
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > @@ -701,8 +701,9 @@
> >  			interrupt-names = "hc_irq", "pwr_irq";
> >  
> >  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> > -					<&gcc GCC_SDCC1_AHB_CLK>;
> > -			clock-names = "core", "iface";
> > +					<&gcc GCC_SDCC1_AHB_CLK>,
> > +					<&rpmhcc RPMH_CXO_CLK>;
> 
> Don't these clocks fit in 100 chars?
> 

We typically list them on one line each, so I'm fine with that.

But all three clocks should be aligned.

> 
> 
> > +			clock-names = "core", "iface","xo";
> 
> A space is missing before "xo".
> 

Thanks for pointing this out.

I fixed up the indentation and applied the patch.

Regards,
Bjorn

> 
> 
> >  			interconnects = <&aggre1_noc MASTER_EMMC 0 &mc_virt SLAVE_EBI1 0>,
> >  					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_EMMC_CFG 0>;
> >  			interconnect-names = "sdhc-ddr","cpu-sdhc";
> > @@ -2666,8 +2667,9 @@
> >  			interrupt-names = "hc_irq", "pwr_irq";
> >  
> >  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> > -					<&gcc GCC_SDCC2_AHB_CLK>;
> > -			clock-names = "core", "iface";
> > +					<&gcc GCC_SDCC2_AHB_CLK>,
> > +					<&rpmhcc RPMH_CXO_CLK>;
> 
> Ditto
> 
> 
> 
> Konrad
> 
