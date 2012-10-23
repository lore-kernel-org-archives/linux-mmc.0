From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use helper macro module_platform_driver()
Date: Tue, 23 Oct 2012 17:14:55 -0400
Message-ID: <87liewhovk.fsf@octavius.laptop.org>
References: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1349270797-19189-2-git-send-email-andriy.shevchenko@linux.intel.com>
	<CAFbHwiQQ9KJ_hddRng54THBQ5E=8L5ge=Pkcv3pak2MKnoavHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40144 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933639Ab2JWVO6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:14:58 -0400
In-Reply-To: <CAFbHwiQQ9KJ_hddRng54THBQ5E=8L5ge=Pkcv3pak2MKnoavHg@mail.gmail.com>
	(Will Newton's message of "Thu, 4 Oct 2012 13:10:57 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 04 2012, Will Newton wrote:
> On Wed, Oct 3, 2012 at 2:26 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> Since v3.2 we have nice macro to define the platform driver's init and exit
>> calls. This patch simplifies the dw_mmc platform driver by using that macro.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/mmc/host/dw_mmc-pltfm.c |   14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
