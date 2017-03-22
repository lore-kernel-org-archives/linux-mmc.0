From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: RE: [PATCH V1] mmc: core: fix still flush cache when eMMC cache off
Date: Wed, 22 Mar 2017 17:31:05 +0000
Message-ID: <bd3043d41c0841909af60c7dd192fe6e@SIWEX5A.sing.micron.com>
References: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
 <CGME20170320113503epcas1p1115fcb2a974a38a4133230b5b9013fbb@epcas1p1.samsung.com>
 <2636452.c51ovjH1JX@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:61811 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934824AbdCVRbX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 13:31:23 -0400
In-Reply-To: <2636452.c51ovjH1JX@amdc3058>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "axboe@fb.com" <axboe@fb.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Ping Linux-mmc maintainer...

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>On Sunday, March 19, 2017 12:45:40 AM Bean Huo wrote:
>> This patch fixes the issue that mmc_blk_issue_rq still flushes cache
>> when eMMC cache has already been off through user space tool, such as
>> mmc-utils.
>> The reason is that card->ext_csd.cache_ctrl isn't reset.
>>
>> Signed-off-by: beanhuo <beanhuo@micron.com>
>
>
>Best regards,
>--
>Bartlomiej Zolnierkiewicz
>Samsung R&D Institute Poland
>Samsung Electronics
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of
>a message to majordomo@vger.kernel.org More majordomo info at
>http://vger.kernel.org/majordomo-info.html

//beanhuo
