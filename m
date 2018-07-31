From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
Date: Tue, 31 Jul 2018 11:33:20 +0200
Message-ID: <56e6c8c572a429a987dd7ef7bd898768@agner.ch>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
 <CAPDyKFo+nv+9qYV=J5k-63cDhQO=L==87RLMj_7BnjEjUf5iEQ@mail.gmail.com>
 <20180730184351.5044cb6e@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730184351.5044cb6e@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 30.07.2018 17:43, Aapo Vienamo wrote:
> On Mon, 30 Jul 2018 17:07:59 +0200
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
>> On 26 July 2018 at 14:26, Aapo Vienamo <avienamo@nvidia.com> wrote:
>> > Hi all,
>> >
>> > Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
>> > procedure to match the ones specified in the TRMs of the more recent
>> > SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
>> > should not break things older generations either.

I can give this a try on Tegra 3 here.

>> >
>> > This series depends on the "Tegra SDHCI enable 1.8 V signaling on
>> > Tegar210 and Tegra186" series posted earlier.
>>
>> According to the cover letter of the above series, it states that it
>> depends on $subject series. A circular dependency. :-)
> 
> The dependency chain goes like this: "Tegra SDHCI update the pad
> autocal procedure" -> "Tegra SDHCI enable 1.8 V signaling on Tegar210
> and Tegra186" -> "Tegra PMC pinctrl pad configuration".
> 
>> In fact, there should be no dependency at all or else there seems to
>> be a DT compatibility problem here...
> 
> From a functionality perspective there's no strict dependency, however,
> I don't think "[PATCH v2 09/10] mmc: tegra: Perform pad calibration
> after voltage switch" can be applied cleanly without
> "[PATCH v2 03/10] mmc: tegra: Reconfigure pad voltages during voltage
> switching" from the "Tegra SDHCI enable 1.8 V signaling on Tegar210 and
> Tegra186" series.
> 
>> Anyway, I think it actually makes sense to fold in all changes into
>> one series. Make sure the dt-doc changes comes first, then the driver
>> changes and finally arm64/dts changes. This should make it easy to
>> follow the review and I can pick the mmc parts and the soc maintainer
>> can pick the arm64/dts changes.
> 
> I've sent the changes in multiple part because I've been working on
> further changes to the driver while the previous parts have been
> getting reviewed. This is still the case and there's still going to be
> at least one more series which adds support for HS200 tuning and some
> smaller changes after it. However, the HS200 work is probably going to
> be ready for review in a day or two. I can send these as a one series
> from now on, although at this point it would be 27 patches in total
> and even more with the HS200 patches.
> 
> I can do that if you prefer to do it that way. Makes my life somewhat
> easier too.

...that would make it easier for my testing too, so I wait for the next
revision and will give it a try on Tegra 3 then.

--
Stefan

> 
>  -Aapo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
