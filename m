From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/5] mmc: dw-mmc: fixed the section mismatch in reference
Date: Mon, 27 Aug 2012 19:10:11 -0400
Message-ID: <87pq6cx770.fsf@octavius.laptop.org>
References: <503614A4.2070801@samsung.com>
	<CAFbHwiSK63g7UQEPb6rPUuhrz=zweL2bbdKicdTKpORxEPhxag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60916 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859Ab2H0XKT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 19:10:19 -0400
In-Reply-To: <CAFbHwiSK63g7UQEPb6rPUuhrz=zweL2bbdKicdTKpORxEPhxag@mail.gmail.com>
	(Will Newton's message of "Thu, 23 Aug 2012 13:13:09 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Hi,

On Thu, Aug 23 2012, Will Newton wrote:
> On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Fixed the below message.
>>
>> WARNING: drivers/mmc/host/built-in.o(.text+0x5ee8): Section mismatch
>> in reference from the function dw_mci_probe() to the function
>> .init.text:dw_mci_init_slot()
>> The function dw_mci_probe() references
>> the function __init dw_mci_init_slot().
>> This is often because dw_mci_probe lacks a __init
>> annotation or the annotation of dw_mci_init_slot is wrong
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc-pltfm.c |    4 ++--
>>  drivers/mmc/host/dw_mmc.c       |    2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Acked-by: Will Newton <will.newton@imgtec.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
