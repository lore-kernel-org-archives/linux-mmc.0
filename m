From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: Revert "mmc: rtsx: add support for pre_req and post_req"
Date: Mon, 28 Apr 2014 12:58:20 +0200
Message-ID: <CAPDyKFr6kNjfE+adx_j05wes0Y1fg=zD-AwciWy0vQdw=DbOrg@mail.gmail.com>
References: <1398670584-26687-1-git-send-email-micky_ching@realsil.com.cn>
	<20140428105350.GM21279@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:60420 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbaD1K6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 06:58:21 -0400
Received: by mail-qg0-f47.google.com with SMTP id e89so6640051qgf.20
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2014 03:58:20 -0700 (PDT)
In-Reply-To: <20140428105350.GM21279@lee--X1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On 28 April 2014 12:53, Lee Jones <lee.jones@linaro.org> wrote:
>> From: Micky Ching <micky_ching@realsil.com.cn>
>>
>> This reverts commit c42deffd5b53c9e583d83c7964854ede2f12410d.
>
> Why was this patch even merged without an MFD Ack?
>
>> commit <mmc: rtsx: add support for pre_req and post_req> did use
>> mutex_unlock() in tasklet, but mutex_unlock() can't used in
>> tasklet(atomic context). The driver need use mutex to avoid concurre=
ncy,
>> so we can't use tasklet here, the patch need to be removed.
>>
>> The spinlock host->lock and pcr->lock may deadlock, one way to solve=
 the
>> deadlock is remove host->lock in sd_isr_done_transfer(), but if usin=
g
>> workqueue the we can avoid using the spinlock and also avoid the pro=
blem.
>>
>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
>> ---
>>  drivers/mfd/rtsx_pcr.c            |  132 ++++--------
>>  drivers/mmc/host/rtsx_pci_sdmmc.c |  418 ++++++--------------------=
-----------
>>  include/linux/mfd/rtsx_common.h   |    1 -
>>  include/linux/mfd/rtsx_pci.h      |    6 -
>>  4 files changed, 109 insertions(+), 448 deletions(-)
>
> This patch should be sent to the -rcs as soon as possible:

Do you mind helping out doing it here Lee? Not sure how busy Chris is
at the moment.

Kind regards
Ulf Hansson

>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
