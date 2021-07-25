Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF6CC4338F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22EC60231
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGYVAO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 17:00:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20875 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhGYVAN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jul 2021 17:00:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210725214041epoutp0350851b02641624733436ccdaaa4eb021~VJpBgCfRW1909019090epoutp03B
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jul 2021 21:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210725214041epoutp0350851b02641624733436ccdaaa4eb021~VJpBgCfRW1909019090epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1627249241;
        bh=iC0O+ZFAAxwkdjBKB6x04hKDYKrS8sbFbpHfsJp2jlU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pGk9yKUGuVAaCDPX5wzUgEgNX+BtMmLbNBFzYyi/qUZFVy4qmEcCGwOtHhriRX9CF
         CFRlG91xfljwRrrNvX07CChP/K4Q2o/aNPuMlyTdvl1U98Q2RSX9mA6aBUEsKYLOwQ
         ab8Ue4gihoCb8bggKOoyH5VzBkPBkcp9Niosb94Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210725214041epcas1p404345218dc94f8acf1e9f71a27170a77~VJpAuC9pS2553125531epcas1p47;
        Sun, 25 Jul 2021 21:40:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GXxLZ2vDSz4x9Pr; Sun, 25 Jul
        2021 21:40:38 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.17.10119.65ADDF06; Mon, 26 Jul 2021 06:40:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210725214037epcas1p181f506c66a4256685923ab915aba3084~VJo9sCAcc1520415204epcas1p1U;
        Sun, 25 Jul 2021 21:40:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210725214037epsmtrp2cfcb90a2951eeefffc1e438788c27b46~VJo9rYfRD2625426254epsmtrp2Q;
        Sun, 25 Jul 2021 21:40:37 +0000 (GMT)
X-AuditID: b6c32a38-97bff70000002787-23-60fdda56288c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.EF.08289.55ADDF06; Mon, 26 Jul 2021 06:40:37 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210725214037epsmtip2caa84d71174be696f01cd8f3bae902e4~VJo9VyjXm3206832068epsmtip2m;
        Sun, 25 Jul 2021 21:40:37 +0000 (GMT)
