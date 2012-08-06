From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 0/3] mmc: dw_mmc: some fixes for error handling
Date: Mon, 6 Aug 2012 10:17:30 +0100
Message-ID: <CAFbHwiQ82g3eBXgTOLWDx1vpA=N4i_b8Ry9er8G7YVJ85Oq7ag@mail.gmail.com>
References: <006201cd6f7c$c9c06730$5d413590$%jun@samsung.com>
	<5019E649.6040203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40565 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab2HFJRa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 05:17:30 -0400
Received: by pbbrr13 with SMTP id rr13so2301537pbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Aug 2012 02:17:30 -0700 (PDT)
In-Reply-To: <5019E649.6040203@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>

On Thu, Aug 2, 2012 at 3:30 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch-set looks good to me.
>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> On 08/01/2012 09:29 AM, Seungwon Jeon wrote:
>> This patch-set includes fixes for the Synopsys DesignWare MMC driver
>>
>> Seungwon Jeon (3):
>>       mmc: dw_mmc: amend using error interrupt status
>>       mmc: dw_mmc: correct mishandling error interrupt
>>       mmc: dw_mmc: fix error handling in PIO mode
>>
>> drivers/mmc/host/dw_mmc.c |   44 ++++++++------------------------------------
>> 1 files changed, 8 insertions(+), 36 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
