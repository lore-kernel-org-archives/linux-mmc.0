From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] Documentation: synopsys-dw-mshc: add binding for resets
Date: Mon, 07 Mar 2016 18:51:42 +0900
Message-ID: <56DD4F2E.3040904@samsung.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <56DCD11E.5000901@samsung.com> <56DD4B79.2090509@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41610 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbcCGJvp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 04:51:45 -0500
In-reply-to: <56DD4B79.2090509@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@kernel-upstream.org

Hi Shawn,

On 03/07/2016 06:35 PM, Shawn Lin wrote:
> Hi Jaehoon,
>=20
> On 2016/3/7 8:53, Jaehoon Chung wrote:
>> Hi Goudong,
>>
>> On 03/06/2016 05:47 PM, Guodong Xu wrote:
>>> Add resets property to synopsys-dw-mshc bindings. It is intended to
>>> represent the hardware reset signal present internally in some host
>>> controller IC designs.
>>>
>>> See Documentation/devicetree/bindings/reset/reset.txt for details.
>>>
>>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 4 ++=
++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc=
=2Etxt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>> index 8636f5a..4e00e85 100644
>>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>> @@ -39,6 +39,10 @@ Required Properties:
>>>
>>>   Optional properties:
>>>
>>> +* resets: phandle + reset specifier pair, intended to represent ha=
rdware
>>> +  reset signal present internally in some host controller IC desig=
ns.
>>> +  See Documentation/devicetree/bindings/reset/reset.txt for detail=
s.
>>
>> Is this reset property for common dwmmc IP controller?
>=20
> I think so. By discussion with my ASIC team, it's provided by synopsy=
s.
> From dw_mmc databook version 270a, section 3.2.5, FBE Scenarios:
>=20
> An FBE occurs due to an AHB error response on the AHB bus. This is a
> system error, so the software driver should not perform any further
> programming to the DWC_mobile_storage. The only recovery mechanism
> from such scenarios is to do one of the following:
> =E2=96=A0 Issue a hard reset by asserting the reset_n signal
> =E2=96=A0 Do a program controller reset by writing to the CTRL[0] reg=
ister
>=20
> the reset_n signal can be used to reset all the internal logic block
> with dwmmc and reset the register value to default stat.
>=20
> Note: reset_n is a internal signal, which is diff from rst_n for mmc =
hw
> reset. (refer to databook section 5.2 Signal Descriptions, table 5-1)

Thanks for this information. :)

>=20
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>> +
>>>   * clocks: from common clock binding: handle to biu and ciu clocks=
 for the
>>>     bus interface unit clock and the card interface unit clock.
>>>
>>>
>>
>>
>>
>>
>=20
>=20

