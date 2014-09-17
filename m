From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH] mmc: rtsx: add card power off during probe
Date: Wed, 17 Sep 2014 17:11:18 +0800
Message-ID: <54195036.2010409@realsil.com.cn>
References: <1410485999-10939-1-git-send-email-micky_ching@realsil.com.cn>
 <CAPDyKFqcbK9OuQXbegignwiS7rz3L8resQ7Jfc8WvqXEKTcWVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFqcbK9OuQXbegignwiS7rz3L8resQ7Jfc8WvqXEKTcWVA@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 09/17/2014 02:01 AM, Ulf Hansson wrote:
> On 12 September 2014 03:39,  <micky_ching@realsil.com.cn> wrote:
>> From: Roger Tseng <rogerable@realtek.com>
>>
>> Some platform have both UEFI driver and MFD/mmc driver, if entering
>> linux while card in the slot, the card power is already on, and rtsx-mmc
>> driver have no chance to make card power off. This will lead UHSI card
>> failed to enter UHSI mode.
>>
>> It is hard to control the UEFI driver leaving state, so we power off the
>> card power during probe.
>>
>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
>> ---
>>   drivers/mmc/host/rtsx_pci_sdmmc.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> index dfde4a2..57b0796 100644
>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> @@ -1341,8 +1341,13 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>>          host->pcr = pcr;
>>          host->mmc = mmc;
>>          host->pdev = pdev;
>> -       host->power_state = SDMMC_POWER_OFF;
>>          INIT_WORK(&host->work, sd_request);
>> +       sd_power_off(host);
>> +       /*
>> +        * ref: SD spec 3.01: 6.4.1.2 Power On or Power Cycle
>> +        */
>> +       usleep_range(1000, 2000);
>> +
> This won't work in cases were you power off eMMC cards, unless you can
> do a full power cycle - cut both VCC and VCCQ. Can you?
Hi Uffe,

VCCQ will poweroff at the same time.

if MMC_CAP2_NO_PRESCAN_POWERUP enable, will call mmc_power_off() at start,
then it will check ios.power_mode, but the state is MMC_POWER_OFF and just return.

Best Regards.
micky.

> There are also another option you might want to use,
> MMC_CAP2_NO_PRESCAN_POWERUP. But again, it must only be used for those
> hosts that you are able to do a full power cycle for.
>
> Kind regards
> Uffe
>
>>          platform_set_drvdata(pdev, host);
>>          pcr->slots[RTSX_SD_CARD].p_dev = pdev;
>>          pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
>> --
>> 1.7.9.5
>>
> .
>
