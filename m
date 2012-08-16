From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3] mmc: card: Skip secure option for MoviNAND.
Date: Thu, 16 Aug 2012 13:14:03 +0900
Message-ID: <502C738B.4080701@samsung.com>
References: <5029F8F6.1080207@samsung.com>
 <CACRpkdYNKxjRXC=4no0p55ADkUvXTEcfW3b2z+Exg=cpHCtAAQ@mail.gmail.com>
 <000f01cd7b64$f70f6620$e52e3260$%cy.chen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37362 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab2HPEOH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Aug 2012 00:14:07 -0400
In-reply-to: <000f01cd7b64$f70f6620$e52e3260$%cy.chen@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: IAN CHEN <ian.cy.chen@samsung.com>
Cc: 'Linus Walleij' <linus.walleij@linaro.org>, cjb@laptop.org, linkinjeon@gmail.com, adrian.hunter@intel.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

On 08/16/2012 01:09 PM, IAN CHEN wrote:
> MMC_QUIRK_SEC_ERASE_TRIM_BROKEN seems quite clear but I might not use "SEC"
> due to it could be Samsung Electronics Corporation.
I didn't think so.
MMC developers didn't think that SEC means Samsung Electronics Corporation.
Already we used the flags with "_SEC_"
It's no problem.

Best Regards,
Jaehoon Chung
> So, how about MMC_QUIRK_SECDISCARD_BROKEN which was used in
> mmc_blk_issue_secdiscard_rq() naming, the function we skip.
> Or, MMC_QUIRK_SECERASE_SECTRIM_BROKEN?
> 
> Regards,
> Ian
> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org] 
> Sent: Tuesday, August 14, 2012 5:07 PM
> To: IAN CHEN
> Cc: cjb@laptop.org; linkinjeon@gmail.com; adrian.hunter@intel.com;
> subhashj@codeaurora.org; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; d.j.shin@samsung.com;
> jongtae22.kim@samsung.com; kyungmin.park@samsung.com; jh80.chung@samsung.com
> Subject: Re: [PATCH v3] mmc: card: Skip secure option for MoviNAND.
> 
> On Tue, Aug 14, 2012 at 9:06 AM, IAN CHEN <ian.cy.chen@samsung.com> wrote:
> 
>> +#define MMC_QUIRK_SECURE_MODE_BROKEN (1<<10)   /* Skip secure for
>> erase/trim */
> 
> OK this will work and sorry for being picky, but we are working with RPMB
> support and that's some other "secure mode" so to avoid any
> misuderstandings it's better to name the flag like I proposed,
> MMC_QUIRK_SEC_ERASE_TRIM_BROKEN
> 
> I won't die if this goes in though :-)
> 
> Yours,
> Linus Walleij
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

