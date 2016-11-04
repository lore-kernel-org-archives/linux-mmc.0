From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] mmc: mmc: Use 500ms as the default generic CMD6 timeout
Date: Fri, 4 Nov 2016 13:13:53 -0700
Message-ID: <20161104201353.GD16026@codeaurora.org>
References: <1478280753-2482-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478280753-2482-1-git-send-email-ulf.hansson@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/04, Ulf Hansson wrote:
> In the eMMC 4.51 version of the spec, an EXT_CSD field called
> GENERIC_CMD6_TIME[248] was added. This allows cards to specify the maximum
> time it may need to move out from its busy state, when a CMD6 command has
> been sent.
> 
> In cases when the card is compliant to versions < 4.51 of the eMMC spec,
> obviously the core needs to use a fall-back value for this timeout, which
> currently is set to 10 minutes. This value is completely in the wrong range
> and importantly in some cases it causes a card initialization to take more
> than 10 minute to complete.
> 
> Earlier this scenario was avoided as the mmc core used CMD13 to poll the
> card, to find out when it stopped signaling busy. Commit 08573eaf1a70
> ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
> changed this behavior.
> 
> Instead of reverting that commit, which would cause other issues, let's
> instead start by picking a simple solution for the problem, by using a
> 500ms default generic CMD6 timeout.
> 
> The reason for using exactly 500ms, comes from observations that shows it's
> quite common for cards to specify 250ms. 500ms is two times that value so
> likely it should be enough for most cards.
> 
> Cc: <stable@vger.kernel.org> # v4.8+
> Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed
> mode switch")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

The 10 minute delay goes away and I see the card almost instantly
on my msm8960-cdp. I smoke tested on a couple other platforms
that weren't experiencing the problem and they seems fine too.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
