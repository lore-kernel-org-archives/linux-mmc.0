From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 3/8] mmc: sdhci-pxav3: fix error handling of armada_38x_quirks
Date: Fri, 9 Oct 2015 02:49:07 +0200
Message-ID: <CAPv3WKen1yb7QZfiLaeiDOHvdXZy3WivAL2qjgacFY=GPCEAcQ@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-4-git-send-email-mw@semihalf.com>
	<CAPDyKFrA1NKDY=z=MMSXeW_naVCAAJnMa_ZfDqo1-tnpbNCoRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrA1NKDY=z=MMSXeW_naVCAAJnMa_ZfDqo1-tnpbNCoRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thanks for grabbing the three patches!

Best regards,
Marcin

2015-10-08 19:35 GMT+02:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 6 October 2015 at 03:22, Marcin Wojtas <mw@semihalf.com> wrote:
>> In case of armada_38x_quirks error, all clocks should be cleaned-up, same
>> as after mv_conf_mbus_windows failure.
>>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> Cc: <stable@vger.kernel.org> # v4.2
>
> Thanks, applied for fixes!
>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index 89a9e49..f5edf9d 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -402,7 +402,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>>                 ret = armada_38x_quirks(pdev, host);
>>                 if (ret < 0)
>> -                       goto err_clk_get;
>> +                       goto err_mbus_win;
>>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>>                 if (ret < 0)
>>                         goto err_mbus_win;
>> --
>> 1.8.3.1
>>
