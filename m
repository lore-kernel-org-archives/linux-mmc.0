From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv3 4/4] ARM: dts: replace the slot property into slot sub-node
 for dwmmc.
Date: Mon, 02 Jun 2014 08:08:48 -0500
Message-ID: <538C7760.2070909@gmail.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com> <1401255351-17653-5-git-send-email-jh80.chung@samsung.com> <001d01cf7c06$420dea90$c629bfb0$%jun@samsung.com> <1834387.xgX8NLRvfH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1834387.xgX8NLRvfH@phil>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, dinguyen@altera.com, cpgs@samsung.com
List-Id: linux-mmc@vger.kernel.org



On 05/30/2014 01:15 PM, Heiko St=FCbner wrote:
> Am Freitag, 30. Mai 2014, 21:54:13 schrieb Seungwon Jeon:
>> + Dinh Nguyen <dinguyen@altera.com>
>> + Heiko Stuebner <heiko@sntech.de>
>>
>> On Wed, May 28, 2014, Jaehoon Chung wrote:
>>> dw-mmc controller can support the multiple slot.
>>> So each slot's property can be difference.
>>> And "support-highspeed" property in dw-mmc is deprecated.
>>> "support-highspeed" property can be replaced to "cap-sd/mmc-highspe=
ed".
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Looks good to me.
>>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> the rockchip part also looks ok to me
>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
>
>>

=46or the socfpga parts:

Acked-by: Dinh Nguyen <dinguyen@altera.com>

Thanks,
Dinh
