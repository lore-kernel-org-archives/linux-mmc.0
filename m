Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07CCC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 13:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJSNYo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiJSNY1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 09:24:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086C631E8
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 06:10:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so16724264pjl.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/lqmtSmjnDpSy8e2ah3ZGeXF+U7z7p+73S0gKH8I72Q=;
        b=oGFhXXxz5t8xxnnHRQNNwMxIQw8Eqe3xQ/dfnw7fm/cl2TdVCy9SQXVgeVGIQJ7obz
         LzLKINkD/DbU79cKV+GfmHusRwGWAnYurApfAUM6DS69HH9zA2dW2g/f/d3UiWPpJe0s
         5K0hiXH/4zwFFZ5Eg1vjIW7vtYEZpOq7ngeJKRUFrGGWSOnG+uyEZUWcrHJmGu61j+Et
         elfCfnb+BbDc3iuzSMSBbuir+GZUwlWTsf3LLBOo/YRMiNPTnAkDGEMbMmUe93KtuTho
         UahIv2UTcEYIlTrrcAFAIOhCtAo3h/UBGdwbSB/DEcOOXCrP3eLWmHKo9Q53J41TRKG5
         4auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lqmtSmjnDpSy8e2ah3ZGeXF+U7z7p+73S0gKH8I72Q=;
        b=BxzG0JC0ka9ORCtCHKZu5uvpH0LHhNsr7EwQW3fcyDXiUhJGb6qFV/czdk7ovOpAK8
         rI+2CU7XLkf7vxKN8yDCTjpEZp1pKw/ysu6x6BnqSumUtEEjKB+jkt5k50ivgb54YrvC
         HARmwXP+Mddo3vCDCd3F9vy0LJfl8TD4M4pZaYRjSP1xWgmZCCQGu6vjGd/TMTRwCSvb
         ByXNNeyJeulf7LyiThUW9ScYzjNVWqluFIoij88IHiD7Rvns40rNmBoS5uFGDKFZTpMS
         IkqliIQg9qiO2QZsFHxIeuEtmpxQZhuqT6arEVBWqfpAaWuv1OTtqRUd4rZPs3ykyUvE
         NP+Q==
X-Gm-Message-State: ACrzQf3REmPdZ8tQbdbi7o2tmUyuOlr59IuhXta4f8kThNttI0x8SMsA
        AVIneYm+fURyQUntuzQbvBpyagVyYO9IIv2LgKE=
X-Google-Smtp-Source: AMsMyM4yVrVoJxuQnVtgPinIx77iK1UoEcHSngq9uDGGKYpLHfopVDyiHg1FoYlhEt5UDujiOG8guamGL9GV8IfPsVs=
X-Received: by 2002:a17:90b:1d0e:b0:20d:a61f:84b1 with SMTP id
 on14-20020a17090b1d0e00b0020da61f84b1mr37260791pjb.172.1666185016511; Wed, 19
 Oct 2022 06:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
 <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com>
 <CAOMZO5CYvbd3uTKxq6suyn5H0yNU1R7tsgbawNdwjEbKgdt6bg@mail.gmail.com>
 <CAOMZO5C-5M8y=V1L6Qdqymhb-1oOpBszFwuWCxedUJ1oO7=ADw@mail.gmail.com> <DB7PR04MB4010FBDF45A7BDD40D02004E902B9@DB7PR04MB4010.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4010FBDF45A7BDD40D02004E902B9@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Oct 2022 10:10:07 -0300
Message-ID: <CAOMZO5AvRHyeJCQemXnab3Z8n=-9eKDKYqA=CRbMEhG89QEvFQ@mail.gmail.com>
Subject: Re: imx7d: Timeout waiting for hardware interrupt.
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

On Wed, Oct 19, 2022 at 7:48 AM Bough Chen <haibo.chen@nxp.com> wrote:

