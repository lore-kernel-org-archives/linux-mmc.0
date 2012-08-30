From: IAN CHEN <ian.cy.chen@samsung.com>
Subject: RE: [PATCH v6] mmc: card: Skip secure option for MoviNAND.
Date: Thu, 30 Aug 2012 10:36:42 +0900
Message-ID: <000401cd864f$e881a000$b984e000$%cy.chen@samsung.com>
References: <503DB130.8090807@samsung.com> <873936vvrg.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <873936vvrg.fsf@octavius.laptop.org>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linkinjeon@gmail.com, adrian.hunter@intel.com, subhashj@codeaurora.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi,

Thanks for your help.
The effected kernel will be all the version with MMC_CAP_ERASE & SECURE
option enabled.
As commit content mentioned, the problem is unrecoverable corruption after
SECURE ERASE or SECURE TRIM.
For devices using defective eMMC with kernel supporting MMC_CAP_ERASE &
SECURE option, this issue might cause damage.
Therefore, we skip secure for these known devices.

Regards,
Ian

-----Original Message-----
From: Chris Ball [mailto:cjb@laptop.org] 
Sent: Wednesday, August 29, 2012 7:27 PM

Hi,

On Wed, Aug 29 2012, IAN CHEN wrote:
> For several MoviNAND, there are some known issue with secure option.
> For these specific MoviNAND device, we skip secure option.
>
> You could refer this discussion in XDA developers.
> http://forum.xda-developers.com/showthread.php?t=1644364
>
https://plus.google.com/111398485184813224730/posts/21pTYfTsCkB#111398485184
813224730/posts/21pTYfTsCkB
>
> Signed-off-by: Ian Chen <ian.cy.chen@samsung.com>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.  We should explain the nature of the bug in the commit message,
so that users and the stable@ maintainers know how bad the problem is
by reading the patch.  (This should go to stable@, right?  Do you know
which kernel versions are affected?)

I'll add something like this, unless you have a better proposal:

==
For several MoviNAND, there are some known issues with secure option.
For these specific MoviNAND device, we skip secure option.

Specifically, there is a bug in the eMMC firmware that causes 
unrecoverable corruption when the MMC is erased with MMC_CAP_ERASE
enabled.

You could refer this discussion in XDA developers.
http://forum.xda-developers.com/showthread.php?t=1644364
https://plus.google.com/111398485184813224730/posts/21pTYfTsCkB#111398485184
813224730/posts/21pTYfTsCkB
==

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
