From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Cleanup unused OF nodes while parsing for
 child nodes
Date: Tue, 31 Mar 2015 13:28:53 +0200
Message-ID: <CAPDyKFqZH3w4HZoeZ=nX3jBZ347qO4=iqFekXfP9Cje9Wku=XQ@mail.gmail.com>
References: <1427707141-3152-1-git-send-email-ulf.hansson@linaro.org>
	<551951B0.7090704@redhat.com>
	<CAPDyKFrwzp5eXO3BwuguaNFpaZ09ZSMtA8_rKEGYn9xEPEpWUg@mail.gmail.com>
	<551A4761.2070803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34660 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbCaL2y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Mar 2015 07:28:54 -0400
Received: by qgep97 with SMTP id p97so11048134qge.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2015 04:28:53 -0700 (PDT)
In-Reply-To: <551A4761.2070803@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 31 March 2015 at 09:06, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 30-03-15 17:09, Ulf Hansson wrote:
>>
>> On 30 March 2015 at 15:37, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 30-03-15 11:19, Ulf Hansson wrote:
>>>>
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>>    drivers/mmc/core/core.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index c296bc0..e6b0bdb 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -1291,6 +1291,8 @@ struct device_node
>>>> *mmc_of_find_child_device(struct
>>>> mmc_host *host,
>>>>          for_each_child_of_node(host->parent->of_node, node) {
>>>>                  if (mmc_of_get_func_num(node) == func_num)
>>>>                          return node;
>>>> +               else
>>>> +                       of_node_put(node);
>>>>          }
>>>>
>>>>          return NULL;
>>>>
>>>
>>> I don't think this is right, non of the other users of
>>> for_each_child_of_node
>>> do this, I think that rather then doing this we should be changing the
>>> callers
>>
>>
>> So, everybody don't follow the API. Cool. :-)
>
>
> Hmm, I don't know where (if anywhere) the API is specified, but if I look at
> the actual implementation in include/linux/of.h
>
> #define for_each_child_of_node(parent, child) \
>         for (child = of_get_next_child(parent, NULL); child != NULL; \
>              child = of_get_next_child(parent, child))
>
> And in drivers/of/base.c:
>
> static struct device_node *__of_get_next_child(const struct device_node
> *node,
>                                                 struct device_node *prev)
> {
>         struct device_node *next;
>
>         if (!node)
>                 return NULL;
>
>         next = prev ? prev->sibling : node->child;
>         for (; next; next = next->sibling)
>                 if (of_node_get(next))
>                         break;
>         of_node_put(prev);
>         return next;
> }
>
> (the non __ prefixed version takes a lock then calls into this one)
>
> Note the "of_node_put(prev);" in the of_get_next_child implementation,
> so yes we've a ref while going through the loop, but its gets freed
> on the "increment" part of the for.
>
> Also see e.g. include/linux/of.h :
>
> static inline int of_get_child_count(const struct device_node *np)
> {
>         struct device_node *child;
>         int num = 0;
>
>         for_each_child_of_node(np, child)
>                 num++;
>
>         return num;
> }
>
> Which I would expect to get things right.

Agree. I didn't look at the code carefully enough. My patch is wrong!

>
>>> of mmc_of_find_child_device to do: of_node_get(), except for the call
>>> which
>>> my "mmc: Add support for marking hpi as broken through devicetree" patch
>>> adds,
>>> as that is intended to only take a temporary reference.
>>>
>>
>> In principle you are saying that the implementation of
>> for_each_child_of_node() API needs to be adopted for how users
>> actually use it, which means leave the of_node_get|put() to be done
>> entirely by the caller, right?
>
>
> What I'm saying is that, if I'm not reading the code the wrong way, that
> is already how the for_each_child_of_node() API works.
>
> As for the mmc subsys it seems that means that no changes are necessary,
> since we do:
>
>         for_each_child_of_node(host->parent->of_node, node) {
>                 if (mmc_of_get_func_num(node) == func_num)
>                         return node;
>         }
>
> So when we've found the right node, we jump out of the loop, returning
> the reference we have while in the loop.
>
> This does mean that my: "mmc: Add support for marking hpi as broken through
> devicetree"
> patch needs to be changed as I ended up calling mmc_of_find_child_device
> twice
> in there, since in that patch I need the of_node before mmc_add_card() gets
> called,
> so I'm leaking a reference there. I'll do a v2 fixing this.

So this discussion around $subject patch, turned out to have some
valuable outcome anyway. :-)

Kind regards
Uffe
