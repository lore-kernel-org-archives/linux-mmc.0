From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 3/5] mmc: mmci: relax blksz check for SDIO
Date: Wed, 13 Aug 2014 10:54:52 +0200
Message-ID: <CACRpkdaWkTp399GoHRifVQJE8WNrYf4GWyThMEg6ZVuy9_H=Tg@mail.gmail.com>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
	<1407845080-8353-1-git-send-email-srinivas.kandadgatla@linaro.org>
	<20140812141242.GI30401@n2100.arm.linux.org.uk>
	<53EAF444.8050507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53EAF444.8050507@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 13, 2014 at 7:14 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> In the past Ulf Hansson and Stefan Nilsson have submitted a patch to fix
> this issue for ux500v2. This patch adds new flag non_power_of_2_blksize /
> any_blksize to variant_data.

That's the right approach. It makes non-2^n support the exception rather
than the rule and applies only to the variants relevant so the logic is right.

Yours,
Linus Walleij
