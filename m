From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Revert the sdr_timing assignment
Date: Sat, 26 Oct 2013 22:38:35 -0400
Message-ID: <871u37l9p0.fsf@octavius.laptop.org>
References: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53255 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab3J0Cil (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Oct 2013 22:38:41 -0400
In-Reply-To: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
	(Yuvaraj Kumar C. D.'s message of "Tue, 22 Oct 2013 14:41:56 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, thomas.ab@samsung.com, grundler@chromium.org, dianders@chromium.org, sonnyrao@chromium.org, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Hi Yuvaraj,

On Tue, Oct 22 2013, Yuvaraj Kumar C D wrote:
> commit 4ad602c9df1e3b04979c260b5612141b4b892257 was wrongly assigning
> ddr_timing value to sdr_timing.This patch fix's this by reverting
> the sdr_timing assignment statement to the earlier location.

4ad602c9df1e3 doesn't exist in mainline.  Do you mean e6c784eded7b3
("mmc: dw_mmc: exynos: move the exynos private init")?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
