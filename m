Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DA2C4321E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Dec 2022 11:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLALA2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLAK74 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 05:59:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C2A0BE1
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 02:59:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so1685010pjb.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvLyS63D83ziQ1ifxnZ+NeidpCYMHNHJhmvj1+Etfgk=;
        b=VsbV2rr0OK5LTbl6GIL9qz8CbZJS3+ZfT9zt9OJ6OLcH7hFBRpKb68rOYPSWUfqod0
         4p2Omz49XnJkcXfK4PRV5UsFaGQigFCHiyoJd/7JkRMo9ABWRZjYUSdBd1hLDCkkhi8s
         pcWhMhtuoFVIFJzTXraItbABBZ/gu6FhGkc5/Wm5fUV49mQlh8HOxcaDCXTagCxncMRQ
         VOzD6L3cmziXNktbDKEkO0a1APC6cHu9HjuDfjA3WDXdiuExM4cZZF+aJ4o4qphh4Qp6
         XSTlkpER489bEeCH4cRPboLsOtNqcuwGWKWiMjx+KIkadpGkCya3lKUVUODcDNP9i99D
         TrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvLyS63D83ziQ1ifxnZ+NeidpCYMHNHJhmvj1+Etfgk=;
        b=NQROmbE96pUGC7NT23NpvBpmFe83gFOkuRHAMbWs8OtuOsPZs0JmqOF3huZg9xJHxj
         b1IK/pSd6/c5z+U6DrgOqnokpm2nuKbh+azondvyu5WsoH/NiQSu80aBF4a+EZjOs7CW
         EHMOBg8RGzO3JHOiVqaJX7dfsbrnRkK9C3DowyRlK6i5II1rMp5G/qcyRHfQD9h7uG0n
         bWkWz4J3/gY9rCNzj/x5iNBWQHqot/t+MSduXf0P7X4JpVEoWsEfDRA8cd1UDgEUbFiS
         wuMjDoGXJ5UFyRqlluaePYgN7xCW1gbJ+c/9wCzTYQOQ0NYtaEcJLftpaYexHNib90WO
         TvVg==
X-Gm-Message-State: ANoB5pmrqKyDm9FvR5gu851fHZCu3foumh261XNke7j6X5nBxxF67yCK
        au7+Ri3a3Pp+vhWKGW6dBKeWjkAm0lotheZFF6+WzA==
X-Google-Smtp-Source: AA0mqf5uWEpafTikpOQusuZUagMDIabJD/f4+9Qck/xjnV2vqtboCJ5sO8McWX63lO5AovyWvGT2UrvNBk2T8Bf0ik0=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr68417624pjq.202.1669892364037; Thu, 01
 Dec 2022 02:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com> <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com> <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
 <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com> <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
 <962458b5-c891-e552-5469-1dbb650a0f3c@gmail.com> <CAOX2RU5OBJyWb_K=b7OO9WKVog8e2kMT50F9PndWcQ+gd=OfPQ@mail.gmail.com>
 <efe523e8-ec02-774b-6348-700e0cfc3345@intel.com>
In-Reply-To: <efe523e8-ec02-774b-6348-700e0cfc3345@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Dec 2022 11:58:47 +0100
Message-ID: <CAPDyKFpZKS27aXcGZubUJJ2Rse0e-KNN4+e1tm6-rO+2QrXYWQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Robert Marko <robimarko@gmail.com>,
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

Sounds reasonable. I have dropped the patch for now.

If we try something like this again later, perhaps better to do that a
bit earlier in the release cycle to get it more tested in linux-next
too.

Kind regards
Uffe
