From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Set ocr_avail directly based on vmmc
Date: Fri, 11 Apr 2014 08:59:11 -0700
Message-ID: <CAAYSxhp7df9ee9+bfz0ht6Lr6ojtfbPAqsa5Sf0=BmVpKymJ6w@mail.gmail.com>
References: <1397172708-19735-1-git-send-email-tim.kryger@linaro.org>
	<CAPDyKFrFyBLtL6dVgFy6DkY0gdCjiVpk1OhsfUXD0nhajCetxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrFyBLtL6dVgFy6DkY0gdCjiVpk1OhsfUXD0nhajCetxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 11, 2014 at 1:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 11 April 2014 01:31, Tim Kryger <tim.kryger@linaro.org> wrote:

>> +static unsigned int sdhci_get_ocr_avail_from_vmmc(struct sdhci_host *host)
>> +{
>> +       unsigned int ocr_avail = 0;
>> +       struct regulator *vmmc = host->vmmc;
>> +
>> +       if (regulator_is_supported_voltage(vmmc, 1650000, 1950000) > 0)
>> +               ocr_avail |= MMC_VDD_165_195;
>> +
>> +       if (regulator_is_supported_voltage(vmmc, 2900000, 3000000) > 0)
>> +               ocr_avail |= MMC_VDD_29_30;
>> +
>> +       if (regulator_is_supported_voltage(vmmc, 3000000, 3100000) > 0)
>> +               ocr_avail |= MMC_VDD_30_31;
>> +
>> +       if (regulator_is_supported_voltage(vmmc, 3200000, 3300000) > 0)
>> +               ocr_avail |= MMC_VDD_32_33;
>> +
>> +       if (regulator_is_supported_voltage(vmmc, 3300000, 3400000) > 0)
>> +               ocr_avail |= MMC_VDD_33_34;
>> +
>> +       return ocr_avail;
>> +}
>> +
>
> There is an API called mmc_regulator_get_ocrmask() for this.

Great.  Thanks for pointing this out.


>> +               ocr_avail = sdhci_get_ocr_avail_from_vmmc(host);
>> +       } else {
>> +               if (caps[0] & SDHCI_CAN_VDD_330)
>> +                       ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
>> +               if (caps[0] & SDHCI_CAN_VDD_300)
>> +                       ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
>> +               if (caps[0] & SDHCI_CAN_VDD_180)
>> +                       ocr_avail |= MMC_VDD_165_195;
>> +       }
>> +
>> +       if (host->ocr_mask)
>> +               ocr_avail = host->ocr_mask;
>> +
>> +       mmc->ocr_avail = ocr_avail;
>> +       mmc->ocr_avail_sdio = ocr_avail;
>> +       if (host->ocr_avail_sdio)
>> +               mmc->ocr_avail_sdio &= host->ocr_avail_sdio;
>> +       mmc->ocr_avail_sd = ocr_avail;
>> +       if (host->ocr_avail_sd)
>> +               mmc->ocr_avail_sd &= host->ocr_avail_sd;
>> +       else /* normal SD controllers don't support 1.8V */
>> +               mmc->ocr_avail_sd &= ~MMC_VDD_165_195;
>> +       mmc->ocr_avail_mmc = ocr_avail;
>> +       if (host->ocr_avail_mmc)
>> +               mmc->ocr_avail_mmc &= host->ocr_avail_mmc;
>> +
>> +       if (mmc->ocr_avail == 0) {
>> +               pr_err("%s: Hardware doesn't report any support voltages.\n",
>> +                      mmc_hostname(mmc));
>> +               return -ENODEV;
>> +       }
>
> I have not fully understand why you have different ocr masks depending
> on what card you initialize. Is that really supported by the
> controller?

Would you mind clarifying your question?  I'm not sure what you are
after.  Also this logic is mostly unchanged, I have simply moved it up
earlier in the function to keep all the ocr parts together.

> I have seen some patches around lately touching the code for handling
> the regulators (vcc and vccq) in sdhci.
>
> A few times I have suggested to switch to use the
> mmc_regulator_get_supply() API to simplify and consolidate code. Could
> you please have a look at that?

Sure, I'll take a look.  Thanks for the helpful comments.

-Tim
