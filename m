From: Chris Ball <cjb@laptop.org>
Subject: Re: [linux-next] sdhci-s3c build error
Date: Wed, 07 Dec 2011 22:52:17 -0500
Message-ID: <87ehwfu3da.fsf@laptop.org>
References: <1322957045.19303.0.camel@phoenix> <87borpfb9x.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50131 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842Ab1LHDwF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Dec 2011 22:52:05 -0500
In-Reply-To: <87borpfb9x.fsf@laptop.org> (Chris Ball's message of "Sat, 03 Dec
	2011 19:09:14 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-mmc@vger.kernel.org, Sangwook Lee <sangwook.lee@samsung.com>

Hi,

On Sat, Dec 03 2011, Chris Ball wrote:
>>   CC      drivers/mmc/host/sdhci-s3c.o
>> drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
>> drivers/mmc/host/sdhci-s3c.c:524: error: 'struct s3c_sdhci_platdata'
>> has no member named 'pm_caps'
>> drivers/mmc/host/sdhci-s3c.c:525: error: 'struct s3c_sdhci_platdata'
>> has no member named 'pm_caps'
>> make[3]: *** [drivers/mmc/host/sdhci-s3c.o] Error 1
>> make[2]: *** [drivers/mmc/host] Error 2
>> make[1]: *** [drivers/mmc] Error 2
>> make: *** [drivers] Error 2
>>
>> Forgot to add pm_caps to struct s3c_sdhci_platdata?
>
> Known, see http://thread.gmane.org/gmane.linux.kernel.mmc/11464.
>
> I'll pull in the arch code fix, but I need to rebase mmc-next against
> a newer Linus tree first (else the patch doesn't apply).

I've rebased and pulled this patch into mmc-next now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
