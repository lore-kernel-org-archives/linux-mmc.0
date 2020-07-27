Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE15C433EA
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9602078E
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjuYOhxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgG0TKj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgG0TKe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2020 15:10:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5898EC0619D6
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2020 12:10:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so8627579pls.5
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2020 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ticL88R8RKVjHDYqCYmCobrUYUcpfnt5xb8RKMzCzX8=;
        b=hjuYOhxWkyxIkco7cz3flsCxvz6RvIAHgzIzkNfgT/x9e/YFx9ROmQLeBaibN/AKQl
         ggH65I1gR0cWWpulPuQvwAQeqlpl5ZyPDgty8hvNF6MJYWNnYWO7dS6mt4IGxRndNyne
         BScKhSPjV9rATxM4xUcrdiLZorsRsZxf3g2IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ticL88R8RKVjHDYqCYmCobrUYUcpfnt5xb8RKMzCzX8=;
        b=V6yFJWJ9PMY6OPz1YOXpx8//skZkVze0hcMnBN/6XgtF+NG+TqvE8wb0P2FxBu06lG
         wrgK9PeaJvxiqupymOOcGGeHiew3gplK2QTRjVae1HHlOzY9nfmQqFara5/islYXEQhX
         OFpb77eGYztRH1VKctp1rCBS9aR3SPQJEjrHNcuAGrJwYfJ3Qa5/dMTgGmLCTeqw8maQ
         cHmZdUYRvdwkEKHXF2fjBtPpAdCja/uziHOFAKDtHH7dPCMFLmFmRsQWperKitNZMF4i
         FfVVOHRR+SJHJcELXvtvUVQsed9S37OxGAm3M0a7Pw4D7tUwH3V9/4GamjL+OQO2tcnD
         QYag==
X-Gm-Message-State: AOAM533qBGH61O/g+22f5pV/8UC7xE9p3F/G1bYtwoP8Q0WJZv1joIAr
        ZuScRCks9SFt/5fkIkGl853wquVsJ/k=
X-Google-Smtp-Source: ABdhPJzhN2J2URR4fF9kWcorXsxPGq7WahUMX2XK2Ft+FbSesYam4d3A186M8w/xW8iuE7/l28C8SQ==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr688207pjs.37.1595877032628;
        Mon, 27 Jul 2020 12:10:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id v28sm16425617pgn.81.2020.07.27.12.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:10:31 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:10:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     sbhanu@codeaurora.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rnayak@codeaurora.org,
        Pradeep P V K <ppvk@codeaurora.org>,
        devicetree-owner@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7180: Add bandwidth votes for
 eMMC and SDcard
Message-ID: <20200727191029.GA3191083@google.com>
References: <1595328381-29552-1-git-send-email-sbhanu@codeaurora.org>
 <20200724171018.GZ3191083@google.com>
 <7ffcb56e9e6723f4bae687e0f491cb93@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ffcb56e9e6723f4bae687e0f491cb93@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jul 27, 2020 at 12:20:38PM +0530, sbhanu@codeaurora.org wrote:
