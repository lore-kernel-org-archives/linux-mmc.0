From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Fix calc_max_discard.
Date: Wed, 14 Dec 2016 09:19:46 +0200
Message-ID: <8d4b89c1-678d-f85d-29b9-e2b8a5a3b40c@intel.com>
References: <1481656818-21141-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9404 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbcLNH2P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Dec 2016 02:28:15 -0500
In-Reply-To: <1481656818-21141-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>, dianders@chromium.org, hisanao.kinkawa@toshiba.co.jp, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

On 13/12/16 21:20, Gwendal Grignou wrote:
> Working with a SDHCI controller and a Toshiba 16GB THGBMFG7C2LBAIL.
> The Toshiba part has a large erase group size and a long erase timeout.
> It barely fits within the controller timeout, but mmc reports a
> 512B discard size to the block layer instead of the expected 4MB:
> /sys/block/mmcblk0/queue/discard_max_bytes = 512
> 
> The host caps[0] is 0x...b2, so host->max_busy_timeout is set to
> 2684.35ms: (1 << 27 / ((0xb2 & 0x3f) * 1000).
> 
> In Toshiba EXT_CSD, HC_ERASE_GRP_SIZE is set to 7 (2100ms erase timeout)
> HC_ERASE_GRP_SIZE is set to 8, (8192 512B sectors erase size).
> 
> In mmc_do_calc_max_discard(), as a safety, for eMMC device, number of
> erase groups that could safely be erased with the host timeout (qty) was
> reduced by 1.

It was not for safety - it was to allow for crossing an erase group boundary.

But the current code is quite different now, so please have a look at that
because this code does not apply anymore.

