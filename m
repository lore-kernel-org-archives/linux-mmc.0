From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: reset tuning circuit when power
 on mmc card
Date: Tue, 18 Apr 2017 18:22:41 +0800
Message-ID: <20170418102241.GA19365@b29396-OptiPlex-7040>
References: <1492509931-3388-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35208 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdDRKWy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2017 06:22:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so32601663pge.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2017 03:22:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1492509931-3388-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org

On Tue, Apr 18, 2017 at 06:05:31PM +0800, Haibo Chen wrote:
> USDHC tuning circuit should be reset before every time card enumeration
> or re-enumeration.
> 
> SD3.0 card need tuning. For SDR104 card, when system suspend in standby
> mode, and then resume back, the IO timing is still SDR104(tuned) which
> may result in card re-enumeration fail in low card speed(400khz) for some
> cards. And we did meet the issue that in certain probability, SDR104
> card meet mmc command CRC/Timeout error when send CMD2 during mmc bus
> resume.
> 
> This patch reset the tuning circuit when the ios timing is
> MMC_TIMING_LEGACY/MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS, which means both
> mmc_power_up() and mmc_power_off() will reset the tuning circuit.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
