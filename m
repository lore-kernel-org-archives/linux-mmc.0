Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCAFC41513
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jul 2023 15:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGaPIs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGaPIs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2023 11:08:48 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4910EB;
        Mon, 31 Jul 2023 08:08:46 -0700 (PDT)
Message-ID: <c545bc4f-6fe9-eca4-535e-2380fd639ea3@gentoo.org>
Date:   Mon, 31 Jul 2023 11:08:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] rtc: ds1685: use EXPORT_SYMBOL_GPL for
 ds1685_rtc_poweroff
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-4-hch@lst.de>
From:   Joshua Kinard <kumba@gentoo.org>
In-Reply-To: <20230731083806.453036-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/31/2023 04:38, Christoph Hellwig wrote:
> ds1685_rtc_poweroff is only used externally via symbol_get, which was
> only ever intended for very internal symbols like this one.  Use
> EXPORT_SYMBOL_GPL for it so that symbol_get can enforce only being used
> on EXPORT_SYMBOL_GPL symbols.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/rtc/rtc-ds1685.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 0f707be0eb87fa..04dbf35cf3b706 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -1432,7 +1432,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>   		unreachable();
>   	}
>   }
> -EXPORT_SYMBOL(ds1685_rtc_poweroff);
> +EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
>   /* ----------------------------------------------------------------------- */
>   
>   

Acked-by: Joshua Kinard <kumba@gentoo.org>

