From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 11/13] usb: port: Parse pwrseq phandle from Device Tree
Date: Fri, 06 May 2016 08:27:35 +0200
Message-ID: <572C3957.3010503@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-12-git-send-email-k.kozlowski@samsung.com>
 <e8f310b5-4fe8-3eb2-2d17-b1d9077daea2@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-reply-to: <e8f310b5-4fe8-3eb2-2d17-b1d9077daea2@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 05/05/2016 10:10 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
>> device. The pwrseq device will be used by USB hub to cycle the power
>> before activating ports.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [snip]
> 
>>  
>> @@ -532,6 +534,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>>  		return retval;
>>  	}
>>  
>> +	port_dev->dev.of_node = usb_of_get_child_node(hub->hdev->dev.of_node, port1);
>> +	port_dev->pwrseq = pwrseq_alloc(&port_dev->dev);
>> +	if (IS_ERR(port_dev->pwrseq)) {
>> +		device_unregister(&port_dev->dev);
>> +		/* TODO: what about EPROBE_DEFER? */
> 
> I think it's OK since the call chain is:
> 
> hub_probe()
>        hub_configure()
>               usb_hub_create_port_device()
> 
> so the hub_probe() will be deferred if the usb-pwrseq was not registered yet.
> Unless I misunderstood your question :)
> 
> Anyway, patch looks good to me:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Yes and deferred probing works in my case. That is an older comment
actually.

Thanks for review,
Krzysztof

