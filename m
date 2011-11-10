From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Thu, 10 Nov 2011 23:01:56 +0100
Message-ID: <CAFEEs1kRrJT+SzbUN5U0rpR0CyRZsH6it-iemBOMKK=tGkOSSw@mail.gmail.com>
References: <4EB11B6B.2010909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46890 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1KJWB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 17:01:57 -0500
Received: by vcbf1 with SMTP id f1so2862509vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2011 14:01:56 -0800 (PST)
In-Reply-To: <4EB11B6B.2010909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

Hi Jaehoon,

On Wed, Nov 2, 2011 at 11:28 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> Enable eMMC background operations (BKOPS) feature.
>
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.
>
> If you want to enable this feature, set MMC_CAP2_BKOPS.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>
> ---
> Changelog V2:
> =A0 =A0 =A0 =A0- Use EXCEPTION_STATUS instead of URGENT_BKOPS
> =A0 =A0 =A0 =A0- Add function to check Exception_status(for eMMC4.5)
> =A0 =A0 =A0 =A0- remove unnecessary code.
Will there be a V3 soon?

I have tested this patch with my minor changes on top and as far as I
can tell it looks ok.
I'm ready to accept this patch if those minor updates are made in V3.

Thanks,
Per
