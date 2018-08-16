From: Igor Opaniuk <igor.opaniuk@linaro.org>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 capability
Date: Thu, 16 Aug 2018 13:03:06 +0300
Message-ID: <CAModR+VU9XmhYt_BdXd1QCTX0d5yUXjQNVjVQpViLuW8aWdMOw@mail.gmail.com>
References: <1534333184-25599-1-git-send-email-igor.opaniuk@linaro.org> <CAAQ0ZWRj6VhgY_hBz0iaxG8rJQVOVCKn4GOpoC_m1opp+qEyqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAQ0ZWRj6VhgY_hBz0iaxG8rJQVOVCKn4GOpoC_m1opp+qEyqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, tianshuliang <tianshuliang@hisilicon.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

Will test it today with the change you suggested, in case if
everything is OK will send v2 asap

Thanks

On 16 August 2018 at 11:01, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Aug 15, 2018 at 7:39 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>>
>> Enable access to the RPMB on the on-board eMMC of the
>> Poplar board.
>>
>> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
>> ---
>>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
>> index f9b333f..7a023f0 100644
>> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
>> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
>> @@ -23,6 +23,12 @@ struct hi3798cv200_priv {
>>         struct clk *drive_clk;
>>  };
>>
>> +static unsigned long dw_mci_hi3798cv200_caps[] = {
>> +       MMC_CAP_CMD23,
>> +       MMC_CAP_CMD23,
>> +       0
>> +};
>
> I believe the three dwmmc blocks integrated on Hi3798CV200 SoC are
> identical on CMD23 support.  So I expect the zero to be MMC_CAP_CMD23
> as well.
>
> Shawn
>
>> +
>>  static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>  {
>>         struct hi3798cv200_priv *priv = host->priv;
>> @@ -160,6 +166,8 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
>>  }
>>
>>  static const struct dw_mci_drv_data hi3798cv200_data = {
>> +       .caps = dw_mci_hi3798cv200_caps,
>> +       .num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
>>         .init = dw_mci_hi3798cv200_init,
>>         .set_ios = dw_mci_hi3798cv200_set_ios,
>>         .execute_tuning = dw_mci_hi3798cv200_execute_tuning,
>> --
>> 2.7.4
>>



-- 
Regards,
Igor Opaniuk
