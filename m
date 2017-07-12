From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESEND PATCH v2 1/7] ARM: dts: rockchip: add cpu enable method for rk3228 SoC
Date: Thu, 13 Jul 2017 01:34:10 +0200
Message-ID: <48386264.sWdhVGKZz6@phil>
References: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com> <1498127402-6705-2-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55330 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750755AbdGLXeU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jul 2017 19:34:20 -0400
In-Reply-To: <1498127402-6705-2-git-send-email-frank.wang@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com

Am Donnerstag, 22. Juni 2017, 18:29:56 CEST schrieb Frank Wang:
> This patch sets PSCI as the default cpu enable-method for RK3228 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

I've seen the work on OP-TEE mainlining for the psci implementation
which seems to be progressing nicely and with the code in the open
now, it's possible to replace the firmware if needed.

So I've applied this patch for 4.14.


Heiko
