From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: db1235: Don't use MMC_CLKGATE
Date: Wed, 2 Oct 2013 11:24:57 +0200
Message-ID: <20131002092457.GB23236@linux-mips.org>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
 <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:37971 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3JBJZF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 05:25:05 -0400
Received: from localhost.localdomain ([127.0.0.1]:45777 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6838727Ab3JBJZDjcqRl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Oct 2013 11:25:03 +0200
Content-Disposition: inline
In-Reply-To: <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org

On Mon, Sep 30, 2013 at 04:41:59PM +0200, Ulf Hansson wrote:

> As a first step in removing code for MMC_CLKGATE, MIPS db1235 defconfig
> which is the only current user, shall move away from this option.
> 
> The mmc host drivers au1xmmc and jz4740_mmc, which are used on MIPS
> don't support clock gating through MMC_CLKGATE, thus removing the
> config option will have no effect on power save - clock gating wise.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to feed this MIPS patch to Linus via the MMC tree.

  Ralf
