From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Sun, 10 Oct 2010 08:50:33 +0200
Message-ID: <4CB16239.1050203@compulab.co.il>
References: <cover.1266847842.git.david.vrabel@csr.com><20100827192248.GJ20407@void.printf.net><4C7CC480.2040903@csr.com><4C7F3E0F.2080402@compulab.co.il><AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com><C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com><AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com><CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com><AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com><4CAC146D.3040001@compulab.co.il><AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com><4CAC7D65.8010705@compulab.co.il><AANLkTikvduxP+gQOs4HvZz2Yw6KCrqHAyim0Ads0Bvj_@mail.gmail.com><56009.192.168.10.88.1286389699.squirrel@dbdmail.itg.ti.com><4CAD739B.4090909@compulab.co.il> <AANLkTimvHnLAchE-Ed1Zve-PU6S98Euj=bFaAtkDWWji@mail.gmail.com> <B02FD62E0C9F4E
 70856C21355A0BAB59@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48322 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab0JJGuz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 10 Oct 2010 02:50:55 -0400
In-Reply-To: <B02FD62E0C9F4E70856C21355A0BAB59@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Steve Sakoman' <sakoman@gmail.com>, 'David Vrabel' <david.vrabel@csr.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, 'Adrian Hunter' <adrian.hunter@nokia.com>, Mike Rapoport <mike@compulab.co.il>

Hi Madhu,

Madhusudhan wrote:
> 
>> -----Original Message-----
>> From: Steve Sakoman [mailto:sakoman@gmail.com]
>> Sent: Thursday, October 07, 2010 8:57 AM
>> To: Mike Rapoport
>> Cc: Madhusudhan Chikkature; David Vrabel; Chris Ball; linux-
>> mmc@vger.kernel.org; linux-omap@vger.kernel.org; Adrian Hunter
>> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
>>
>> I can confirm exactly the same behavior on my hardware with this
>> version of the patch.
> 
> Steve,
> 
> Okay. Did the version you had in your tree worked? I just want to check if I
> messed up something in my patch.

The patch works if applied before commit 
b417577d3b9bbb06a4ddc9aa955af9bd503f7242 (omap_hsmmc: improve interrupt 
synchronisation). Apparently, changes in interrupt handling require major rework 
  of the SDIO interrupt handling...

> Regards,
> Madhu
> 
>> Steve
> 


-- 
Sincerely yours,
Mike.
