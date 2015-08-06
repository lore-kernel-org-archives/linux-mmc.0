From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [RFC] sdhci: fix DMA leaks [was: [SHDCI] Heavy (thousands) DMA
 leaks]
Date: Thu, 6 Aug 2015 11:06:45 +0200
Message-ID: <55C323A5.6050303@suse.cz>
References: <55B9EF02.7040404@suse.cz>
 <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
 <55BF36D6.4080504@suse.cz> <55C1F919.4080002@suse.cz>
 <55C227B4.3030102@suse.cz>
 <BY1PR03MB13889A6C31FC542DB544CE479A740@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BY1PR03MB13889A6C31FC542DB544CE479A740@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 08/06/2015, 09:42 AM, Chen Bough wrote:
> I read your attached log and patch, yes, dma memory leak will happen when
> more than one pre_request execute. The method of ++next->cookie is not good,
> your patch seems good, but I still need some time to test the patch, because
> you unmap the dma in sdhci_finish_data rather than the sdhci_post_req.

Hi,

yes, this is not correct. We can perhaps differentiate according to the
COOKIE value. Should I fix it or are you going to prepare a patch based
on my RFC?

thanks,
-- 
js
suse labs
