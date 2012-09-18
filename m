From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 29/34] mmc: mxcmmc: remove mach/hardware.h inclusion
Date: Tue, 18 Sep 2012 11:18:42 +0200
Message-ID: <CACKLOr24teo+Y6ZqZCAdg7poMN8w3s0QQavV2F+M=fJCcF0aqA@mail.gmail.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
	<1347860103-4141-30-git-send-email-shawn.guo@linaro.org>
	<m3392h1a0p.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45668 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab2IRJSn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 05:18:43 -0400
Received: by obbuo13 with SMTP id uo13so10158752obb.19
        for <linux-mmc@vger.kernel.org>; Tue, 18 Sep 2012 02:18:42 -0700 (PDT)
In-Reply-To: <m3392h1a0p.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi Shawn,



On 17 September 2012 07:41, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Sep 17 2012, Shawn Guo wrote:
>> It changes the driver to use platform_device_id rather than cpu_is_xxx
>> to determine the controller type, and updates the platform code
>> accordingly.
>>
>> As the result, mach/hardware.h inclusion gets removed from the driver.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: linux-mmc@vger.kernel.org
>
the dma fix provided by Sascha is needed for this patch to work too:

http://www.spinics.net/lists/arm-kernel/msg195690.html

Otherwise:

Tested-by: Javier Martin <javier.martin@vista-silicon.com>


Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
