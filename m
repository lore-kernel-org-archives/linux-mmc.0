From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
Date: Thu, 28 Nov 2019 11:26:28 +0200
Message-ID: <6de5746e-bca2-fbe7-ff48-46103b9500a7@intel.com>
References: <20190903115114.33053-1-alcooperx@gmail.com>
 <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
 <CAOGqxeUJD7eQxRnH1rep=m2+Ga5DDF=uWMsc_j2NZgC+EnZqsg@mail.gmail.com>
 <7e495749-1539-9164-d801-305a918318d6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7e495749-1539-9164-d801-305a918318d6@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, Alan Cooper <alcooperx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28/11/19 10:21 AM, Faiz Abbas wrote:
> Hi,
> 
> On 19/09/19 5:27 PM, Alan Cooper wrote:
>> This does correct the sequence of switching to HS400 but it might be
>> safest to just add this to the latest until it gets a little testing
>> to make sure it doesn't expose some bug in existing controllers.
>>
>> Thanks
>> Al
>>
>> On Tue, Sep 3, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
>>>>
>>>> When switching from any MMC speed mode that requires 1.8v
>>>> (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
>>>> ends up configured for SDR12 with a 50MHz clock which is an illegal
>>>> mode.
>>>>
>>>> This happens because the SDHCI_CTRL_VDD_180 bit in the
>>>> SDHCI_HOST_CONTROL2 register is left set and when this bit is
>>>> set, the speed mode is controlled by the SDHCI_CTRL_UHS field
>>>> in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
>>>> will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
>>>> because there is no UHS mode being set.
>>>>
>>>> The fix is to change sdhci_set_uhs_signaling() to set the
>>>> SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
>>>> any switch to HS mode.
> 
> This change has broken High speed mode in SD card for me in AM65x-evm. I
> guess this change only needs to be done for eMMC. SDR25 is decidedly not
> the same as high speed for SD card.

Shall we revert c894e33ddc1910e14d6f2a2016f60ab613fd8b37 and then Alan
could send a patch providing the desired behaviour in ->set_uhs_signaling()
of the relevant driver e.g.

void ???_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
{
	if (timing == MMC_TIMING_SD_HS || timing == MMC_TIMING_MMC_HS)
		timing = MMC_TIMING_UHS_SDR25;
	sdhci_set_uhs_signaling(host, timing);
}
