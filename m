From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mci_parse_dt()
Date: Fri, 4 Mar 2016 11:45:57 +0800
Message-ID: <56D904F5.9020700@rock-chips.com>
References: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
 <1456968818-22140-2-git-send-email-guodong.xu@linaro.org>
 <56D79AB4.7050809@rock-chips.com> <56D900A8.9070204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D900A8.9070204-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-NgiFYW8Wbx6Ta72+1OMJgUB+6BGkLq7r@public.gmane.org, Xinwei Kong <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2016/3/4 11:27, zhangfei =D0=B4=B5=C0:
>
>
> On 03/03/2016 10:00 AM, Shawn Lin wrote:
>> Hi Guodong,
>>
>> On 2016/3/3 9:33, Guodong Xu wrote:
>>> With this, user can add a 'resets' property into dw_mmc dts
>>> node, and when driver probe and parse_dt, it will call
>>> reset APIs to reset dw_mmc host controller.
>>>
>>> Please also refer to Documentation/devicetree/bindings/reset/reset.=
txt
>>
>> I have no hard objection for this patch, but I'd rather not add it
>> unless we actually need it. Could you elaborate more about any futhe=
r
>> actions you will take if it's applied(i.e: deal with some unrecovera=
ble
>> broken case)?  If we just reset the controller while probing, actual=
ly I
>> can't find any problems without it based on tons of my reboot test.
>
> mmc register maybe abnormal state, if mmc is used in uefi, like boot
> from emmc.
> So we need reset mmc register when kernel boot up, instead of assumin=
g
> mmc is in clean state.
> Next step is adding reset node in dts for drivers/mmc/host/dw_mmc-k3.=
c
> as reset driver is already there.

=46air enough. Thanks for explaining.

>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 242f9a0..d3a7376 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -2878,6 +2878,13 @@ static struct dw_mci_board
>>> *dw_mci_parse_dt(struct dw_mci *host)
>>>       if (!pdata)
>>>           return ERR_PTR(-ENOMEM);
>>>
>>> +    /* find reset controller when exist */
>>> +    pdata->rstc =3D devm_reset_control_get_optional(dev, NULL);
>>> +    if (IS_ERR(pdata->rstc))
>>> +        pdata->rstc =3D NULL;
>>> +    else
>>> +        reset_control_deassert(pdata->rstc);
>>> +
>>
>> if the PTR_ERR(pdata->rstc) is -EPROBE_DEFER, should we defer probin=
g
>> the driver?
> Yes, good catch.
>
> Thanks
>
>
>


--=20
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
