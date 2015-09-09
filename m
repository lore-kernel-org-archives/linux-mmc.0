From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RESEND PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Wed, 09 Sep 2015 16:35:16 -0700
Message-ID: <7h4mj3kvyj.fsf@deeprootsystems.com>
References: <1441368795-21420-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36166 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbIIXfU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 19:35:20 -0400
Received: by padhk3 with SMTP id hk3so23631357pad.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2015 16:35:18 -0700 (PDT)
In-Reply-To: <1441368795-21420-1-git-send-email-kishon@ti.com> (Kishon Vijay
	Abraham, I's message of "Fri, 4 Sep 2015 17:43:15 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: arm@kernel.org, ulf.hansson@linaro.org, tony@atomide.com, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com

Kishon Vijay Abraham I <kishon@ti.com> writes:

> PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
> OMAP5 and DRA7 SoCs. Enable it here.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, added to our next/late branch.

Kevin
