From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 13/13] ARM: dts: exynos: Fix LAN and HUB after bootloader
 initialization on Odroid U3
Date: Fri, 06 May 2016 08:28:48 +0200
Message-ID: <572C39A0.8030701@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-14-git-send-email-k.kozlowski@samsung.com>
 <9dff13ae-5863-2b45-0e6a-00b345a19019@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <9dff13ae-5863-2b45-0e6a-00b345a19019@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 05/05/2016 10:16 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> On Odroid U3 (Exynos4412-based) board if USB was initialized by
>> bootloader (in U-Boot "usb start" before tftpboot), the HUB (usb3503)
>> and LAN (smsc95xx) after after successful probing were not visible in the
>> system ("lsusb").
>>
>> In such case the devices had to be fully reset before configuring.
>> Reset by GPIO (called RESET_N pin) and by RESET field in STCD register
>> in usb3503 HUB are not sufficient. Instead full reset has to be done by
>> disabling and enabling regulator.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [snip]
> 
>>  
>> +	lan_pwrseq: pwrseq2 {
>> +		compatible = "mmc-pwrseq-simple";
> 
> It feels strange to have a "mmc-pwrseq-simple" compatible for a USB power
> sequence provider. As I mentioned in the other patch, I think there should
> either be a DT binding for the USB pwrseq-simple with a "usb-pwrseq-simple"
> compatible that binds to the same pwrseq-simple driver or maybe having a
> generic DT binding for any device with a new "pwrseq-simple" compatible.
> 
> Patch looks good to me though, so after having a DT binding and changing
> the compatible string:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Probably this will change after Rob's feedback. :)

Best regards,
Krzysztof
