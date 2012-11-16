From: Krishna Konda <kkonda@codeaurora.org>
Subject: Re: Fwd: [PATCH v3 2/5] mmc: card: Do not scan RPMB partitions
Date: Fri, 16 Nov 2012 13:31:38 -0800
Message-ID: <1353101498.6697.6.camel@kkonda-linux.qualcomm.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	 <1344265951-22437-3-git-send-email-loic.pallardy-ext@stericsson.com>
	 <CAJOk3oE2gXH1AQQBqq-nuLCEb4--vcMZRYnQJNWOdCP8c0JcAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:22098 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab2KPVbj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 16:31:39 -0500
In-Reply-To: <CAJOk3oE2gXH1AQQBqq-nuLCEb4--vcMZRYnQJNWOdCP8c0JcAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: loic.pallardy-ext@stericsson.com, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linus.walleij@linaro.org, STEricsson_nomadik_linux@list.st.com, ulf.hansson@stericcson.com, johan.rudholm@stericsson.com

On Fri, 2012-11-16 at 13:17 -0800, Krishna Konda wrote:
> 
> 
> From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
> Date: Mon, Aug 6, 2012 at 8:12 AM
> Subject: [PATCH v3 2/5] mmc: card: Do not scan RPMB partitions
> To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux
> <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson
> <ulf.hansson@stericcson.com>, Loic Pallardy
> <loic.pallardy-ext@stericsson.com>, Johan Rudholm
> <johan.rudholm@stericsson.com>
> 
> 
> Do not scan rpmb partitions for "soft" partitions, since the rpmb
> partition contains protected data. Silences the following
> message during boot:
> 
>  mmcblkXRPMB: unknown partition table
> 
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
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

