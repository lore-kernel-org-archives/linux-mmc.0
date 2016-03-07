From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] Documentation: synopsys-dw-mshc: add binding for
 resets
Date: Mon, 7 Mar 2016 17:35:53 +0800
Message-ID: <56DD4B79.2090509@rock-chips.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <56DCD11E.5000901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:58907 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcCGJg3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 04:36:29 -0500
In-Reply-To: <56DCD11E.5000901@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org

Hi Jaehoon,

On 2016/3/7 8:53, Jaehoon Chung wrote:
> Hi Goudong,
>
> On 03/06/2016 05:47 PM, Guodong Xu wrote:
>> Add resets property to synopsys-dw-mshc bindings. It is intended to
>> represent the hardware reset signal present internally in some host
>> controller IC designs.
>>
>> See Documentation/devicetree/bindings/reset/reset.txt for details.
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 4 +++=
+
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.=
txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index 8636f5a..4e00e85 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -39,6 +39,10 @@ Required Properties:
>>
>>   Optional properties:
>>
>> +* resets: phandle + reset specifier pair, intended to represent har=
dware
>> +  reset signal present internally in some host controller IC design=
s.
>> +  See Documentation/devicetree/bindings/reset/reset.txt for details=
=2E
>
> Is this reset property for common dwmmc IP controller?

I think so. By discussion with my ASIC team, it's provided by synopsys.
 From dw_mmc databook version 270a, section 3.2.5, FBE Scenarios:

An FBE occurs due to an AHB error response on the AHB bus. This is a
system error, so the software driver should not perform any further
programming to the DWC_mobile_storage. The only recovery mechanism
from such scenarios is to do one of the following:
=E2=96=A0 Issue a hard reset by asserting the reset_n signal
=E2=96=A0 Do a program controller reset by writing to the CTRL[0] regis=
ter

the reset_n signal can be used to reset all the internal logic block
with dwmmc and reset the register value to default stat.

Note: reset_n is a internal signal, which is diff from rst_n for mmc hw
reset. (refer to databook section 5.2 Signal Descriptions, table 5-1)

>
> Best Regards,
> Jaehoon Chung
>
>> +
>>   * clocks: from common clock binding: handle to biu and ciu clocks =
for the
>>     bus interface unit clock and the card interface unit clock.
>>
>>
>
>
>
>


--=20
Best Regards
Shawn Lin

