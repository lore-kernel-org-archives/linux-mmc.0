Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA9C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BAF611C4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbhIQRLE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhIQRLD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Sep 2021 13:11:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DFFC60F58;
        Fri, 17 Sep 2021 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631898581;
        bh=NpEKxjp9I+L4UooaH1nMDbAKoSdqZVGp40AAgxgeW6o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hQy4Tp/ITgbLlUCdiMbiL3iWZYoZuHa3Qhy0QL5OYjl0BywxPbhspzClFDot88mnq
         UTqNuug/HUlfoiQpuRVtFkztt7436k+Kw+PKXfUS1qS7pUuBCcd4ZZ7u1Y31tKkWs+
         8j6dr1Y+DyQ3SdGWNH8qzZAf4DQjtui/DrxAdjMfXBCBuNZPKFE4jkaZdHqPX+bhyl
         /TTyT2jMllXZc1nKJ9dAa49bvYAjVkSHmT475PvD45yHwyrByzH0a6WnL8Hj/CrRnz
         K7FFJHu3QNP+SFzwgqNf+JZsoGyVUkJ5MBATJZ7FlL9MlDBsZwWTjLvPm+h6VeqdYH
         PkqZ7uf4e2EuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4ADB95C0A30; Fri, 17 Sep 2021 10:09:41 -0700 (PDT)
Date:   Fri, 17 Sep 2021 10:09:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
Message-ID: <20210917170941.GR4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210917163245.f53fh2nuswqlkwgw@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917163245.f53fh2nuswqlkwgw@e107158-lin>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 17, 2021 at 05:32:45PM +0100, Qais Yousef wrote:
> Hi Paul
> 
> On 08/18/21 08:43, Paul E. McKenney wrote:
> > On Wed, Aug 18, 2021 at 12:18:25PM -0300, Fabio Estevam wrote:
> > > Hi,
> > > 
> > > When launching the hostapd application on a i.MX7 based board with an
> > > ath10k device connected via SDIO, the following "NOHZ tick-stop error"
> > > messages are seen:
> > > 
> > > # hostapd /etc/wifi.conf
> > > Configuration file: /etc/wifi.conf
> > > wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
> > > [   63.021149] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
> > > [   67.332470] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> > > wlan0: interface state COUNTRY_UPDATE->ENABLED
> > > wlan0: AP-ENABLED
> > > [   68.025845] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   69.025973] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   69.607432] cfg80211: failed to load regulatory.db
> > > [   72.026748] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   73.027039] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   74.027159] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   75.027109] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   76.027461] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   77.027391] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > [   78.027560] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, handler #08!!!
> > > 
> > > This happens on all kernel versions from 5.10  to 5.13.
> > > 
> > > Any ideas on how to fix this problem?
> > 
> > I believe that you need this commit (and possibly some prerequsites):
> > 
> > 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
> > 
> > Adding Qais on CC for his thoughts.
> 
> Sorry for the late response. A combination of holidays and sickness kept me
> away from email for a while.
> 
> I did see an issue on 5.10 recently but I was running android kernel. I thought
> initially the problem is similar to the upstream one we were seeing on mainline
> for a while in the past but it turned out a genuine bug due to a patch that
> tries to 'fix' softirq interference with RT. Reverting that patch fixed the
> issue for me. It turned out later that it was specific to the platform I was
> running on and it's not reproducible by others on other platforms.
> 
> Upstream 5.10-LTS was fine for me.
> 
> HTH.

Good to hear that you found the problem and fixed it!

							Thanx, Paul
