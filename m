From: Kalle Valo <kvalo@adurom.com>
Subject: Re: [PATCH] sdio: add new function for RAW (Read after Write)
	operation
Date: Mon, 17 May 2010 09:43:36 +0300
Message-ID: <AANLkTil49xWUSeUCGk_EQgdfOUSnFyKv6xf-RW7RX661@mail.gmail.com>
References: <1272403088-4727-1-git-send-email-notasas@gmail.com>
	 <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58623 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0EQGni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 May 2010 02:43:38 -0400
Received: by fxm6 with SMTP id 6so3414244fxm.19
        for <linux-mmc@vger.kernel.org>; Sun, 16 May 2010 23:43:36 -0700 (PDT)
In-Reply-To: <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

On 14 May 2010 14:04, Grazvydas Ignotas <notasas@gmail.com> wrote:
> Hi Kalle,

Hi Grazvydas,

> On Wed, Apr 28, 2010 at 12:18 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>> SDIO specification allows RAW (Read after Write) operation using
>> IO_RW_DIRECT command (CMD52) by setting the RAW bit. This operation is
>> similar to ordinary read/write commands, except that both write and read
>> are performed using single command/response pair. The Linux SDIO layer
>> already supports this internaly, only external function is missing for
>> drivers to make use, which is added by this patch.
>>
>> This type of command is required to implement proper power save mode
>> support in wl1251 wifi driver.
>
> As wl1251 maintainer, can you confirm this is needed for wl1251 driver
> to function in SDIO mode? Perhaps this could help convince Andrew to
> merge this patch. Without this the chip is having problems leaving ELP
> mode.

Yes, this is needed for wl1251 (and I would assume also for wl1271) to
wake up firmware from it's sleep state, also called as the ELP mode. A
TI engineer has confirmed this for me.

Kalle
