From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: increase the pad I/O drive
 strength for DDR50 card
Date: Tue, 18 Apr 2017 18:23:40 +0800
Message-ID: <20170418102340.GB19365@b29396-OptiPlex-7040>
References: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33607 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755382AbdDRKXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2017 06:23:47 -0400
Content-Disposition: inline
In-Reply-To: <1492427402-5506-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, tharvey@gateworks.com, stable@vger.kernel.org, linux-mmc@vger.kernel.org

On Mon, Apr 17, 2017 at 07:10:02PM +0800, Haibo Chen wrote:
> Currently for DDR50 card, it need tuning in default. We meet tuning fail
> issue for DDR50 card and some data CRC error when DDR50 sd card works.
> 
> This is because the default pad I/O drive strength can't make sure DDR50
> card work stable. So increase the pad I/O drive strength for DDR50 card,
> and use pins_100mhz.
> 
> Tested-and-reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v4.4+

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