> On 2020-07-24 22:40, Matthias Kaehlcke wrote:
> > Hi Shaik,
> > 
> > On Tue, Jul 21, 2020 at 04:16:21PM +0530, Shaik Sajida Bhanu wrote:
> > > From: Pradeep P V K <ppvk@codeaurora.org>
> > > 
> > > Add the bandwidth domain supporting performance state and
> > > the corresponding OPP tables for the sdhc device on sc7180.
> > > 
> > > Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> > > Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> > > ---
> > > 
> > > Changes since V1:
> > > 	- Incorporated review comments by Bjorn Andersson.
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > index 68f9894..d78a066 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > > @@ -684,6 +684,9 @@
> > >  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> > >  					<&gcc GCC_SDCC1_AHB_CLK>;
> > >  			clock-names = "core", "iface";
> > > +			interconnects = <&aggre1_noc MASTER_EMMC &mc_virt SLAVE_EBI1>,
> > > +				<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_EMMC_CFG>;
> > > +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> > >  			power-domains = <&rpmhpd SC7180_CX>;
> > >  			operating-points-v2 = <&sdhc1_opp_table>;
> > > 
> > > @@ -704,11 +707,15 @@
> > >  				opp-100000000 {
> > >  					opp-hz = /bits/ 64 <100000000>;
> > >  					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <100000 100000>;
> > > +					opp-avg-kBps = <100000 50000>;
> > >  				};
> > > 
> > >  				opp-384000000 {
> > >  					opp-hz = /bits/ 64 <384000000>;
> > >  					required-opps = <&rpmhpd_opp_svs_l1>;
> > > +					opp-peak-kBps = <600000 900000>;
> > > +					opp-avg-kBps = <261438 300000>;
> > >  				};
> > >  			};
> > >  		};
> > > @@ -2476,6 +2483,10 @@
> > >  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> > >  					<&gcc GCC_SDCC2_AHB_CLK>;
> > >  			clock-names = "core", "iface";
> > > +
> > > +			interconnects = <&aggre1_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
> > > +				<&gem_noc MASTER_APPSS_PROC &config_noc	SLAVE_SDCC_2>;
> > > +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> > >  			power-domains = <&rpmhpd SC7180_CX>;
> > >  			operating-points-v2 = <&sdhc2_opp_table>;
> > > 
> > > @@ -2489,11 +2500,15 @@
> > >  				opp-100000000 {
> > >  					opp-hz = /bits/ 64 <100000000>;
> > >  					required-opps = <&rpmhpd_opp_low_svs>;
> > > +					opp-peak-kBps = <160000 100000>;
> > > +					opp-avg-kBps = <80000 50000>;
> > >  				};
> > > 
> > >  				opp-202000000 {
> > >  					opp-hz = /bits/ 64 <202000000>;
> > >  					required-opps = <&rpmhpd_opp_svs_l1>;
> > > +					opp-peak-kBps = <200000	120000>;
> > > +					opp-avg-kBps = <100000 60000>;
> > >  				};
> > >  			};
> > >  		};
> > 
> > Does the sdhci-msm driver actually have BW scaling support at this
> > point?
> > 
> 
> yes
> 
> > There is commit 4ece9795be56 ("mmc: sdhci-msm: Add interconnect
> > bandwidth scaling support"), whose commit message says "make sure
> > interconnect driver is ready before handling interconnect scaling.".
> > 
> > I haven't seen any patch adding the scaling support (supposedly by
> > adding dev_pm_opp_set_bw() calls?). Did I miss it? If not it seems
> > it would make sense to post it in a series together with this patch,
> > as far as I can tell this patch alone does nothing in practical terms.
> > 
> > grep sdhc /sys/kernel/debug/interconnect/interconnect_summary
> >   8804000.sdhci                          0            0            0
> >   7c4000.sdhci                           0            0            0
> >   7c4000.sdhci                           0            0            0
> >   8804000.sdhci                          0            0            0
> >   ...
> 
> "mmc: sdhci-msm: Use OPP API to set clk/perf
> state"(https://lkml.org/lkml/2020/4/8/425) and "mmc: sdhci-msm: Add
> interconnect bandwidth scaling support"(https://lkml.org/lkml/2020/3/12/60)
> with these two patches scaling will be supported for sdhci-msm driver.

Are you testing with exactly these patches or with the ones that landed
upstream? At least the second one changed substantially

> the values  in  grep sdhc
> /sys/kernel/debug/interconnect/interconnect_summary will be zero during
> device is in suspend state...

Yes, I forgot to mention that I started MMC IO before looking at
'interconnect_summary'.

> and the values in  grep sdhc
> /sys/kernel/debug/interconnect/interconnect_summary during device in resume
> state will be like the following::
> 
> cicalhost / # cat /sys/kernel/debug/interconnect/interconnect_summary | grep
> sdh
>   8804000.sdhci                          0        60000       120000
>   7c4000.sdhci                           0       300000       900000
>   7c4000.sdhci                           0       300000       900000
>   8804000.sdhci                          0        60000       120000
>   8804000.sdhci                          0       100000       200000
>   7c4000.sdhci                           0       261438       600000
>   8804000.sdhci                          0        60000       120000

On my system the bandwidth is never set:

3.590152] sdhci_msm 7c4000.sdhci: DBG: old/new frequencies (384000000 Hz) are same, nothing to do
https://elixir.bootlin.com/linux/v5.7.8/source/drivers/opp/core.c#L847

This happens every time, even after the bandwith is set to 0. The problem
seems to be that opp_table->clk doesn't change for target_freq = 0.

My system is based on v5.4, so it is possible that my kernel is missing some
relevant patch from upstream.
