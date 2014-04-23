From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't print data errors
Date: Wed, 23 Apr 2014 09:43:21 -0700
Message-ID: <CAD=FV=U_H_RdoMr2R9TAgj9HmaU0zm=UxcvvMXErzQ-acwZJwA@mail.gmail.com>
References: <1398210681-22976-1-git-send-email-dianders@chromium.org>
	<CAPDyKFpzPCi2Yb_33akh5dg1NjudydLkJrdGnQ_xJtsEGGcQ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpzPCi2Yb_33akh5dg1NjudydLkJrdGnQ_xJtsEGGcQ3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Seungwon / Ulf,

On Wed, Apr 23, 2014 at 1:17 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 April 2014 01:51, Doug Anderson <dianders@chromium.org> wrote:
>> Data errors are completely expected during tuning.  Printing them out
>> is confusing people looking at the kernel logs.  They see things like:
>>
>>  [    3.613296] dwmmc_exynos 12200000.dwmmc0: data error, status 0x00000088
>>
>> ...and they think something is wrong with their hardware.
>>
>> Remove the printouts.  We'll leave it up to a higher level to report
>> about errors.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index cced599..4c8d423 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1248,7 +1248,7 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
>>                         data->error = -EIO;
>>                 }
>>
>> -               dev_err(host->dev, "data error, status 0x%08x\n", status);
>> +               dev_dbg(host->dev, "data error, status 0x%08x\n", status);
>>
>
> The "status" here could be useful information about the status
> register, which is not considered while printing errors by the "higher
> levels". An option could be to print the error, but not when you
> perform tuning.
>
> No big deal though, just a thought.

Right, I could potentially put the driver into "tuning" mode and then
suppress the errors during that time.  If you request it I will do
that.

I will also note that there are many other error conditions in the
driver that don't have such printouts.  I think the general philosophy
of this driver is not to print them...

-Doug
