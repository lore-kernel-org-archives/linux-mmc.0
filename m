From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Cleanup unused OF nodes while parsing for
 child nodes
Date: Mon, 30 Mar 2015 17:09:40 +0200
Message-ID: <CAPDyKFrwzp5eXO3BwuguaNFpaZ09ZSMtA8_rKEGYn9xEPEpWUg@mail.gmail.com>
References: <1427707141-3152-1-git-send-email-ulf.hansson@linaro.org>
	<551951B0.7090704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36078 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbbC3PJl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 11:09:41 -0400
Received: by qgf60 with SMTP id 60so172694166qgf.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 08:09:40 -0700 (PDT)
In-Reply-To: <551951B0.7090704@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 30 March 2015 at 15:37, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 30-03-15 11:19, Ulf Hansson wrote:
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>   drivers/mmc/core/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index c296bc0..e6b0bdb 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1291,6 +1291,8 @@ struct device_node *mmc_of_find_child_device(struct
>> mmc_host *host,
>>         for_each_child_of_node(host->parent->of_node, node) {
>>                 if (mmc_of_get_func_num(node) == func_num)
>>                         return node;
>> +               else
>> +                       of_node_put(node);
>>         }
>>
>>         return NULL;
>>
>
> I don't think this is right, non of the other users of
> for_each_child_of_node
> do this, I think that rather then doing this we should be changing the
> callers

So, everybody don't follow the API. Cool. :-)

> of mmc_of_find_child_device to do: of_node_get(), except for the call which
> my "mmc: Add support for marking hpi as broken through devicetree" patch
> adds,
> as that is intended to only take a temporary reference.
>

In principle you are saying that the implementation of
for_each_child_of_node() API needs to be adopted for how users
actually use it, which means leave the of_node_get|put() to be done
entirely by the caller, right?

Kind regards
Uffe
