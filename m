From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH 1/1] mmc: debugfs: Set frequency to maximum possible on
 higher request
Date: Mon, 03 Sep 2012 18:05:52 +0530
Message-ID: <5044A428.6040907@codeaurora.org>
References: <1346670519-13097-1-git-send-email-vinit.shenoy@st.com> <5044996A.2050502@codeaurora.org> <CAHp75Ves-htU9bPtsXjum9KWADADenM+oZHeBHHUCDhDBOyf=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:58371 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab2ICMf5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Sep 2012 08:35:57 -0400
In-Reply-To: <CAHp75Ves-htU9bPtsXjum9KWADADenM+oZHeBHHUCDhDBOyf=g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinit Shenoy <vinit.shenoy@st.com>, cjb@laptop.org, viresh.kumar@linaro.org, linux-mmc@vger.kernel.org, spear-devel@list.st.com

On 9/3/2012 6:00 PM, Andy Shevchenko wrote:
> On Mon, Sep 3, 2012 at 2:50 PM, Subhash Jadavani
> <subhashj@codeaurora.org> wrote:
>> As such this is ok if you want this behaviour. But i see other issue which
>> is not related to your patch.
>> Let's say if the host supports 400KHz, 25 MHz,  50MHz, 100MHz and currently
>> card is operating in HS (High Speed) mode@50MHz. and now if someone tries to
>> change the frequency to 100MHz, then we should just don't let the clock
>> change to 100MHz before we put the card in appropriate bus speed mode (in SD
>> cards case, it would be SDR50 and eMMC case it would be HS200). Although
>> this is anyway not an issue created by your patch but this is just to let
>> you know that frequency can't be changed indepently without informing the
>> card beforehand.
> That's why the file is located under debugfs. There is an assumption
> that developer understands
> what he or she is doing by changing this parameter.
Agreed. Thanks.
>
>
>

