From: Krishna Konda <kkonda@codeaurora.org>
Subject: Re: Fwd: [PATCH v3 5/5] mmc: card: Add RPMB support in IOCTL
 interface
Date: Fri, 16 Nov 2012 13:23:03 -0800
Message-ID: <1353100983.5776.5.camel@kkonda-linux.qualcomm.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	 <1344265951-22437-6-git-send-email-loic.pallardy-ext@stericsson.com>
	 <CAJOk3oERiGjxm-u6iGZLxK0Mq5noC76d33ojwVtY3gtdRBju3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:59413 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2KPVXE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 16:23:04 -0500
In-Reply-To: <CAJOk3oERiGjxm-u6iGZLxK0Mq5noC76d33ojwVtY3gtdRBju3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: loic.pallardy-ext@stericsson.com, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linus.walleij@linaro.org, STEricsson_nomadik_linux@list.st.com, ulf.hansson@stericcson.com, alex.macro@stericsson.com

On Fri, 2012-11-16 at 13:17 -0800, Krishna Konda wrote:
> 
> 
> From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
> Date: Mon, Aug 6, 2012 at 8:12 AM
> Subject: [PATCH v3 5/5] mmc: card: Add RPMB support in IOCTL interface
> To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux
> <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson
> <ulf.hansson@stericcson.com>, Loic Pallardy
> <loic.pallardy-ext@stericsson.com>, Alex Macro
> <alex.macro@stericsson.com>, Loic Pallardy
> <loic.pallardy@stericsson.com>
> 
> 
> RPMB partition is accessing though /dev/block/mmcXrpmb device
> User callers can read and write entire data frame(s) as defined
> by JEDEC Standard JESD84-A441, using standard IOCTL interface.
> 
> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Acked-by: Krishna Konda <kkonda@codeaurora.org>


-- 

Thanks,
Krishna Konda
-----------------------------------------------------------------------
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
hosted by The Linux Foundation
-----------------------------------------------------------------------

