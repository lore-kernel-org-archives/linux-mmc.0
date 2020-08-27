Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C01DC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 06:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3425D20786
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 06:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgH0GqA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:46:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:3564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgH0Gp7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 27 Aug 2020 02:45:59 -0400
IronPort-SDR: UxdRk3eXKp44EuIdGe6/N7CSC0Okx5OasHBuyi5J3iZyw8C/bFJzakxE7MXATLwYg9/rmqx8Zq
 ReY3H39f7qPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144109102"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="144109102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 23:45:58 -0700
IronPort-SDR: bhh5IeRvAmjU2S8givn05HqpKnUHorYxlVY0p7rP2Tn8QhhVJFBnGpvTYH7lMm/wUXMEH+gUcm
 Mmwrulc9/cmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="337069793"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2020 23:45:51 -0700
Subject: Re: Broadcom WiFi SDIO performance regression after commit "mmc:
 sdhci: Remove finish_tasklet"
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5cf1af89-6026-09ad-7f20-82e19ad49fa1@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9332715c-6ee5-fce3-8b93-305823d5a551@intel.com>
Date:   Thu, 27 Aug 2020 09:45:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5cf1af89-6026-09ad-7f20-82e19ad49fa1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/08/20 9:07 am, Dmitry Osipenko wrote:
> Hello!
> 
> I was debugging WiFi performance problems on Acer A500 tablet device
> that has BCM4329 WiFi chip which is connected to NVIDIA Terga20 SoC via
> SDIO and found that the following commit causes a solid 5-10 Mbit/s of
> WiFi throughput regression after 5.2 kernel:

What is that in percentage terms?

> 
> commit c07a48c2651965e84d35cf193dfc0e5f7892d612
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Fri Apr 5 15:40:20 2019 +0300
> 
>     mmc: sdhci: Remove finish_tasklet
> 
>     Remove finish_tasklet. Requests that require DMA-unmapping or
> sdhci_reset
>     are completed either in the IRQ thread or a workqueue if the
> completion is
>     not initiated by the IRQ.
> 
> Reverting the offending commit on top of recent linux-next resolves the
> problem.
> 
> Ulf / Adrian, do you have any ideas what could be done in regards to
> restoring the SDIO performance? Should we just revert the offending commit?
> 

Unfortunately I think we are past the point of returning to the tasklet.

sdhci can complete requests in the irq handler but only if ->pre_req() and
->post_req() are used, which is not supported by SDIO at present.  pre_req
and post_req were introduced to reduce latency for the block driver, so it
seems reasonable perhaps to look at using them in SDIO as well.
