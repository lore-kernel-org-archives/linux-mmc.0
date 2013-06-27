From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 04/13] mmc: mxs-mmc: Let device core handle pinctrl
Date: Thu, 27 Jun 2013 11:20:34 -0400
Message-ID: <87obarpol9.fsf@octavius.laptop.org>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
	<1367863561-11534-4-git-send-email-fabio.estevam@freescale.com>
	<CAOMZO5BmvsnNPCxv6shNQsVg3cJcdPxQrMJzZz3fyBGKPOYF_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52660 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab3F0PUk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:20:40 -0400
In-Reply-To: <CAOMZO5BmvsnNPCxv6shNQsVg3cJcdPxQrMJzZz3fyBGKPOYF_A@mail.gmail.com> (Fabio
	Estevam's message of "Sun, 26 May 2013 18:01:17 -0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org

Hi Fabio,

On Sun, May 26 2013, Fabio Estevam wrote:
> Hi Chris,
>
> On Mon, May 6, 2013 at 3:05 PM, Fabio Estevam
> <fabio.estevam@freescale.com> wrote:
>> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
>> we can rely on device core for handling pinctrl.
>>
>> So remove devm_pinctrl_get_select_default() from the driver.
>>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: <linux-mmc@vger.kernel.org>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Any comments on this one?

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
