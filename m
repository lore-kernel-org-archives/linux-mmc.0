From: Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Sat, 28 Jul 2018 08:03:19 -0400
Message-ID: <73510426-3b7e-cc7c-39db-4058bc6a4c22@gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch>
 <4098188.Bd2NGYzoJE@dimapc>
 <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
 <7096174.4n8ysn5QrL@dimapc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7096174.4n8ysn5QrL@dimapc>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 7/28/2018 6:13 AM, Dmitry Osipenko wrote:
> On Friday, 27 July 2018 23:19:53 MSK Peter Geis wrote:
>> Kingston KE4CN3K6A.
>> Though I am pretty sure I've figured out the instability.
>> Brought it in to work and hooked it to a scope.
>> Couldn't find clock, but cmd and all eight bits are running at 1.2 volts.
>> Repeated the results with the bootloader, the original kernel, and my
>> mainline.
>> Also noticed that even on the slowest slew rate there is significant
>> ringing and overshoot of .15 volts.
> 
> Okay, but eMMC is working fine with the original kernel, isn't it?
> 
> 
Correct, at roughly double the speed of the mainline kernel.
According to the mmc spec, in high voltage mode it should have 2.7-3.3 
volts in, and the minimum signal voltage should be .75 of that, which 
equates to a minimum voltage of over 2 volts.
For low voltage mode, it should be 1.8 volts in, with the signals being 
between .3 and .7 volts.
Signal voltage of 1.3 volts is .75 of 1.8, which means we have low 
voltage in, but high voltage signaling.
This is even with HS-200 or DDR-1.8 assigned in the controller mode, so 
for some reason we aren't switching modes.
The original kernel was running in SDR 25 signaling, but didn't try to 
switch either.

Digging through the old code and the TRM, there are three ideas stuck in 
my head.
The original pinmux driver had settings such as low voltage divider and 
two values for each pull direction.
The pinmux driver is io resetting specifically the pads we are using, 
dumping any values the bootloader had set.
Is it possible the tap configuration is not working?
