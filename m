From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
Date: Mon, 25 Feb 2019 11:48:56 +0100
Message-ID: <9c88d76c-2080-71b1-c9c6-c24d0f0aeb91@st.com>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
 <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
 <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

hi Russell & Ulf

On 2/21/19 3:03 PM, Russell King - ARM Linux admin wrote:
> On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
>> hi Russell & Ulf
>>
>> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
>>> On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
>>>> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
>>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>>
>>>>> This patch series introduces a bitmap of hardware quirks that require
>>>>> some special action. This should reduce the number of boolean
>>>>> into variant structure.
>>>>> And adds quirk bit to define sdmmc specific transfer modes.
>>>>
>>>> Please find some other way to deal with these differences.  As far as
>>>> I'm concerned, introducing a quirk bitmask such as what was done in
>>>> sdhci is a complete disaster and leads to long-term maintanability
>>>> problems.
>>>>
>>>> We already have a way to deal with variants in mmci.
>>>
>>> ... to finish what I was saying ...
>>>
>>> and I think that:
>>>
>>>           if (variant->blksz_datactrl16)
>>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
>>>           else if (variant->blksz_datactrl4)
>>>                   datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
>>>           else
>>>                   datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
>>>
>>> ought to become a variant function call which returns the appropriate
>>> datactrl value.  This would shrink the amount of variant testing in this
>>> path, and also means that going forward we aren't facing an endlessly
>>> increasing number of tests here.
>>
>> For blksz_datactrl case:
>> We could create an inline function for datactrl16 and blksz_datactrl4
>> which returns the appropriate datactrl value (specific for ux500v2 and
>> qcom). This function could be register in mmci_host_ops structure.
> 
> Yes, this is what I'm proposing (except for the "inline" bit which
> seems meaningless if it's called via the mmci_host_ops structure.)
> I'm also proposing that it shouldn't just be the blksz that's
> returned but anything that the variant needs to take account of,
> including the stm transfer mode.

Ulf, are you alright with this callback approach (just to be sure that 
every body is align, before send a patch)?

This mmci_host_ops callback could return datactrl config to
start data (defined by variant).

> 
>> in mmci_start_data function we could call a common function which call a
>> hook if defined.
>>
>> int mmci_dblksz(struct mmci_host *host)
> 
> As this is returning a register value, "u32" would be more appropriate
> than "int".
> 
>> {
>> 	if (host->ops && host->ops->dblksz)
>> 		return host->ops->dblk(host);
>>
>> 	/* default data block size definition */
>> 	blksz_bits = ffs(data->blksz) - 1;
>> 	return blksz_bits << 4;
>> }
>>
>> what do you think about it?
> 
> I don't see any reason not to make the call unconditional and have every
> variant supply an appropriate function pointer.  IMHO that keeps stuff
> cleaner.
> 
>> After, I'm afraid to multiply callback function in mmci_host_ops.
>>
>> For stm32 transfer mode:
>> ditto, a callback function or I keep a boolean?
>>
>> BR
>> Ludo
>>
>>>
>>>>
>>>>>
>>>>> Ludovic Barre (2):
>>>>>     mmc: mmci: introduce a quirks property into variant struct
>>>>>     mmc: mmci: add quirk property to add stm32 transfer mode
>>>>>
>>>>>    drivers/mmc/host/mmci.c | 11 +++++++++++
>>>>>    drivers/mmc/host/mmci.h |  9 +++++++++
>>>>>    2 files changed, 20 insertions(+)
>>>>>
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>
>>>> -- 
>>>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>>>> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
>>>> According to speedtest.net: 11.9Mbps down 500kbps up
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
> 
