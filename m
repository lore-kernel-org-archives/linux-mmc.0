From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: core: Fix the incorrect calculation for erase unit
 size.
Date: Wed, 14 Sep 2011 11:27:26 +0900
Message-ID: <002f01cc7285$d80dc660$88295320$%jun@samsung.com>
References: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
 <m24o0n6ujm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m24o0n6ujm.fsf@bob.laptop.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Chris Ball wrote:
> 
> Hi,
> 
> On Thu, Sep 08 2011, Seungwon Jeon wrote:
> > Erase unit size of high capacity is multiple of 512KiB not 1024KiB.
> 
> Could we have some more info, please?  What are the visible symptoms
> of the erase unit size being incorrect, how did you realize this was
> a problem, should this patch be applied to stable@, etc.

It is mentioned from eMMC Spec.
Erase unit size is defined in 512Kbyte * HC_ERASE_GRP_SIZE(EXT_CSD[224]).

Thanks.

> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
