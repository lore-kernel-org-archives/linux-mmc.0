Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4354C43217
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 10:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiLAKtr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 05:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiLAKsw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 05:48:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17B8C444
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 02:48:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so1306731pgr.12
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JFHi+SvGwI1rfEOY9CnG9SQiWVATkN0Avu2bzkUODq0=;
        b=REJmmdkIL9XLClNj8D1a7+Tov+FPxEwMcRLyjnoMtS6DAX84BEn3GHRETkHwAI/06e
         QaSFdYf9ZG0Gy18t9gmztEDWfuPdB65DmofhMxUQX4PkIJynJKIj5XsU4AvmCdxGJFhE
         T+Ykg9uNrqk9reuFi6x+BjP/0PDoFgj2iBaUV2pbBIj7o34jm2VVhtG1FK3RbdBPSKWi
         jHhzJUZmjxKf8t+kEQgTqfFjnmXemHR+vEwKKAeRGKKu1fd9Q6EoPwXWk5PyX15UOASS
         8tzOJMpXv8B0biHE3A/TcZtAs/5CCtL9rHDp9P/odH0+Kg6M6BXAwZ/6HXsptxq7nWd5
         j+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFHi+SvGwI1rfEOY9CnG9SQiWVATkN0Avu2bzkUODq0=;
        b=YVEiaQaMVPQopev8T2MhBXnBnOL35gcoNJW9lMdB+fb0NZiiuNiHpGYiOC+reYWUx+
         73bDPt/FMk/5yQdT4A0M7sbrkvA78gooP6adVYn2PU/kgZfr3rPkpD8jb/2ybHD4eJhU
         2vaSdofVAH6l6D/+2/jtn++CWzDTGNo1Nh4+OyH+Yqh1P+NEAd5r3Kf4gbqXe9BEMlPk
         3Mqz8LA36wyRvzyj7hbo10jYyD+9kRDsJHUg007O5o0Scda5GA0E4MLIZ+3P2Hs2OYmZ
         gnX24ZZITgTshgDwKYbnwMT20bgjUA9DEyM9nwePp5cn/xut7KHSsoXSPZU23VKLjJTG
         VZTQ==
X-Gm-Message-State: ANoB5pmtdTjQmfcb9Vvq1aCAviroLWSOtgm+88148s6IlG90Nl7QWZS+
        4rHPe56s/9j1H42Su8B+zlDt7YXwBqTk2DAHnBA=
X-Google-Smtp-Source: AA0mqf6nqnXUHIqAHr2V67SEJaVdEYhQC/mAIBAcZ8xQdElNfpTJYWYU5bc/8aM7GUez7eQBDJb8y/yfexr9QTcrgd8=
X-Received: by 2002:a63:1f62:0:b0:477:f21a:56a9 with SMTP id
 q34-20020a631f62000000b00477f21a56a9mr24506356pgm.149.1669891713273; Thu, 01
 Dec 2022 02:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com> <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com> <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
 <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com> <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
 <962458b5-c891-e552-5469-1dbb650a0f3c@gmail.com> <CAOX2RU5OBJyWb_K=b7OO9WKVog8e2kMT50F9PndWcQ+gd=OfPQ@mail.gmail.com>
 <efe523e8-ec02-774b-6348-700e0cfc3345@intel.com>
In-Reply-To: <efe523e8-ec02-774b-6348-700e0cfc3345@intel.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 1 Dec 2022 11:48:22 +0100
Message-ID: <CAOX2RU60mau1kfFkPPvqwQvPy9Z6k=3h8UO_zAFe2c8ws_=TTQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sarthak Garg <sartgarg@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Dec 2022 at 09:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 30/11/22 21:56, Robert Marko wrote:
> > On Wed, 30 Nov 2022 at 19:39, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 11/30/22 09:24, Robert Marko wrote:
> >>> On Wed, 30 Nov 2022 at 15:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 30/11/22 15:00, Robert Marko wrote:
> >>>>> On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>>
> >>>>>> On 30/11/22 13:54, Robert Marko wrote:
> >>>>>>>
> >>>>>>> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
> >>>>>>>> Avoid re-configuring UHS and preset settings when the settings have not
> >>>>>>>> changed, irrespective of whether the clock is turning on.
> >>>>>>>>
> >>>>>>>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
> >>>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>>>
> >>>>>>> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
> >>>>>>> and reverting it makes the eMMC work again.
> >>>>>>>
> >>>>>>> I get a lot of:
> >>>>>>>
> >>>>>>> [    2.727287] mmc0: tuning execution failed: -5
> >>>>>>> [    2.727323] mmc0: error -5 whilst initialising MMC card
> >>>>>>> [    3.846540] mmc0: tuning execution failed: -5
> >>>>>>> [    3.846564] mmc0: error -5 whilst initialising MMC card
> >>>>>>> [    4.966517] mmc0: tuning execution failed: -5
> >>>>>>> [    4.966539] mmc0: error -5 whilst initialising MMC card
> >>>>>>> [    6.096486] mmc0: tuning execution failed: -5
> >>>>>>> [    6.096508] mmc0: error -5 whilst initialising MMC card
> >>>>>>> [    7.206431] mmc0: tuning execution failed: -5
> >>>>>>> [    7.206454] mmc0: error -5 whilst initialising MMC card
> >>>>>>
> >>>>>> Thanks for the report!  Are you able to debug this any more?
> >>>>>> What transfer mode is it? e.g. HS400?  Can you enable debug
> >>>>>> messages and get more information?
> >>>>>
> >>>>> With some guidance yes, it's in HS200 as there is an issue with HS400
> >>>>> to HS200 switch on this SoC so I have HS400 disabled.
> >>>>>
> >>>>> With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
> >>>>> messages.
> >>>>
> >>>> You should get a lot more with:
> >>>>
> >>>> CONFIG_DYNAMIC_DEBUG=y
> >>>>
> >>>> and kernel commandline option:
> >>>>
> >>>> dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
> >>>
> >>> Unfortunatelly not:
> >>
> >> Are you sure you have debug messages enabled with your current console
> >> loglevel? Might want to add "debug" at the end of your kernel command
> >> line and try again.
> >
> > Ok, so indeed debug was required, here is the huge bootlog now:
> > https://gist.github.com/robimarko/e370bce66d0d2e7e54a2f5daf9784ee4
>
> Thanks for the log!  It shows everything is OK up until the first
> (HS200) tuning.
>
> sdhci-msm takes the clock frequency into account when setting UHS
> signaling, refer sdhci_msm_set_uhs_signaling(), so that is
> presumably why the UHS signalling needs to be re-done even if
> only the clock frequency changes.
>
> It would be possible to change sdhci-msm to hook ->set_ios() and
> set host->reinit_uhs before calling sdhci_set_ios(), which should
> put back the original behaviour for sdhci-msm.
>
> However "mmc: sdhci: Avoid unnecessary re-configuration" is really
> a "nice-to-have" and it is not impossible other drivers are affected
> by something similar, but just haven't noticed.
>
> Consequently, I tend to think we should just drop the patch
> "mmc: sdhci: Avoid unnecessary re-configuration" ?

That works for me, as I am not skilled to update the sdhci-msm driver
instead.

Regards,
Robert
>
>
