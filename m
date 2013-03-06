From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 2/3] mmc: omap_hsmmc: Skip platform_get_resource_byname()
 for dt case
Date: Wed, 6 Mar 2013 10:40:55 -0600
Message-ID: <51377197.4070402@ti.com>
References: <1362518004-7083-1-git-send-email-mporter@ti.com> <1362518004-7083-3-git-send-email-mporter@ti.com> <513747C5.6080507@ti.com> <20130306135605.GK6209@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40326 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3CFQlF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Mar 2013 11:41:05 -0500
In-Reply-To: <20130306135605.GK6209@beef>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Balaji T K <balajitk@ti.com>, Chris Ball <cjb@laptop.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vinod Koul <vinod.koul@intel.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>


On 03/06/2013 07:56 AM, Matt Porter wrote:
> On Wed, Mar 06, 2013 at 07:12:29PM +0530, Balaji T K wrote:
>> On Wednesday 06 March 2013 02:43 AM, Matt Porter wrote:
>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> MMC driver probe will abort for DT case because of failed
>>> platform_get_resource_byname() lookup. Fix it by skipping resource
>>> byname lookup for device tree build.
>>>
>>> Issue is hidden because hwmod popullates the IO resources which
>>> helps to succeed platform_get_resource_byname() and probe.
>>>
>>
>> Hi Matt,
>> Could you please drop this patch from the current series,
>> since this patch causes regression on omap3,4 platform
>> which are not yet dma dt adapted.
>> It is best to send this patch along with Jon Hunter dma dt series,
>> which adds dt dma support and mmc dma data. DMA dt series is needed
>> any way before hwmod cleanup can happen.
> 
> *sigh* ok, I should have never split this stuff out from the am33xx
> series. Will do.

There will not be any regression if all of these make the same merge
window. I am hoping that the omap dma patches will make 3.10 as well. I
think that it is best for Matt to keep his patches together although now
I see he has already posted a V3 dropping this :-(

Jon
