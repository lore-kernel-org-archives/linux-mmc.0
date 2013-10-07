From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to the CMD
 error flag
Date: Mon, 07 Oct 2013 13:34:08 +0900
Message-ID: <525239C0.803@samsung.com>
References: <1254168.213051381119727256.JavaMail.weblogic@epml12>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40749 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3JGEeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Oct 2013 00:34:08 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUA006N47CU9D30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 07 Oct 2013 13:34:06 +0900 (KST)
In-reply-to: <1254168.213051381119727256.JavaMail.weblogic@epml12>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alim.akhtar@samsung.com
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, "cjb@laptop.org" <cjb@laptop.org>, "dianders@chromium.org" <dianders@chromium.org>

On 10/07/2013 01:22 PM, ALIM AKHTAR wrote:
> Hi Jaehoon,
>=20
>> ------- Original Message -------
>> Sender : Jaehoon Chung<jh80.chung@samsung.com> S4/Engineer/System S/=
W Lab./Samsung Electronics
>> Date : Oct 06, 2013 17:28 (GMT+09:00)
>> Title : Re: [PATCH] mmc: dw_mmc: Add hardware lock error (HLE) to th=
e CMD error flag
> =20
>> Hi Alim,
>=20
>> On 10/03/2013 06:18 PM, alim akhtar wrote:
>>> From: Alim Akhtar=20
>>>
>>> Hardware locked error set when the dw_mmc controller cannot load a
>>> command issued by software. When software sets the start_cmd bit in=
 the
>>> CMD register, the controller tries to load the command. If the comm=
and
>>> buffer is already filled with a command, this error is raised. Curr=
ently
>>> driver does not handle HLE interrupt, which results in a system han=
g.
>> When SDMMC_INT_HLE is set into CMD_ERROR_FLAGS,.then could driver ha=
ndle the HLE interrupt?
> Yes, this will be handled as a part of DW_MCI_CMD_ERROR_FLAGS error h=
andling.
Could some command or data be lost?

>=20
>> Best Regards,
>> Jaehoon Chung
>>>
>>> HLE can be simulated by quickly inserting and removing sd card in c=
ard
>>> slot (30 ~ 40 times in say 20 secs)
>>>
>>> Reviewed-by: Doug Anderson=20
>>> Signed-off-by: Alim Akhtar=20
>>> ---
>>>   drivers/mmc/host/dw_mmc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 0a6a512..24b4a52 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -44,7 +44,7 @@
>>>   	 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
>>>   	 SDMMC_INT_EBE)
>>>   #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | =
\
>>> -	 SDMMC_INT_RESP_ERR)
>>> +	 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
>>>   #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
>>>   	 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
>>>   #define DW_MCI_SEND_STATUS	1
>>> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA=
{.n=C7+=89=B7=A5=8A{=B1=9Ag"=9E=D8^n=87r=A1=F6=A6z=CB=1A=81=EBh=99=A8=E8=
=AD=DA&=A2=F8=1E=AEG=AB=9D=E9h=AE=03(=AD=E9=9A=8E=8A=DD=A2j"=9D=FA=1A=B6=
=1Bm=A7=FF=EF=81=EA=E4z=B9=DE=96=8A=E0=FEf=A3=A2=B7h=9A=88=A7~=88mml=3D=
=3D

