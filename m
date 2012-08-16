From: IAN CHEN <ian.cy.chen@samsung.com>
Subject: RE: [PATCH v3] mmc: card: Skip secure option for MoviNAND.
Date: Thu, 16 Aug 2012 13:09:39 +0900
Message-ID: <000f01cd7b64$f70f6620$e52e3260$%cy.chen@samsung.com>
References: <5029F8F6.1080207@samsung.com>
 <CACRpkdYNKxjRXC=4no0p55ADkUvXTEcfW3b2z+Exg=cpHCtAAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CACRpkdYNKxjRXC=4no0p55ADkUvXTEcfW3b2z+Exg=cpHCtAAQ@mail.gmail.com>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Linus Walleij' <linus.walleij@linaro.org>
Cc: cjb@laptop.org, linkinjeon@gmail.com, adrian.hunter@intel.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com
List-Id: linux-mmc@vger.kernel.org

MMC_QUIRK_SEC_ERASE_TRIM_BROKEN seems quite clear but I might not use "SEC"
due to it could be Samsung Electronics Corporation.
So, how about MMC_QUIRK_SECDISCARD_BROKEN which was used in
mmc_blk_issue_secdiscard_rq() naming, the function we skip.
Or, MMC_QUIRK_SECERASE_SECTRIM_BROKEN?

Regards,
Ian
-----Original Message-----
From: Linus Walleij [mailto:linus.walleij@linaro.org] 
Sent: Tuesday, August 14, 2012 5:07 PM
To: IAN CHEN
Cc: cjb@laptop.org; linkinjeon@gmail.com; adrian.hunter@intel.com;
subhashj@codeaurora.org; linux-mmc@vger.kernel.org;
linux-kernel@vger.kernel.org; d.j.shin@samsung.com;
jongtae22.kim@samsung.com; kyungmin.park@samsung.com; jh80.chung@samsung.com
Subject: Re: [PATCH v3] mmc: card: Skip secure option for MoviNAND.

On Tue, Aug 14, 2012 at 9:06 AM, IAN CHEN <ian.cy.chen@samsung.com> wrote:

> +#define MMC_QUIRK_SECURE_MODE_BROKEN (1<<10)   /* Skip secure for
> erase/trim */

OK this will work and sorry for being picky, but we are working with RPMB
support and that's some other "secure mode" so to avoid any
misuderstandings it's better to name the flag like I proposed,
MMC_QUIRK_SEC_ERASE_TRIM_BROKEN

I won't die if this goes in though :-)

Yours,
Linus Walleij
