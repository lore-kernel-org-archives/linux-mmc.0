From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v4 3/3] mmc: sdhci-of-arasan: add runtime pm support
Date: Tue, 15 Dec 2015 17:16:03 +0100
Message-ID: <CAPDyKFrHhxuoKXKRJfbLYOjb4dAByibfPdNV2BuoJrAM=xRZ8Q@mail.gmail.com>
References: <1445504810-5642-1-git-send-email-shawn.lin@rock-chips.com>
	<CAPDyKFqzA31PVdqw0mLi=ZOezcXH1hECHgzpMDzt_th4zdY_dw@mail.gmail.com>
	<5629AD12.2020709@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5629AD12.2020709@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

Sorry for the delay.

[...]

>>
>> I think your are in right track, but unfortunate you still have some
>> work to do. :-)
>>
>> You can't call sdhci_suspend_host() with a runtime suspended host. You
>> will for example access sdhci internal registers, even-though the
>> clock to the SDHCI controller is gated, which is not a good idea.
>>
>> Now, this leads me to the following questions/ideas, which I am really
>> glad we can bring up within this context.
>>
>> So, sdhci_suspend_host() and sdhci_runtime_suspend_host() performs
>> very similar actions, but not completely the same.
>>
>> I have a feeling that we might be able to merge the above functions
>> into one function. The only thing that may differ between system PM
>> and runtime PM, is probably the wakeup settings and since that is
>> possible to control before the sdhci variant host driver decide to
>> call these functions, merging them might work.
>>
>>> From a wakeup point of view, does your case have different settings
>>
>> between system PM and runtime PM?
>>
>> What do you think?
>
>
> My case doesn't have diff settings between system PM and runtime PM.

Okay!

> If my understanding is proper, I guess you want to remove
> sdhci_suspend|resume_host and assign  pm_runtime_force_suspend|resume to
> SET_SYSTEM_SLEEP_PM_OPS directly by sdhci variant HCs?
>

Yes.

You may have a look at the following commit from Ludovic, which is
queued for 4.5 on my next branch. That should give you an idea.

"mmc: sdhci-of-at91: add PM support"

> If that is the case, I guess we should look more precisely into other
> sdhci variant HCs to check whether they need to do diff things for system PM
> and RPM or not.

Yes, please! It would be nice to get that code to actually work.
Currently it's mostly broken when runtime PM is enabled.

Kind regards
Uffe
