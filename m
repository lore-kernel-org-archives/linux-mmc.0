From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix wrong SDMMC_GET_FCNT macro
Date: Mon, 26 Sep 2011 10:30:38 +0100
Message-ID: <CAFbHwiQCCfzWme31tk23kQ1kNuQvbN7JxbX-6jdBRRj+wZ5Edw@mail.gmail.com>
References: <4E8010A0.7060106@samsung.com>
	<4E803254.9050908@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61935 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab1IZJaj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2011 05:30:39 -0400
Received: by pzk1 with SMTP id 1so14289093pzk.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2011 02:30:38 -0700 (PDT)
In-Reply-To: <4E803254.9050908@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Mon, Sep 26, 2011 at 9:05 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On 09/26/2011 06:41 AM, Jaehoon Chung wrote:
>> I understood that SDMMC_GET_FCNT is used to get fifo_count.
>> In status register, fifo_count is bit[17:29].
>> But this macro is control with bit[17:25].
>>
>> i think right that change 0x1FFF instead of 0x1FF.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.Park@samsung.com>
>
> nice catch.
>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Yes, looks correct.

Acked-by: Will Newton <will.newton@imgtec.com>
