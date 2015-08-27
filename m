From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Kconfig: Add dependency on GPIOLIB for MMC_SDHCI
Date: Thu, 27 Aug 2015 14:30:30 +0200
Message-ID: <CAPDyKFo=DfMkg-wn7FEhsT4keMgWw0fYogvEo0xPBczGP6s9nQ@mail.gmail.com>
References: <6906e34b62f162018984a5fbd12b3ef6cd5e3a29.1438839562.git.michal.simek@xilinx.com>
	<CAPDyKFqgLonYZT86ixOAwJ3G5tsozxee6dEs+QRFYzwOWFUNNQ@mail.gmail.com>
	<CAPDyKFoPDMcO_19_pg7=aFUUCQrnxnoZD+YGpjYaBcRWu4ArJw@mail.gmail.com>
	<55DEF7FD.8020904@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DEF7FD.8020904@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Scott Branden <sbranden@broadcom.com>, Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 27 August 2015 at 13:43, Michal Simek <michal.simek@xilinx.com> wrote:
> Hi Ulf,
>
> On 08/27/2015 01:32 PM, Ulf Hansson wrote:
>> On 25 August 2015 at 14:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 6 August 2015 at 07:39, Michal Simek <michal.simek@xilinx.com> wrote:
>>>> Add GPIOLIB dependency for MMC_SDHCI.
>>>>
>>>> Problem was observed after adding the patch
>>>> "mmc: sdhci-of-arasan: Call OF parsing for MMC"
>>>> (sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) which calls
>>>> mmc_of_parse() -> mmc_gpiod_request_cd() (slot-gpio.c) which
>>>> calls devm_gpiod_get_index() which returns -ENOSYS.
>>>>
>>>> Error log:
>>>> sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
>>>> sdhci-arasan: probe of ff160000.sdhci failed with error -38
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>
>>> Thanks, applied for next!
>>
>> kbuild test robot reports a warning for this one, so I am dropping it
>> from my next branch.
>
> I think is just better to fix the problem there instead of dropping this
> patch which fix GPIO dependency.
>
> Fix is quite easy.
> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig
> index 5538e57c36c1..874f07c7d0b8 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -219,6 +219,7 @@ config AKEBONO
>         select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
>         select MMC_SDHCI
>         select MMC_SDHCI_PLTFM
> +       select GPIOLIB
>         select ATA
>         select SATA_AHCI_PLATFORM
>         help
>
> But the question is if we should keep these ancient targets in the tree.
>
> I am happy to send this patch but it should go via PPC tree. Or are you
> happy to apply it to your tree?

It's getting really late for 4.3 so I would rather postpone this to
the next release cycle.

As I stated in my earlier reply, do we really want to add the GPIOLIB
dependency to the Kconfig file for SDHCI?
I assume we have lots of other Kconfig dependencies, then these should
also to be added for the same reasons. I doubt this is the right thing
to do.

How about if the mmc core instead treat GPIOs as optional from an API
point of view and thus it won't cause ->probe() to fail. Is that a way
forward for you?

Kind regards
Uffe
