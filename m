From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: fix failing to mount partition with
 "discard"
Date: Wed, 2 Mar 2016 09:46:14 +0800
Message-ID: <56D645E6.80508@rock-chips.com>
References: <1456816373-32518-1-git-send-email-shawn.lin@rock-chips.com>
 <56D641FA.8010606@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D641FA.8010606@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/3/2 9:29, Jaehoon Chung =E5=86=99=E9=81=93:
> Hi Shawn.
>
> On 03/01/2016 04:12 PM, Shawn Lin wrote:
>> Without MMC_CAP_ERASE support, we fail to mount partition
>> with "discard" option since mmc_queue_setup_discard is limited
>> for checking mmc_can_erase. Without doing mmc_queue_setup_discard,
>> blk_queue_discard fails to test QUEUE_FLAG_DISCARD flag, so we get
>> the following log from f2fs(actually similar to other file system):
>>
>> mounting with "discard" option, but the device does not support disc=
ard
>
> We can enable MMC_CAP_ERASE by default, since other SoC also needs th=
is capability.
> I had sent some patch for enabling by default, but at that time i did=
n't remember why not enabled by default.
> I will check that reason..and share the information.

Hi Jaehoon,

Thanks for checking that. I didn't notice this part of code either unti=
l
I began to develop f2fs last month.
yes, I can't find any reasons not to enable it for dw_mmc because I loo=
k
more into dwmmc-databooks to see if any version of IP can't support
ERASE/TRIM command, and find none of them. So, enabling it by default i=
s
safe.

>
> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/d=
w_mmc-rockchip.c
>> index 84e50f3..2eda118 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -234,11 +234,20 @@ static int dw_mci_rockchip_init(struct dw_mci =
*host)
>>   	return 0;
>>   }
>>
>> +/* Common capabilities of RK3288 SoC */
>> +static unsigned long dw_mci_rk3288_dwmmc_caps[4] =3D {
>> +	MMC_CAP_ERASE,
>> +	MMC_CAP_ERASE,
>> +	MMC_CAP_ERASE,
>> +	MMC_CAP_ERASE,
>> +};
>> +
>>   static const struct dw_mci_drv_data rk2928_drv_data =3D {
>>   	.init			=3D dw_mci_rockchip_init,
>>   };
>>
>>   static const struct dw_mci_drv_data rk3288_drv_data =3D {
>> +	.caps			=3D dw_mci_rk3288_dwmmc_caps,
>>   	.set_ios		=3D dw_mci_rk3288_set_ios,
>>   	.execute_tuning		=3D dw_mci_rk3288_execute_tuning,
>>   	.parse_dt		=3D dw_mci_rk3288_parse_dt,
>>
>
>
>
>


--=20
Best Regards
Shawn Lin
