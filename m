From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 30 Dec 2013 21:27:41 +0100
Message-ID: <201312302127.41690.arnd@arndb.de>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org> <CAMj5Bkif9pQHVdA71QccamVQkfgTheUNzowW6AyTwC3dy5XF+g@mail.gmail.com> <52C1AB34.3010402@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62762 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab3L3U2O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2013 15:28:14 -0500
In-Reply-To: <52C1AB34.3010402@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, cpgs@samsung.com, Kumar Gala <galak@codeaurora.org>, Chris Ball <cjb@laptop.org>, Zhigang Wang <brooke.wangzhigang@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Monday 30 December 2013, zhangfei wrote:
> >>>> +static int dw_mci_k3_suspend(struct device *dev)
> >>>> +{
> >>>> +    struct dw_mci *host = dev_get_drvdata(dev);
> >>>> +    int ret = 0;
> >>>> +
> >>>> +    ret = dw_mci_suspend(host);
> >>>
> >>> You should never initialize local variables when they are set later in the
> >>> function (the ret = 0 part above). For more complex functions, this prevents
> >>> gcc from warning you about accidentally uninitialized uses.
> 
> I am sorry I may fall into the dead end, but still quite not understand 
> this rule.
> I alwayes thought it would be a good habit to init local variables before.
> Do you mean it should NOT init local variable as much as possible and 
> only init on demand, like solving the gcc warning.
> Why not init the them at start in case random value cause unpredicted error?

The gcc warnings are 100% correct, we can use them as a tool to write better
code. If you write code that has no warnings with a modern compiler, you will
never use random values, but if you always initialize the local variables,
you can end up accidentally using '0' where you shouldn't have.

See http://rusty.ozlabs.org/?p=232 for an excellent article on the topic
by former Linaro assignee Rusty Russell.

	Arnd
