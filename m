From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] msm_sdcc: remove needless cache flush after dma_unmap_sg()
Date: Mon, 28 Feb 2011 10:54:02 -0500
Message-ID: <m3vd0417fp.fsf@pullcord.laptop.org>
References: <1297895333-5551-1-git-send-email-linus.walleij@linaro.org>
	<AANLkTikju_TmJpPceg0BNvfGx1w1yuNUZcqcSc1ttLhv@mail.gmail.com>
	<1298896097.15439.7.camel@stummala-linux.in.qualcomm.com>
	<1298896477.15439.9.camel@stummala-linux.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1298896477.15439.9.camel@stummala-linux.in.qualcomm.com>
	(Sahitya Tummala's message of "Mon, 28 Feb 2011 18:04:37 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, San Mehat <san@google.com>, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Feb 28 2011, Sahitya Tummala wrote:
>> > > dma_unmap_sg() already flushes the cache, I don't get what this
>> > > code is doing here.
>> > >
>> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> > 
>> > Any feedback on this? I'd prefer the maintainer(s) Acked-by,
>> > but the patch is pretty clear as it stands I believe and I will
>> > request Chris to include it anyway, intuitively it is correct.
>> 
>> Hi Linus Walleij,
>> 
>> You are right. This patch looks good.

Thanks, merged to mmc-next for .39.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
