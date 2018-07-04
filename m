From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/3] mmc: sdhci: add quirk to prevent higher speed modes
Date: Wed, 04 Jul 2018 12:55:01 +0200
Message-ID: <ffea342896629cf57b78661b04f60eda@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-3-stefan@agner.ch>
 <CAPDyKFqPaRRuXdSD50q=et-OvJ=emdbq-XWyeddkiuC5SjuLig@mail.gmail.com>
 <76c619e6267c5f0adfda80d0fdba3c6b@agner.ch>
 <CAPDyKFrjSadT0T2+zWhpq-E5kS1bm01y4R+LfyHyhjFBuK_hLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrjSadT0T2+zWhpq-E5kS1bm01y4R+LfyHyhjFBuK_hLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 04.07.2018 12:07, Ulf Hansson wrote:
> On 3 July 2018 at 10:48, Stefan Agner <stefan@agner.ch> wrote:
>> On 02.07.2018 16:36, Ulf Hansson wrote:
>>> On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
>>>> Some hosts are capable of running higher speed modes but do not
>>>> have the board support for it. Introduce a quirk which prevents
>>>> the stack from using modes running at 100MHz or faster.
>>>
>>> To cap the freq, use the DT property "max-frequency". To enable
>>> certain speed modes, use the corresponding speed mode binding. For
>>> example "sd-uhs-sdr*" and "mmc-hs200*".
>>> Documented in Documentation/devicetree/bindings/mmc/mmc.txt
>>
>> I had bad experience with max-frequency: Some higher speed modes seem
>> not to work reliably if constraint to low frequencies. E.g. we had lots
>> of devices fail in practise with HS400@100MHz... So it is doing what it
>> should, but it just seems that higher speed modes do not necessarily run
>> well with lower frequencies...
>>
>> So I'd rather prefer to limit speed modes as it is done right now.
>>
>>>
>>> In case the sdhci cap register, doesn't reflect the board support
>>> properly, such that you may want to disable some speed modes, then you
>>> may benefit from using the DT properties "sdhci-caps*.
>>> Documented in Documentation/devicetree/bindings/mmc/sdhci.txt
>>
>> Hm, yeah I guess something like
>>
>> sdhci-caps-mask =  /bits/ 64 <((SDHCI_SUPPORT_SDR104 |
>> SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50) << 32)>
>>
>> would come close.
>>
>> But it does not restrict MMC modes such as HS200/HS400. There seem to be
>> no mmc-caps...
> 
> Right.
> 
> The solution to fix this, should be to *not* set those DT properties,
> like "mmc-hs*" for example. That should work, no?
> 

The controller does not make use of the dt modes so far, so I can't not
set those properties...

>>
>>
>> My aim is to replace the SDHCI_QUIRK2_NO_1_8_V fix, which does not
>> restrict modes correctly. Currently the driver checks whether >=100MHz
>> pinctrl settings are available, and if not uses the quirk to restrict
>> higher speed modes. Removing that would break device tree backward
>> compatibility...
> 
> Looks like the problem is not really SDHCI_QUIRK2_NO_1_8_V, but rather
> how the pinctrl setting becomes interpreted when setting the quirk.
> 

Yes, sorry for the confusion. SDHCI_QUIRK2_NO_1_8_V is fine, it is just
not the quirk this driver needs.

I argue that commit ad93220de7da ("mmc: sdhci-esdhc-imx: change pinctrl
state according to uhs mode") chose the wrong quirk from the
beginning...

Afaict, the quirk needed here does not exist.

--
Stefan

>>
>> We probably could do something like this:
>> if (!100mhzpinctrl) {
>>      if (!sdhci-caps) {
>>           /*
>>            * If no 100MHz/200MHz pinctrl are available, SDHC caps should
>> be used to restrict
>>            * modes. Falling back to old behavior...
>>            */
>>          pr_warn(...)
>>          host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>      }
>> }
>>
> 
> I am not sure what makes best sense here. Let me have a look at patch 3 as well.
> 
> [...]
> 
> Kind regards
> Uffe
