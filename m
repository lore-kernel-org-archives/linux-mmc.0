From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Date: Thu, 05 Jul 2018 13:22:33 +0200
Message-ID: <69f6122b8a69f1ab41d2ef8274321689@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch>
 <b2cc30701b1c38cd0c40736d04407424@agner.ch>
 <CAPDyKFqhUBteUNwE4aice5kxNkTX-0mHiJELhA57hwEmPH6v6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqhUBteUNwE4aice5kxNkTX-0mHiJELhA57hwEmPH6v6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 05.07.2018 11:48, Ulf Hansson wrote:
> On 4 July 2018 at 17:18, Stefan Agner <stefan@agner.ch> wrote:
>> On 04.07.2018 17:07, Stefan Agner wrote:
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
>>> ---
>>
>> Btw, I still get the switching error once during boot-up:
>>   mmc1: Switching to 3.3V signalling voltage failed
> 
> I guess the this happens then also at system resume?
> 
> The core tries first with 3.3 then if it fails, it continues with 1.8V, etc.
> 
>>
>> This is due to the call from mmc_set_initial_signal_voltage. It is a bit
>> unfortunate since this is printed as a warning. Not sure if that could
>> be prevented somehow?
> 
> Seems like SDHCI_SIGNALING_330 should not be set, unless 3.3V I/O is
> supported. That should avoid SDHCI from trying and instead just
> returning an error code immediately.
> 
> This seems like a generic issues for all SDHCI variant drivers.

Hm, can we resolve this in a generic fashion?

E.g something like this in sdhci_setup_host():

if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 3200000,
3450000))
	host->flags &= ~SDHCI_SIGNALING_330;

--
Stefan
