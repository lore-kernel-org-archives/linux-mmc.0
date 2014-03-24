From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Mon, 24 Mar 2014 10:12:33 +0530
Message-ID: <CAKuRcOKOBebW157R16_KtSR541MwwZ4pyynBRnbvOLm9RK4SAg@mail.gmail.com>
References: <1395635037-24081-1-git-send-email-yuvaraj.cd@samsung.com>
	<532FB4A7.7020700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <532FB4A7.7020700@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Grant Grundler <grundler@chromium.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Doug Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 24, 2014 at 9:59 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Yuvaraj.
>
> NACK. we can use "mmc_of_parese()".
Thanks Jaehoon for the pointer.I will use "mmc_of_parse()".
>
> I have sent the patch that use "mmc_of_parse()".
> https://patchwork.kernel.org/patch/3750681/
>
> Best Regards,
> Jaehoon Chung
>
> On 03/24/2014 01:23 PM, Yuvaraj Kumar C D wrote:
>> The mmc part in exynos supports SDIO interrupts and they work fine, so
>> turn the capability on.  With this I see download speeds increase
>> about 10x.
>>
>> This V1 of this patch is posted to LKML at
>> https://patchwork.kernel.org/patch/2429661/) by Doug Anderson.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 0c56faa..240949d 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2417,6 +2417,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>       if (of_get_property(np, "cd-inverted", NULL))
>>               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>>
>> +     if (of_find_property(np, "cap-sdio-irq", NULL))
>> +             pdata->caps |= MMC_CAP_SDIO_IRQ;
>> +
>>       return pdata;
>>  }
>>
>>
>
