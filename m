From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode switch"
Date: Mon, 24 Oct 2016 16:23:53 +0200
Message-ID: <CACRpkdYQPrDg3EJkKJ0YebjDjoojV0n_L+fsjnNDZBYk4tmibA@mail.gmail.com>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
 <bb6c1f05-d81c-4284-5831-c9d49bf038f3@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <bb6c1f05-d81c-4284-5831-c9d49bf038f3@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 20, 2016 at 5:17 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> I remember hitting timeout issue with new version of eMMC on SD600c-eval
> board, this patch/hack fixed it for me.
>
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/commitdiff/e42d7427b9ce77174eef079be0e04e22bdb8fd07?hp=3e4bf0b78405694fd1ab4371c73e80932be21e3a

This doesn't work for me, sadly. I reworked the patch to use the same
codeflow as the Ux500/ST variant and posted my patches, but still no
luck (hope it helps though, and just wanted to illustrate how I think the
final patch should look).

Are you sure the MMCI derivates on the APQ8060 and MSM8660 has this
extra "PROGDONE" bit? (I guess you have the SoC reference manual for
these, I don't...)

> Also one more important thing was to do with regulator mode too.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=93b8e6fda11757a20df21f3fc18e12789841f173

Since my rootfs does come up after the 20 minute timeout I do not thing
power surges are the cause. This problem seems SD600c-specific.

Yours,
Linus Walleij
