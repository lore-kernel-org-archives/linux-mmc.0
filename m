From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add a new compatible string for exynos5420
Date: Sun, 25 Aug 2013 00:22:09 -0400
Message-ID: <87ppt2pfgu.fsf@octavius.laptop.org>
References: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
	<1369389873-15018-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50600 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab3HYEWO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Aug 2013 00:22:14 -0400
In-Reply-To: <1369389873-15018-2-git-send-email-yuvaraj.cd@samsung.com>
	(Yuvaraj Kumar C. D.'s message of "Fri, 24 May 2013 15:34:32 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, jh80.chung@samsung.com, tgih.jun@samsung.com, thomas.ab@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>

Hi Yuvaraj,

On Fri, May 24 2013, Yuvaraj Kumar C D wrote:
> The Exynos5420 has a DWMMC controller which is different from prior
> versions.This patch adds a new compatible string for Exynos5420.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
