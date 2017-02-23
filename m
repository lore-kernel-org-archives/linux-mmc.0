From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/2] [2/2] mmc: sdhci-cadence: Update PHY delay configuration
Date: Thu, 23 Feb 2017 20:47:10 +0900
Message-ID: <CAK7LNARh=cNON0ufHKzcxs2C9Brw+_hSiFj-SUh3GCpRpGqjkw@mail.gmail.com>
References: <1487250413-5769-1-git-send-email-piotrs@cadence.com>
 <1487250413-5769-2-git-send-email-piotrs@cadence.com> <CAPDyKFqsuzT9NXARMJtey_kZ0y2GsdOxZGsjbodWA1EXw_ZSzw@mail.gmail.com>
 <MWHPR07MB308848FCAB0C9A6A7976B09BDD5D0@MWHPR07MB3088.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MWHPR07MB308848FCAB0C9A6A7976B09BDD5D0@MWHPR07MB3088.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi.

2017-02-17 23:12 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: 16 February, 2017 4:10 PM
>> Subject: Re: [PATCH 2/2] [2/2] mmc: sdhci-cadence: Update PHY delay
>> configuration
>>
>> On 16 February 2017 at 14:06, Piotr Sroka <piotrs@cadence.com> wrote:
>> > DTS properties are used instead of fixed data because PHY settings can
>> > be different for different platforms.
>> > Configuration of new three PHY delays were added
>> >
>> > Signed-off-by: Piotr Sroka <piotrs@cadence.com>
>> > ---
>> >  .../devicetree/bindings/mmc/sdhci-cadence.txt      | 54 ++++++++++++++
>>
>> Please split this patch.
>>
>> DT docs should be a separate patch and make sure it precedes the changes
>> where the new bindings are being parsed in the driver code.
>>
>
> Ok I will do it in next version of patch.
>
>> >  drivers/mmc/host/sdhci-cadence.c                   | 83 +++++++++++++++++++-
>> --
>> >  2 files changed, 129 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
>> > b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
>> > index c0f37cb..221d3fe 100644
>> > --- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
>> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
>> > @@ -19,6 +19,59 @@ if supported.  See mmc.txt for details.
>> >  - mmc-hs400-1_8v
>> >  - mmc-hs400-1_2v
>> >
>> > +- phy-input-delay-sd-hs:
>> > +  Value of the delay in the input path for High Speed work mode.
>> > +  Valid range = [0:0x1F].

Instead of bunch of new bindings,
a data associated with an SoC specific compatible will do in most cases.


static const struct of_device_id sdhci_cdns_match[] = {
        {
                .compatible = "socionext,uniphier-sd4hc",
                .data = sdhci_cdns_uniphier_phy_data,
        },
        { .compatible = "cdns,sd4hc" },
        { /* sentinel */ }
};


Strictly speaking, the DLL delays will depend on board design as well as SoC.
So, DT bindings would be more flexible, though.





>> Please specify what unit this in. And then also a suffix, like "-ns"
>> to the name of the binding.
>
> The delay starts from 5ns (for delay parameter equal to 0), and it is increased by 2.5ns.
> 0 - means 5ns, 1 means 7.5 ns etc.


In short, all the DT values here are
kind of mysterious register values for the PHY.



>
>> > +               if (ret)
>> > +                       return ret;
>> > +       }
>> > +       if (!of_property_read_u32(np, "phy-dll-delay-sdclk-hsmmc", &tmp)) {
>> > +               ret = sdhci_cdns_write_phy_reg(priv,
>> > +                                              SDHCI_CDNS_PHY_DLY_HSMMC, tmp);
>> > +               if (ret)
>> > +                       return ret;
>> > +       }
>> > +       if (!of_property_read_u32(np, "phy-dll-delay-strobe", &tmp)) {
>> > +               ret = sdhci_cdns_write_phy_reg(priv,
>> > +                                              SDHCI_CDNS_PHY_DLY_STROBE, tmp);
>> > +               if (ret)
>> > +                       return ret;
>> > +       }
>> > +       return 0;


The repeat of the same pattern,
"look up a DT property, then if it exists, set it to a register."


Maybe, is it better to describe it with data array + loop, like this?


struct sdhci_cdns_phy_cfg {
        const char *property;
        u8 addr;
};

static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] =  {
        { "phy-input-delay-sd-hs", SDHCI_CDNS_PHY_DLY_SD_HS, },
        { "phy-input-delay-sd-default", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
        { "phy-input-delay-sd-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
        { "phy-input-delay-sd-sdr25", SDHCI_CDNS_PHY_DLY_UHS_SDR25, },
        { "phy-input-delay-sd-sdr50", SDHCI_CDNS_PHY_DLY_UHS_SDR50, },
        ...
};

static int sdhci_cdns_phy_init(struct device_node *np,
                               struct sdhci_cdns_priv *priv)
{
        u32 val;
        int i;

        for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs), i++) {
                ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
                                           &val);
                if (ret)
                        continue;

                ret = sdhci_cdns_write_phy_reg(priv,
                                               sdhci_cdns_phy_cfgs[i].addr,
                                               val);
                if (ret)
                        return ret;
        }
}





-- 
Best Regards
Masahiro Yamada
