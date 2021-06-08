Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D192C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CEE61042
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 15:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhFHPw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:52:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:17817 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhFHPwZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 11:52:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210608155031euoutp02ea34005037b758979a3c8365a0d29693~Gpi3BVyym1476614766euoutp02q
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 15:50:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210608155031euoutp02ea34005037b758979a3c8365a0d29693~Gpi3BVyym1476614766euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623167431;
        bh=lQDN/fpAzqGYy7LzoYvp6Ion14lhyWtEa5vksLY4N8o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=afu7GIkBKrqCxH9i4WU5VR+kmhybC9ie5vCC38LgCH3OVLmrSv4S2QS+cSrK0I3D1
         hR9ZfYf1bt7oh5vblJg9NPX4ocpgKzk82BdDtbq4TzrlbpLGEqEmcx/7GwA6iOcn6y
         4NTDAKinUJ+J2sW2UBMn6dqdkpwE4dVx/0BvPQTI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210608155030eucas1p1683fd440e38132411ef60cd791e0371d~Gpi2rCkf63069630696eucas1p1j;
        Tue,  8 Jun 2021 15:50:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 96.93.09452.6C19FB06; Tue,  8
        Jun 2021 16:50:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210608155030eucas1p19993729a4e2ada763234d6c1202e305e~Gpi2P6mRb3070030700eucas1p1Z;
        Tue,  8 Jun 2021 15:50:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210608155030eusmtrp1936cc162daf97d4d00ef7fe40fbde0aa~Gpi2PGKnq1228612286eusmtrp1Y;
        Tue,  8 Jun 2021 15:50:30 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-58-60bf91c67443
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.B0.08705.6C19FB06; Tue,  8
        Jun 2021 16:50:30 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210608155029eusmtip2ec2b417eb14cea309d9f789ff9f35652~Gpi1eVv8v1396313963eusmtip26;
        Tue,  8 Jun 2021 15:50:29 +0000 (GMT)
Subject: Re: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e9f057f6-324e-0637-b57a-cc2f87e0d108@samsung.com>
Date:   Tue, 8 Jun 2021 17:50:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608153344.3813661-1-narmstrong@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87rHJu5PMOhepWWxccZ6Vos3j44w
        W/xs38JksWA2t8Wmx9dYLS7vmsNmceR/P6PF0usXmSyOLTrJYnGoL9ri+NpwB26PNfPWMHq8
        v9HK7vF0wmR2jzvX9rB5bF5S79G3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZc+YtZyxYK1fx
        6d8DpgbGbRJdjJwcEgImEic3PmcEsYUEVjBKPPhmAGF/YZT4t7+qi5ELyP7MKHFj9152mIZZ
        TyYzQSSWM0p0fbzNDuF8ZJRo/TaVFaRKWMBHYvXMU2BjRQRcJO4vOcUKUsQssJ1J4vqkE2wg
        CTYBQ4mut11gNq+AncTjK41gDSwCKhLXup8AxTk4RAWSJX5v1IUoEZQ4OfMJC4jNKWAvcebU
        AbCLmAXkJba/ncMMYYtL3Hoynwni0mZOidtNWhC2i8TVExD3SAgIS7w6vgXqGxmJ05N7WEBu
        A6pnlHh4bi07hNPDKHG5aQZUh7XEnXO/wA5iFtCUWL9LHyLsKPH3zWewsIQAn8SNt4IQN/BJ
        TNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLyWezkHwzC8k3sxD2LmBkWcUonlpanJue
        WmyYl1quV5yYW1yal66XnJ+7iRGYtE7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4S0z3JcgxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnHfV7DXxQgLpiSWp2ampBalFMFkmDk6pBiaH89szggTUin1n
        MH89KqLc96S97qu6xHYtnlvf5zO3iS66dyK06OnMtbdK3esXmIbZa0hI5CZeTGQ6uHxx18RD
        1bP37j+9sDWsZZeizb2PwoofA+3YmR58aZv6csekj/OXJhhVJH/YdnjxwU8i3rn+el06z2c1
        1n8rcE7++cjDq4VxieNH6aS1C3SWVyuoqpo837DtYLBP9jXDMDG2iPb21x5rlP/e3FSnOcGJ
        /z7vIhaDfauLDNJrvi6ayd4qmu+0uab0QWjax8sf/K5NXZTu/N6tPZHhuavWO/Y7ui+n6b1f
        c7bpeHCkj/DtXj/lvMyq4KmsZVzJ+U+SgtgeTxNNy6jRlb7+pnzZsykXViqxFGckGmoxFxUn
        AgC0hQhEyQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7rHJu5PMFi3nNti44z1rBZvHh1h
        tvjZvoXJYsFsbotNj6+xWlzeNYfN4sj/fkaLpdcvMlkcW3SSxeJQX7TF8bXhDtwea+atYfR4
        f6OV3ePphMnsHneu7WHz2Lyk3qNvyypGj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30
        jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy5sxbzliwVq7i078HTA2M2yS6GDk5JARMJGY9
        mczUxcjFISSwlFFi65H/TBAJGYmT0xpYIWxhiT/XuthAbCGB94wSD5Zag9jCAj4Sq2eeYgSx
        RQRcJO4vOcUKMohZYDuTROuh36wQDZMYJTbtMQax2QQMJbreQgziFbCTeHylEayZRUBF4lr3
        E7C4qECyxIb2/6wQNYISJ2c+YQGxOQXsJc6cOsAOYjMLmEnM2/yQGcKWl9j+dg6ULS5x68l8
        pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbqtmM/N+9g
        nPfqo94hRiYOxkOMEhzMSiK8ZYb7EoR4UxIrq1KL8uOLSnNSiw8xmgL9M5FZSjQ5H5gq8kri
        Dc0MTA1NzCwNTC3NjJXEebfOXRMvJJCeWJKanZpakFoE08fEwSnVwKRkzBlnVXRJXabLRuvl
        j5APdo97+JzZoqbYfd109l3/xfsePeoPVsfuXi/6w+7ZhrcxMU83xDheeb3m/7tm+WNbQnLu
        r1vQJeiwp2/bx+BsGa/C1s0n186c5Pt7pvlP++52T1WZBUJlWwqKOIPXcF1rrq3Tu3r10qmI
        guU+BmGme0OTpbjy9t/8aia4INGNKZt1RadhVb9EUjC3Ep9J5fpZT2LX5EuJRHwo0r94yeyB
        QqNKySfNP3xnZ/i+azb85ZHdknaktqK1Y+29n3Ya9StnmppY3pn2t0Mk3M9gyeTCL929q969
        y5+0/kN5dSEHi6Dc7F61pVLH0teG1ic8fB5rkfrj9MeHM0p8nUStlFiKMxINtZiLihMB3vwr
        RF0DAAA=
