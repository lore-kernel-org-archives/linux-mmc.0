From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
Date: Wed, 5 Aug 2015 16:43:20 +0800
Message-ID: <55C1CCA8.7040304@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
 <55C1C8E9.1060808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
        format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <55C1C8E9.1060808@samsung.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: shawn.lin@rock-chips.com, dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>, Govindraj Raja <govindraj.raja@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/5 16:27, Krzysztof Kozlowski =E5=86=99=E9=81=93:
> On 05.08.2015 17:17, Shawn Lin wrote:
>> synopsys-dw-mshc supports three types of transfer mode. We add bindi=
ngs
>> and description for how to use them at runtime. Without idmac and ed=
mac
>> property, pio is the default transfer mode. Make sure that Idmac and=
 emdac
>> should not be used simultaneously.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 41 ++++++++++=
++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.=
txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index 346c609..30369cb 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -75,6 +75,25 @@ Optional properties:
>>   * vmmc-supply: The phandle to the regulator to use for vmmc.  If t=
his is
>>     specified we'll defer probe until we can find this regulator.
>>  =20
>> +* supports-idmac: Enables support for internal DMAC block within th=
e Synopsys
>> +  Designware Mobile Storage IP block. If supports-idmac property is=
 present, then
>> +  we MUST NOT add supports-edmac property since we'd assume that dw=
-mshc IP is
>> +  integrated with only one type of dma master.
>> +
>> +* supports-edmac: Enables support for external DMAC block outside t=
he Synopsys
>> +  Designware Mobile Storage IP block. If supports-edmac property is=
 present, then
>> +  we MUST NOT add supports-idmac property since we'd assume that dw=
-mshc IP is
>> +  integrated with only one type of dma master.
>> +
>> +  (Without "supports-idmac" and "supports-edmac", use PIO as defaul=
t transfer mode)
> Aren't you breaking here backward compatibility with existing DTB?
>
> Best regards,
> Krzysztof

  Thanks, Krzysztof.
  I guess you mean that I should keep existing DTB w/o these two=20
properties work fine using idmac?
>> +
>> +* dmas: List of DMA specifiers with the controller specific format =
as described
>> +  in the generic DMA client binding. This property should be combin=
ed with
>> +  supports-edmac. Refer to dma.txt for details.
>> +
>> +* dma-names: DMA request names. Must be "rx-tx". And This property =
should be
>> +  combined with supports-edmac. Refer to dma.txt for details.
>> +
>>   Aliases:
>>  =20
>>   - All the MSHC controller nodes should be represented in the alias=
es node using
>> @@ -95,6 +114,8 @@ board specific portions as listed below.
>>   		#size-cells =3D <0>;
>>   	};
>>  =20
>> +[board specific internal DMA resources]
>> +
>>   	dwmmc0@12200000 {
>>   		clock-frequency =3D <400000000>;
>>   		clock-freq-min-max =3D <400000 200000000>;
>> @@ -106,4 +127,24 @@ board specific portions as listed below.
>>   		bus-width =3D <8>;
>>   		cap-mmc-highspeed;
>>   		cap-sd-highspeed;
>> +		supports-idmac;
>>   	};
>> +
>> +[board specific generic DMA request binding]
>> +
>> +	dwmmc0@12200000 {
>> +		clock-frequency =3D <400000000>;
>> +		clock-freq-min-max =3D <400000 200000000>;
>> +		num-slots =3D <1>;
>> +		broken-cd;
>> +		fifo-depth =3D <0x80>;
>> +		card-detect-delay =3D <200>;
>> +		vmmc-supply =3D <&buck8>;
>> +		bus-width =3D <8>;
>> +		cap-mmc-highspeed;
>> +		cap-sd-highspeed;
>> +		supports-edmac;
>> +		dmas =3D <&pdma 12>;
>> +		dma-names =3D "rx-tx";
>> +	};
>> +
>>
>
>
>


--=20
Shawn Lin
