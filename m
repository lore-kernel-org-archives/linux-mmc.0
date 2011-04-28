From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 01/11] mmc: sd: add support for signal voltage switch procedure
Date: Wed, 27 Apr 2011 23:17:49 -0400
Message-ID: <BANLkTinmq+LO7o_iGF7JAGOh3ZDiw-WTSQ@mail.gmail.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
	<1303291861-1788-2-git-send-email-arindam.nath@amd.com>
	<BANLkTim=q-WfvjOShA9PW0yVPrO8edaPVg@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB819A74@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53828 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1D1DRu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 23:17:50 -0400
Received: by qyk7 with SMTP id 7so2107468qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 20:17:50 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB819A74@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "prakity@marvell.com" <prakity@marvell.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Wed, Apr 27, 2011 at 6:17 AM, Nath, Arindam <Arindam.Nath@amd.com> w=
rote:
> Hi Zhangfei,
>
> [...]
>
>> Hi, Arindam
>>
>> The uhs card works OK,
>> However after use uhs card, the io voltage keeps 1.8v, and
>> mmc_send_app_op_cond will return error, so no chance to go back to
>> 3.3v.
>> The result is hs card can not be detected after using uhs card.
>> Also some hs card have timeout issue here when reading partition
>> table, still not know it is local reason.
>
> [...]
>
>> > @@ -781,6 +808,11 @@ int mmc_attach_sd(struct mmc_host *host)
>> > =A0 =A0 =A0 =A0if (host->ocr_avail_sd)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ocr_avail =3D host->ocr_avail=
_sd;
>> >
>> > + =A0 =A0 =A0 /* Make sure we are at 3.3V signalling voltage */
>> > + =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, MMC_SIGNAL_VOLT=
AGE_330);
>> > + =A0 =A0 =A0 if (err)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> The code here may have no chance to execute, since
>> mmc_send_app_op_cond already failed if v_io is 1.8v for hs card.
>> Could you move the voltage setting before mmc_send_app_op_cond.
>
> Thanks once again for your sharp review. Yes, it makes sense to move =
mmc_set_signal_voltage() before mmc_send_app_op_cond(). Will do it.
>
> [...]
>
>> > @@ -1297,11 +1299,116 @@ out:
>> > =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
>> > =A0}
>> >
>> > +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc=
,
>> > + =A0 =A0 =A0 struct mmc_ios *ios)
>> > +{
>> > + =A0 =A0 =A0 struct sdhci_host *host;
>> > + =A0 =A0 =A0 u8 pwr;
>> > + =A0 =A0 =A0 u16 clk, ctrl;
>> > + =A0 =A0 =A0 u32 present_state;
>> > +
>> > + =A0 =A0 =A0 host =3D mmc_priv(mmc);
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* Signal Voltage Switching is only applicable for=
 Host
>> Controllers
>> > + =A0 =A0 =A0 =A0* v3.00 and above.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (host->version < SDHCI_SPEC_300)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* We first check whether the request is to set si=
gnalling
>> voltage
>> > + =A0 =A0 =A0 =A0* to 3.3V. If so, we change the voltage to 3.3V a=
nd return
>> quickly.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> > + =A0 =A0 =A0 if ((ctrl & SDHCI_CTRL_VDD_180) &&
>>
>> The check here may fail, could you remove this check, for example
>> ctrl=3D0x10 and no chance to 3.3v.
>
> If ctrl=3D0x10, it would mean the signaling voltage is already at 3.3=
V, so why do we need to set it to 3.3V again?

The test here shows ctrl return back to 0x10 once the card is removed
even the io voltage is 1.8v.
And the first time SDHCI_CTRL_VDD_180 is not set, so the default
voltage is used if using external regulator.

>
> Thanks,
> Arindam
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
