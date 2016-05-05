From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RFC v2 11/13] usb: port: Parse pwrseq phandle from Device Tree
Date: Thu, 5 May 2016 16:10:04 -0400
Message-ID: <e8f310b5-4fe8-3eb2-2d17-b1d9077daea2@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-12-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52425 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755262AbcEEUKW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2016 16:10:22 -0400
In-Reply-To: <1462451666-17945-12-git-send-email-k.kozlowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> device. The pwrseq device will be used by USB hub to cycle the power
> before activating ports.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

>  
> @@ -532,6 +534,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>  		return retval;
>  	}
>  
> +	port_dev->dev.of_node = usb_of_get_child_node(hub->hdev->dev.of_node, port1);
> +	port_dev->pwrseq = pwrseq_alloc(&port_dev->dev);
> +	if (IS_ERR(port_dev->pwrseq)) {
> +		device_unregister(&port_dev->dev);
> +		/* TODO: what about EPROBE_DEFER? */

I think it's OK since the call chain is:

hub_probe()
       hub_configure()
              usb_hub_create_port_device()

so the hub_probe() will be deferred if the usb-pwrseq was not registered yet.
Unless I misunderstood your question :)

Anyway, patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
