From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH RESEND 1/8] mmc: omap: Enable Auto CMD12
Date: Fri, 16 Mar 2012 10:55:00 +0530
Message-ID: <CANfBPZ-_WGEx2OmCdJmE2AP_CmYSUiqRqsamwUXRm=+rExyQpA@mail.gmail.com>
References: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-2-git-send-email-svenkatr@ti.com> <20120315145750.GQ28447@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51031 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751841Ab2CPFZZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 01:25:25 -0400
Received: by bkuw5 with SMTP id w5so4346504bku.17
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 22:25:20 -0700 (PDT)
In-Reply-To: <20120315145750.GQ28447@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com

On Thu, Mar 15, 2012 at 8:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Mar 15, 2012 at 08:03:35PM +0530, Venkatraman S wrote:
>> From: Balaji T K <balajitk@ti.com>
>>
>> Enable Auto-CMD12 for multi block read/write on HSMMC
>> Tested on OMAP4430, OMAP3430 and OMAP2430 SDP
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>
> BTW, since patches are flowing through you now, they should have your
> SoB line.
>

Sure. I'll edit and send again.
