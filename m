From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH] msm_sdcc: remove needless cache flush after
 dma_unmap_sg()
Date: Mon, 28 Feb 2011 17:58:17 +0530
Message-ID: <1298896097.15439.7.camel@stummala-linux.in.qualcomm.com>
References: <1297895333-5551-1-git-send-email-linus.walleij@linaro.org>
	 <AANLkTikju_TmJpPceg0BNvfGx1w1yuNUZcqcSc1ttLhv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30313 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab1B1M20 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 07:28:26 -0500
In-Reply-To: <AANLkTikju_TmJpPceg0BNvfGx1w1yuNUZcqcSc1ttLhv@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, San Mehat <san@google.com>, "; linux-arm-msm"@vger.kernel.org

On Sat, 2011-02-26 at 13:01 +0100, Linus Walleij wrote:
> On Wed, Feb 16, 2011 at 11:28 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
> > dma_unmap_sg() already flushes the cache, I don't get what this
> > code is doing here.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Any feedback on this? I'd prefer the maintainer(s) Acked-by,
> but the patch is pretty clear as it stands I believe and I will
> request Chris to include it anyway, intuitively it is correct.

Hi Linus Walleij,

You are right. This patch looks good.

-- 
Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.

