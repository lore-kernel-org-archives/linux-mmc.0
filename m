Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18282C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 17:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiK3RYy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiK3RYw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 12:24:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD892A96D
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 09:24:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o12so8457828pjo.4
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAj12w4JxYlY8N7svFC8WvFNQuE+jR6L9oRtQKfbRIs=;
        b=LA+qnr18lG+ywpCq/cDdOhXORZI7X3O96I7ps6e0hf0V6dlCRq4WPxz1Sgeq5xYBAF
         HFVAawuLSZqWpsrvh5oMLV7JrPsRXn9b9hmLxmMNhR+3McR572U3StezdxGoxOxBdQfq
         NK4Y99Nu2KRRyEIkZN0C67m6+bN66wje7+SOAyKVcaK+Mv4cI4rRWl3kFH0Oag1hGdmH
         tx1SWC9hR1BcdYmcdN0HISLJsfS65x5JFPUPe1Y9dEuOkIasBjePDRKDz7SNnywoIejT
         IOXxIjPhjjnHID2aGsq2V1m28J04JC4ENhAw0AkAp3YhfA98MywyKLi8EcyltLBuAzy8
         TW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAj12w4JxYlY8N7svFC8WvFNQuE+jR6L9oRtQKfbRIs=;
        b=EsvLZOd0aFBAIIx6qOYiuqfWOcmLq1m8w6TaaqvDspbvwjVZkwdimKBDPv0/V4gtYL
         Ja7qv0+Kgn9b8FNiC8+MZzVmgtsIkwb2vq0iLSWO4rXe1CgMmicP5wy3iR5A2IF/rW/W
         KeyErwZ09sS0oHKCwYiPLzsBYePDrVuYPmagWkPgA982jB9mjLuGg1/jkQ9C03RTRvXn
         GYDG9hS+UIp4HrnpOXwrNjIWThKv6hiLHMpePqfXLDUwW7iWtRDHV5l6irXrJeXHS2qI
         tKs6X+oJmLZGlrafrpSu3aIJ8njrEoMJ50MJvdQ85WSRa152RetoOepTM4KzJcgoO+vx
         Mfdg==
X-Gm-Message-State: ANoB5pkG0lzp3ck6fRdoYNkz5ta4MMHhsgEBzN2+3oRuxPolbwnfKm5l
        nVDwxSFTztoylK+PnhaE2YzYsQNcmhQOuJrhF4Q=
X-Google-Smtp-Source: AA0mqf7MtGofRfGUMVi8XY8SmkEZJp3WysW260EO7VuvFWQj+u3BkoTGrpLtsQi0fv0/Q7nJPVn0NU0WqKzo6tTUlu4=
X-Received: by 2002:a17:902:ebc1:b0:176:a6c5:20c9 with SMTP id
 p1-20020a170902ebc100b00176a6c520c9mr47017111plg.57.1669829090561; Wed, 30
 Nov 2022 09:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com> <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com> <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
 <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com>
In-Reply-To: <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 30 Nov 2022 18:24:39 +0100
Message-ID: <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 15:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 30/11/22 15:00, Robert Marko wrote:
> > On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 30/11/22 13:54, Robert Marko wrote:
> >>>
> >>> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
> >>>> Avoid re-configuring UHS and preset settings when the settings have not
> >>>> changed, irrespective of whether the clock is turning on.
> >>>>
> >>>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>
> >>> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
> >>> and reverting it makes the eMMC work again.
> >>>
> >>> I get a lot of:
> >>>
> >>> [    2.727287] mmc0: tuning execution failed: -5
> >>> [    2.727323] mmc0: error -5 whilst initialising MMC card
> >>> [    3.846540] mmc0: tuning execution failed: -5
> >>> [    3.846564] mmc0: error -5 whilst initialising MMC card
> >>> [    4.966517] mmc0: tuning execution failed: -5
> >>> [    4.966539] mmc0: error -5 whilst initialising MMC card
> >>> [    6.096486] mmc0: tuning execution failed: -5
> >>> [    6.096508] mmc0: error -5 whilst initialising MMC card
> >>> [    7.206431] mmc0: tuning execution failed: -5
> >>> [    7.206454] mmc0: error -5 whilst initialising MMC card
> >>
> >> Thanks for the report!  Are you able to debug this any more?
> >> What transfer mode is it? e.g. HS400?  Can you enable debug
> >> messages and get more information?
> >
> > With some guidance yes, it's in HS200 as there is an issue with HS400
> > to HS200 switch on this SoC so I have HS400 disabled.
> >
> > With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
> > messages.
>
> You should get a lot more with:
>
> CONFIG_DYNAMIC_DEBUG=y
>
> and kernel commandline option:
>
> dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"