Subject: Re: [PATCH v2] mmc: dw_mmc: Add data CRC error injection
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <06d89a02-708e-c096-5b96-165f1ce8724c@samsung.com>
Date:   Mon, 26 Jul 2021 06:41:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701080534.23138-1-vincent.whitchurch@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTVzfs1t8Eg56bQhafWlQtLu+aw2Zx
        5H8/o8XxteEW57f5O7B6XF8X4HHn2h42j8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
        lVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM05c7GcuuK9T8fV9D0sD41yVLkZODgkB
        E4n3mz6xdTFycQgJ7GCU2D3vM5TziVHi+c5VrBDOZ0aJafNeMsG03L2zGyqxi1Hie8slJgjn
        PaNEX89hsCphAUeJ7lv7wWwRgRiJpz0b2UBsZgEfiatTDjOC2GwCOhLbvx0Hq+EVsJNonv0T
        LM4ioCrx4PseMFtUIFLi/O4FLBA1ghInZz4BszmB5j/f0csKMVNc4taT+UwQtrzE9rdzmCEu
        fcQucfwG1KMuEi+WX2KBsIUlXh3fwg5hS0l8freXDcKultjVfIYZ5BkJgQ5GiVvbmqBeNpbY
        v3QykM0BtEBTYv0ufYiwosTO33MZIfbySbz72sMKUiIhwCvR0SYEUaIicek1LOCkJO4++c8K
        YXtInGv+wjqBUXEWks9mIflmFpJvZiEsXsDIsopRLLWgODc9tdiwwAQ5tjcxgpOilsUOxrlv
        P+gdYmTiYDzEKMHBrCTC67Did4IQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgem5bySeENT
        I2NjYwsTQzNTQ0Mlcd5vsV8ThATSE0tSs1NTC1KLYPqYODilGpgst22/6BLqZbv1U2qtzf7n
        xi29Ap1pu945+RzvDtTbwDh1p+AD9xdB2y92BGoekH1h6CL6dUlj+kkGlTpjzzn++n8LuKN/
        1W8TftD01DblktHrta5FiYtkCn/3Tt2w8ljXntnNoQ21hXfPNc4Xsf/jE6LUGnrv5cEXXKkJ
        l+tUVgY9eVQcz8M0be6nM1tnbHWv/3Py48JlIR0c6v1Zr4857ZTW9yvxDZgtzOtg/FpqpdSN
        CD61XjO7w89uH18SdyvOpiVNOUnihqCKcL3T7wViS5M0muS/p5RPSw8LuttodP1KTM3xnRyG
        DHZ+T2//sN8a2XhkQ9yxH1vbXxtyck/xfV6ob8bkf25Hyi9BGyWW4oxEQy3mouJEAJxYPSYT
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvG7orb8JBqf/a1h8alG1uLxrDpvF
        kf/9jBbH14ZbnN/m78DqcX1dgMeda3vYPD5vkgtgjuKySUnNySxLLdK3S+DKOHGxn7ngvk7F
        1/c9LA2Mc1W6GDk5JARMJO7e2c3axcjFISSwg1FiUudGNoiElMTnp1OBbA4gW1ji8OFiiJq3
        jBLT981kBqkRFnCU6L61nwnEFhGIkdj56hlYL7OAj8TVKYcZIRqmMEpsPHIfrIhNQEdi+7fj
        YDavgJ1E8+yfjCA2i4CqxIPve8BsUYFIic8LXrFC1AhKnJz5hAXE5gRa9nxHLyvEAnWJP/Mu
        MUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK9
        4sTc4tK8dL3k/NxNjOA40NLawbhn1Qe9Q4xMHIyHGCU4mJVEeB1W/E4Q4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgcnVvv7q5p8/7Qz4Aq1lHfdPnjRx
        smZ1wVa1QtOVu+YVNbd+mnz+W82D9hVu2/Stwni33738yOqzz1aOlU+/H+Zo979qxu1yUSv/
        dJPSwoDCM7ceit7RO8QflZxZ0i/wK1219MOHN249Z6fbz7LK5Y2VFkru4rf6KLjGfL+Jvu2t
        vDU7TNwkLhxXfd62lTHUJG1hy9vUbM9U23aO4v29enX3b80We/jNhfdp1JeewH02f7VS44U0
        f+5bNrNMciLz+1+Bz4NOr2uS3xHR/TPjGqO16NaKNPe39dZ/lxa0KDumB9ZeY9vyQWLZr91P
        3qZ4TrOLL1R+Wh88m2fL3RtX1qUdTf4guKZT1cxqgZZVtBJLcUaioRZzUXEiAFfrH1nyAgAA
X-CMS-MailID: 20210725214037epcas1p181f506c66a4256685923ab915aba3084
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701080542epcas1p1ba3235a77ae2ddccc1d1cb40df2e51de
References: <CGME20210701080542epcas1p1ba3235a77ae2ddccc1d1cb40df2e51de@epcas1p1.samsung.com>
        <20210701080534.23138-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/1/21 5:05 PM, Vincent Whitchurch wrote:
