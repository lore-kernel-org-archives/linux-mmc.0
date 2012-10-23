From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv2] mmc: dw_mmc: use __devexit_p macro for .remove()
Date: Tue, 23 Oct 2012 17:13:26 -0400
Message-ID: <87pq48hoy1.fsf@octavius.laptop.org>
References: <CAGxe1ZHF--qR68A4PGBwmFe85DZUK3gxQWE+05PT9yKBUWOPrg@mail.gmail.com>
	<1349271927-6260-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<CAFbHwiTziS2Q+av6e2z6vZk0uoStZb8C8C5KkfCjtw5c4p=SEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56687 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965694Ab2JWVNc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:13:32 -0400
In-Reply-To: <CAFbHwiTziS2Q+av6e2z6vZk0uoStZb8C8C5KkfCjtw5c4p=SEw@mail.gmail.com>
	(Will Newton's message of "Thu, 4 Oct 2012 13:11:40 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

Hi,

On Thu, Oct 04 2012, Will Newton wrote:
> On Wed, Oct 3, 2012 at 2:45 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/mmc/host/dw_mmc-pci.c   |    2 +-
>>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.8

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
