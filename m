From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
Date: Wed, 17 May 2017 13:19:56 +0300
Message-ID: <9a1fdf1f-cf44-5aa5-f2a3-5e5a0a05777a@intel.com>
References: <20170516061720.1755-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35826 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbdEQKZs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 May 2017 06:25:48 -0400
In-Reply-To: <20170516061720.1755-1-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, huziji@marvell.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 16/05/17 09:17, Jisheng Zhang wrote:
> Currently, the xenon_clean_phy() is only used for freeing phy_params.
> The phy_params is allocated by devm_kzalloc(), there's no need to free
> is explicitly.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

