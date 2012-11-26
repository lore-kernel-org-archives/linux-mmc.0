From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 1/7] mmc: omap_hsmmc: Fix Oops in case of data errors
Date: Mon, 26 Nov 2012 17:32:23 +0530
Message-ID: <CAOyx1LqzYVCABRZ+7U8Tzp5mDdT25Dsawkbo4bftO6+NJfXB0w@mail.gmail.com>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
	<87sj7x76hd.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:63089 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab2KZMCZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 07:02:25 -0500
In-Reply-To: <87sj7x76hd.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

On Mon, Nov 26, 2012 at 2:19 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Venkat,
>
> On Mon, Nov 19 2012, Venkatraman S wrote:
>> From: Balaji T K <balajitk@ti.com>
>>
>> "commit ae4bf788ee9bf7c2d51b0309117d1fcccbdd50a2
>> mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ"
>> sets both end_cmd and end_trans to 1.
>>
>> Setting end_cmd to 1 for Data Timeout/CRC leads to NULL pointer dereference of
>> host->cmd as the command complete has previously been handled.
>> Set end_cmd only in case of command Timeout/CRC.
>>
>> Moreover host->cmd->error should not be updated on data error case, only
>> host->data->error needs to be updated.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>
> Thanks, pushed all 7 patches to mmc-next for 3.8.
>
Great - Thank you !
