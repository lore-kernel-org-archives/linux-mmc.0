From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode
 switch"
Date: Thu, 20 Oct 2016 16:17:15 +0100
Message-ID: <bb6c1f05-d81c-4284-5831-c9d49bf038f3@linaro.org>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On 17/10/16 15:32, Linus Walleij wrote:
> Hi Chaotian,
>
> my Dragonboard 8060 has a regression on detecting the eMMC after
> bisecting it down to this patch (which is sadly already in v4.8):
>
> commit 08573eaf1a70104f83fdbee9b84e5be03480e9ed
> Author: Chaotian Jing <chaotian.jing@mediatek.com>
> Date:   Thu May 19 16:47:41 2016 +0800
> mmc: mmc: do not use CMD13 to get status after speed mode switch
>
> Before this patch the eMMC is detected and all partitions enumerated
> immediately, but after the patch it doesn't come up at all, except
> sometimes, when it appears minutes (!) after boot, all of a sudden.
>
> Do you have any ideas on what can be wrong?

I remember hitting timeout issue with new version of eMMC on SD600c-eval 
board, this patch/hack fixed it for me.

https://git.linaro.org/people/srinivas.kandagatla/linux.git/commitdiff/e42d7427b9ce77174eef079be0e04e22bdb8fd07?hp=3e4bf0b78405694fd1ab4371c73e80932be21e3a


Also one more important thing was to do with regulator mode too. 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=93b8e6fda11757a20df21f3fc18e12789841f173

Can you give it a try.. If it works I can clean it up and send it for 
review.

Thanks,
srini

>
> This is the Qualcomm MMCI variant whid does *not* support
> busydetection in hardware.
>
> I will continue looking at it but would be happy for any hints on how to
> solve it, currently I cannot mount root off the eMMC because of this.


>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
