From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Sat, 28 Jul 2018 13:13:42 +0300
Message-ID: <7096174.4n8ysn5QrL@dimapc>
References: <20180712073904.4705-1-stefan@agner.ch> <4098188.Bd2NGYzoJE@dimapc> <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMdYzYpawoCQ_08aJr0XUNxY8C=K95gkgMbZNetcw1vrmDgpig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Geis <pgwipeout@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday, 27 July 2018 23:19:53 MSK Peter Geis wrote:
> Kingston KE4CN3K6A.
> Though I am pretty sure I've figured out the instability.
> Brought it in to work and hooked it to a scope.
> Couldn't find clock, but cmd and all eight bits are running at 1.2 volts.
> Repeated the results with the bootloader, the original kernel, and my
> mainline.
> Also noticed that even on the slowest slew rate there is significant
> ringing and overshoot of .15 volts.

Okay, but eMMC is working fine with the original kernel, isn't it?
