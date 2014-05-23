From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v3 2/2] mmc: tegra: fix reporting of base clock frequency
Date: Fri, 23 May 2014 13:53:29 +0100
Message-ID: <86bnuor706.fsf@void.printf.net>
References: <1400774136-12396-1-git-send-email-abrestic@chromium.org>
	<1400774136-12396-2-git-send-email-abrestic@chromium.org>
	<CAPDyKFqBcp7PZQ-04s02Jrqscna0UVex2DEbVPYghmRR8g9HnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqBcp7PZQ-04s02Jrqscna0UVex2DEbVPYghmRR8g9HnA@mail.gmail.com>
	(Ulf Hansson's message of "Fri, 23 May 2014 09:04:12 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Bresticker <abrestic@chromium.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, May 23 2014, Ulf Hansson wrote:
> On 22 May 2014 17:55, Andrew Bresticker <abrestic@chromium.org> wrote:
>> Tegra SDHCI controllers, by default, report a base clock frequency
>> of 208Mhz in SDHCI_CAPABILTIES which may or may not be equal to the
>> actual base clock frequency.  This is because the clock rate is
>> configured by the clock controller, which is external to the SD/MMC
>> controller.  Since the SD/MMC controller has no knowledge of how this
>> clock is configured, it will simply report the maximum frequency.
>> While the reported value can be overridden by setting BASE_CLK_FREQ in
>> VENDOR_CLOCK_CTRL on Tegra30 and later SoCs, just set CAP_CLOCK_BASE_BROKEN
>> and supply sdhci_pltfm_clk_get_max_clock(), which simply does a
>> clk_get_rate(), as the get_max_clock() callback.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> Thanks Andrew!
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Chris, can you pick this up?

Thanks, pushed to mmc-next for 3.16.

- Chris.
-- 
Chris Ball   <http://printf.net/>
