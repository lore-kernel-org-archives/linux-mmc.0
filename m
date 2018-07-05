From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Date: Thu, 5 Jul 2018 13:29:48 +0200
Message-ID: <CAPDyKFpWzWeXxDfHXpFBboCtJKH97pPotTcmuFigZhET7zA26g@mail.gmail.com>
References: <20180704150745.21003-1-stefan@agner.ch> <b2cc30701b1c38cd0c40736d04407424@agner.ch>
 <CAPDyKFqhUBteUNwE4aice5kxNkTX-0mHiJELhA57hwEmPH6v6A@mail.gmail.com> <69f6122b8a69f1ab41d2ef8274321689@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <69f6122b8a69f1ab41d2ef8274321689@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, Russell King <rmk+kernel@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>> Btw, I still get the switching error once during boot-up:
>>>   mmc1: Switching to 3.3V signalling voltage failed
>>
>> I guess the this happens then also at system resume?
>>
>> The core tries first with 3.3 then if it fails, it continues with 1.8V, etc.
>>
>>>
>>> This is due to the call from mmc_set_initial_signal_voltage. It is a bit
>>> unfortunate since this is printed as a warning. Not sure if that could
>>> be prevented somehow?
>>
>> Seems like SDHCI_SIGNALING_330 should not be set, unless 3.3V I/O is
>> supported. That should avoid SDHCI from trying and instead just
>> returning an error code immediately.
>>
>> This seems like a generic issues for all SDHCI variant drivers.
>
> Hm, can we resolve this in a generic fashion?
>
> E.g something like this in sdhci_setup_host():
>
> if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 3200000,
> 3450000))
>         host->flags &= ~SDHCI_SIGNALING_330;

Something like that seems right, but a wider range should be allowed.
2.7V to 3.6V is allowed according to the specs.

Also, vqmmc is optional, so in case it doesn't exist we must not clear
the SDHCI_SIGNALING_330 bit.

Kind regards
Uffe
