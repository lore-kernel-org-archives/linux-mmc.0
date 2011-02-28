From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH] msm_sdcc: remove needless cache flush after
 dma_unmap_sg()
Date: Mon, 28 Feb 2011 18:04:37 +0530
Message-ID: <1298896477.15439.9.camel@stummala-linux.in.qualcomm.com>
References: <1297895333-5551-1-git-send-email-linus.walleij@linaro.org>
	 <AANLkTikju_TmJpPceg0BNvfGx1w1yuNUZcqcSc1ttLhv@mail.gmail.com>
	 <1298896097.15439.7.camel@stummala-linux.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1298896097.15439.7.camel@stummala-linux.in.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, San Mehat <san@google.com>, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Adding MSM list to the thread.

On Mon, 2011-02-28 at 17:58 +0530, Sahitya Tummala wrote:
> On Sat, 2011-02-26 at 13:01 +0100, Linus Walleij wrote:
> > On Wed, Feb 16, 2011 at 11:28 PM, Linus Walleij
> > <linus.walleij@linaro.org> wrote:
> > 
> > > dma_unmap_sg() already flushes the cache, I don't get what this
> > > code is doing here.
> > >
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Any feedback on this? I'd prefer the maintainer(s) Acked-by,
> > but the patch is pretty clear as it stands I believe and I will
> > request Chris to include it anyway, intuitively it is correct.
> 
> Hi Linus Walleij,
> 
> You are right. This patch looks good.
> 
-- 
Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.

