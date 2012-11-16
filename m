From: Krishna Konda <kkonda@codeaurora.org>
Subject: Re: Fwd: [PATCH v3 1/5] mmc: core: Expose access to RPMB partition
Date: Fri, 16 Nov 2012 13:32:32 -0800
Message-ID: <1353101552.6697.9.camel@kkonda-linux.qualcomm.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	 <1344265951-22437-2-git-send-email-loic.pallardy-ext@stericsson.com>
	 <CAJOk3oHfTMr7-esASZKV0kmiFmeGzD1OjgwMZrTtz8Pk61Lswg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:60133 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab2KPVcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 16:32:33 -0500
In-Reply-To: <CAJOk3oHfTMr7-esASZKV0kmiFmeGzD1OjgwMZrTtz8Pk61Lswg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: loic.pallardy-ext@stericsson.com, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linus.walleij@linaro.org, STEricsson_nomadik_linux@list.st.com, ulf.hansson@stericcson.com, alex.macro@stericsson.com

On Fri, 2012-11-16 at 13:16 -0800, Krishna Konda wrote:
> 
> 
> From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
> Date: Mon, Aug 6, 2012 at 8:12 AM
> Subject: [PATCH v3 1/5] mmc: core: Expose access to RPMB partition
> To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux
> <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson
> <ulf.hansson@stericcson.com>, Loic Pallardy
> <loic.pallardy-ext@stericsson.com>, Alex Macro
> <alex.macro@stericsson.com>, Loic Pallardy
> <loic.pallardy@stericsson.com>
> 
> 
> Following JEDEC standard, if the mmc support RPMB partition,
> a new interface is created and exposed via /dev/block.
> Users will be able to access RPMB partition using standard
> mmc IOCTL command.
> 
> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
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

