From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] mmc: dw_mmc: Add MSHC compatible for Exynos4412
Date: Mon, 18 Feb 2013 22:36:43 +0000
Message-ID: <201302182236.43877.arnd@arndb.de>
References: <1361210793-5710-1-git-send-email-tobetter@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62775 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240Ab3BRWgz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 17:36:55 -0500
In-Reply-To: <1361210793-5710-1-git-send-email-tobetter@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dongjin Kim <tobetter@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Chris Ball <cjb@laptop.org>, Thomas Abraham <thomas.abraham@linaro.org>, Will Newton <will.newton@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 18 February 2013, Dongjin Kim wrote:
> 
> This patch adds the compatible string for MSHC controller of Exynos4412, and
> share the controller specific properties with Exynos5250 since they have same
> features. Its driver data name is changed to exynos_drv_data instead SoC
> specific name.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>

If they are completely compatibly, you can just list
"samsung,exynos4412-dw-mshc" in the compatible property of the
exynos5250 device tree, along with the other ones like:

	compatible = "samsung,exynos5250-dw-mshc", "samsung,exynos4412-dw-mshc", "snps,dw-mshc";

then you don't need to change the driver at all.

	Arnd
