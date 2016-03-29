From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 3/5] mmc: tegra: implement UHS tuning
Date: Tue, 29 Mar 2016 17:37:45 +0100
Message-ID: <56FAAF59.8080501@nvidia.com>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
 <1450809664-11360-4-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16781 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384AbcC2Qhv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 12:37:51 -0400
In-Reply-To: <1450809664-11360-4-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Lucas,

On 22/12/15 18:41, Lucas Stach wrote:
> This implements the UHS tuning sequence in a similar way to the one
> contained in the TRM. It deviates in the way how to check if the tap
> value is passing, by using the common Linux MMC function, which does
> not only check for data CRC errors, but also if the received block
> pattern is correct.
>=20
> Signed-off-by: Lucas Stach <dev@lynxeye.de>

I have been investigating a hang that occurs randomly during
system-suspend on Tegra124 Jetson TK1 (I have also reproduced the
problem on Tegra124 Nyan Big as well) with -next. The problem does not
occur on every suspend transition but if I execute 100 transitions I
will typically see it at some point. For example ...

count=3D0; while [ $count -lt 100 ]; do rtcwake -d rtc0 -m mem -s 3; ec=
ho
Suspend iteration $count; count=3D`expr $count + 1`; done

I was able to bisect this problem down to RMK's commit 71fcbda0fcdd
(=93mmc: sdhci: fix command response CRC error handling=94). However,
looking at RMK's change, I believe that this commit is not the problem
but has exposed a problem with the tegra SDHCI driver.

When the hang occurs I always see the following when starting the
suspend sequence and after which the system continues to suspend but
never exits suspend:

	mmc0: Timeout waiting for hardware interrupt.

The above message is a symptom of RMK's commit and I have found that
when I see this, it always occurs during tegra_sdhci_execute_tuning()
because sometimes we get a CRC error.

I don't fully understand why the hang occurs in suspend, but putting
this aside (as well as the CRC error and timeout), the more I look at
the tuning code, the more it appears incomplete. Unfortunately, the
Tegra TRM alone does not give the complete procedure for performing the
tuning because there can be multiple windows where the tap values may
pass and these windows will vary with voltage/frequency. Plus we need t=
o
ensure that the window is greater than a minimum width of 4 valid tap
values. The 3.18 kernel that is used for chrome-os products with
Tegra has a more complete implementation that is a good reference
(although not that easy to follow without good documentation!) [0].

We would definitely like to get this working in the mainline and I am
not sure if this is something that you are keen to spend time on or not=
?
Let me know and we can decide what makes most sense here.

Cheers
Jon

[0]
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-3.10/drivers/mmc/host/sdhci-tegra.c


