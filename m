From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 01/21] sh: sh7724: Don't use a public mmc header for
 MMC_PROGRESS*
Date: Tue, 3 Jan 2017 10:24:39 +0100
Message-ID: <20170103092439.GH14032@verge.net.au>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:53181 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbdACJYp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2017 04:24:45 -0500
Content-Disposition: inline
In-Reply-To: <1483102054-1752-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On Fri, Dec 30, 2016 at 01:47:14PM +0100, Ulf Hansson wrote:
> The enum that specifies the MMC_PROGRESS* types, is a sh mmcif specific
> thing and has no relevance in a public mmc header. Currently it's used only
> by the sh romImage MMCIF boot, so let's instead define the enum in there
> and rename the types to MMCIF_* to show this.
> 
> Cc: linux-sh@vger.kernel.org
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

I assume there is also a patch to remove the enum from
include/linux/mmc/boot.h