X-CMS-MailID: 20210608155030eucas1p19993729a4e2ada763234d6c1202e305e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53
References: <CGME20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53@eucas1p2.samsung.com>
        <20210608153344.3813661-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

On 08.06.2021 17:33, Neil Armstrong wrote:
> It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
> and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
> is used on the G12A/G12B platforms.
>
> This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
> when dram-access-quirk is enabled.
>
> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> [1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Hi Ulf, Marek, Mark,
>
> I haven't tested the patch yet, but should fix issue reported at [2].

Works fine here and fixed the issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Neil
>
> [2] https://lore.kernel.org/r/acb244ad-0759-5a96-c659-5c23003d3dcd@samsung.com
>
>   drivers/mmc/host/meson-gx-mmc.c | 48 ++++++++++++++++++++++++++++++---
>   1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index b8b771b643cc..89ff6038092d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -742,6 +742,48 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>   	writel(start, host->regs + SD_EMMC_START);
>   }
>   
> +/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
> +static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
> +				  size_t buflen, bool to_buffer)
> +{
> +	unsigned int sg_flags = SG_MITER_ATOMIC;
> +	struct scatterlist *sgl = data->sg;
> +	unsigned int nents = data->sg_len;
> +	struct sg_mapping_iter miter;
> +	void *buf = host->bounce_buf;
> +	unsigned int offset = 0;
> +
> +	if (to_buffer)
> +		sg_flags |= SG_MITER_FROM_SG;
> +	else
> +		sg_flags |= SG_MITER_TO_SG;
> +
> +	sg_miter_start(&miter, sgl, nents, sg_flags);
> +
> +	while ((offset < buflen) && sg_miter_next(&miter)) {
> +		unsigned int len;
> +
> +		len = min(miter.length, buflen - offset);
> +
> +		/* When dram_access_quirk, the bounce buffer is a iomem mapping */
> +		if (host->dram_access_quirk) {
> +			if (to_buffer)
> +				memcpy_toio(buf + offset, miter.addr, len);
> +			else
> +				memcpy_fromio(miter.addr, buf + offset, len);
> +		} else {
> +			if (to_buffer)
> +				memcpy(buf + offset, miter.addr, len);
> +			else
> +				memcpy(miter.addr, buf + offset, len);
> +		}
> +
> +		offset += len;
> +	}
> +
> +	sg_miter_stop(&miter);
> +}
> +
>   static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>   {
>   	struct meson_host *host = mmc_priv(mmc);
> @@ -785,8 +827,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>   		if (data->flags & MMC_DATA_WRITE) {
>   			cmd_cfg |= CMD_CFG_DATA_WR;
>   			WARN_ON(xfer_bytes > host->bounce_buf_size);
> -			sg_copy_to_buffer(data->sg, data->sg_len,
> -					  host->bounce_buf, xfer_bytes);
> +			meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>   			dma_wmb();
>   		}
>   
> @@ -955,8 +996,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>   	if (meson_mmc_bounce_buf_read(data)) {
>   		xfer_bytes = data->blksz * data->blocks;
>   		WARN_ON(xfer_bytes > host->bounce_buf_size);
> -		sg_copy_from_buffer(data->sg, data->sg_len,
> -				    host->bounce_buf, xfer_bytes);
> +		meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>   	}
>   
>   	next_cmd = meson_mmc_get_next_command(cmd);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

