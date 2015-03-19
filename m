From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH] mmc: sdhci-msm: Add support for vendor capabilities registers
Date: Thu, 19 Mar 2015 10:55:55 -0700
Message-ID: <CAJAp7Og=56Zk5EfFwQXhU7rCdUCM4OXV9mhiuRFVthNUhR+3Mg@mail.gmail.com>
References: <1426769720-18657-1-git-send-email-georgi.djakov@linaro.org>
	<CAJAp7Oj9XMHcbsMGfTCUWoi5tGi=eR2AxG_0Bkn4tzAiks89xg@mail.gmail.com>
	<550AF78B.6020800@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <550AF78B.6020800@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 19, 2015 at 9:21 AM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
[..]
>> Does the 8916 board you have work without bumping the
>> regulator_set_load() (previously regulator_set_optimum_mode())? None
>> of my 8974 boards work reliably without it.
>
> My 8916 board seems to be working fine with this, at least when doing basic tests
> like mounting filesystems and file transfers. I'm not calling any regulator_set_load()
> functions. Is your board a dragonboard or something else? If you are doing any
> specific tests maybe i can try the same on my board?
>

My test setup is Xperia Z1, where I get issues when running with
hs200. On Xperia Z3 i can't even read out the partition table during
boot. I'm not sure what causes the difference to the dragonboard -
perhaps just different memories.

So I have a patch where I hook up the mmc framework with some calls to
regulator_set_load(), but it need some more love before I can send it
out. I postponed it due to the rework of regulator_set_optimum_mode()
that I did.

Regards,
Bjorn
