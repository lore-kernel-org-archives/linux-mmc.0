From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 03/15] ARM: davinci: Don't rely on public mmc header to
 include interrupt.h
Date: Fri, 13 Jan 2017 19:08:41 +0530
Message-ID: <d1b15248-4609-e0a1-49b3-41605f5eefd3@ti.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:38952 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdAMNjS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:39:18 -0500
In-Reply-To: <1484313256-25993-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org

On Friday 13 January 2017 06:44 PM, Ulf Hansson wrote:
> The davinci board omapl138-hawk, depends on interrupt.h. Explicitly include
> it instead of relying on the public mmc header host.h.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Additionally checked that 02/15 and 03/15 do not clash with anything I
have queued so far. And built test my tree + these two patches with
davinci_all_defconfig.

Thanks,
Sekhar
