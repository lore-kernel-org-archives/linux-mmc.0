From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: Add missing description
Date: Fri, 18 Oct 2013 18:43:38 +0900
Message-ID: <526102CA.7000907@samsung.com>
References: <1381903554-3456-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44736 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab3JRJng (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 05:43:36 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUU00KQIZ06LX30@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Oct 2013 18:43:34 +0900 (KST)
In-reply-to: <1381903554-3456-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 10/16/2013 03:05 PM, Sachin Kamat wrote:
> Commit 0976f16d ("mmc: dw_mmc: add support tuning scheme") introduced
> the execute_tuning hook but did not add its description for kernel docs.
> Update the same.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 6bf24ab..306451f 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -244,6 +244,7 @@ struct dw_mci_tuning_data {
>   * @prepare_command: handle CMD register extensions.
>   * @set_ios: handle bus specific extensions.
>   * @parse_dt: parse implementation specific device tree properties.
> + * @execute_tuning: implementation specific tuning procedure.
>   *
>   * Provide controller implementation specific extensions. The usage of this
>   * data structure is fully optional and usage of each member in this structure
> 

