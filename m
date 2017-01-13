From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 02/15] ARM: davinci: Don't rely on public mmc header to
 include leds.h
Date: Fri, 13 Jan 2017 18:56:12 +0530
Message-ID: <ccc2cc5c-b9a9-aca2-9677-22c5cd698ad7@ti.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:37224 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdAMN0s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:26:48 -0500
In-Reply-To: <1484313256-25993-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org

On Friday 13 January 2017 06:44 PM, Ulf Hansson wrote:
> Some of the davinci boards, da850-evm, dm644x-evm and neuros-osd2 depends
> on leds.h. Explicitly include it instead of relying on the public mmc
> header host.h.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
