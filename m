From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Wed, 06 Oct 2010 15:45:09 +0200
Message-ID: <4CAC7D65.8010705@compulab.co.il>
References: <cover.1266847842.git.david.vrabel@csr.com>	<20100827192248.GJ20407@void.printf.net>	<4C7CC480.2040903@csr.com>	<4C7F3E0F.2080402@compulab.co.il>	<AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>	<C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>	<AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>	<CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com>	<AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>	<4CAC146D.3040001@compulab.co.il> <AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, David Vrabel <david.vrabel@csr.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-mmc@vger.kernel.org

Hi Steve,
Steve Sakoman wrote:
> On Tue, Oct 5, 2010 at 11:17 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> 
>> I've tried to update the patches on top of 2.6.36-rc3 and I've got stuck.
>> The changes Adrian has made to the interrupt synchronization  affect the way
>> the
>> SDIO irq should be implemented and I haven't found a way to resolve it :-(
> 
> I tried my hand at making the patch apply on 2.6.35:
> 
> http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=51b802d73191c306618cddefbd63379c839589f5

This one fails to build:

   CC      drivers/mmc/host/omap_hsmmc.o
drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_start_command': 

drivers/mmc/host/omap_hsmmc.c:791: warning: unused variable 'int_en_mask' 

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_do_irq': 

drivers/mmc/host/omap_hsmmc.c:1023: error: label 'out' used but not defined 

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_irq': 

drivers/mmc/host/omap_hsmmc.c:1101: warning: label 'out' defined but not used 

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend': 

drivers/mmc/host/omap_hsmmc.c:2346: warning: unused variable 'state' 

make[4]: *** [drivers/mmc/host/omap_hsmmc.o] Error 1

Moving the 'out' label where I believe it should live I get:
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
libertas: command 0x0003 timed out
libertas: Timeout submitting command 0x0003
libertas: PREP_CMD: command 0x0003 failed: -110
libertas_sdio: probe of mmc1:0001:1 failed with error -110

> 
> It seems to work, but I'm pretty sure I must have messed something up
> because I get error messages every once in a while:
> 
> libertas: tx watch dog timeout
> 
> I don't recall seeing these with the original version of the patch :-(
> 
> Suggestions as to where I went wrong are welcome!

I've "applied" the patch almost the same way you did and I was not able to get 
any further than the point above (command 0x0003 timed out). As far as I 
understand, what we have now is that omap_hsmmc_request_done() calls 
omap_hsmmc_disable_irq() and the interrupts that come from the 8686 _between_ 
requests are simply missed. Whatever I've tried to keep the SDIO interrupts on 
didn't help... :(

> Steve


-- 
Sincerely yours,
Mike.
