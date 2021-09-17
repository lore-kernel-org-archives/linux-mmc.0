Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD3C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629CF61108
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 16:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhIQQeL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:34:11 -0400
Received: from foss.arm.com ([217.140.110.172]:55128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhIQQeL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Sep 2021 12:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E62101E;
        Fri, 17 Sep 2021 09:32:48 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E116D3F59C;
        Fri, 17 Sep 2021 09:32:47 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:32:45 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
Message-ID: <20210917163245.f53fh2nuswqlkwgw@e107158-lin>
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Paul

On 08/18/21 08:43, Paul E. McKenney wrote:
> On Wed, Aug 18, 2021 at 12:18:25PM -0300, Fabio Estevam wrote:
> > Hi,
> > 
> > When launching the hostapd application on a i.MX7 based board with an
> > ath10k device connected via SDIO, the following "NOHZ tick-stop error"
> > messages are seen:
> > 
> > # hostapd /etc/wifi.conf
> > Configuration file: /etc/wifi.conf
> > wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
> > [   63.021149] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
> > [   67.332470] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> > wlan0: interface state COUNTRY_UPDATE->ENABLED
> > wlan0: AP-ENABLED
> > [   68.025845] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   69.025973] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   69.607432] cfg80211: failed to load regulatory.db
> > [   72.026748] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   73.027039] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   74.027159] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   75.027109] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   76.027461] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   77.027391] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > [   78.027560] NOHZ tick-stop error: Non-RCU local softirq work is
> > pending, handler #08!!!
> > 
> > This happens on all kernel versions from 5.10  to 5.13.
> > 
> > Any ideas on how to fix this problem?
> 
> I believe that you need this commit (and possibly some prerequsites):
> 
> 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
> 
> Adding Qais on CC for his thoughts.

Sorry for the late response. A combination of holidays and sickness kept me
away from email for a while.

I did see an issue on 5.10 recently but I was running android kernel. I thought
initially the problem is similar to the upstream one we were seeing on mainline
for a while in the past but it turned out a genuine bug due to a patch that
tries to 'fix' softirq interference with RT. Reverting that patch fixed the
issue for me. It turned out later that it was specific to the platform I was
running on and it's not reproducible by others on other platforms.

Upstream 5.10-LTS was fine for me.

HTH.

Thanks

--
Qais Yousef
