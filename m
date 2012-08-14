From: IAN CHEN <ian.cy.chen@samsung.com>
Subject: RE: [PATCH] mmc: card: Skip secure option for MoviNAND.
Date: Tue, 14 Aug 2012 11:10:04 +0900
Message-ID: <000101cd79c1$ebf01040$c3d030c0$%cy.chen@samsung.com>
References: <5028CDED.2020307@samsung.com>
 <CAKYAXd--Ta1xL2uMEsArmpsg99x+B21ScJOQAty=RFWWCQ6M2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd--Ta1xL2uMEsArmpsg99x+B21ScJOQAty=RFWWCQ6M2w@mail.gmail.com>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Namjae Jeon' <linkinjeon@gmail.com>
Cc: cjb@laptop.org, adrian.hunter@intel.com, subhashj@codeaurora.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com
List-Id: linux-mmc@vger.kernel.org

Dear Mr. Jeon,

This is workaround for some Samsung eMMC, MoviNAND.
There are known issue about secure erase & secure trim with these eMMC device which I listed by product_name.
Therefore, for these eMMC devices, we just skip mmc_blk_issue_secdiscard_rq() and use mmc_blk_issue_discard_rq() instead.

You could refer this discussion in XDA developers.
    http://forum.xda-developers.com/showthread.php?t=1644364
    https://plus.google.com/111398485184813224730/posts/21pTYfTsCkB#111398485184813224730/posts/21pTYfTsCkB

Regards,
Ian
 
-----Original Message-----
From: Namjae Jeon [mailto:linkinjeon@gmail.com] 
Sent: Monday, August 13, 2012 10:03 PM
To: IAN CHEN
Cc: cjb@laptop.org; adrian.hunter@intel.com; subhashj@codeaurora.org; linus.walleij@linaro.org; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; d.j.shin@samsung.com; jongtae22.kim@samsung.com; kyungmin.park@samsung.com; jh80.chung@samsung.com
Subject: Re: [PATCH] mmc: card: Skip secure option for MoviNAND.

Hi. Ian.

known issue ? Would you explain more ?

Thanks.

2012/8/13 IAN CHEN <ian.cy.chen@samsung.com>:
> From 5c60eb8be04c7440d6e33b8f72ea2046a3657ac4 Mon Sep 17 00:00:00 2001
> From: ian.cy.chen <ian.cy.chen@samsung.com>
> Date: Mon, 13 Aug 2012 10:53:55 +0900
> Subject: [PATCH] mmc: card: Skip secure option for MoviNAND.
>
> For several MoviNAND, there are some known issue with secure option.
> For these specific MoviNAND device, we skip secure option.
>
> Signed-off-by: Ian Chen <ian.cy.chen@samsung.com>
> ---
>  drivers/mmc/card/block.c |   24 +++++++++++++++++++++++-
>  include/linux/mmc/card.h |    1 +
>  2 files changed, 24 insertions(+), 1 deletions(-)
>
