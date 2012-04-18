From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc: core: Fix the HPI execution sequence
Date: Thu, 19 Apr 2012 08:03:14 +0900
Message-ID: <CAKYAXd_MM07n6Vm5ggFxNLn5QGUarXaXGT7JE4htwKY_CAz4cA@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
	<1334760358-17568-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41639 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2DRXDP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 19:03:15 -0400
Received: by wibhq7 with SMTP id hq7so1173693wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 16:03:14 -0700 (PDT)
In-Reply-To: <1334760358-17568-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, jh80.chung@samsung.com

2012/4/18 Venkatraman S <svenkatr@ti.com>:
> mmc_execute_hpi should send the HPI command only
> once, only if the card is in PRG state.
>
> According to eMMC spec, the command's completion time is
> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
> defined to begin at the end of sending the command itself.
>
> Specify the default timeout for the actual sending of HPI
> command, and then use OUT_OF_INTERRUPT_TIME to wait for
> the transition out of PRG state.
>
> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
Looks good to me~
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Thanks.
> ---