Unfortunatelly not:
[    1.630829] mmc0: tuning execution failed: -5
[    1.634255] mmc0: error -5 whilst initialising MMC card
[    1.693655] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [    1.750807] udevd[123]: starting version 3.2.11
[    2.813509] mmc0: tuning execution failed: -5
[    2.813532] mmc0: error -5 whilst initialising MMC card
[    3.933817] mmc0: tuning execution failed: -5
[    3.933845] mmc0: error -5 whilst initialising MMC card
[    5.053732] mmc0: tuning execution failed: -5
[    5.053756] mmc0: error -5 whilst initialising MMC card
[    6.173933] mmc0: tuning execution failed: -5
[    6.173960] mmc0: error -5 whilst initialising MMC card
[    7.303852] mmc0: tuning execution failed: -5
[    7.303877] mmc0: error -5 whilst initialising MMC card
[    8.415565] mmc0: tuning execution failed: -5
[    8.415591] mmc0: error -5 whilst initialising MMC card
[    9.539392] mmc0: tuning execution failed: -5
[    9.539414] mmc0: error -5 whilst initialising MMC card
[   10.654012] mmc0: tuning execution failed: -5
[   10.654038] mmc0: error -5 whilst initialising MMC card
[   11.774310] mmc0: tuning execution failed: -5
[   11.774337] mmc0: error -5 whilst initialising MMC card
[   12.353608] random: crng init done
[   12.357231] udevd[124]: starting eudev-3.2.11
done
Starting watchdog...
Saving random seed: OK
Starting network: OK
Starting ntpd: OK
Unsupported board: qnap,301w
Starting dropbear sshd: OK

Welcome to Buildroot
buildroot login: [   12.896218] mmc0: tuning execution failed: -5
[   12.896243] mmc0: error -5 whilst initialising MMC card
[   14.016298] mmc0: tuning execution failed: -5
[   14.016323] mmc0: error -5 whilst initialising MMC card
[   15.136251] mmc0: tuning execution failed: -5
[   15.136276] mmc0: error -5 whilst initialising MMC card
[   16.256295] mmc0: tuning execution failed: -5
[   16.256318] mmc0: error -5 whilst initialising MMC card
[   17.376286] mmc0: tuning execution failed: -5
[   17.376310] mmc0: error -5 whilst initialising MMC card
[   18.496279] mmc0: tuning execution failed: -5
[   18.496301] mmc0: error -5 whilst initialising MMC card
[   19.616306] mmc0: tuning execution failed: -5
[   19.616331] mmc0: error -5 whilst initialising MMC card
[   20.736156] mmc0: tuning execution failed: -5
[   20.736180] mmc0: error -5 whilst initialising MMC card
[   21.856224] mmc0: tuning execution failed: -5
[   21.856249] mmc0: error -5 whilst initialising MMC card
[   22.976226] mmc0: tuning execution failed: -5
[   22.976251] mmc0: error -5 whilst initialising MMC card
[   24.096153] mmc0: tuning execution failed: -5
[   24.096179] mmc0: error -5 whilst initialising MMC card
[   25.216275] mmc0: tuning execution failed: -5
[   25.216299] mmc0: error -5 whilst initialising MMC card
[   26.336265] mmc0: tuning execution failed: -5
[   26.336289] mmc0: error -5 whilst initialising MMC card
[   27.456213] mmc0: tuning execution failed: -5
[   27.456238] mmc0: error -5 whilst initialising MMC card
[   28.576362] mmc0: tuning execution failed: -5
[   28.576388] mmc0: error -5 whilst initialising MMC card
[   29.696385] mmc0: tuning execution failed: -5
[   29.696408] mmc0: error -5 whilst initialising MMC card
[   30.816245] mmc0: tuning execution failed: -5
[   30.816271] mmc0: error -5 whilst initialising MMC card
[   31.936377] mmc0: tuning execution failed: -5
[   31.936402] mmc0: error -5 whilst initialising MMC card
[   33.056207] mmc0: tuning execution failed: -5
[   33.056232] mmc0: error -5 whilst initialising MMC card
[   34.176244] mmc0: tuning execution failed: -5
[   34.176268] mmc0: error -5 whilst initialising MMC card
[   35.296349] mmc0: tuning execution failed: -5
[   35.296374] mmc0: error -5 whilst initialising MMC card
[   36.416237] mmc0: tuning execution failed: -5
[   36.416265] mmc0: error -5 whilst initialising MMC card
[   37.536187] mmc0: tuning execution failed: -5
[   37.536213] mmc0: error -5 whilst initialising MMC card
>
>
