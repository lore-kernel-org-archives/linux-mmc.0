From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] mmc: core: Cleanup unused OF nodes while parsing for
 child nodes
Date: Mon, 30 Mar 2015 15:37:52 +0200
Message-ID: <551951B0.7090704@redhat.com>
References: <1427707141-3152-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbbC3Nhy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Mar 2015 09:37:54 -0400
In-Reply-To: <1427707141-3152-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Hi,

On 30-03-15 11:19, Ulf Hansson wrote:
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/core.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c296bc0..e6b0bdb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1291,6 +1291,8 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
>   	for_each_child_of_node(host->parent->of_node, node) {
>   		if (mmc_of_get_func_num(node) == func_num)
>   			return node;
> +		else
> +			of_node_put(node);
>   	}
>
>   	return NULL;
>

I don't think this is right, non of the other users of for_each_child_of_node
do this, I think that rather then doing this we should be changing the callers
of mmc_of_find_child_device to do: of_node_get(), except for the call which
my "mmc: Add support for marking hpi as broken through devicetree" patch adds,
as that is intended to only take a temporary reference.

Regards,

Hans
