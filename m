From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH 0/4] mmc: core: hw_reset changes
Date: Mon, 3 Nov 2014 09:46:14 +0100
Message-ID: <CA+20K0DgFFxsfyTu0U-8mq0cZSmNE6xAa0UyBBYdRKCViLjy6A@mail.gmail.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:33742 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaKCIqT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Nov 2014 03:46:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 068A61806C
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 09:46:18 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DJ9841Ty7slZ for <linux-mmc@vger.kernel.org>;
	Mon,  3 Nov 2014 09:46:16 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 756D01807C
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 09:46:16 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 5D830DA2
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 09:46:16 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 50DCF607
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 09:46:16 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 4DDC4342B9
	for <linux-mmc@vger.kernel.org>; Mon,  3 Nov 2014 09:46:16 +0100 (CET)
Received: by mail-qg0-f54.google.com with SMTP id q108so8239000qgd.41
        for <linux-mmc@vger.kernel.org>; Mon, 03 Nov 2014 00:46:14 -0800 (PST)
In-Reply-To: <1414154790-20893-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johanru@axis.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

Hi all,

any comments on this patch set?

//Johan

2014-10-24 14:46 GMT+02:00 Johan Rudholm <johan.rudholm@axis.com>:
> Make the mmc_hw_reset routines more generic, so we can easily add a
> power cycle of SD cards as well. Also simplify the (e)MMC specific
> parts of the reset code.
>
> As I don't have an eMMC device myself, much less one with a reset line,
> I'd be very happy if someone could help me test the code with an eMMC?
>
> Johan Rudholm (4):
>   mmc: core: use mmc_send_status to check hw_reset
>   mmc: core: use mmc_power_up in hw_reset
>   mmc: core: make hw_reset generic
>   mmc: sd: add power_reset callback
>
>  drivers/mmc/card/block.c    |    2 +-
>  drivers/mmc/card/mmc_test.c |    5 +--
>  drivers/mmc/core/core.c     |   73 ++++++++-----------------------------------
>  drivers/mmc/core/core.h     |    4 ++
>  drivers/mmc/core/mmc.c      |   40 +++++++++++++++++++++++
>  drivers/mmc/core/sd.c       |   16 +++++++++
>  include/linux/mmc/core.h    |    5 +--
>  7 files changed, 77 insertions(+), 68 deletions(-)
>
> --
> 1.7.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
