From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH RESEND 4/8] mmc: omap: context save after enabling runtime pm
Date: Fri, 16 Mar 2012 19:02:38 +0530
Message-ID: <CANrkHUaNXE0ZK_pDzJTk8yUJHSqm4xzGAvmQs1GX2y9WEU+wpQ@mail.gmail.com>
References: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
	<1331822022-26714-5-git-send-email-svenkatr@ti.com>
	<4F6206EA.9060104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4F6206EA.9060104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 15, 2012 at 8:42 PM, Shubhrajyoti <shubhrajyoti@ti.com> wro=
te:
> On Thursday 15 March 2012 08:03 PM, Venkatraman S wrote:
>> From: Balaji T K <balajitk@ti.com>
>>
>> call context save api after enabling runtime pm
>> to make sure register access in context save api
> If I am not mistaken =A0the api =A0would
> store the number of power state changes and accesses no registers.
>
> Am I missing something?

Yes, as of now no registers are accessed in context store. However
this patch is needed if registers are accessed in context save api.

>
>> =A0happens with clk enabled.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A04 ++--
>> =A01 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 0f8d34b..9fa2f39 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1871,8 +1871,6 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 omap_hsmmc_context_save(host);
>> -
>> =A0 =A0 =A0 if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MU=
LTIBLOCK_READ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "multiblock reads d=
isabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\=
n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 |=3D MMC_CAP2_NO_MULTI_READ;
>> @@ -1883,6 +1881,8 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
>> =A0 =A0 =A0 pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSP=
END_DELAY);
>> =A0 =A0 =A0 pm_runtime_use_autosuspend(host->dev);
>>
>> + =A0 =A0 omap_hsmmc_context_save(host);
>> +
>> =A0 =A0 =A0 if (cpu_is_omap2430()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dbclk =3D clk_get(&pdev->dev, "mmc=
hsdb_fck");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
