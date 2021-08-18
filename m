Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DFBC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B59610A1
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 15:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHRPod (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239819AbhHRPod (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 11:44:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E9DF60EFF;
        Wed, 18 Aug 2021 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629301438;
        bh=MwqiLS/+P5aIrGr3Qc5NcX2A3jn4UKNerJSZzZiOj/k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OAm2wOz9uDTfrQbewMMgZRbK28sOaLQyxRWyBHHX5DHuMhip+OhonIV19UofrK6O4
         br/W1qnbF4ARqUnHvijo3jMRX+fRaSrsDG0pMe6oKNQWgeHV5Es8lwTb9ZXnKtjtTX
         Kp54gJVHQWIIxqfGr0uZNH/G4sEnNSHkxOpoxysG+ZIGCIHd/1PgyT88jZRtvL02R5
         YSEbeIUxQETb713d3YZ0Y0RlUiSeg61YG6SCcnuZaFZFVNpBFlGAKiZ3e6/gW7MwFp
         yEyVpTIfAWjkFKolgac0HxFJIbattr2bWK7rxLNOmEeAWxYZBj8rC/xtt6vrV/0J+s
         R9EbRaiWD52Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E5B25C04B1; Wed, 18 Aug 2021 08:43:58 -0700 (PDT)
Date:   Wed, 18 Aug 2021 08:43:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com
Subject: Re: NOHZ tick-stop error with ath10k SDIO
Message-ID: <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 18, 2021 at 12:18:25PM -0300, Fabio Estevam wrote:
> Hi,
> 
> When launching the hostapd application on a i.MX7 based board with an
> ath10k device connected via SDIO, the following "NOHZ tick-stop error"
> messages are seen:
> 
> # hostapd /etc/wifi.conf
> Configuration file: /etc/wifi.conf
> wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
> [   63.021149] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> Using interface wlan0 with hwaddr 00:1f:7b:31:04:a0 and ssid "thessid"
> [   67.332470] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> wlan0: interface state COUNTRY_UPDATE->ENABLED
> wlan0: AP-ENABLED
> [   68.025845] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   69.025973] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   69.607432] cfg80211: failed to load regulatory.db
> [   72.026748] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   73.027039] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   74.027159] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   75.027109] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   76.027461] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   77.027391] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> [   78.027560] NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!
> 
> This happens on all kernel versions from 5.10  to 5.13.
> 
> Any ideas on how to fix this problem?

I believe that you need this commit (and possibly some prerequsites):

47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")

Adding Qais on CC for his thoughts.

							Thanx, Paul