> This driver has had problems when handling data errors.  Add fault
> injection support so that the abort handling can be easily triggered and
> regression-tested.  A hrtimer is used to indicate a data CRC error at
> various points during the data transfer.
> 
> Note that for the recent problem with hangs in the case of some data CRC
> errors, a udelay(10) inserted at the start of send_stop_abort() greatly
> helped in triggering the error, but I've not included this as part of
> the fault injection support since it seemed too specific.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
> Notes:
>     v2: Add missing includes.
> 
>  drivers/mmc/host/dw_mmc.c | 73 +++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h |  7 ++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d333130d1531..dbbb94e6ff4b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -17,9 +17,11 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/ioport.h>
> +#include <linux/ktime.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/prandom.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> @@ -181,6 +183,9 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
>  			   &host->pending_events);
>  	debugfs_create_xul("completed_events", S_IRUSR, root,
>  			   &host->completed_events);
> +#ifdef CONFIG_FAULT_INJECTION
> +	fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
> +#endif
>  }
>  #endif /* defined(CONFIG_DEBUG_FS) */
>  
> @@ -1788,6 +1793,68 @@ static const struct mmc_host_ops dw_mci_ops = {
>  	.prepare_hs400_tuning	= dw_mci_prepare_hs400_tuning,
>  };
>  
> +#ifdef CONFIG_FAULT_INJECTION
> +static enum hrtimer_restart dw_mci_fault_timer(struct hrtimer *t)
> +{
> +	struct dw_mci *host = container_of(t, struct dw_mci, fault_timer);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +
> +	if (!host->data_status)
> +		host->data_status = SDMMC_INT_DCRC;
> +	set_bit(EVENT_DATA_ERROR, &host->pending_events);
> +	tasklet_schedule(&host->tasklet);
> +
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void dw_mci_start_fault_timer(struct dw_mci *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	if (!data || data->blocks <= 1)
> +		return;
> +
> +	if (!should_fail(&host->fail_data_crc, 1))
> +		return;
> +
> +	/*
> +	 * Try to inject the error at random points during the data transfer.
> +	 */
> +	hrtimer_start(&host->fault_timer,
> +		      ms_to_ktime(prandom_u32() % 25),
> +		      HRTIMER_MODE_REL);
> +}
> +
> +static void dw_mci_stop_fault_timer(struct dw_mci *host)
> +{
> +	hrtimer_cancel(&host->fault_timer);
> +}
> +
> +static void dw_mci_init_fault(struct dw_mci *host)
> +{
> +	host->fail_data_crc = (struct fault_attr) FAULT_ATTR_INITIALIZER;
> +
> +	hrtimer_init(&host->fault_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	host->fault_timer.function = dw_mci_fault_timer;
> +}
> +#else
> +static void dw_mci_init_fault(struct dw_mci *host)
> +{
> +}
> +
> +static void dw_mci_start_fault_timer(struct dw_mci *host)
> +{
> +}
> +
> +static void dw_mci_stop_fault_timer(struct dw_mci *host)
> +{
> +}
> +#endif
> +
>  static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>  	__releases(&host->lock)
>  	__acquires(&host->lock)
> @@ -2102,6 +2169,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  				break;
>  			}
>  
> +			dw_mci_stop_fault_timer(host);
>  			host->data = NULL;
>  			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
>  			err = dw_mci_data_complete(host, data);
> @@ -2151,6 +2219,7 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  			if (mrq->cmd->error && mrq->data)
>  				dw_mci_reset(host);
>  
> +			dw_mci_stop_fault_timer(host);
>  			host->cmd = NULL;
>  			host->data = NULL;
>  
> @@ -2600,6 +2669,8 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
>  
>  	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
>  	tasklet_schedule(&host->tasklet);
> +
> +	dw_mci_start_fault_timer(host);
>  }
>  
>  static void dw_mci_handle_cd(struct dw_mci *host)
> @@ -3223,6 +3294,8 @@ int dw_mci_probe(struct dw_mci *host)
>  	spin_lock_init(&host->irq_lock);
>  	INIT_LIST_HEAD(&host->queue);
>  
> +	dw_mci_init_fault(host);
> +
>  	/*
>  	 * Get the host data width - this assumes that HCON has been set with
>  	 * the correct values.
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index da5923a92e60..ce05d81477d9 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -14,6 +14,8 @@
>  #include <linux/mmc/core.h>
>  #include <linux/dmaengine.h>
>  #include <linux/reset.h>
> +#include <linux/fault-inject.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  
>  enum dw_mci_state {
> @@ -230,6 +232,11 @@ struct dw_mci {
>  	struct timer_list       cmd11_timer;
>  	struct timer_list       cto_timer;
>  	struct timer_list       dto_timer;
> +
> +#ifdef CONFIG_FAULT_INJECTION
> +	struct fault_attr	fail_data_crc;
> +	struct hrtimer		fault_timer;
> +#endif
>  };
>  
>  /* DMA ops for Internal/External DMAC interface */
> 

