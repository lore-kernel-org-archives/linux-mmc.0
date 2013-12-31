From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Tue, 31 Dec 2013 12:43:57 +0800
Message-ID: <52C24B8D.1030205@linaro.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org> <CAMj5Bkif9pQHVdA71QccamVQkfgTheUNzowW6AyTwC3dy5XF+g@mail.gmail.com> <52C1AB34.3010402@linaro.org> <201312302127.41690.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57849 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab3LaEoH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2013 23:44:07 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so12310147pad.31
        for <linux-mmc@vger.kernel.org>; Mon, 30 Dec 2013 20:44:04 -0800 (PST)
In-Reply-To: <201312302127.41690.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, cpgs@samsung.com, Kumar Gala <galak@codeaurora.org>, Chris Ball <cjb@laptop.org>, Zhigang Wang <brooke.wangzhigang@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Dear Arnd,

On 12/31/2013 04:27 AM, Arnd Bergmann wrote:
> On Monday 30 December 2013, zhangfei wrote:
>>>>>> +static int dw_mci_k3_suspend(struct device *dev)
>>>>>> +{
>>>>>> +    struct dw_mci *host = dev_get_drvdata(dev);
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    ret = dw_mci_suspend(host);
>>>>>
>>>>> You should never initialize local variables when they are set later in the
>>>>> function (the ret = 0 part above). For more complex functions, this prevents
>>>>> gcc from warning you about accidentally uninitialized uses.
>>
>> I am sorry I may fall into the dead end, but still quite not understand
>> this rule.
>> I alwayes thought it would be a good habit to init local variables before.
>> Do you mean it should NOT init local variable as much as possible and
>> only init on demand, like solving the gcc warning.
>> Why not init the them at start in case random value cause unpredicted error?
>
> The gcc warnings are 100% correct, we can use them as a tool to write better
> code. If you write code that has no warnings with a modern compiler, you will
> never use random values, but if you always initialize the local variables,
> you can end up accidentally using '0' where you shouldn't have.
>
> See http://rusty.ozlabs.org/?p=232 for an excellent article on the topic
> by former Linaro assignee Rusty Russell.
>

Excellent, this is what I am looking for.
Thanks for the patience.
I may need some time and gradually change the habit to diminish the hurt 
memory caused by uninitialized vector.
Will update and take care latter.

By the way, are you fine with the other comments' explanation.

Thanks
