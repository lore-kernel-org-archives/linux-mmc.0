From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix the incorrect calculation for erase unit size.
Date: Thu, 08 Sep 2011 09:19:25 -0400
Message-ID: <m24o0n6ujm.fsf@bob.laptop.org>
References: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
	(Seungwon Jeon's message of "Thu, 8 Sep 2011 14:59:25 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Sep 08 2011, Seungwon Jeon wrote:
> Erase unit size of high capacity is multiple of 512KiB not 1024KiB.

Could we have some more info, please?  What are the visible symptoms
of the erase unit size being incorrect, how did you realize this was
a problem, should this patch be applied to stable@, etc.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
