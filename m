From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Date: Mon, 9 Jul 2018 13:31:55 +0200
Message-ID: <CAPDyKFqoZ=od-sJVO9Aj9Ha6QjGqjvrNuyWE2HS_Rtkap_bbKw@mail.gmail.com>
References: <20180704150745.21003-1-stefan@agner.ch> <CAPDyKFou773HgPzE29Ynr2MVFcaOhb=+uXBrjL+1H8iWx4jdQw@mail.gmail.com>
 <3d4064a559e741e05105b11c9e7a831d@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d4064a559e741e05105b11c9e7a831d@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, Russell King <rmk+kernel@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 5 July 2018 at 16:22, Stefan Agner <stefan@agner.ch> wrote:
> On 05.07.2018 15:10, Ulf Hansson wrote:
>> On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
>>> If pinctrl nodes for 100/200MHz are missing, the controller should
>>> not select any mode which need signal frequencies 100MHz or higher.
>>> To prevent such speed modes the driver currently uses the quirk flag
>>> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
>>> signaling is required for all faster modes and slower modes use 3.3V
>>> signaling only.
>>>
>>> However, there are eMMC modes which use 1.8V signaling and run below
>>> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
>>> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
>>> the stack has no valid mode to use. In this tenuous situation the
>>> kernel continuously prints voltage switching errors:
>>>   mmc1: Switching to 3.3V signalling voltage failed
>>>
>>> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
>>> altering the SDHCI capability register. With that the stack is able
>>> to select 1.8V modes even if no faster pinctrl states are available:
>>>   # cat /sys/kernel/debug/mmc1/ios
>>>   ...
>>>   timing spec:    8 (mmc DDR52)
>>>   signal voltage: 1 (1.80 V)
>>>   ...
>>>
>>> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> Thanks, applied for next! Let's see if this turns out okay, then let's
>> make it a fix and add a stable tag.
>>
>> BTW, would you mind looking up the commit it fixes? Or if there is a
>> certain stable release we should target.
>>
>
> The quirk SDHCI_QUIRK2_NO_1_8_V has been used if pinctrl were missing
> since support has been added for additional pinctrl states (back around
> 3.13).
>
> Fixes: ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl state
> according to uhs mode")
>
> I guess it won't apply on older kernels since the code which applies the
> quirk has been moved around.

Thanks!

I have moved the patch to fixes and added a stable tag, # v4.13+. It
applied cleanly on top of that kernel version, if you or anyone else
needs it for an older kernel, please post a backported patch.

[...]

Kind regards
Uffe
