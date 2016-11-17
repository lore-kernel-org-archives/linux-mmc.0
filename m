From: Jeremy McNicoll <jmcnicol@redhat.com>
Subject: Re: [PATCH v8 00/16] mmc: sdhci-msm: Add clk-rates, DDR, HS400
 support
Date: Wed, 16 Nov 2016 16:08:53 -0800
Message-ID: <1993f1b4-2989-af06-a5f0-06170db7c333@redhat.com>
References: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753994AbcKQAI4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Nov 2016 19:08:56 -0500
In-Reply-To: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com

On 2016-11-16 8:00 AM, Ritesh Harjani wrote:
> Hi,
>
> This is v8 version of the patch series which adds support for MSM8996.
> Adds HS400 driver support as well.
> These are tested on internal msm8996 & db410c HW.
>
> Changes from v7 -> v8 :-
> 1. Added patch 005 to add dt bindings for xo_clock.
> 2. Added patch 009 to factor out sdhci_enable_clock as discussed on v7 series.
> 2.a. Modified patch 010 by making use of sdhci_enable_clock.
> 2.b. Addressed Stephen's comment on patch 010 to call clk_set_rate unconditionally.
> 3. Addressed Stephen comments to remove unncessary one line comments, braces and other
> minor comments.
> 4. Added changes from Jeremy in patch 002 for gcc-msm8994 as well for sdcc clk_rcg2_floor_ops.
> minor comments.
>
> v7 series was verified on msm8994 target by Jeremy McNicoll.


v7 was verified on my Nexus 5X (msm8992).

-jeremy

