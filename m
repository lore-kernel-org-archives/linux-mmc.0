From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
Date: Fri, 28 Jun 2013 21:18:59 +0530
Message-ID: <51CDB06B.9010604@ti.com>
References: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
	<CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
	<51CC2A1E.2040003@ti.com>
	<CAD=GYpa9LQ1fV6=O9B65sJURVAigsgXCPLWav8cHXTuGQXPc9A@mail.gmail.com>
	<51CC67CA.2070805@ti.com>
	<083BC63EECB6FD41B8E81CF7FD87CC0F2E4F0F95@DLEE08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F0F95-YmePFLaaepqIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Fernandes, Joel" <joelf-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday 27 June 2013 11:38 PM, Fernandes, Joel wrote:
> Hi Balaji,
>

<snip>

>>> Some patches were squashed and others dropped in the series resulting
>>> in the single patch above. This patch should be good to apply
>> Hi Joel,
>>
>> Before pushing mmc dts support for am335x, Can you please let me
>> know if below 2 patches [1] are merged/accepted,
>> IIRC these patches are needed for MMC to work properly.
>>
>> I suggest to hold the dts patch until slave_sg_limit gets merged
>> otherwise it will cause regression in am335x mmc.
>>
>> [PATCH v4 1/3] dmaengine: add dma_get_slave_sg_limits()
>> [PATCH v4 2/3] dma: edma: add device_slave_sg_limits() support
>
> Actually this is an independent regression and is currently worked on by Lars-Peter Clausen [1].
>
> Currently not having the MMC DTS merged is also a regression,

No, Right now mmc support is not added to am335x, so it is not really a regression

 > so I suggest lets take it one
> step at a time and get the DTS merged in first. Also there will be overhead of reposting this
> DTS patch later again which will not change. What do you say?
>

If it gets enabled via dts, without slave sg limit support,
file read/write will fail, possibly corrupting file system.

> Thanks,
>
> -Joel
>
> [1] https://patchwork.kernel.org/patch/2228041/
>