> Hi Fabio,
>
> Yes, I think imx7d also has this limitation. Can you check whether the ipg and ahb clock source from pll_drm_533_clk on 5.10 stable tree?
>
>
>  67static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
>  68         "pll_dram_533m_clk", "pll_sys_main_240m_clk",
>  69         "pll_sys_pfd2_135m_clk", "pll_sys_pfd6_clk", "pll_enet_250m_clk",
>  70         "pll_audio_post_div", };
>  71
>  72 static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
>  73         "pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
>  74         "pll_enet_250m_clk", "pll_usb_main_clk", "pll_audio_post_div",
>  75         "pll_video_post_div", };

By default, on imx7 the ahb_root_clk and nand_usdhc_root_clk have the
same pll_sys_pfd2_270m_clk parent:

             pll_sys_pfd2_270m_clk       1        1        0
270000000          0     0  50000
                nand_usdhc_src        0        0        0   270000000
        0     0  50000
                   nand_usdhc_cg       0        0        0   270000000
         0     0  50000
                      nand_usdhc_pre_div       0        0        0
270000000          0     0  50000
                         nand_usdhc_root_clk       0        0        0
  270000000          0     0  50000
                            nand_usdhc_rawnand_clk       0        0
    0   270000000          0     0  50000
                ahb_src               1        1        0   270000000
        0     0  50000
                   ahb_cg             1        1        0   270000000
        0     0  50000
                      ahb_pre_div       1        1        0
270000000          0     0  50000
                         ahb_root_clk       2        3        0
135000000          0     0  50000

So they satisfy the condition requested by the erratum.

Do you know if we should increase the interrupt timeouts like the done
in the MSM driver?

commit 3f8920c5706e9a688705b6217996cde01e851591
Author: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Date:   Fri Jul 16 17:16:14 2021 +0530

    mmc: sdhci-msm: Update the software timeout value for sdhc

    [ Upstream commit 67b13f3e221ed81b46a657e2b499bf8b20162476 ]

    Whenever SDHC run at clock rate 50MHZ or below, the hardware data
    timeout value will be 21.47secs, which is approx. 22secs and we have
    a current software timeout value as 10secs. We have to set software
    timeout value more than the hardware data timeout value to avioid seeing
    the below register dumps.

    [  332.953670] mmc2: Timeout waiting for hardware interrupt.
    [  332.959608] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
    [  332.966450] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00007202
    [  332.973256] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
    [  332.980054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000027
    [  332.986864] mmc2: sdhci: Present:   0x01f801f6 | Host ctl: 0x0000001f
    [  332.993671] mmc2: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
    [  333.000583] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
    [  333.007386] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
    [  333.014182] mmc2: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
    [  333.020976] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
    [  333.027771] mmc2: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x0000808f
    [  333.034561] mmc2: sdhci: Cmd:       0x0000183a | Max curr: 0x00000000
    [  333.041359] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
    [  333.048157] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
    [  333.054945] mmc2: sdhci: Host ctl2: 0x00000000
    [  333.059657] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
    0x0000000ffffff218
    [  333.067178] mmc2: sdhci_msm: ----------- VENDOR REGISTER DUMP
    -----------
    [  333.074343] mmc2: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
    0x6000642c | DLL cfg2: 0x0020a000
    [  333.083417] mmc2: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
    0x00000000 | DDR cfg: 0x80040873
    [  333.092850] mmc2: sdhci_msm: Vndr func: 0x00008a9c | Vndr func2 :
    0xf88218a8 Vndr func3: 0x02626040
    [  333.102371] mmc2: sdhci: ============================================

    So, set software timeout value more than hardware timeout value.

    Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
    Acked-by: Adrian Hunter <adrian.hunter@intel.com>
    Cc: stable@vger.kernel.org
    Link: https://lore.kernel.org/r/1626435974-14462-1-git-send-email-sbhanu@codeaurora.org
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

Or any other suggestions?

Thanks
