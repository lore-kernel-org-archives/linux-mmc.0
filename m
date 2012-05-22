From: ludovic.desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] ARM: dts: add nodes for atmel hsmci controllers
 for atmel platforms
Date: Tue, 22 May 2012 16:41:35 +0200
Message-ID: <4FBBA59F.3000804@atmel.com>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
 <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
 <20120522141348.GC3377@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120522141348.GC3377-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Le 05/22/2012 04:13 PM, Jean-Christophe PLAGNIOL-VILLARD a =E9crit :
> On 12:09 Tue 22 May     , ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>> From: Ludovic Desroches<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>
>> Add nodes for mci controllers.
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/at91sam9g20.dtsi     |   12 ++++++++++++
>>   arch/arm/boot/dts/at91sam9g25ek.dts    |   16 ++++++++++++++++
>>   arch/arm/boot/dts/at91sam9g45.dtsi     |   24 ++++++++++++++++++++++++
>>   arch/arm/boot/dts/at91sam9m10g45ek.dts |   17 +++++++++++++++++
>>   arch/arm/boot/dts/at91sam9x5.dtsi      |   24 ++++++++++++++++++++++++
>>   5 files changed, 93 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91=
sam9g20.dtsi
>> index 773ef48..6a28bfe 100644
>> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
>> @@ -197,6 +197,18 @@
>>   				interrupts =3D<10 4>;
>>   				status =3D "disabled";
>>   			};
>> +
>> +			mmc0: mmc@fffa800 {
>> +				compatible =3D "atmel,hsmci";
>> +				reg =3D<0xfffa800 0x600>;
>> +				interrupts =3D<9 4>;
>> +				status =3D "disabled";
>> +				#address-cells =3D<1>;
>> +				#size-cells =3D<0>;
>> +				slot@0 {
>> +					reg =3D<0>;
>> +				};
>> +			};
> this need to be in 9260.dtsi
>
> if you add the board too plese add all of them
> or seperate the commits
>

I based it on 3.4 so 9260.dtsi was not present. Nicolas gave me a new =

branch with it so I will add mmc node to 9260.

Regards

Ludovic
